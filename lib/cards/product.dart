import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krushak/data/data.dart';
import 'package:krushak/globals.dart';
import 'package:krushak/other_screens/product_screen.dart';
import 'package:page_transition/page_transition.dart';

class Product extends StatefulWidget {
  final Map<String, dynamic>? product;
  const Product({this.product});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              duration: Duration(milliseconds: 400),
              curve: Curves.bounceInOut,
              type: PageTransitionType.rightToLeft,
              child: ProductScreen(
                product: widget.product,
              )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 6,
              ),
              Container(
                  height: 140,
                  child: Image.asset(
                    widget.product!['url'],
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 13,
              ),
              Text(
                widget.product!['name'],
                style: TextStyle(
                    fontFamily: 'SemiBold', fontSize: 16, color: secondary),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey.shade500)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        widget.product!['quantity'],
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: secondary),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Rs. ${widget.product!['price']}',
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: secondary),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    'Rs. ${widget.product!['mrp']}',
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: Colors.grey.shade600),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                widget.product!['seller'],
                style: TextStyle(
                    fontFamily: 'Regular', fontSize: 14, color: secondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
