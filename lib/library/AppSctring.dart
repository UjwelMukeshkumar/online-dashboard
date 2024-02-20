import 'package:flutter/material.dart';
import 'package:glowrpt/util/MyKey.dart';


extension AppString on String{
  get eachWordFirstLetter=>this.split(" ")
      .map((element) => element.characters.first)
      .take(2)
      .join();

  get toDouble=>double.tryParse(this)??0;
  DateTime get toDate=>MyKey.displayDateFormat.parse(this);
  DateTime get tDateTodateTime=>MyKey.dateWebFormatT.parse(this);
  DateTime get toPickerDate=>MyKey.pickerDate.parse(this);
}