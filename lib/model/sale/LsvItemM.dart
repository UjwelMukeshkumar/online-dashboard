import 'package:json_annotation/json_annotation.dart';

//part 'LsvItemM.g.dart';

@JsonSerializable()
class LsvItemM {
  String Item_No;
  String Item_Name;
  String Barcode;
  num OnHand;
  num MinimumQty;
  num MaximumQty;

  LsvItemM({
  required  this.Item_No,
  required  this.Item_Name,
  required  this.Barcode,
  required  this.OnHand,
  required  this.MinimumQty,
  required  this.MaximumQty,
  });

  factory LsvItemM.fromJson(Map<String, dynamic> json) {
    return LsvItemM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Barcode: json["Barcode"],
      OnHand: json["OnHand"],
      MinimumQty: json["MinimumQty"],
      MaximumQty: json["MaximumQty"],
    );
  }
//

/*
  factory LsvItemM.fromJson(Map<String, dynamic> json) => _$LsvItemMFromJson(json);

  Map<String, dynamic> toJson() => _$LsvItemMToJson(this);
*/
}
