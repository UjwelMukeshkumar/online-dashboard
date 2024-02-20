import 'package:json_annotation/json_annotation.dart';

//part 'MovingM.g.dart';

@JsonSerializable()
class MovingM {
  String Item_No;
  String Item_Name;
  num StockPrecent;
  num Qty;
  num Amount;

  MovingM({
  required this.Item_No,
  required this.Item_Name,
  required this.StockPrecent,
  required this.Qty,
  required this.Amount,
  });

  factory MovingM.fromJson(Map<String, dynamic> json) {
    return MovingM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      StockPrecent: json["StockPrecent"],
      Qty: json["Qty"],
      Amount: json["Amount"],
    );
  }
//

/*
  factory MovingM.fromJson(Map<String, dynamic> json) => _$MovingMFromJson(json);

  Map<String, dynamic> toJson() => _$MovingMToJson(this);
*/
}
