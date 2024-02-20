import 'package:json_annotation/json_annotation.dart';

//part 'AttandanceFindM.g.dart';

@JsonSerializable()
class AttandanceFindM {
  String EmpCode;
  String EmpName;
  String? EmployeeID;
  String FirstPunch;
  String ShiftBeginTime;
  String PunchInDeviation;
  String LastPunch;
  String ShiftEndTime;
  String PunchOutDeviation;
  String DutyHours;
  String AttendanceName;
  String AttendanceShortName;
  num AttendanceValue;
  bool isSelected;

  factory AttandanceFindM.fromJson(Map<String, dynamic> json) {
    return AttandanceFindM(
        EmpCode: json["EmpCode"],
        EmpName: json["EmpName"],
        EmployeeID: json["EmployeeID"],
        FirstPunch: json["FirstPunch"],
        ShiftBeginTime: json["ShiftBeginTime"],
        PunchInDeviation: json["PunchInDeviation"],
        LastPunch: json["LastPunch"],
        ShiftEndTime: json["ShiftEndTime"],
        PunchOutDeviation: json["PunchOutDeviation"],
        DutyHours: json["DutyHours"],
        AttendanceName: json["AttendanceName"],
        AttendanceShortName: json["AttendanceShortName"],
        AttendanceValue: json["AttendanceValue"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "EmpCode": this.EmpCode,
      "EmpName": this.EmpName,
      "EmployeeID": this.EmployeeID,
      "FirstPunch": this.FirstPunch,
      "ShiftBeginTime": this.ShiftBeginTime,
      "PunchInDeviation": this.PunchInDeviation,
      "LastPunch": this.LastPunch,
      "ShiftEndTime": this.ShiftEndTime,
      "PunchOutDeviation": this.PunchOutDeviation,
      "DutyHours": this.DutyHours,
      "AttendanceName": this.AttendanceName,
      "AttendanceShortName": this.AttendanceShortName,
      "AttendanceValue": this.AttendanceValue,
      "isSelected": this.isSelected,
    };
  }

  AttandanceFindM({
   required this.EmpCode,
   required this.EmpName,
    this.EmployeeID,
   required this.FirstPunch,
   required this.ShiftBeginTime,
   required this.PunchInDeviation,
   required this.LastPunch,
   required this.ShiftEndTime,
   required this.PunchOutDeviation,
   required this.DutyHours,
   required this.AttendanceName,
   required this.AttendanceShortName,
   required this.AttendanceValue,
    this.isSelected=false
  });

/*
  factory AttandanceFindM.fromJson(Map<String, dynamic> json) => _$AttandanceFindMFromJson(json);

  Map<String, dynamic> toJson() => _$AttandanceFindMToJson(this);
*/
}
