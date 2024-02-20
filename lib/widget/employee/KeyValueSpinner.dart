import 'package:flutter/material.dart';

class KeyValueSpinner extends StatefulWidget {
  String title = "Select expense";
  List<dynamic> modelList;
  dynamic initModel;
  String fieldName;
  ValueChanged<dynamic> onChanged;

  KeyValueSpinner({
   required this.title,
   required this.modelList,
   required this.initModel,
   required this.fieldName,
   required this.onChanged,
  });

  @override
  _KeyValueSpinnerState createState() => _KeyValueSpinnerState();
}

class _KeyValueSpinnerState extends State<KeyValueSpinner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${widget.title}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .apply(fontSizeFactor: .5)),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: DropdownButton<dynamic>(
                    isDense: true,
                    isExpanded: true,
                    underline: Container(),
                    items: widget.modelList
                        .map<DropdownMenuItem<dynamic>>((model) {
                      return DropdownMenuItem(
                        child: Text(
                          model["${widget.fieldName}"],
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        value: model,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        widget.onChanged(value);
                        widget.initModel = value;
                      });
                    },
                    value: widget.initModel,
//                    value: null,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black38,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
