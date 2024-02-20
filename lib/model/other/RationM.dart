// To parse this JSON data, do
//
//     final rationM = rationMFromJson(jsonString);

import 'dart:convert';

RationM rationMFromJson(String str) => RationM.fromJson(json.decode(str));

String rationMToJson(RationM data) => json.encode(data.toJson());

class RationM {
  RationM({
   required this.currentRatio,
   required this.daySalesOutstanding,
   required this.daysPayableOutstanding,
   required this.quickRatio,
   required this.cashIn,
   required this.cashOut,
  });

  double currentRatio;
  double daySalesOutstanding;
  double daysPayableOutstanding;
  double quickRatio;
  double cashIn;
  double cashOut;

  factory RationM.fromJson(Map<String, dynamic> json) => RationM(
        currentRatio:
            json["CurrentRatio"] == null ? null : json["CurrentRatio"],
        daySalesOutstanding: json["Day_Sales_Outstanding"] == null
            ? null
            : json["Day_Sales_Outstanding"].toDouble(),
        daysPayableOutstanding: json["Days_Payable_Outstanding"] == null
            ? null
            : json["Days_Payable_Outstanding"],
        quickRatio: json["QuickRatio"] == null ? null : json["QuickRatio"],
        cashIn: json["CashIn"] == null ? null : json["CashIn"].toDouble(),
        cashOut: json["CashOut"] == null ? null : json["CashOut"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "CurrentRatio": currentRatio == null ? null : currentRatio,
        "Day_Sales_Outstanding":
            daySalesOutstanding == null ? null : daySalesOutstanding,
        "Days_Payable_Outstanding":
            daysPayableOutstanding == null ? null : daysPayableOutstanding,
        "QuickRatio": quickRatio == null ? null : quickRatio,
        "CashIn": cashIn == null ? null : cashIn,
        "CashOut": cashOut == null ? null : cashOut,
      };
}
