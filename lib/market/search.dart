import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:krushak/cards/product.dart';
import 'package:krushak/globals.dart';

class MarketSearch extends StatefulWidget {
  const MarketSearch({Key? key}) : super(key: key);

  @override
  State<MarketSearch> createState() => _MarketSearchState();
}

class _MarketSearchState extends State<MarketSearch> {
  TextEditingController? searchValue = TextEditingController();
  double? closeOpacity = 0.0;

  var stream = FirebaseFirestore.instance
      .collection('Market')
      .orderBy('name', descending: false)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: getWidth(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.grey.shade100),
                child: TextField(
                  controller: searchValue,
                  style: TextStyle(fontFamily: 'Regular', color: secondary),
                  onChanged: (value) async {
                    setState(() {
                      stream = FirebaseFirestore.instance
                          .collection('Market')
                          .orderBy('name', descending: false)
                          .where('name', isGreaterThanOrEqualTo: value)
                          .where('name', isLessThan: value + 'z')
                          .snapshots();
                      /*.startAt([value]).endAt(
                              [value + '\uf8ff']).snapshots();*/
                    });
                    if (value.length != 0) {
                      setState(() {
                        closeOpacity = 1.0;
                      });
                    } else {
                      setState(() {
                        closeOpacity = 0.0;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(0),
                      suffixIcon: InkWell(
                        onTap: () => searchValue!.clear(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AnimatedOpacity(
                              opacity: closeOpacity!,
                              duration: Duration(milliseconds: 400),
                              child: Icon(Icons.close)),
                        ),
                      ),
                      prefixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.search)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none),
                      hintStyle: TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 18,
                          color: Colors.grey.shade400),
                      hintText: "Search"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: stream,
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
                          print('map22--$map');
                          return Product(
                            product: map,
                          );
                        }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
