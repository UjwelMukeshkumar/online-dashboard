// To parse this JSON data, do
//
//     final tDetailsM = tDetailsMFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

TDetailsM tDetailsMFromJson(String str) => TDetailsM.fromJson(json.decode(str));

String tDetailsMToJson(TDetailsM data) => json.encode(data.toJson());

class TDetailsM {
  TDetailsM({
  required this.rowNum,
  required this.category,
  required this.date,
  required this.balance,
  required this.Document,
  required this.Source_Type,
  required this.RunningTotal,
  required this.DocumentNo,
  });

  int rowNum;
  String category;
  String date;
  double balance;
  double RunningTotal;
  String Document;
  String Source_Type;
  num DocumentNo;

  factory TDetailsM.fromJson(Map<String, dynamic> json) => TDetailsM(
        rowNum: json["RowNum"] == null ? null : json["RowNum"],
        category: json["Category"] == null ? null : json["Category"],
        date: json["Date"] == null ? null : json["Date"],
        balance: json["Balance"] == null ? null : json["Balance"].toDouble(),
        RunningTotal: json["RunningTotal"] == null
            ? null
            : json["RunningTotal"].toDouble(),
        Document: json["Document"] == null ? null : json["Document"],
        Source_Type: json["Source_Type"] == null ? null : json["Source_Type"],
        DocumentNo: json["DocumentNo"] == null ? null : json["DocumentNo"],
      );

  Map<String, dynamic> toJson() => {
        "RowNum": rowNum == null ? null : rowNum,
        "Category": category == null ? null : category,
        "Date": date == null ? null : date,
        "Balance": balance == null ? null : balance,
        "RunningTotal": RunningTotal == null ? null : RunningTotal,
        "Source_Type": Source_Type == null ? null : Source_Type,
        "DocumentNo": DocumentNo == null ? null : DocumentNo,
      };
  @override
  String toString() {
    return "$rowNum $category ${DateFormat("dd MMM").format(DateFormat("dd/MM/yyyy").parse(date))} $balance $Document";
  }
}
