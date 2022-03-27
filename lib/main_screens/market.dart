import 'package:flutter/material.dart';
import 'package:krushak/cards/product.dart';
import 'package:krushak/data/data.dart';
import 'package:krushak/globals.dart';

class Market extends StatefulWidget {
  final String? langCode;
  const Market({Key? key,this.langCode}) : super(key: key);

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: getWidth(context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey.shade200),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: (3 / 5),
                shrinkWrap: true,
                children: List.generate(
                    product.length,
                    (index) => Product(
                          product: product[index],
                        ))),
          )
        ],
      ),
    );
  }
}
