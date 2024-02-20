import 'package:flutter/material.dart';
import 'package:glowrpt/util/MyKey.dart';

class MenuItemIcon extends StatefulWidget {
  GestureTapCallback onTap;
  IconData iconData;
  String title;
  Color? color;

  MenuItemIcon({required this.onTap, required this.iconData,
      required this.title,
       this.color});

  @override
  _MenuItemIconState createState() => _MenuItemIconState();
}

class _MenuItemIconState extends State<MenuItemIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
            color: widget.color,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    widget.iconData,
                    color: Color(MyKey.hexToInt("ff0000aa")),
                    size: 35,
                  ),
                  SizedBox(
                    width: 18,
                    height: 2,
                  ),
                  Text(widget.title)
                ],
              ),
            )),
      ),
    );
  }
}
