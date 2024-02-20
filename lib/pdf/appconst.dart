import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppConst{
  static var displayDateFormat = DateFormat("dd/MM/yyyy");
  static var shortDate = DateFormat("d/M/yy");
  static var dateMMddYYY = DateFormat("MM/dd/yyyy");
  static var dateWebFormat = DateFormat("yyyy-MM-dd"); //
  static var dateWebFormatT = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  static String dbName="glowsis_offline.db";
  static String lastUploadedMillis="lastUploadedMillis";
  static int salesReturn=9;
  static int sales=7;
  static int SalesOrder =11;
  static int  Receipt = 17;

  static String addButtonWithoutParty="Add button without party";

}

const textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black12),
  borderRadius: BorderRadius.all(Radius.circular(10))
);
enum PayMentMode {Cash, Card, Bank, UPI,Cheque}

var inpuFormattersForNumber=[
FilteringTextInputFormatter.allow(
RegExp(r'^\d+\.?\d{0,2}')),
];