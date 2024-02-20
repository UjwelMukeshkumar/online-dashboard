import 'package:json_annotation/json_annotation.dart';

//part 'ItemLstM.g.dart';

@JsonSerializable()
class ItemLstM {
  String Item_No;
  String Item_Name;
  String? Barcode;
  num? Qty;
  num? Price;
  num? OnHand;
  num? MaximumQty;
  num? MinimumQty;

  get triling => Price ?? OnHand;
  get leading => MaximumQty ?? Qty ?? MinimumQty ?? Barcode;

  ItemLstM({
  required  this.Item_No,
  required  this.Item_Name,
    this.Qty,
    this.Price,
    this.OnHand,
    this.MaximumQty,
    this.MinimumQty,
    this.Barcode,
  });

  factory ItemLstM.fromJson(Map<String, dynamic> json) {
    return ItemLstM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Barcode: json["Barcode"],
      Qty: json["Qty"],
      Price: json["Price"],
      OnHand: json["OnHand"],
      MaximumQty: json["MaximumQty"],
      MinimumQty: json["MinimumQty"],
    );
  }
//

/*
  factory ItemLstM.fromJson(Map<String, dynamic> json) => _$ItemLstMFromJson(json);

  Map<String, dynamic> toJson() => _$ItemLstMToJson(this);
*/
}
