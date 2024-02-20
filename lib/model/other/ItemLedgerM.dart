import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:json_annotation/json_annotation.dart';

// part 'ItemLedgerM.g.dart';

@JsonSerializable()
class ItemLedgerM {
  ItemLedgerM({
    this.Item_No,
    this.Item_Name,
     this.StockValue,
     this.Onhand,
    this.Grp_Id,
    this.GrpName,
    this.Id,
    this.Name,
    this.UOM,
  });

  String? Item_No;
  String? Item_Name;
  double? StockValue;
  double? Onhand;
  int? Grp_Id;
  String? GrpName;
  dynamic Id;
  String? Name;
  String? UOM;

  dynamic itemId() => Item_No ?? Grp_Id ??  Id ?? "";
  dynamic title() => Item_Name ?? GrpName ?? Name ?? "";
  Color getColor() =>
      StockValue! < 0 ? AppColor.negativeRed : AppColor.positiveGreen;

  Color getColorOnhand() =>
      Onhand! < 0 ? AppColor.negativeRed : AppColor.positiveGreen;

  factory ItemLedgerM.fromJson(Map<String, dynamic> json) {
    return ItemLedgerM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      StockValue: json["StockValue"],
      Onhand: json["Onhand"]??0.0,
      Grp_Id: json["Grp_Id"],
      GrpName: json["GrpName"],
      // Id: json["Id"]??"",
      Id: json["Id"]??0??"",
      Name: json["Name"],
      UOM: json["UOM"] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Item_No": this.Item_No,
      "Item_Name": this.Item_Name,
      "StockValue": this.StockValue,
      "Onhand": this.Onhand,
      "Grp_Id": this.Grp_Id,
      "GrpName": this.GrpName,
      "Id": this.Id,
      "Name": this.Name,
      "UOM": this.UOM,
    };
  } // Color getColor() =>AppColor.positiveGreen;

/*  factory ItemLedgerM.fromJson(Map<String, dynamic> json) =>
      _$ItemLedgerMFromJson(json);

  Map<String, dynamic> toJson() => _$ItemLedgerMToJson(this);*/

  @override
  String toString() {
    return "${itemId()} ${title()} $StockValue";
  }
}

//
////////////////////////////////////////////////////////////////////////
