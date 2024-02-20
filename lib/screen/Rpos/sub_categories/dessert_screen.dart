import 'package:flutter/material.dart';

class DessertScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dessert Items'),
      ),
      body: Center(
        child: Text('List of Dessert items goes here...'),
      ),
    );
  }
}
