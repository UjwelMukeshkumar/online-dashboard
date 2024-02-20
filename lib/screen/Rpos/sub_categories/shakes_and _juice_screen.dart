import 'package:flutter/material.dart';

class ShakesAndJuice extends StatelessWidget {
  final List<String> categoryItems = [
    "Lemon Juice"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shakes and juices Items'),
      ),
      body: Center(
        child: Text('List of shakes and juices items goes here...'),
      ),
    );
  }
}
