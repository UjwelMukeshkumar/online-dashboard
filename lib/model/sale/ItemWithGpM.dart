import 'package:json_annotation/json_annotation.dart';

//part 'ItemWithGpM.g.dart';

@JsonSerializable()
class ItemWithGpM {
  String? Item_No;
  String? Item_Name;
  num? SalesAmount;
  num? GPPercent;

  ItemWithGpM({
    this.Item_No,
    this.Item_Name,
    this.SalesAmount,
    this.GPPercent,
  });

  factory ItemWithGpM.fromJson(Map<String, dynamic> json) {
    return ItemWithGpM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      SalesAmount: json["SalesAmount"],
      GPPercent: json["GPPercent"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Item_No": this.Item_No,
      "Item_Name": this.Item_Name,
      "SalesAmount": this.SalesAmount,
      "GPPercent": this.GPPercent,
    };
  }
//

/*
  factory ItemWithGpM.fromJson(Map<String, dynamic> json) => _$ItemWithGpMFromJson(json);

  Map<String, dynamic> toJson() => _$ItemWithGpMToJson(this);
*/
}
