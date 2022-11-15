import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krushak/cards/agro_consultant.dart';
import 'package:krushak/cards/crop_prices.dart';
import 'package:krushak/cards/videos.dart';
import 'package:krushak/data/data.dart';
import 'package:krushak/globals.dart';
import 'package:translator/translator.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AgriInfo extends StatefulWidget {
  final String? langCode;
  const AgriInfo({Key? key, this.langCode}) : super(key: key);

  @override
  State<AgriInfo> createState() => _AgriInfoState();
}

class _AgriInfoState extends State<AgriInfo> {
  String? head1 = 'Crop Prices';
  String? head2 = 'Agro Consultant';
  bool? screen_load = false;

  Future<List<String>> extractData() async {
//Getting the response from the targeted url
    final response =
        await http.Client().get(Uri.parse('https://www.msamb.com/'));
    //Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {
      //Getting the html document from the response
      var document = parser.parse(response.body);
      try {
        //Scraping the first article title
        var responseString1 = document
            .getElementsByClassName('data-list')[0]
            .children[0]
            .children[0]
            .children[0];

        print(responseString1.text.trim());

        //Scraping the second article title
        var responseString2 = document
            .getElementsByClassName('articles-list')[0]
            .children[1]
            .children[0]
            .children[0];

        print(responseString2.text.trim());

        //Scraping the third article title
        var responseString3 = document
            .getElementsByClassName('articles-list')[0]
            .children[2]
            .children[0]
            .children[0];

        print(responseString3.text.trim());
        //Converting the extracted titles into string and returning a list of Strings
        return [
          responseString1.text.trim(),
          responseString2.text.trim(),
          responseString3.text.trim()
        ];
      } catch (e) {
        return ['', '', 'ERROR!'];
      }
    } else {
      return ['', '', 'ERROR: ${response.statusCode}.'];
    }
  }

  void translate() async {
    setState(() {
      screen_load = true;
    });
    final translator = GoogleTranslator();

    head1 = (await translator.translate(head1!, to: 'hi')).toString();
    head2 =
        (await translator.translate(head2!, to: widget.langCode!)).toString();

    setState(() {
      screen_load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.langCode == 'hi') {
      translate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen_load!
            ? Container(
                height: getHeight(context),
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: primary,
                )))
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TranslatedText(
                        langCode!,
                        'Learn',
                        TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 26,
                            color: secondary),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: primary!, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TranslatedText(
                            langCode!,
                            'See All >',
                            TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: secondary),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 260,
                  child: Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: videos.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          return Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 0),
                              child: InkWell(
                                onTap: () {
                                  launch(videos[i]['video'],
                                      forceWebView: true);
                                },
                                child: Videos(
                                  title: videos[i]['title'],
                                  source: videos[i]['source'],
                                  creator: videos[i]['creator'],
                                  url: videos[i]['url'],
                                ),
                              ));
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TranslatedText(
                    langCode!,
                    head2!,
                    TextStyle(
                        fontFamily: 'SemiBold', fontSize: 26, color: secondary),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Consultant")
                      .where('city', isEqualTo: city)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return const SizedBox.shrink();
                    if (snapshot.data!.docs.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          height: getHeight(context) / 3.3,
                          width: getWidth(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TranslatedText(
                                langCode!,
                                'No consultants near your area to display',
                                TextStyle(
                                    fontFamily: 'Medium',
                                    fontSize: 20,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, i) {
                            Map<String, dynamic> map = snapshot.data!.docs[i]
                                .data() as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 4),
                              child: Consultants(
                                langCode: widget.langCode,
                                speciality: map['speciality'],
                                title: map['name'],
                                url: map['url'],
                                education: map['education'],
                                experience: map['experience'],
                                contact: map['phone'],
                              ),
                            );
                          }),
                    );
                  },
                ),
              ]));
  }
}
