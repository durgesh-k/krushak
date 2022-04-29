import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';

class NearbyTrainings extends StatefulWidget {
  final String? title;
  final String? start;
  final String? end;
  final String? time;
  final String? address;
  final String? url;
  const NearbyTrainings(
      {this.title, this.start, this.end, this.time, this.address, this.url});

  @override
  State<NearbyTrainings> createState() => _NearbyTrainingsState();
}

class _NearbyTrainingsState extends State<NearbyTrainings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context) * 0.7,
      //height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Image.network(
                      widget.url!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: getWidth(context) * 0.44,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title!,
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            color: secondary,
                            fontSize: 20),
                      ),
                      /*Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            '${widget.start} to ${widget.end} ${widget.time}',
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: secondary),
                          ),
                        ),
                      )*/
                      Text(
                        '${widget.address}',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: secondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: getWidth(context),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black.withOpacity(0.3))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.start}-${widget.end} ${widget.time}',
                    style: TextStyle(fontFamily: 'SemiBold', color: secondary),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
