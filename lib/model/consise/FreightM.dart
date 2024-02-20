// To parse this JSON data, do
//
//     final freightM = freightMFromJson(jsonString);

import 'dart:convert';

FreightM freightMFromJson(String str) => FreightM.fromJson(json.decode(str));

String freightMToJson(FreightM data) => json.encode(data.toJson());

class FreightM {
  FreightM({
    this.account,
    this.amount,
  });

  String? account;
  double? amount;

  factory FreightM.fromJson(Map<String, dynamic> json) => FreightM(
        account: json["Account"] == null ? null : json["Account"].toString(),
        amount: json["Amount"] == null ? null : json["Amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Account": account == null ? null : account,
        "Amount": amount == null ? null : amount,
      };
}
