import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:krushak/cards/nearby_trainings.dart';
import 'package:krushak/cards/news.dart';
import 'package:krushak/cards/videos.dart';
import 'package:krushak/cards/weather.dart';
import 'package:krushak/data/data.dart';
import 'package:krushak/globals.dart';
import 'package:krushak/key.dart';
import 'package:krushak/other_screens/weather_screen.dart';
import 'package:krushak/popup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/weather.dart';

class HomeScreen extends StatefulWidget {
  final String? langCode;
  const HomeScreen({Key? key, this.langCode}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Weather>? forecast;
  WeatherFactory wf = WeatherFactory(api_key!);
  bool weather_load = true;
  bool screen_load = false;
  void getWeather(double lat, double lon) async {
    List<Weather> _forecast = await wf.fiveDayForecastByLocation(lat, lon);
    setState(() {
      forecast = _forecast;
      weather_load = false;
    });
    print('weather--${forecast}');
  }

  String head1 = 'Nearby';
  String head2 = 'Learn';
  String head3 = 'News';

  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .timeout(Duration(seconds: 5));

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print('locationssd--${placemarks[0]}');
      print('lat--${position.latitude}');
      print('lon--${position.longitude}');
      getWeather(position.latitude, position.longitude);
    } catch (err) {}
  }

  void translate() async {
    setState(() {
      screen_load = true;
    });
    final translator = GoogleTranslator();

    head1 = (await translator.translate(head1, to: 'hi')).toString();
    head2 =
        (await translator.translate(head2, to: widget.langCode!)).toString();
    head3 =
        (await translator.translate(head3, to: widget.langCode!)).toString();

    setState(() {
      screen_load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    translate();
  }

  @override
  Widget build(BuildContext context) {
    return screen_load
        ? Container(
            height: getHeight(context),
            child: Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
              color: primary,
            )))
        : Scaffold(
            body: Container(
              height: getHeight(context) * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getHeight(context) * 0.01,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 100,
                          width: getWidth(context),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: weather_load
                              ? Center(
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: primary,
                                      )))
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            duration:
                                                Duration(milliseconds: 400),
                                            curve: Curves.bounceInOut,
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: WeatherPopup(
                                              forecast: forecast,
                                              hero: forecast![0]
                                                  .weatherMain
                                                  .toString(),
                                            )));
                                  },
                                  child: WeatherInfo(
                                      forecast: forecast,
                                      weather:
                                          forecast![0].weatherMain.toString(),
                                      temp: forecast![0].temperature.toString(),
                                      wind: forecast![0].windSpeed.toString(),
                                      date: formatDate(forecast![0].date!)),
                                ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        head1,
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 26,
                            color: secondary),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 140,
                      child: Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: nearby.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, right: 0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        HeroDialogRoute(builder: (context) {
                                      return NearbyPopup(
                                        nearby: nearby[i],
                                        hero: nearby[i]['url'],
                                      );
                                    }));
                                  },
                                  child: Hero(
                                    tag: nearby[i]['url'],
                                    createRectTween: (begin, end) {
                                      return CustomRectTween(
                                          begin: begin, end: end);
                                    },
                                    child: NearbyTrainings(
                                      title: nearby[i]['title'],
                                      start: nearby[i]['start'],
                                      end: nearby[i]['end'],
                                      time: nearby[i]['time'],
                                      address: nearby[i]['address'],
                                      url: nearby[i]['url'],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        head2,
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 26,
                            color: secondary),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 260,
                      child: Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: videos.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, right: 0),
                                  child: InkWell(
                                    onTap: () {
                                      launch(videos[i]['video']);
                                    },
                                    child: Videos(
                                      title: videos[i]['title'],
                                      source: videos[i]['source'],
                                      creator: videos[i]['creator'],
                                      url: videos[i]['url'],
                                    ),
                                  ));
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        head3,
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 26,
                            color: secondary),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: getHeight(context) * 0.25,
                      child: Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: news.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: InkWell(
                                  onTap: () {
                                    launch(news[i]['url']);
                                  },
                                  child: News(
                                    news: news[0],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
