import 'package:flutter/material.dart';
import 'package:glowrpt/util/MyKey.dart';

class PriceWidget extends StatelessWidget {
  double price;

  PriceWidget({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Theme.of(context).primaryColor),
      child: Text(
        "₹ ${priceToString(price)}",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
