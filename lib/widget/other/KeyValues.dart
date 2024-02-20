import 'package:flutter/material.dart';

class KeyValues extends StatefulWidget {
  String keys = "";
  String values = "";
  int keyFlex;
  int valueFlex;

  KeyValues({
   required this.keys,
   required this.values,
    this.keyFlex = 1,
    this.valueFlex = 1,
  });

  @override
  _KeyValuesState createState() => _KeyValuesState();
}

class _KeyValuesState extends State<KeyValues> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: widget.keyFlex,
            child: Text(
              widget.keys,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Text(
            ": ",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(
              flex: widget.valueFlex,
              child: Text(
                widget.values,
                style: Theme.of(context).textTheme.bodyText1,
              )),
        ],
      ),
    );
  }
}
