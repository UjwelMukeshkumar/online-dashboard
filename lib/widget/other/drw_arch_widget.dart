import 'package:flutter/material.dart';
import 'dart:math';

import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';

class DrawArchWidget extends StatelessWidget {
  double readingPercent;
  String text;
  double stroke;
  List<Color> colorList;

  DrawArchWidget({
   required this.readingPercent,
   required this.text,
   required this.stroke,
   required this.colorList,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        AspectRatio(
            aspectRatio: 2,
            child: CustomPaint(
                painter: OpenPainter(-180, 60, colorList.first, stroke))),
        AspectRatio(
            aspectRatio: 2,
            child: CustomPaint(
                painter: OpenPainter(-120, 60, colorList[1], stroke))),
        AspectRatio(
            aspectRatio: 2,
            child: CustomPaint(
                painter: OpenPainter(-60, 60, colorList.last, stroke))),
        AspectRatio(
            aspectRatio: 2,
            child: CustomPaint(
                painter: OpenPainter(-180 * (100 - readingPercent) / 100, 1,
                    Colors.black, stroke))),
        AspectRatio(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              MyKey.currencyFromat(text, sign: "", decimmalPlace: 0),
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.black),
            ),
          ),
          aspectRatio: 2,
        )
      ],
    );
  }
}

class OpenPainter extends CustomPainter {
  double startAngle;
  double sweepAngle;
  Color color;
  double stroke;

  OpenPainter(this.startAngle, this.sweepAngle, this.color, this.stroke);

  @override
  void paint(Canvas canvas, Size size) {
    // double stroke = 15;
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke * 2;
    //draw arc
    var height = size.width - (stroke * 2);
    canvas.drawArc(
        Offset(stroke, stroke) & Size(height, height),
        (pi / 180) * startAngle, //radians
        (pi / 180) * sweepAngle, //radians
        // 1,2,
        false,
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
