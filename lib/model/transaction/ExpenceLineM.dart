import 'package:json_annotation/json_annotation.dart';

//part 'ExpenceLineM.g.dart';

@JsonSerializable()
class ExpenceLineM {
  String Item_No;
  String Item_Name;
  num Quantity;
  num Price;
  num Total;
  String TaxCode;
  num TaxAmount;

  ExpenceLineM({
  required  this.Item_No,
  required  this.Item_Name,
  required  this.Quantity,
  required  this.Price,
  required  this.Total,
  required  this.TaxCode,
  required  this.TaxAmount,
  });

  factory ExpenceLineM.fromJson(Map<String, dynamic> json) {
    return ExpenceLineM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Quantity: json["Quantity"],
      Price: json["Price"],
      Total: json["Total"],
      TaxCode: json["TaxCode"],
      TaxAmount: json["TaxAmount"],
    );
  }
//

/*
  factory ExpenceLineM.fromJson(Map<String, dynamic> json) => _$ExpenceLineMFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenceLineMToJson(this);
*/
}
