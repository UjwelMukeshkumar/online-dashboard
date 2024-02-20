import 'package:json_annotation/json_annotation.dart';
//part 'Quantity.g.dart';

@JsonSerializable()
class Quantity {
  double PurchaseQuantity;
  double SalesQuantity;
  double SalesReturnQuantity;
  double PurchaseReturnQuantity;
  double GoodsReceiptQuantity;
  double GoodsIssueQuantity;
  double ProductionQuantit;

  Quantity({
  required this.PurchaseQuantity,
  required this.SalesQuantity,
  required this.SalesReturnQuantity,
  required this.PurchaseReturnQuantity,
  required this.GoodsReceiptQuantity,
  required this.GoodsIssueQuantity,
  required this.ProductionQuantit,
  });

  Map<String, dynamic> toJson() {
    return {
      "PurchaseQuantity": this.PurchaseQuantity,
      "SalesQuantity": this.SalesQuantity,
      "SalesReturnQuantity": this.SalesReturnQuantity,
      "PurchaseReturnQuantity": this.PurchaseReturnQuantity,
      "GoodsReceiptQuantity": this.GoodsReceiptQuantity,
      "GoodsIssueQuantity": this.GoodsIssueQuantity,
      "ProductionQuantit": this.ProductionQuantit,
    };
  }

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return Quantity(
      PurchaseQuantity: json["PurchaseQuantity"],
      SalesQuantity: json["SalesQuantity"],
      SalesReturnQuantity: json["SalesReturnQuantity"],
      PurchaseReturnQuantity: json["PurchaseReturnQuantity"],
      GoodsReceiptQuantity: json["GoodsReceiptQuantity"],
      GoodsIssueQuantity: json["GoodsIssueQuantity"],
      ProductionQuantit: json["ProductionQuantit"]??0.0,
    );
  }
//

/*
  factory Quantity.fromJson(Map<String, dynamic> json) =>
      _$QuantityFromJson(json);

  Map<String, dynamic> toJson() => _$QuantityToJson(this);
*/
}
