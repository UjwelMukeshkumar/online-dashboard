import 'package:flutter/material.dart';
class KeyValueTextArea extends StatefulWidget {
  TextEditingController tec;
  String label;
  String errorMessage;
  int minLine;

  KeyValueTextArea({required this.tec,
      required this.label,this.errorMessage="Blank not allowed",this.minLine=4});

  @override
  _KeyValueTextAreaState createState() => _KeyValueTextAreaState();
}

class _KeyValueTextAreaState extends State<KeyValueTextArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text("${widget.label}",style: Theme.of(context)
              .textTheme
              .headline4!
              .apply(fontSizeFactor: .5)),
        ),
        TextFormField(
          controller: widget.tec,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          minLines: widget.minLine,
          decoration: InputDecoration(
              alignLabelWithHint: true,
//                            hintText: "Reason",
              border: OutlineInputBorder()
          ),
          validator: (text) {
            return text!.isEmpty ? widget.errorMessage : null;
          },
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
