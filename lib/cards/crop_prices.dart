import 'package:flutter/material.dart';
import 'package:krushak/globals.dart';

class CropPrices extends StatefulWidget {
  final String? title;
  final String? quantity;
  final String? price;
  final String? url;
  const CropPrices({
    this.url,
    this.title,
    this.quantity,
    this.price,
  });

  @override
  State<CropPrices> createState() => _CropPricesState();
}

class _CropPricesState extends State<CropPrices> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context) * 0.7,
      height: 200,
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
                  child: Image.asset(
                    widget.url!,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: getWidth(context) * 0.4,
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
                      Row(
                        children: [
                          Text(
                            "Today's Arrival: ",
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: secondary),
                          ),
                          Text(
                            '${widget.quantity}',
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: secondary),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: primary),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Rs. ${widget.price}/quintal',
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 18,
                                color: secondary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
