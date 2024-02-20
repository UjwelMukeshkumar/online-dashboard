import 'package:flutter/material.dart';
import 'package:glowrpt/util/Constants.dart';

class AppCard extends StatelessWidget {
  Widget child;

  AppCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      elevation: CardProperty.elivation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CardProperty.radiuos),
      ),
      child: child,
    );
  }
}
