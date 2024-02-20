import 'package:json_annotation/json_annotation.dart';

//part 'PriceM.g.dart';

@JsonSerializable()
class PriceM {
  num PriceListID;
  String PriceListName;
  String Is_Inclusive;
  @JsonKey(defaultValue: 0)
  num Price = 0;

  factory PriceM.fromJson(Map<String, dynamic> json) {
    return PriceM(
      PriceListID: (json["PriceListID"] ?? 0),
      PriceListName: json["PriceListName"],
      Is_Inclusive: json["Is_Inclusive"],
      Price: json["Price"] ?? 0,
      Discount: json["Discount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "PriceListID": this.PriceListID,
      "PriceListName": this.PriceListName,
      "Is_Inclusive": this.Is_Inclusive,
      "Price": this.Price,
      "Discount": this.Discount,
    };
  }

  @JsonKey(defaultValue: 0)
  num Discount;

  PriceM({
    required this.PriceListID,
    required this.PriceListName,
    required this.Is_Inclusive,
    required this.Price,
    required this.Discount,
  });

/*
  factory PriceM.fromJson(Map<String, dynamic> json) => _$PriceMFromJson(json);

  Map<String, dynamic> toJson() => _$PriceMToJson(this);
*/
}
