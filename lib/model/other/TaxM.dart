import 'package:json_annotation/json_annotation.dart';
// part 'TaxM.g.dart';

@JsonSerializable()
class TaxM {
  String TaxCode;
  String TaxName;

  TaxM({
   required this.TaxCode,
    required this.TaxName,
  });

  factory TaxM.fromJson(Map<String, dynamic> json) {
    return TaxM(
      TaxCode: json["TaxCode"],
      TaxName: json["TaxName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TaxCode": this.TaxCode,
      "TaxName": this.TaxName,
    };
  }
//
  /* factory TaxM.fromJson(Map<String, dynamic> json) => _$TaxMFromJson(json);

  Map<String, dynamic> toJson() => _$TaxMToJson(this);*/
}
