// To parse this JSON data, do
//
//     final salesLinesM = salesLinesMFromJson(jsonString);

import 'dart:convert';

SalesLinesM salesLinesMFromJson(String str) =>
    SalesLinesM.fromJson(json.decode(str));

String salesLinesMToJson(SalesLinesM data) => json.encode(data.toJson());

class SalesLinesM {
  SalesLinesM({
   required this.itemName,
   required this.quantity,
   required this.price,
   required this.discount,
   required this.discAmount,
   required this.uom,
   required this.netTotal,
   required this.batchCode,
   required this.taxcode,
   required this.cost,
   required this.gpPercent,
   required this.mrp,
   required this.taxAmount,
  });

  String itemName;
  int quantity;
  int price;
  int discount;
  int discAmount;
  String uom;
  double netTotal;
  String batchCode;
  String taxcode;
  double cost;
  double gpPercent;
  int mrp;
  double taxAmount;

  factory SalesLinesM.fromJson(Map<String, dynamic> json) => SalesLinesM(
        itemName: json["Item_Name"] == null ? null : json["Item_Name"],
        quantity: json["Quantity"] == null ? null : json["Quantity"],
        price: json["Price"] == null ? null : json["Price"],
        discount: json["Discount"] == null ? null : json["Discount"],
        discAmount: json["DiscAmount"] == null ? null : json["DiscAmount"],
        uom: json["UOM"] == null ? null : json["UOM"],
        netTotal: json["NetTotal"] == null ? null : json["NetTotal"].toDouble(),
        batchCode: json["BatchCode"] == null ? null : json["BatchCode"],
        taxcode: json["Taxcode"] == null ? null : json["Taxcode"],
        cost: json["Cost"] == null ? null : json["Cost"].toDouble(),
        gpPercent:
            json["GPPercent"] == null ? null : json["GPPercent"].toDouble(),
        mrp: json["MRP"] == null ? null : json["MRP"],
        taxAmount:
            json["TaxAmount"] == null ? null : json["TaxAmount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Item_Name": itemName == null ? null : itemName,
        "Quantity": quantity == null ? null : quantity,
        "Price": price == null ? null : price,
        "Discount": discount == null ? null : discount,
        "DiscAmount": discAmount == null ? null : discAmount,
        "UOM": uom == null ? null : uom,
        "NetTotal": netTotal == null ? null : netTotal,
        "BatchCode": batchCode == null ? null : batchCode,
        "Taxcode": taxcode == null ? null : taxcode,
        "Cost": cost == null ? null : cost,
        "GPPercent": gpPercent == null ? null : gpPercent,
        "MRP": mrp == null ? null : mrp,
        "TaxAmount": taxAmount == null ? null : taxAmount,
      };
}
