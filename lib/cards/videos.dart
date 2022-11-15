import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';

class Videos extends StatefulWidget {
  final String? title;
  final String? source;
  final String? url;
  final String? creator;
  const Videos({this.title, this.source, this.url, this.creator});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context) * 0.7,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 4,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: Image.asset(
                    widget.url!,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(color: Colors.black.withOpacity(0.1)),
                Center(
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: primary!.withOpacity(0.5)),
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white.withOpacity(0.7),
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: TranslatedText(
                langCode!,
                widget.title!,
                TextStyle(
                    fontFamily: 'SemiBold', fontSize: 20, color: secondary),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  child: TranslatedText(
                    langCode!,
                    widget.creator!,
                    TextStyle(
                        fontFamily: 'Medium', fontSize: 18, color: secondary),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: secondary),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: TranslatedText(
                    langCode!,
                    widget.source!,
                    TextStyle(
                        fontFamily: 'MediumItalic',
                        fontSize: 15,
                        color: secondary),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
