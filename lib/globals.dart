import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:weather/weather.dart';

Color? primary = Color(0xFF0CED7F);
Color? secondary = Color(0xFF06371F);

String? language = 'English';
String? langCode = 'en';

String? translate(String? str, String? code) {
  final translator = GoogleTranslator();
  return (translator.translate(str!, to: code!)).toString();
}

double getHeight(context) {
  double height = MediaQuery.of(context).size.height;
  return height;
}

double getWidth(context) {
  double width = MediaQuery.of(context).size.width;
  return width;
}
