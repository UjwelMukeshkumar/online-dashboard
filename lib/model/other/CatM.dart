// To parse this JSON data, do
//
//     final catM = catMFromJson(jsonString);

import 'dart:convert';

CatM catMFromJson(String str) => CatM.fromJson(json.decode(str));

String catMToJson(CatM data) => json.encode(data.toJson());

class CatM {
  CatM({
   required this.itemGroup,
   required this.salesAmount,
   required this.quantity,
   required this.grossProfit,
   required this.gpPercent,
   required this.salesPercentage,
  });

  String itemGroup;
  double salesAmount;
  double quantity;
  double grossProfit;
  double gpPercent;
  double salesPercentage;

  factory CatM.fromJson(Map<String, dynamic> json) => CatM(
        itemGroup: json["ItemGroup"] == null ? null : json["ItemGroup"],
        salesAmount:
            json["SalesAmount"] == null ? null : json["SalesAmount"].toDouble(),
        quantity: json["Quantity"] == null ? null : json["Quantity"].toDouble(),
        grossProfit:
            json["GrossProfit"] == null ? null : json["GrossProfit"].toDouble(),
        gpPercent:
            json["GPPercent"] == null ? null : json["GPPercent"].toDouble(),
        salesPercentage: json["SalesPercentage"] == null
            ? null
            : json["SalesPercentage"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ItemGroup": itemGroup == null ? null : itemGroup,
        "SalesAmount": salesAmount == null ? null : salesAmount,
        "Quantity": quantity == null ? null : quantity,
        "GrossProfit": grossProfit == null ? null : grossProfit,
        "GPPercent": gpPercent == null ? null : gpPercent,
        "SalesPercentage": salesPercentage == null ? null : salesPercentage,
      };
}
