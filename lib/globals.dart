import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';
import 'package:weather/weather.dart';

Color? primary = Color(0xFF0CED7F);
Color? secondary = Color(0xFF06371F);

String? language = 'English';
String? langCode = 'en';

TextEditingController mobile = TextEditingController();
TextEditingController otp = TextEditingController();

/*String? translate(String? str, String? code) {
  final translator = GoogleTranslator();
  return (translator.translate(str!, to: code!)).toString();
}*/

double getHeight(context) {
  double height = MediaQuery.of(context).size.height;
  return height;
}

double getWidth(context) {
  double width = MediaQuery.of(context).size.width;
  return width;
}

String? city = '';
Locale? locale;

String? formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(date);
  String month = formatted.toString().substring(5, 7);
  String day = formatted.toString().substring(8, 10);
  String year = formatted.toString().substring(0, 4);
  return '$day ${months[int.parse(month) - 1]} $year';
}

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

GoogleTranslator translator = GoogleTranslator();
Future<String> translate(String translateText, String langCode) async {
  if (translateText == 'kg') {
    return 'kg';
  }
  var result = await translator.translate(translateText, to: langCode);
  return result.toString();
}

Future<String> fetchLocation(BuildContext context) async {
  while (city == '') {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      var position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .timeout(Duration(seconds: 5));
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
    } catch (e) {}
  }
  return city!;
}

Widget TranslatedText(String langCode, String text, TextStyle style) {
  if (langCode == 'en') {
    return Text(
      text,
      style: style,
    );
  }
  return Container(
      child: FutureBuilder(
          future: translate(text, langCode),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(
                snapshot.data.toString(),
                //overflow: TextOverflow.ellipsis,
                style: style,
              );
            } else {
              return Text(" ");
            }
          }));
}

Widget LocationText(String langCode, String text, TextStyle style) {
  return Container(
      child: FutureBuilder(
          future: translate(text, langCode),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TranslatedText(
                langCode,
                snapshot.data.toString(),
                style,
              );
            } else {
              return Text(" ");
            }
          }));
}
