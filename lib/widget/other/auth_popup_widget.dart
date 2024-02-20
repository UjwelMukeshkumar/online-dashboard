import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glowrpt/model/auth/RetDetailsM.dart';

class AuthPopupWidget extends StatefulWidget {
  RetDetailsM retDetailsM;

  AuthPopupWidget({required this.retDetailsM});

  @override
  State<AuthPopupWidget> createState() => _AuthPopupWidgetState();
}

class _AuthPopupWidgetState extends State<AuthPopupWidget> {
   Timer? timer;
  int intTick = 0;

  @override
  void initState() {
    
    super.initState();
    runTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text('Passkey only valid for ${50-intTick} sec'),
          Text(
            '${widget.retDetailsM.PassKey}',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  void runTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if(intTick==50){
        timer!.cancel();
        Navigator.pop(context);
      }
      if (intTick%5==0) {
        checkStatus();
      }
      setState(() {
        intTick++;
      });
    });
  }

  @override
  void dispose() {
    
    super.dispose();
    timer!.cancel();
  }

  void checkStatus() {

  }
}
