import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

class Consultants extends StatefulWidget {
  final String? title;
  final String? education;
  final String? experience;
  final String? url;
  final String? speciality;
  final String? contact;
  final String? langCode;
  const Consultants({
    required this.langCode,
    this.url,
    this.speciality,
    this.title,
    this.education,
    this.contact,
    this.experience,
  });

  @override
  State<Consultants> createState() => _ConsultantState();
}

class _ConsultantState extends State<Consultants> {
  bool? screen_load = false;
  void translate() async {
    setState(() {
      screen_load = true;
    });
    final translator = GoogleTranslator();

    /*head1 = (await translator.translate(head1!, to: 'hi')).toString();
    head2 =
        (await translator.translate(head2!, to: widget.langCode!)).toString();*/

    setState(() {
      screen_load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launch("tel:${widget.contact}");
      },
      child: Container(
        width: getWidth(context) * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.network(
                        widget.url!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: getWidth(context) * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TranslatedText(
                          langCode!,
                          widget.title!,
                          TextStyle(
                              fontFamily: 'SemiBold',
                              color: secondary,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            TranslatedText(
                              langCode!,
                              '${widget.speciality},   ',
                              TextStyle(
                                  fontFamily: 'MediumItalic',
                                  fontSize: 16,
                                  color: secondary),
                            ),
                            TranslatedText(
                              langCode!,
                              '${widget.education}',
                              TextStyle(
                                  fontFamily: 'Medium',
                                  fontSize: 16,
                                  color: secondary),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.grey.shade200,
                                  border: Border.all(
                                      color: Colors.grey.shade400, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    TranslatedText(
                                      langCode!,
                                      'Experience:  ',
                                      TextStyle(
                                          fontFamily: 'SemiBold',
                                          fontSize: 14,
                                          color: secondary),
                                    ),
                                    TranslatedText(
                                      langCode!,
                                      '${widget.experience} Years',
                                      TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 14,
                                          color: secondary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: primary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TranslatedText(
                                  langCode!,
                                  'Contact >>',
                                  TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: secondary),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
