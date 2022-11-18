import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krushak/globals.dart';
import 'package:krushak/key.dart';
import 'package:krushak/main.dart';
import 'package:krushak/main_screens/agri_info.dart';
import 'package:krushak/main_screens/home_screen.dart';
import 'package:krushak/main_screens/market.dart';
import 'package:krushak/main_screens/schemes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather/weather.dart';

import 'market/search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screens = [
    HomeScreen(
      langCode: langCode,
    ),
    Market(
      langCode: langCode,
    ),
    Schemes(
      langCode: langCode,
    ),
    AgriInfo(
      langCode: langCode,
    )
  ];
  List<String> titles = ['Home', 'Market', 'Schemes', 'Agri Info'];
  int? _selectedIndex = 0;
  String? locality = '';
  double? lat;
  double? lon;
  WeatherFactory wf = WeatherFactory(api_key!);

  /*void getWeather(double lat, double lon) async {
    List<Weather> _forecast = await wf.fiveDayForecastByLocation(lat, lon);
    setState(() {
      forecast = _forecast;
    });
    print('weather--${forecast}');
  }*/

  void getLocation() async {
    /*LocationPermission permission = await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .timeout(Duration(seconds: 5));*/

    while (city == '') {
      try {
        LocationPermission permission = await Geolocator.requestPermission();
        var position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best)
            .timeout(Duration(seconds: 15));
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        setState(() {
          city = placemarks[0].locality;
        });
      } catch (e) {}
    }

    /*try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      setState(() {
        locality = placemarks[0].name;
        city = placemarks[0].locality;
        lat = position.latitude;
        lon = position.longitude;
      });
      print('locationssd1--${placemarks[0].name}');
      print('locationssd--${placemarks[0].locality}');
      print('lat--${position.latitude}');
      print('lon--${position.longitude}');
      //getWeather(lat!, lon!);
    } catch (err) {}*/
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _selectedIndex == 0
                    ? Container(
                        height: 70,
                        width: 90,
                        child: Image.asset(
                          'assets/english_logo_transparent.png',
                          fit: BoxFit.cover,
                        ))
                    : TranslatedText(
                        langCode!,
                        titles[_selectedIndex!],
                        TextStyle(fontFamily: 'SemiBold', color: Colors.black),
                      ),
                SizedBox(
                  width: 16,
                ),
                _selectedIndex != 2
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade200,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              city != ''
                                  ? TranslatedText(
                                      langCode!,
                                      city!,
                                      TextStyle(
                                          fontFamily: 'Medium',
                                          color: Colors.black.withOpacity(0.4),
                                          fontSize: 16),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            _selectedIndex == 1
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.bounceInOut,
                            type: PageTransitionType.rightToLeft,
                            child: MarketSearch()),
                      );
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ))
                : Container(),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: primary!, width: 2),
                  borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.language_outlined,
                      color: secondary,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 20,
                      child: DropdownButton<String>(
                        icon: Container(),
                        underline: Container(),
                        borderRadius: BorderRadius.circular(20),
                        hint: TranslatedText(
                          langCode!,
                          language!,
                          TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 18,
                              color: secondary),
                        ),
                        items:
                            <String>['English', 'हिन्दी'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: TranslatedText(
                              langCode!,
                              value,
                              TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 18,
                                  color: secondary),
                            ),
                          );
                        }).toList(),
                        onChanged: (_) {
                          if (_ == 'हिन्दी') {
                            setState(() {
                              langCode = 'hi';
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget));
                          } else {
                            setState(() {
                              langCode = 'en';
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget));
                          }
                          setState(() {
                            language = _;
                            super.reassemble();

                            print(langCode);
                          });
                          //runApp(const MyApp());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: screens[_selectedIndex!],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: AnimatedContainer(
          duration: Duration(microseconds: 300),
          child: BottomNavigationBar(
            iconSize: 24,
            backgroundColor: Colors.grey.shade50,
            elevation: 0,
            selectedItemColor: Colors.black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            currentIndex: _selectedIndex!,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/home.svg'),
                activeIcon: SvgPicture.asset('assets/home1.svg'),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: new SvgPicture.asset('assets/market.svg'),
                activeIcon: SvgPicture.asset('assets/market1.svg'),
                label: '   ',
              ),
              BottomNavigationBarItem(
                icon: new SvgPicture.asset('assets/schemes.svg'),
                activeIcon: SvgPicture.asset('assets/schemes1.svg'),
                label: '   ',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/buildings.svg'),
                activeIcon: SvgPicture.asset('assets/buildings1.svg'),
                label: ' ',
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
