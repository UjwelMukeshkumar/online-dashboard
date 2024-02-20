import 'package:json_annotation/json_annotation.dart';

//part 'StoreM.g.dart';

@JsonSerializable()
class StoreM {
  num Str_Id;
  String StrName;
  num Quantity;

  StoreM({
  required this.Str_Id,
  required this.StrName,
  required this.Quantity,
  });

  factory StoreM.fromJson(Map<String, dynamic> json) {
    return StoreM(
      Str_Id: json["Str_Id"],
      StrName: json["StrName"],
      Quantity: json["Quantity"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Str_Id": this.Str_Id,
      "StrName": this.StrName,
      "Quantity": this.Quantity,
    };
  }
//

/*
  factory StoreM.fromJson(Map<String, dynamic> json) => _$StoreMFromJson(json);

  Map<String, dynamic> toJson() => _$StoreMToJson(this);
*/
}
