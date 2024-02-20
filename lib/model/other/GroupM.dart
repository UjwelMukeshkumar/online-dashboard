import 'package:json_annotation/json_annotation.dart';
// part 'GroupM.g.dart';

@JsonSerializable()
class GroupM {
  int Grp_Id;
  String GrpName;

  GroupM({
    required this.Grp_Id,
    required this.GrpName,
  });

  factory GroupM.fromJson(Map<String, dynamic> json) {
    return GroupM(
      Grp_Id: json["Grp_Id"],
      GrpName: json["GrpName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Grp_Id": this.Grp_Id,
      "GrpName": this.GrpName,
    };
  }
//

  /* factory GroupM.fromJson(Map<String, dynamic> json) => _$GroupMFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMToJson(this);*/
}
