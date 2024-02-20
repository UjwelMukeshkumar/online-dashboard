import 'package:flutter/material.dart';

class KeyValuesApproveItem extends StatefulWidget {
  String keys = "";
  String values = "";

  KeyValuesApproveItem({required this.keys, required this.values});

  @override
  _KeyValuesApproveItemState createState() => _KeyValuesApproveItemState();
}

class _KeyValuesApproveItemState extends State<KeyValuesApproveItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 4),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Text(
                  widget.keys,
                  style: Theme.of(context).textTheme.subtitle2!.apply(fontSizeFactor: 1.3),
                ),
              ),
              Text(": ",style: Theme.of(context).textTheme.subtitle2,),
              Expanded(
                  flex: 10,
                  child: Text(widget.values,style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeFactor: 1.3),)),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black38,
          ),
        ],
      ),
    );
  }
}
