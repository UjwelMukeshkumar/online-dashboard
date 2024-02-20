import 'package:json_annotation/json_annotation.dart';

//part 'GroupSaleM.g.dart';

@JsonSerializable()
class GroupSaleM {
  num GrpId;
  String Name;

  GroupSaleM({
  required this.GrpId,
  required this.Name,
  });

  factory GroupSaleM.fromJson(Map<String, dynamic> json) {
    return GroupSaleM(
      GrpId: json["GrpId"],
      Name: json["Name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "GrpId": this.GrpId,
      "Name": this.Name,
    };
  }
//

/*
  factory GroupSaleM.fromJson(Map<String, dynamic> json) => _$GroupSaleMFromJson(json);

  Map<String, dynamic> toJson() => _$GroupSaleMToJson(this);
*/
}
