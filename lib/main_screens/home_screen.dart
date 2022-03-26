import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:krushak/cards/nearby_trainings.dart';
import 'package:krushak/cards/videos.dart';
import 'package:krushak/cards/weather.dart';
import 'package:krushak/data/data.dart';
import 'package:krushak/globals.dart';
import 'package:krushak/key.dart';
import 'package:weather/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Weather>? forecast;
  WeatherFactory wf = WeatherFactory(api_key!);
  bool weather_load = true;
  void getWeather(double lat, double lon) async {
    List<Weather> _forecast = await wf.fiveDayForecastByLocation(lat, lon);
    setState(() {
      forecast = _forecast;
      weather_load = false;
    });
    print('weather--${forecast}');
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

  String? formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    return formatted.toString(); // something like 2013-04-20
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        : WeatherInfo(
                            forecast: forecast,
                            weather: forecast![0].weatherMain.toString(),
                            temp: forecast![0].temperature.toString(),
                            wind: forecast![0].windSpeed.toString(),
                            date: formatDate(forecast![0].date!)),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  langCode == 'hi'
                      ? translate('Nearby', langCode).toString()
                      : 'Nearby',
                  style: TextStyle(
                      fontFamily: 'SemiBold', fontSize: 26, color: secondary),
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
                          padding: const EdgeInsets.only(left: 18.0, right: 0),
                          child: NearbyTrainings(
                            title: nearby[i]['title'],
                            start: nearby[i]['start'],
                            end: nearby[i]['end'],
                            time: nearby[i]['time'],
                            address: nearby[i]['address'],
                            url: nearby[i]['url'],
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
                  'Learn',
                  style: TextStyle(
                      fontFamily: 'SemiBold', fontSize: 26, color: secondary),
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
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 0),
                            child: Videos(
                              title: videos[i]['title'],
                              source: videos[i]['source'],
                              creator: videos[i]['creator'],
                              url: videos[i]['url'],
                            ));
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'News',
                  style: TextStyle(
                      fontFamily: 'SemiBold', fontSize: 26, color: secondary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'News',
                  style: TextStyle(
                      fontFamily: 'SemiBold', fontSize: 26, color: secondary),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
