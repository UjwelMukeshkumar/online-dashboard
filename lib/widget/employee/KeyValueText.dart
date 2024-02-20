import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class KeyValueText extends StatefulWidget {
  String labelText;
  String value;

  @override
  _KeyValueTextState createState() => _KeyValueTextState();

  KeyValueText({ this.labelText = "", required this.value});
}

class _KeyValueTextState extends State<KeyValueText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: InkWell(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.labelText,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .apply(fontSizeFactor: .5)),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 8, right: 8, bottom: 8),
                    child: Column(
                      children: <Widget>[
                        Text(widget.value,
                            style: Theme.of(context).textTheme.subtitle2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
