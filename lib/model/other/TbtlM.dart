import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glowrpt/util/Constants.dart';

TbtlM tbtlMFromJson(String str) => TbtlM.fromJson(json.decode(str));

String tbtlMToJson(TbtlM data) => json.encode(data.toJson());

class TbtlM {
  TbtlM({
   required this.aClassification,
   required this.code,
   required this.name,
   required this.amount,
    this.drCr,
   required this.type,
  });

  String aClassification;
  int code;
  String name;
  double amount;
  String? drCr;
  String type;
  Color? get rowColor {
    if (type == 'D') {
      return AppColor.backgroundDark;
    } else if (type == "H") {
      return AppColor.chartBacground;
    } else if (type == "L") {
      return Colors.white;
    }
  }

  factory TbtlM.fromJson(Map<String, dynamic> json) => TbtlM(
        aClassification:
            json["A_Classification"] == null ? null : json["A_Classification"],
        code: json["Code"] == null ? null : json["Code"],
        name: json["Name"] == null ? null : json["Name"],
        amount: json["Amount"] == null ? null : json["Amount"],
        drCr: json["Dr/Cr"] == null ? "" : json["Dr/Cr"],
        type: json["Type"] == null ? null : json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "A_Classification": aClassification == null ? null : aClassification,
        "Code": code == null ? null : code,
        "Name": name == null ? null : name,
        "Amount": amount == null ? null : amount,
        "Dr/Cr": drCr == null ? null : drCr,
        "Type": type == null ? null : type,
      };
}
