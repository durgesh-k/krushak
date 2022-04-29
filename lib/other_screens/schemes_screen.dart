import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class SchemesInfo extends StatefulWidget {
  final Map<String, dynamic>? scheme;
  const SchemesInfo({this.scheme});

  @override
  State<SchemesInfo> createState() => _SchemesInfoState();
}

class _SchemesInfoState extends State<SchemesInfo> {
  int? steps;
  String? step = '';
  bool? load = true;
  void getSteps() {
    List<String>? steps = widget.scheme!['steps'];
    for (int i = 0; i < steps!.length; i++) {
      step = step! +
          '\n\n' +
          '${(i + 1).toString()}. ' +
          widget.scheme!['steps'][i];
    }
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSteps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
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
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        height: getHeight(context) * 0.9,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        height: 90,
                        width: 90,
                        child: Image.asset(
                          widget.scheme!['image'],
                          fit: BoxFit.contain,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Container(
                            width: getWidth(context) * 0.55,
                            child: Text(
                              widget.scheme!['name'],
                              style: TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 24,
                                  color: secondary),
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            width: getWidth(context) * 0.55,
                            child: Text(
                              widget.scheme!['from'],
                              style: TextStyle(
                                  fontFamily: 'Medium',
                                  fontSize: 18,
                                  color: secondary),
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: getWidth(context),
                  child: Text(
                    widget.scheme!['description'],
                    style: TextStyle(
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
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.scheme!['benefit'],
                                  style: TextStyle(
                                      fontFamily: 'Medium',
                                      fontSize: 14,
                                      color: secondary),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.grey.shade400)),
                  child: Column(
                    children: [
                      Container(
                        width: getWidth(context),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'How to apply?',
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 18,
                                color: secondary),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: load!
                              ? CircularProgressIndicator()
                              : Text(
                                  step!,
                                  style: TextStyle(
                                      fontFamily: 'Medium',
                                      fontSize: 16,
                                      color: secondary),
                                )),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
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
                  'Mode: ${widget.scheme!['mode']}',
                  style: TextStyle(
                      fontFamily: 'Medium', fontSize: 18, color: secondary),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  launch("${widget.scheme!['url']}", forceWebView: true);
                },
                child: Container(
                  height: 50,
                  width: getWidth(context) * 0.3,
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      'Go to website',
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
