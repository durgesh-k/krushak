import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krushak/cards/product.dart';
import 'package:krushak/data/data.dart';
import 'package:krushak/globals.dart';

class Others extends StatefulWidget {
  const Others({Key? key}) : super(key: key);

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Market")
                  .where('category', isEqualTo: 'Others')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();
                if (snapshot.data!.docs.length == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: getHeight(context),
                      width: getWidth(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TranslatedText(
                            langCode!,
                            'No items to display',
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
                return GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: (3 / 5),
                    shrinkWrap: true,
                    children:
                        List.generate(snapshot.data!.docs.length, (index) {
                      Map<String, dynamic> map = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;
                      print('map--$map');
                      return Product(
                        product: map,
                      );
                    }));
              },
            ),
          ),
        ],
      ),
    );
  }
}
