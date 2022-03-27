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
                    height: 80,
                    width: 80,
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
            SizedBox(
              height: 10,
            ),
            GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: (3 / 3),
                shrinkWrap: true,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.thermostat_auto_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${widget.forecast![0].temperature!.toString().substring(0, 4)} °C',
                            style: TextStyle(
                                fontFamily: 'Medium',
                                fontSize: 30,
                                color: secondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.forecast![0].humidity!.toString(),
                            style: TextStyle(
                                fontFamily: 'Medium',
                                fontSize: 30,
                                color: secondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.air,
                            size: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.forecast![0].windDegree!.toString(),
                            style: TextStyle(
                                fontFamily: 'Medium',
                                fontSize: 30,
                                color: secondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.forecast![0].cloudiness!.toString(),
                            style: TextStyle(
                                fontFamily: 'Medium',
                                fontSize: 30,
                                color: secondary),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.forecast!.length,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
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
          borderRadius: BorderRadius.circular(14), color: Colors.grey.shade100),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
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
              width: 10,
            ),
            Container(
              width: getWidth(context) * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            formatDate(widget.forecast!.date!)!,
                            style: TextStyle(
                                fontFamily: 'Medium',
                                color: secondary,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${widget.forecast!.date!.hour.toString()}:${widget.forecast!.date!.minute.toString()}',
                            style: TextStyle(
                                fontFamily: 'Medium',
                                color: secondary,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.forecast!.weatherMain.toString(),
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            color: secondary,
                            fontSize: 28),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.water_drop_outlined),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.forecast!.humidity.toString(),
                                    style: TextStyle(
                                        fontFamily: 'Medium',
                                        color: secondary,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.cloud_outlined),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.forecast!.cloudiness.toString(),
                                    style: TextStyle(
                                        fontFamily: 'Medium',
                                        color: secondary,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
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
