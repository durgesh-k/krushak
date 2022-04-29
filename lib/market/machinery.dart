import 'package:flutter/material.dart';
import 'package:krushak/cards/product.dart';
import 'package:krushak/data/data.dart';

class Machinery extends StatefulWidget {
  const Machinery({Key? key}) : super(key: key);

  @override
  State<Machinery> createState() => _MachineryState();
}

class _MachineryState extends State<Machinery> {
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
