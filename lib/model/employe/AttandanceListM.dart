import 'package:json_annotation/json_annotation.dart';

//part 'AttandanceListM.g.dart';

@JsonSerializable()
class AttandanceListM {
  String? FirstPunch;

  factory AttandanceListM.fromJson(Map<String, dynamic> json) {
    return AttandanceListM(
      FirstPunch: json["FirstPunch"],
      LastPunch: json["LastPunch"],
      AttendanceName: json["AttendanceName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "FirstPunch": this.FirstPunch,
      "LastPunch": this.LastPunch,
      "AttendanceName": this.AttendanceName,
    };
  }

  String? LastPunch;
  String? AttendanceName;

  AttandanceListM({
   this.FirstPunch,
   this.LastPunch,
    this.AttendanceName,
  });

/*
  factory AttandanceListM.fromJson(Map<String, dynamic> json) => _$AttandanceListMFromJson(json);

  Map<String, dynamic> toJson() => _$AttandanceListMToJson(this);
*/
}
