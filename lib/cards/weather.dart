import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';
import 'package:weather/weather.dart';

class WeatherInfo extends StatefulWidget {
  final String? weather;
  final String? wind;
  final String? temp;
  final String? date;
  final List<Weather>? forecast;
  const WeatherInfo(
      {this.forecast, this.wind, this.weather, this.temp, this.date});

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  @override
  Widget build(BuildContext context) {
    print('iconn-${widget.forecast![0].weatherIcon}');
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  //height: 100,
                  width: 70,
                  child: Image.network(
                    "http://openweathermap.org/img/wn/${widget.forecast![0].weatherIcon}@2x.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: getWidth(context) * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*Text(
                          widget.date!,
                          style: TextStyle(
                              fontFamily: 'Medium',
                              color: secondary,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),*/
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  '${widget.forecast![0].temperature!.toString().substring(0, 4)} °C',
                                  style: TextStyle(
                                      fontFamily: 'SemiBold',
                                      color: secondary,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.weather!,
                              style: TextStyle(
                                  fontFamily: 'Bold',
                                  color: secondary,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        /*SizedBox(
                          height: 8,
                        ),*/
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
