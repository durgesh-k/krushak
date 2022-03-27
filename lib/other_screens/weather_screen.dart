import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';
import 'package:krushak/popup.dart';
import 'package:weather/weather.dart';

class WeatherPopup extends StatefulWidget {
  final String? hero;
  final List<Weather>? forecast;
  const WeatherPopup({Key? key, this.hero, this.forecast}) : super(key: key);

  @override
  State<WeatherPopup> createState() => _WeatherPopupState();
}

class _WeatherPopupState extends State<WeatherPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Weather Info',
          style: TextStyle(fontFamily: 'SemiBold', color: Colors.black),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'assets/cloudy.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          formatDate(widget.forecast![0].date!)!,
                          style: TextStyle(
                              fontFamily: 'Medium',
                              color: secondary,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getWidth(context) * 0.44,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.forecast![0].weatherMain.toString(),
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                color: secondary,
                                fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.forecast!.length,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: FutureWeather(
                        forecast: widget.forecast![i],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class FutureWeather extends StatefulWidget {
  final Weather? forecast;
  const FutureWeather({Key? key, this.forecast}) : super(key: key);

  @override
  State<FutureWeather> createState() => _FutureWeatherState();
}

class _FutureWeatherState extends State<FutureWeather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), color: Colors.grey.shade200),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 60,
                width: 60,
                child: Image.asset(
                  'assets/cloudy.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: getWidth(context) * 0.4,
              child: Column(
                children: [
                  Text(
                    formatDate(widget.forecast!.date!)!,
                    style: TextStyle(
                        fontFamily: 'SemiBold', color: secondary, fontSize: 28),
                  ),
                  Text(
                    widget.forecast!.weatherMain.toString(),
                    style: TextStyle(
                        fontFamily: 'SemiBold', color: secondary, fontSize: 28),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
