import 'package:json_annotation/json_annotation.dart';

//part 'SalesItemM.g.dart';

@JsonSerializable()
class SalesItemM {
  String Item_No;
  String Item_Name;
  num Quantity;
  num SalesAmount;

  SalesItemM({
  required  this.Item_No,
  required  this.Item_Name,
  required  this.Quantity,
  required  this.SalesAmount,
  });

  factory SalesItemM.fromJson(Map<String, dynamic> json) {
    return SalesItemM(
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
  factory SalesItemM.fromJson(Map<String, dynamic> json) => _$SalesItemMFromJson(json);

  Map<String, dynamic> toJson() => _$SalesItemMToJson(this);
*/
}
