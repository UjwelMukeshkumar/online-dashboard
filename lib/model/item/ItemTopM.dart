import 'package:json_annotation/json_annotation.dart';

//part 'ItemTopM.g.dart';

@JsonSerializable()
class ItemTopM {
  String Item_No;
  String Item_Name;
  num Qty;
  num SalesAmount;
  String Image;

  ItemTopM({required this.Item_No, required this.Item_Name, required this.Qty, required this.Image,required this.SalesAmount});

  factory ItemTopM.fromJson(Map<String, dynamic> json) {
    return ItemTopM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Qty: json["Qty"],
      SalesAmount: json["SalesAmount"],
      Image: json["Image"],
    );
  }
//

/*
  factory ItemTopM.fromJson(Map<String, dynamic> json) => _$ItemTopMFromJson(json);

  Map<String, dynamic> toJson() => _$ItemTopMToJson(this);
*/
}

