import 'package:flutter/material.dart';
import 'package:krushak/cards/agro_consultant.dart';
import 'package:krushak/cards/crop_prices.dart';
import 'package:krushak/data/data.dart';
import 'package:krushak/globals.dart';
import 'package:translator/translator.dart';

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
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    head1!,
                    style: TextStyle(
                        fontFamily: 'SemiBold', fontSize: 26, color: secondary),
                  ),
                ),
                Container(
                    height: 124,
                    child: Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: cropp.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, right: 0),
                                child: CropPrices(
                                  langCode: widget.langCode,
                                  title: cropp[i]['title'],
                                  url: cropp[i]['url'],
                                  quantity: cropp[i]['quantity'],
                                  price: cropp[i]['price'],
                                ),
                              );
                            }))),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    head2!,
                    style: TextStyle(
                        fontFamily: 'SemiBold', fontSize: 26, color: secondary),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: consultant.length,
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 4),
                          child: Consultants(
                            langCode: widget.langCode,
                            speciality: consultant[i]['speciality'],
                            title: consultant[i]['title'],
                            url: consultant[i]['url'],
                            education: consultant[i]['education'],
                            experience: consultant[i]['experience'],
                            contact: consultant[i]['contact'],
                          ),
                        );
                      }),
                ),
              ]));
  }
}
