import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class Consultants extends StatefulWidget {
  final String? title;
  final String? education;
  final String? experience;
  final String? url;
  final String? speciality;
  final int? contact;
  const Consultants({
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      widget.url!,
                      fit: BoxFit.cover,
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
                        Text(
                          widget.title!,
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              color: secondary,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.speciality},   ',
                              style: TextStyle(
                                  fontFamily: 'MediumItalic',
                                  fontSize: 16,
                                  color: secondary),
                            ),
                            Text(
                              '${widget.education}',
                              style: TextStyle(
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
                                    Text(
                                      'Experience:  ',
                                      style: TextStyle(
                                          fontFamily: 'SemiBold',
                                          fontSize: 14,
                                          color: secondary),
                                    ),
                                    Text(
                                      '${widget.experience}',
                                      style: TextStyle(
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
                                child: Text(
                                  'Contact >>',
                                  style: TextStyle(
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
