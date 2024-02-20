import 'package:flutter/material.dart';

class MyMenuItem extends StatefulWidget {
  GestureTapCallback onTap;
  String title;

  MyMenuItem({required this.onTap, required this.title});

  @override
  _MyMenuItemState createState() => _MyMenuItemState();
}

class _MyMenuItemState extends State<MyMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4,right: 4),
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
          elevation: 10,
            child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(widget.title)],
          ),
        )),
      ),
    );
  }
}
