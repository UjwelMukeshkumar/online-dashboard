// import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/widget/other/app_card.dart';

import 'package:carousel_slider/carousel_slider.dart';
// import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
class CaroserSliderWidget extends StatelessWidget {
  List<String> imageAssetsList = [
    "assets/slider/A12.jpeg",
    "assets/slider/A13.jpeg",
    "assets/slider/A14.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 6 / 3,
        child: AppCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            // Text("Work in progress...")
            CarouselSlider(
              items: imageAssetsList.map((e) => Image.asset(e,fit: BoxFit.cover,)).toList(),
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1
                // aspectRatio: 5/2
              ),
            ),
          ),
        ));
  }
}
