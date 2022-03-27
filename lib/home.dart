import 'package:flutter/material.dart';
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
import 'package:weather/weather.dart';

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
    LocationPermission permission = await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .timeout(Duration(seconds: 5));

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      setState(() {
        locality = placemarks[0].locality;
        lat = position.latitude;
        lon = position.longitude;
      });
      print('locationssd--${placemarks[0]}');
      print('lat--${position.latitude}');
      print('lon--${position.longitude}');
      //getWeather(lat!, lon!);
    } catch (err) {}
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
                        width: 80,
                        child: Image.asset(
                          'assets/logo_transparent.png',
                          fit: BoxFit.cover,
                        ))
                    : Text(
                        titles[_selectedIndex!],
                        style: TextStyle(
                            fontFamily: 'SemiBold', color: Colors.black),
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
                              Text(
                                locality!,
                                style: TextStyle(
                                    fontFamily: 'Medium',
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 16),
                              ),
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
                        hint: Text(
                          language!,
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 18,
                              color: secondary),
                        ),
                        items:
                            <String>['English', 'हिन्दी'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
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
                          } else {
                            setState(() {
                              langCode = 'en';
                            });
                          }
                          setState(() {
                            language = _;
                            super.reassemble();

                            print(langCode);
                          });
                          runApp(const MyApp());
                        },
                      ),
                    )
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
