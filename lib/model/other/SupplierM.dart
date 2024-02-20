import 'package:json_annotation/json_annotation.dart';

// part 'SupplierM.g.dart';

@JsonSerializable()
class SupplierM {
  String CVCode;
  String CVName;

  SupplierM({
   required this.CVCode,
   required this.CVName,
  });

  factory SupplierM.fromJson(Map<String, dynamic> json) {
    return SupplierM(
      CVCode: json["CVCode"],
      CVName: json["CVName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "CVCode": this.CVCode,
      "CVName": this.CVName,
    };
  }
//

  /*factory SupplierM.fromJson(Map<String, dynamic> json) =>
      _$SupplierMFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierMToJson(this);*/
}
