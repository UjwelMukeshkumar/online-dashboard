import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/util/MyKey.dart';

class AppDateWidget extends StatefulWidget {
  String title;
  String? initialDate;
  ValueChanged<String> onDateSelected;

  AppDateWidget({this.title = "Date", this.initialDate,
      required this.onDateSelected});

  @override
  _AppDateWidgetState createState() => _AppDateWidgetState();
}

class _AppDateWidgetState extends State<AppDateWidget> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialDate == null) {
      widget.initialDate = MyKey.getCurrentDate();
    }
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: MyKey.displayDateFormat.parse(widget.initialDate!),
            initialDatePickerMode: DatePickerMode.day,
            firstDate: DateTime(2015),
            lastDate: DateTime(2101));
        if (picked != null)
          setState(() {
            widget.initialDate = MyKey.displayDateFormat.format(picked);
          });
        widget.onDateSelected(widget.initialDate!);
      },
      child: Row(
        children: [
          Text(widget.title, style: textTheme.caption),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${widget.initialDate}"),
          ),
          Icon(
            Icons.calendar_today_outlined,
            size: 14,
          )
        ],
      ),
    );
  }
}
