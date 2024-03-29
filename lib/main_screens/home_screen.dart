import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:krushak/auth/auth.dart';
import 'package:krushak/cards/crop_prices.dart';
import 'package:krushak/cards/nearby_trainings.dart';
import 'package:krushak/cards/news.dart';
import 'package:krushak/cards/videos.dart';
import 'package:krushak/cards/weather.dart';
import 'package:krushak/data/data.dart';
import 'package:krushak/globals.dart';
import 'package:krushak/key.dart';
import 'package:krushak/other_screens/weather_screen.dart';
import 'package:krushak/popup.dart';
import 'package:krushak/see_all/nearby_trainings_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/weather.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

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
  String head2 = 'Crop Prices';
  String head3 = 'News';

  void extractData() async {
    final response =
        await http.Client().get(Uri.parse('https://www.msamb.com/Home/Index'));

    print('resp--${response.statusCode}');

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        var elements = document
            .getElementsByClassName('table')[0]
            .getElementsByTagName('tr');
        List l = [];
        print('1');
        print(elements.length);
        for (int i = 1; i < elements.length; i++) {
          var responseString1 = elements[i].children[0].text;
          var responseString2 = elements[i].children[1].text;
          var responseString3 = elements[i].children[2].text;
          var responseString4 = elements[i].children[3].text;
          l.add(responseString1);
          print('scraped--$responseString1');
          print('scraped2--$responseString2');
          print('scraped3--$responseString3');
          print('scraped3--$responseString4');
          cropp.add({
            'url': 'assets/image 32.png',
            'title': responseString1,
            'quantity': '$responseString2 quintal',
            'price': responseString4,
          });
        }
        setState(() {});
      } catch (e) {
        print('1e');
      }
    } else {
      print('2e');
    }
  }

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

  @override
  void initState() {
    super.initState();
    extractData();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (screen_load) {
      return Container(
          height: getHeight(context),
          child: Center(
              child: CircularProgressIndicator(
            strokeWidth: 2,
            color: primary,
          )));
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
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
                      //height: 100,
                      width: getWidth(context),
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.bounceInOut,
                                        type: PageTransitionType.rightToLeft,
                                        child: WeatherPopup(
                                          forecast: forecast,
                                          hero: forecast![0]
                                              .weatherMain
                                              .toString(),
                                        )));
                              },
                              child: WeatherInfo(
                                  forecast: forecast,
                                  weather: forecast![0].weatherMain.toString(),
                                  temp: forecast![0].temperature.toString(),
                                  wind: forecast![0].windSpeed.toString(),
                                  date: formatDate(forecast![0].date!)),
                            ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TranslatedText(
                    langCode!,
                    head2,
                    TextStyle(
                        fontFamily: 'SemiBold', fontSize: 26, color: secondary),
                  ),
                ),
                Container(
                    height: 124,
                    child: Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: cropp.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, right: 0),
                                child: CropPrices(
                                  langCode: widget.langCode,
                                  title: cropp[i]['title'],
                                  url: cropp[i]['url'],
                                  quantity: cropp[i]['quantity'],
                                  price: cropp[i]['price'],
                                ),
                              );
                            }))),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TranslatedText(
                        langCode!,
                        head1,
                        TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 26,
                            color: secondary),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.bounceInOut,
                                type: PageTransitionType.rightToLeft,
                                child: NearbyTrainingsSeeMore()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: primary!, width: 2),
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: TranslatedText(
                              langCode!,
                              'See All >',
                              TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: secondary),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 140,
                  child: Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Trainings")
                          .where('city', isEqualTo: city)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) return const SizedBox.shrink();
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, index) {
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];
                            Map<String, dynamic> map =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;

                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return NearbyPopup(
                                      nearby: map,
                                      hero: map['url'],
                                    );
                                  }));
                                },
                                child: Hero(
                                  tag: map['url'],
                                  createRectTween: (begin, end) {
                                    return CustomRectTween(
                                        begin: begin, end: end);
                                  },
                                  child: NearbyTrainings(
                                    title: map['title'],
                                    start: map['start'],
                                    end: map['end'],
                                    time: map['time'],
                                    address: map['address'],
                                    url: map['url'],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TranslatedText(
                        langCode!,
                        head3,
                        TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 26,
                            color: secondary),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: primary!, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TranslatedText(
                            langCode!,
                            'See All >',
                            TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: secondary),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: getHeight(context) * 0.30,
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
                                launch(news[i]['url'], forceWebView: true);
                              },
                              child: News(
                                news: news[0],
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
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(80)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.grey.shade300),
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          TranslatedText(
                            langCode!,
                            FirebaseAuth.instance.currentUser!.phoneNumber
                                .toString(),
                            TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 20,
                                color: secondary),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              logOut(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: primary),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TranslatedText(
                                  langCode!,
                                  'Logout',
                                  TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 16,
                                      color: secondary),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
