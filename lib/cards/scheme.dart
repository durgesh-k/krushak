import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';
import 'package:krushak/other_screens/schemes_screen.dart';
import 'package:page_transition/page_transition.dart';

class Scheme extends StatefulWidget {
  final Map<String, dynamic>? scheme;
  const Scheme({this.scheme});

  @override
  State<Scheme> createState() => _SchemeState();
}

class _SchemeState extends State<Scheme> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 400),
                curve: Curves.bounceInOut,
                type: PageTransitionType.rightToLeft,
                child: SchemesInfo(
                  scheme: widget.scheme,
                )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.grey.shade400)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    child: Image.asset(
                      widget.scheme!['image'],
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    children: [
                      Container(
                        width: getWidth(context) * 0.6,
                        child: TranslatedText(
                          langCode!,
                          widget.scheme!['name'],
                          TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 20,
                              color: secondary),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: getWidth(context) * 0.6,
                        child: TranslatedText(
                          langCode!,
                          widget.scheme!['from'],
                          TextStyle(
                              fontFamily: 'Medium',
                              fontSize: 16,
                              color: secondary),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: getWidth(context),
                child: TranslatedText(
                  langCode!,
                  widget.scheme!['description'],
                  TextStyle(
                      fontFamily: 'Medium', fontSize: 14, color: secondary),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              widget.scheme!['benefit'] != null
                  ? Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade400)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TranslatedText(
                                langCode!,
                                widget.scheme!['benefit'],
                                TextStyle(
                                    fontFamily: 'Medium',
                                    fontSize: 14,
                                    color: secondary),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
