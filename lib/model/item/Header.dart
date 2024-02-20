import 'package:json_annotation/json_annotation.dart';
//part 'Header.g.dart';

@JsonSerializable()
class Header {
  String Item_Name;
  double OnHand;
  double Cost;
  String GrpName;

  Header({
  required  this.Item_Name,
  required  this.OnHand,
  required  this.Cost,
  required  this.GrpName,
  });

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      Item_Name: json["Item_Name"],
      OnHand: json["OnHand"],
      Cost: json["Cost"],
      GrpName: json["GrpName"],
    );
  }
//

/*
  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);

  Map<String, dynamic> toJson() => _$HeaderToJson(this);
*/
}
