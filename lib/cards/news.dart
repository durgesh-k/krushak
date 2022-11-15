import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';

class News extends StatefulWidget {
  final Map<String, dynamic>? news;
  const News({Key? key, this.news}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context) - 36,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
                      widget.news!['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: getWidth(context) * 0.64,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TranslatedText(
                        langCode!,
                        widget.news!['title'],
                        TextStyle(
                            fontFamily: 'SemiBold',
                            color: secondary,
                            fontSize: 20),
                      ),
                      TranslatedText(
                        langCode!,
                        '${widget.news!['source']}',
                        TextStyle(
                            fontFamily: 'Medium',
                            fontSize: 14,
                            color: secondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              width: getWidth(context),
              child: TranslatedText(
                langCode!,
                widget.news!['description'],
                TextStyle(fontFamily: 'Regular', color: secondary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
