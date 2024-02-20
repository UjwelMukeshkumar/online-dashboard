import 'package:flutter/material.dart';

class RestuarentPosOrderScreen extends StatefulWidget {
  const RestuarentPosOrderScreen({super.key});

  @override
  State<RestuarentPosOrderScreen> createState() => _RestuarentPosOrderScreenState();
}

class _RestuarentPosOrderScreenState extends State<RestuarentPosOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("R Pos Order Screen"),),
    );
  }
}