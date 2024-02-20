import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';
import 'package:rxdart/rxdart.dart';
import 'package:speedometer/speedometer.dart';

class SpedoMeterWidget extends StatefulWidget {
  double counter;

  SpedoMeterWidget({Key? key, this.counter = 0}) : super(key: key);

  @override
  _SpedoMeterWidgetState createState() => _SpedoMeterWidgetState();
}

class _SpedoMeterWidgetState extends State<SpedoMeterWidget> {
  PublishSubject<double> eventObservable = new PublishSubject();
  double _lowerValue = 20.0;
  double _upperValue = 40.0;
  int start = 0;
  int end = 60;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      eventObservable.add(widget.counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(38.0),
        child: SpeedOMeter(
            start: start,
            end: end,
            highlightStart: (_lowerValue / end),
            highlightEnd: (_upperValue / end),
            themeData: ThemeData(
              primaryColor: Colors.blue,
              //hintColor: Colors.black,
              // backgroundColor: Colors.grey,
              colorScheme: ThemeData().colorScheme.copyWith(
                    primary: Colors.green,
                    // background: Colors.grey,
                    secondary: Colors.grey,
                  ),
            ),
            eventObservable: this.eventObservable),
      ),
    );
  }
}
