import 'package:json_annotation/json_annotation.dart';

//part 'OrgM.g.dart';

@JsonSerializable()
class OrgM {
  num Org_Id;
  String Organisation;
  String ImageUpload;
  String PunchStatus;
  String PunchOutStatus;

  OrgM(
      {required this.Org_Id,
      required this.Organisation,
      required this.ImageUpload,
      required this.PunchStatus,
      required this.PunchOutStatus});

  factory OrgM.fromJson(Map<String, dynamic> json) {
    return OrgM(
      Org_Id: json["Org_Id"],
      Organisation: json["Organisation"],
      ImageUpload: json["ImageUpload"]??"",
      PunchStatus: json["PunchStatus"]??"",
      PunchOutStatus: json["PunchOutStatus"]??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Org_Id": this.Org_Id,
      "Organisation": this.Organisation,
      "ImageUpload": this.ImageUpload,
      "PunchStatus": this.PunchStatus,
      "PunchOutStatus": this.PunchOutStatus,
    };
  }
//

/*
  factory OrgM.fromJson(Map<String, dynamic> json) => _$OrgMFromJson(json);

  Map<String, dynamic> toJson() => _$OrgMToJson(this);
*/
}
