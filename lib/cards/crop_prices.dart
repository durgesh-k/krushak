import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';
import 'package:translator/translator.dart';

class CropPrices extends StatefulWidget {
  final String? title;
  final String? quantity;
  final String? price;
  final String? url;
  final String? langCode;
  const CropPrices({
    required this.langCode,
    this.url,
    this.title,
    this.quantity,
    this.price,
  });

  @override
  State<CropPrices> createState() => _CropPricesState();
}

class _CropPricesState extends State<CropPrices> {
  bool screen_load = false;

  @override
  void initState() {
    super.initState();
    /*if (widget.langCode == 'hi') {
      translate();
    } else {
      setState(() {
        title = widget.title;
        quantity = widget.quantity;
        price = widget.price;
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return screen_load
        ? Container(
            height: getHeight(context),
            child: Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
              color: primary,
            )))
        : Container(
            width: getWidth(context) * 0.7,
            height: 200,
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
                        child: Image.asset(
                          widget.url!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        width: getWidth(context) * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              widget.langCode!,
                              widget.title!,
                              TextStyle(
                                  fontFamily: 'SemiBold',
                                  color: secondary,
                                  fontSize: 20),
                            ),
                            Row(
                              children: [
                                TranslatedText(
                                  langCode!,
                                  "Today's Arrival: ",
                                  TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: secondary),
                                ),
                                TranslatedText(
                                  langCode!,
                                  widget.quantity!,
                                  TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: secondary),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: primary),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TranslatedText(
                                  langCode!,
                                  'Rs. ${widget.price}/quintal',
                                  TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 18,
                                      color: secondary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
