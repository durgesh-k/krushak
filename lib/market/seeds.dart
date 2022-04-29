import 'package:flutter/material.dart';
import 'package:krushak/cards/product.dart';
import 'package:krushak/data/data.dart';

class Seeds extends StatefulWidget {
  const Seeds({Key? key}) : super(key: key);

  @override
  State<Seeds> createState() => _SeedsState();
}

class _SeedsState extends State<Seeds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
          ),
        ],
      ),
    );
  }
}
