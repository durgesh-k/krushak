import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatefulWidget {
  final Map<String, dynamic>? product;
  const ProductScreen({this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var description;

  /*void translate() async {
    final translator = GoogleTranslator();
    description = (await translator.translate(widget.product!['description'],
        from: 'en', to: 'hi'));
    setState(() {});
    print('desc -- $description');
  }*/

  @override
  void initState() {
    super.initState();
    //translate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: getHeight(context) * 0.4,
              decoration: BoxDecoration(color: Color(0xFFF7F7F7)),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ),
                    Row(
                      children: [
                        Container(
                          width: getWidth(context) * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product!['name'],
                                style: TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 22,
                                    color: secondary),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 2,
                                width: 100,
                                decoration: BoxDecoration(color: secondary),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Use',
                                style: TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 22,
                                    color: Colors.grey.shade400),
                              ),
                              Text(
                                widget.product!['use'],
                                style: TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: secondary),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: getHeight(context) * 0.28,
                            width: getWidth(context) * 0.5,
                            child: Image.asset(widget.product!['url']))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 2,
              width: getWidth(context),
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Description',
                style: TextStyle(
                    fontFamily: 'SemiBold', fontSize: 20, color: secondary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                widget.product!['description'],
                style: TextStyle(
                    fontFamily: 'Medium', fontSize: 18, color: secondary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Container(
                    width: getWidth(context) * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Grade',
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 22,
                              color: Colors.grey.shade400),
                        ),
                        Text(
                          widget.product!['grade'],
                          style: TextStyle(
                              fontFamily: 'Medium',
                              fontSize: 18,
                              color: secondary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: getWidth(context) * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 22,
                              color: Colors.grey.shade400),
                        ),
                        Text(
                          widget.product!['quantity'],
                          style: TextStyle(
                              fontFamily: 'Medium',
                              fontSize: 18,
                              color: secondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Container(
                    width: getWidth(context) * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Target Crops',
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 22,
                              color: Colors.grey.shade400),
                        ),
                        Text(
                          widget.product!['targetCrops'],
                          style: TextStyle(
                              fontFamily: 'Medium',
                              fontSize: 18,
                              color: secondary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: getWidth(context) * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Form',
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 22,
                              color: Colors.grey.shade400),
                        ),
                        Text(
                          widget.product!['form'],
                          style: TextStyle(
                              fontFamily: 'Medium',
                              fontSize: 18,
                              color: secondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Container(
                width: getWidth(context) * 0.4,
                child: Text(
                  widget.product!['seller'],
                  style: TextStyle(
                      fontFamily: 'Medium', fontSize: 18, color: secondary),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  launch("tel:${widget.product!['contact']}");
                },
                child: Container(
                  height: 50,
                  width: getWidth(context) * 0.3,
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      'Contact',
                      style: TextStyle(
                          fontFamily: 'Medium', fontSize: 18, color: secondary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
