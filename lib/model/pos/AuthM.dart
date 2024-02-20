import 'package:json_annotation/json_annotation.dart';

//part 'AuthM.g.dart';

@JsonSerializable()
class AuthM {
  String DiscountChange;
  String PriceChange;
  bool get isDiscountReadOnly => DiscountChange == "N";
  bool get isPriceReadOnly => PriceChange == "N";

  factory AuthM.fromJson(Map<String, dynamic> json) {
    return AuthM(
      DiscountChange: json["DiscountChange"],
      PriceChange: json["PriceChange"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "DiscountChange": this.DiscountChange,
      "PriceChange": this.PriceChange,
    };
  }

  AuthM({
  required  this.DiscountChange,
  required  this.PriceChange,
  });

/*
  factory AuthM.fromJson(Map<String, dynamic> json) => _$AuthMFromJson(json);

  Map<String, dynamic> toJson() => _$AuthMToJson(this);
*/
}
