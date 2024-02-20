import 'package:json_annotation/json_annotation.dart';

//part 'ItemSaleReportM.g.dart';

@JsonSerializable()
class ItemSaleReportM {
  String? Item_No;
  String? Item_Name;
  num? Quantity;
  num? SalesAmount;

  ItemSaleReportM({
   this.Item_No,
   this.Item_Name,
   this.Quantity,
  this.SalesAmount,
  });

  factory ItemSaleReportM.fromJson(Map<String, dynamic> json) {
    return ItemSaleReportM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Quantity: json["Quantity"],
      SalesAmount: json["SalesAmount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Item_No": this.Item_No,
      "Item_Name": this.Item_Name,
      "Quantity": this.Quantity,
      "SalesAmount": this.SalesAmount,
    };
  }
//

/*
  factory ItemSaleReportM.fromJson(Map<String, dynamic> json) =>
      _$ItemSaleReportMFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSaleReportMToJson(this);
*/
}
