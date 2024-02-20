import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyValCol extends StatelessWidget {
  String title;
  String value;
  CrossAxisAlignment crossAxisAlignment;

  TextAlign titleAlign;

  KeyValCol(
      {
        
        required this.title,
    required  this.value,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.titleAlign = TextAlign.start});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title.tr,
            style: Theme.of(context).textTheme.overline,
            textAlign: titleAlign,
          ),
          SizedBox(height: 4),
          Text(value,
              style:
                  Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
