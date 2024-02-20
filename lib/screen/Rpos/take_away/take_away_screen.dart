import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TakeAwayScreen extends StatefulWidget {
  const TakeAwayScreen({super.key});

  @override
  State<TakeAwayScreen> createState() => _TakeAwayScreenState();
}

class _TakeAwayScreenState extends State<TakeAwayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,elevation: 0.0,centerTitle: true,
        title: Text("Take Away"),
      ),
    );
  }
}