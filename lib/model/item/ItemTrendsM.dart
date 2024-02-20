import 'package:json_annotation/json_annotation.dart';

//part 'ItemTrendsM.g.dart';

@JsonSerializable()
class ItemTrendsM {
  String Item_No;
  String Item_Name;
  num Quantity;
  num SalesAmount;
  num MRP;
  num? GP;

  ItemTrendsM({
   required this.Item_No,
   required this.Item_Name,
   required this.Quantity,
   required this.SalesAmount,
   required this.MRP,
    this.GP,
  });

  Map<String, dynamic> toJson() {
    return {
      "Item_No": this.Item_No,
      "Item_Name": this.Item_Name,
      "Quantity": this.Quantity,
      "SalesAmount": this.SalesAmount,
      "MRP": this.MRP,
      "GP": this.GP,
    };
  }

  factory ItemTrendsM.fromJson(Map<String, dynamic> json) {
    return ItemTrendsM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Quantity: json["Quantity"],
      SalesAmount: json["SalesAmount"],
      MRP: json["MRP"],
      GP: json["GP"],
    );
  }
//

/*
  factory ItemTrendsM.fromJson(Map<String, dynamic> json) =>
      _$ItemTrendsMFromJson(json);

  Map<String, dynamic> toJson() => _$ItemTrendsMToJson(this);
*/
}
