import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glowrpt/app.dart';

class ImageViewer extends StatelessWidget {
  var byte;
  ImageViewer(this.byte);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Image Viewer"),),
      body: Image.memory(Base64Decoder().convert(byte)),
    );
  }
}
