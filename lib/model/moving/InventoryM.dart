import 'package:json_annotation/json_annotation.dart';

//part 'InventoryM.g.dart';

@JsonSerializable()
class InventoryM {
  var Item_No;
  String Item_Name;
  num StockValue;
  get getItemNo => "$Item_No";

  factory InventoryM.fromJson(Map<String, dynamic> json) {
    return InventoryM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      StockValue: json["StockValue"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Item_No": this.Item_No,
      "Item_Name": this.Item_Name,
      "StockValue": this.StockValue,
    };
  }

  InventoryM({
   required this.Item_No,
   required this.Item_Name,
   required this.StockValue,
  });

/*
  factory InventoryM.fromJson(Map<String, dynamic> json) => _$InventoryMFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryMToJson(this);
*/
}
