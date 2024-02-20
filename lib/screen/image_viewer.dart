import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MyImageViewer extends StatelessWidget {
  String selectedImageUrl;

  MyImageViewer({required this.selectedImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image"),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(selectedImageUrl),
      ),
    );
  }
}



