import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

Color? primary = Color(0xFF0CED7F);
Color? secondary = Color(0xFF06371F);

double getHeight(context) {
  double height = MediaQuery.of(context).size.height;
  return height;
}

double getWidth(context) {
  double width = MediaQuery.of(context).size.width;
  return width;
}
