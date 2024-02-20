// To parse this JSON data, do
//
//     final transactionM = transactionMFromJson(jsonString);

import 'dart:convert';

TransactionM transactionMFromJson(String str) =>
    TransactionM.fromJson(json.decode(str));

String transactionMToJson(TransactionM data) => json.encode(data.toJson());

class TransactionM {
  TransactionM({
  required  this.mMonth,
  required  this.total,
  required  this.yYear,
  required  this.amount,
  });

  String mMonth;
  double total;
  double amount;
  DateTime yYear;
  double get getValue => amount ?? total;

  factory TransactionM.fromJson(Map<String, dynamic> json) => TransactionM(
        mMonth: json["MMonth"] == null ? null : json["MMonth"],
        total: json["Total"] == null ? null : json["Total"].toDouble(),
        amount: json["Amount"] == null ? null : json["Amount"].toDouble(),
        //yYear: json["YYear"] == null ? null : DateTime.parse(json["YYear"]),
        yYear:  DateTime.parse(json["YYear"]),
      );

  Map<String, dynamic> toJson() => {
        "MMonth": mMonth == null ? null : mMonth,
        "Total": total == null ? null : total,
        "Amount": amount == null ? null : amount,
        "YYear": yYear == null ? null : yYear.toIso8601String(),
      };
}
