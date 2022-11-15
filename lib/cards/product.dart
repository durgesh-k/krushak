import 'package:cloud_firestore/cloud_firestore.dart';
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
                  child: Image.network(
                    widget.product!['url'],
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 13,
              ),
              TranslatedText(
                langCode!,
                widget.product!['name'],
                TextStyle(
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
                      child: TranslatedText(
                        langCode!,
                        '${widget.product!['quantity']} kg',
                        TextStyle(
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
                      child: TranslatedText(
                        langCode!,
                        'Rs. ${widget.product!['price']}',
                        TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: secondary),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  TranslatedText(
                    langCode!,
                    'Rs. ${widget.product!['mrp']}',
                    TextStyle(
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
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Seller")
                    .doc(widget.product!['by'])
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) return const SizedBox.shrink();
                  Map<String, dynamic> map =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return TranslatedText(
                    langCode!,
                    map['address'],
                    TextStyle(
                        fontFamily: 'Regular', fontSize: 14, color: secondary),
                  );
                },
              ),
              /*TranslatedText(
                widget.product!['seller'],
                style: TextStyle(
                    fontFamily: 'Regular', fontSize: 14, color: secondary),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
