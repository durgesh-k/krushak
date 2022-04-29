import 'package:flutter/material.dart';
import 'package:krushak/cards/product.dart';
import 'package:krushak/data/data.dart';

class Fertilizers extends StatefulWidget {
  const Fertilizers({Key? key}) : super(key: key);

  @override
  State<Fertilizers> createState() => _FertilizersState();
}

class _FertilizersState extends State<Fertilizers> {
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
