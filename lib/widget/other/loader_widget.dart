import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glowrpt/util/Constants.dart';
// import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class LoaderWidget extends StatefulWidget {
  @override
  _LoaderWidgetState createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
  double progressVal = 0.003;
  List loadingText = [
    "Loading.....",
    "Please Wait.....",
    "We are working for you.....",
    "Processing.....",
    "Preparing.....",
    "Validating.....",
    "Loading.....",
    "Please Wait.....",
    "We are working for you.....",
    "Processing.....",
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted)
        setState(() {
          progressVal = progressVal + 0.003;
          if (progressVal >= 1) {
            progressVal = 0;
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: LiquidCircularProgressIndicator(
          value: progressVal,
          // Defaults to 0.5.
          valueColor: AlwaysStoppedAnimation(AppColor.greenLigt),
          // Defaults to the current Theme's accentColor.
          backgroundColor: Colors.white,
          // Defaults to the current Theme's backgroundColor.
          borderColor: AppColor.green,
          borderWidth: 5.0,
          direction: Axis.horizontal,
          // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
          center: Text(
            getRandomText(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
    return Image.asset(
      "assets/source.gif",
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.fitHeight,
      // height: 125.0,
      // width: 125.0,
    );
  }

  String getRandomText() {
    // loadingText[];
    return loadingText[(progressVal * 10).toInt()];
  }
}
