import 'package:flutter/material.dart';
import 'package:krushak/cards/scheme.dart';
import 'package:krushak/data/data.dart';

class Schemes extends StatefulWidget {
  const Schemes({Key? key}) : super(key: key);

  @override
  State<Schemes> createState() => _SchemesState();
}

class _SchemesState extends State<Schemes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: schemes.length,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Scheme(
                        scheme: schemes[i],
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
