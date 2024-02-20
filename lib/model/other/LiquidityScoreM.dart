// To parse this JSON data, do
//
//     final liquidityScoreM = liquidityScoreMFromJson(jsonString);

import 'dart:convert';

import 'package:glowrpt/model/other/RationM.dart';
import 'package:glowrpt/model/other/TransactionHM.dart';
import 'package:glowrpt/model/other/TransactionM.dart';

LiquidityScoreM liquidityScoreMFromJson(String str) =>
    LiquidityScoreM.fromJson(json.decode(str));

String liquidityScoreMToJson(LiquidityScoreM data) =>
    json.encode(data.toJson());

class LiquidityScoreM {
  LiquidityScoreM({
   this.receviable,
   this.payable,
   this.cash,
   this.ratios,
   this.accountReceviable,
   this.accountPayable,
  });

  List<TransactionHm>? receviable;
  List<TransactionHm>? payable;
  List<TransactionM>? cash;
  List<RationM>? ratios;
  List<TransactionM>? accountReceviable;
  List<TransactionM>? accountPayable;

  factory LiquidityScoreM.fromJson(Map<String, dynamic> json) =>
  //  LiquidityScoreM(
  //       receviable:  List<TransactionHm>.from(
  //               json["Receviable"].map((x) => TransactionHm.fromJson(x))),
  //       payable: List<TransactionHm>.from(
  //               json["Payable"].map((x) => TransactionHm.fromJson(x))),
  //       cash: List<TransactionM>.from(
  //               json["Cash"].map((x) => TransactionM.fromJson(x))),
  //       ratios:  List<RationM>.from(
  //               json["Ratios"].map((x) => RationM.fromJson(x))),
  //       accountReceviable: List<TransactionM>.from(
  //               json["AccountReceviable"].map((x) => TransactionM.fromJson(x))),
  //       accountPayable:  List<TransactionM>.from(
  //               json["AccountPayable"].map((x) => TransactionM.fromJson(x))),
  //     );
      LiquidityScoreM(
        receviable: List<TransactionHm>.from(json['Receviable'].map((x)=>TransactionHm.fromJson(x))),
        payable: List<TransactionHm>.from(json["Payable"].map((x)=>TransactionHm.fromJson(x))),
        cash: List<TransactionM>.from(json["Cash"].map((x)=>TransactionM.fromJson(x))),
        ratios: List<RationM>.from(json["Ratios"].map((x)=>RationM.fromJson(x))),
        accountReceviable: List<TransactionM>.from(json["AccountReceviable"].map((x)=>TransactionM.fromJson(x))),
        accountPayable: List<TransactionM>.from(json["AccountPayable"].map((x)=>TransactionM.fromJson(x)))

        // receviable: json["Receviable"] == null
        //     ? null
        //     : List<TransactionHm>.from(
        //         json["Receviable"].map((x) => TransactionHm.fromJson(x))),
        // payable: json["Payable"] == null
        //     ? null
        //     : List<TransactionHm>.from(
        //         json["Payable"].map((x) => TransactionHm.fromJson(x))),
        // cash: json["Cash"] == null
        //     ? null
        //     : List<TransactionM>.from(
        //         json["Cash"].map((x) => TransactionM.fromJson(x))),
        // ratios: json["Ratios"] == null
        //     ? null
        //     : List<RationM>.from(
        //         json["Ratios"].map((x) => RationM.fromJson(x))),
        // accountReceviable: json["AccountReceviable"] == null
        //     ? null
        //     : List<TransactionM>.from(
        //         json["AccountReceviable"].map((x) => TransactionM.fromJson(x))),
        // accountPayable: json["AccountPayable"] == null
        //     ? null
        //     : List<TransactionM>.from(
        //         json["AccountPayable"].map((x) => TransactionM.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Receviable": receviable == null
            ? null
            : List<dynamic>.from(receviable!.map((x) => x)),
        "Payable":
            payable == null ? null : List<dynamic>.from(payable!.map((x) => x)),
        "Cash": cash == null ? null : List<dynamic>.from(cash!.map((x) => x)),
        "Ratios":
            ratios == null ? null : List<dynamic>.from(ratios!.map((x) => x)),
        "AccountReceviable": accountReceviable == null
            ? null
            : List<dynamic>.from(accountReceviable!.map((x) => x)),
        "AccountPayable": accountPayable == null
            ? null
            : List<dynamic>.from(accountPayable!.map((x) => x)),
      };
}
