import 'package:flutter/material.dart';
import 'package:krushak/cards/agro_consultant.dart';
import 'package:krushak/cards/crop_prices.dart';
import 'package:krushak/data/data.dart';
import 'package:krushak/globals.dart';

class AgriInfo extends StatefulWidget {
  const AgriInfo({Key? key}) : super(key: key);

  @override
  State<AgriInfo> createState() => _AgriInfoState();
}

class _AgriInfoState extends State<AgriInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          'Crop prices',
          style:
              TextStyle(fontFamily: 'SemiBold', fontSize: 26, color: secondary),
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
                      padding: const EdgeInsets.only(left: 18.0, right: 0),
                      child: CropPrices(
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
          'Agro consultant',
          style:
              TextStyle(fontFamily: 'SemiBold', fontSize: 26, color: secondary),
        ),
      ),
      Expanded(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: consultant.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
                child: Consultants(
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
