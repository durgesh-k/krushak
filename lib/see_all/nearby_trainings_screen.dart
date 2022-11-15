import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krushak/cards/nearby_trainings.dart';
import 'package:krushak/globals.dart';
import 'package:page_transition/page_transition.dart';

class NearbyTrainingsSeeMore extends StatefulWidget {
  const NearbyTrainingsSeeMore({Key? key}) : super(key: key);

  @override
  State<NearbyTrainingsSeeMore> createState() => _NearbyTrainingsSeeMoreState();
}

class _NearbyTrainingsSeeMoreState extends State<NearbyTrainingsSeeMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            TranslatedText(
              langCode!,
              'Nearby Trainings',
              TextStyle(fontFamily: 'SemiBold', fontSize: 20, color: secondary),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.shade200,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    city == null
                        ? Container()
                        : TranslatedText(
                            langCode!,
                            city!,
                            TextStyle(
                                fontFamily: 'Medium',
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 16),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            /*InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.bounceInOut,
                      type: PageTransitionType.rightToLeft,
                      child: NearbyTrainingsAdd()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      /*TranslatedText(
                        'New',
                        style: TextStyle(
                            fontFamily: 'Medium',
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 16),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),*/
          ],
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Trainings")
                .where('city', isEqualTo: city)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  Map<String, dynamic> map =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: NearbyTrainings(
                      title: map['title'],
                      start: map['start'],
                      end: map['end'],
                      time: map['time'],
                      address: map['address'],
                      url: map['url'],
                    ),
                  );
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
