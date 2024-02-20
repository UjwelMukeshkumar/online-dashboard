import 'package:json_annotation/json_annotation.dart';

//part 'PosGroupM.g.dart';

@JsonSerializable()
class PosGroupM {
  num? Grp_Id;
  String? GrpName;
  String? Image;

  Map<String, dynamic> toJson() {
    return {
      "Grp_Id": this.Grp_Id,
      "GrpName": this.GrpName,
      "Image": this.Image,
    };
  }

  PosGroupM({
    this.Grp_Id,
    this.GrpName,
    this.Image,
  });

  factory PosGroupM.fromJson(Map<String, dynamic> json) {
    return PosGroupM(
      Grp_Id: json["Grp_Id"],
      GrpName: json["GrpName"],
      Image: json["Image"],
    );
  }

//

/*
  factory PosGroupM.fromJson(Map<String, dynamic> json) => _$PosGroupMFromJson(json);

  Map<String, dynamic> toJson() => _$PosGroupMToJson(this);
*/
}
