import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RposDeleveryScreen extends StatefulWidget {
  const RposDeleveryScreen({super.key});

  @override
  State<RposDeleveryScreen> createState() => _RposDeleveryScreenState();
}

class _RposDeleveryScreenState extends State<RposDeleveryScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,automaticallyImplyLeading: false,elevation: 0.0,
        title: Text("Delivery"),),
    );
  }
}