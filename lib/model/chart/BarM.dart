import 'package:flutter/cupertino.dart';

class CustomeBarStack {
  List<BarM> barList;
  double yMax;
  List<String> xLabel;
  double barWidth;
  // double barSpace;
  double leftMargin;
  double bottomMargin;
  double rightMargin;

  CustomeBarStack({
    required this.barList,
    required this.yMax,
    required this.xLabel,
    required this.barWidth,
    // this.barSpace,
    required this.leftMargin,
    required this.bottomMargin,
    required this.rightMargin,
  });
}

class BarM {
  List<BarStack> barStacks;

  BarM({
    required this.barStacks,
  });
}

class BarStack {
  Color color;
  String text;
  double value;

  BarStack({
  required this.color,
  required this.text,
  required this.value,
  });
}
