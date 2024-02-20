// To parse this JSON data, do
//
//     final price1M = price1MFromJson(jsonString);

import 'dart:convert';

import 'dart:math';

Price1M price1MFromJson(String str) => Price1M.fromJson(json.decode(str));

String price1MToJson(Price1M data) => json.encode(data.toJson());

class Price1M {
  Price1M({
    required this.priceListNo,
    required this.priceListName,
    required this.price,
    required this.discount,
    required this.isInclusive,
    required this.Is_Inclusive,
    required this.margin,
    required this.cost,
    required this.taxRate,
    required this.gp,
  });

  int priceListNo;
  String priceListName;
  double price;
  double discount;
  String isInclusive;
  String Is_Inclusive;
  double margin;
  double cost;
  double taxRate;
  double gp;

  double get taxAmount {
    if (isTaxInclusive) {
      return netPrice * taxRate / (100 + taxRate);
    } else {
      return netPrice * taxRate / 100;
    }
  }

  double get discountAmount => price * discount / 100.0;
  double get netPrice => price - discountAmount;

  // double get dicoutPercent=>discount/price*100;
  bool get isTaxInclusive => isInclusive == "Y";

  updateDiscountPercent(String value) {
    discount = double.tryParse(value) ?? 0;
  }

  updateNetPrice(String value) {
    double netPrice = double.tryParse(value) ?? 0;
    discount = (price - netPrice) / price * 100.0;
  }

  updateGpPercent(String value) {
    double netPrice = 0;
    double gp = (double.tryParse(value) ?? 0) / 100;
    if (isTaxInclusive) {
      var price = cost / (1 - gp);
      netPrice = price + price * taxRate / (100 + taxRate);
    } else {
      netPrice = cost / (1 - gp);
    }
    updateNetPrice(netPrice.toString());
  }

  updateInclusieve(bool value) {
    isInclusive = value ? "Y" : "N";
    updateDiscountPercent(discount.toString());
    print("Gp $gpCalculated");
  }

  double get gpCalculated {
    if (isTaxInclusive) {
      var gpc = (netPrice - taxAmount - cost) / (netPrice - taxAmount) * 100.0;
      gp = gpc;
      return gpc;
    } else {
      var gpc = (netPrice - cost) / netPrice * 100.0;
      gp = gpc;
      return gpc;
    }
  }

  // double get netPrice=>cost/(1-gp)+
  // When net price is changed
  // Discount percent = (price - net price)/(price) x 100
  // GP% = (Net price - tax amount - cost) / (net price - tax amount)x 100
  //gp% ->net price ,discount percent
  //DP-> net price ,gp%
  factory Price1M.fromJson(Map<String, dynamic> json) => Price1M(
        priceListNo: json["PriceListNo"] == null ? null : json["PriceListNo"],
        priceListName:
            json["PriceListName"] == null ? null : json["PriceListName"],
        price: json["Price"] == null ? null : json["Price"].toDouble(),
        discount: json["Discount"] == null ? null : json["Discount"].toDouble(),
        isInclusive: json["IsInclusive"] == null ? null : json["IsInclusive"],
        margin: json["Margin"] == null ? null : json["Margin"].toDouble(),
        cost: json["Cost"] == null ? null : json["Cost"].toDouble(),
        taxRate: json["TaxRate"] == null ? null : json["TaxRate"].toDouble(),
        gp: json["GP"] == null ? null : json["GP"].toDouble(),
        Is_Inclusive: '',
      );

  Map<String, dynamic> toJson() => {
        "PriceListNo": priceListNo == null ? null : priceListNo,
        "PriceListName": priceListName == null ? null : priceListName,
        "Price": price == null ? null : price,
        "Discount": discount == null ? null : discount,
        "IsInclusive": isInclusive == null ? null : isInclusive,
        "Margin": margin == null ? null : margin,
        "Cost": cost == null ? null : cost,
        "TaxRate": taxRate == null ? null : taxRate,
        "GP": gp == null ? null : gp,
      };
}
