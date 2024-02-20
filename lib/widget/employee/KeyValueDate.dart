import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/util/MyKey.dart';


class KeyValueDate extends StatefulWidget {
  String labelText;
  final TextEditingController controller;
   DateTime dateTime;
//  String dateData;
  final GestureTapCallback onTap;


  @override
  _KeyValueDateState createState() => _KeyValueDateState();

  KeyValueDate({
   required this.controller,
    this.labelText = "Select date",
   required this.dateTime,
   required this.onTap
  });
}

class _KeyValueDateState extends State<KeyValueDate> {
  @override
  void initState() {
    
    super.initState();
//    widget. dateData=MyKey.displayDateFormat.format(widget.dateTime??DateTime.now());

  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 4,bottom: 4),
      child: InkWell(
        child: Stack(
          alignment: Alignment.bottomLeft,
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.only(top: 4,bottom: 4),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(widget.labelText,style: Theme.of(context).textTheme.headline4!.apply(fontSizeFactor: .5)),
                   Padding(
                     padding: const EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 8),
                     child: Column(
                       children: <Widget>[
                         Text(widget.controller.text,style: Theme.of(context).textTheme.subtitle2),
                       ],
                     ),
                   ),
                 ],),
             ),
             Divider(
               thickness: 1,
               color: Colors.black38,
             ),
           ],

        ),
        onTap: () async {
          var selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              initialDate: MyKey.displayDateFormat.parse(widget.controller.text));

          String strDate=MyKey.displayDateFormat.format(selectedDate!);
          setState(() {
            widget.controller.text=strDate;
//            widget.dateData=strDate;
//            widget.dateTime=selectedDate;
          });
          widget.onTap();
        },
      ),
    );
  }
}
