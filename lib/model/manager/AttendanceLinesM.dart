import 'package:json_annotation/json_annotation.dart';

//part 'AttendanceLinesM.g.dart';

// @JsonSerializable()
class AttendanceLinesM {
  String EmployeeID;
  String AttendanceName;
  String AttendanceShortName;
  num AttendanceValue;
  String EmpCode;
  String EmpName;
  String FirstPunch;
  num InitNo;
  bool isPresent;
  num? Ispaid;
  String LastPunch;
  String PunchInDeviation;
  String PunchOutDeviation;
  num RecNum;
  num Sequence;
  String ShiftBeginTime;

  factory AttendanceLinesM.fromJson(Map<String, dynamic> json) {
    return AttendanceLinesM(
      EmployeeID: json["EmployeeID"],
      AttendanceName: json["AttendanceName"],
      AttendanceShortName: json["AttendanceShortName"],
      AttendanceValue: json["AttendanceValue"],
      EmpCode: json["EmpCode"],
      EmpName: json["EmpName"],
      FirstPunch: json["FirstPunch"],
      InitNo: json["InitNo"],
      isPresent: json["isPresent"].toLowerCase() == 'true',
      Ispaid: json["Ispaid"],
      LastPunch: json["LastPunch"],
      PunchInDeviation: json["PunchInDeviation"],
      PunchOutDeviation: json["PunchOutDeviation"],
      RecNum: json["RecNum"],
      Sequence: json["Sequence"],
      ShiftBeginTime: json["ShiftBeginTime"],
      ShiftEndTime: json["ShiftEndTime"],
      Sl_No: json["Sl_No"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "EmployeeID": this.EmployeeID,
      "AttendanceName": this.AttendanceName,
      "AttendanceShortName": this.AttendanceShortName,
      "AttendanceValue": this.AttendanceValue,
      "EmpCode": this.EmpCode,
      "EmpName": this.EmpName,
      "FirstPunch": this.FirstPunch,
      "InitNo": this.InitNo,
      "isPresent": this.isPresent,
      "Ispaid": this.Ispaid,
      "LastPunch": this.LastPunch,
      "PunchInDeviation": this.PunchInDeviation,
      "PunchOutDeviation": this.PunchOutDeviation,
      "RecNum": this.RecNum,
      "Sequence": this.Sequence,
      "ShiftBeginTime": this.ShiftBeginTime,
      "ShiftEndTime": this.ShiftEndTime,
      "Sl_No": this.Sl_No,
    };
  }

  String ShiftEndTime;
  num? Sl_No;

  AttendanceLinesM({
  required this.EmployeeID,
  required this.AttendanceName,
  required this.AttendanceShortName,
  required this.AttendanceValue,
  required this.EmpCode,
  required this.EmpName,
  required this.FirstPunch,
  required this.InitNo,
  required this.isPresent,
   this.Ispaid,
  required this.LastPunch,
  required this.PunchInDeviation,
  required this.PunchOutDeviation,
  required this.RecNum,
  required this.Sequence,
  required this.ShiftBeginTime,
  required this.ShiftEndTime,
   this.Sl_No,
  });

/*
  factory AttendanceLinesM.fromJson(Map<String, dynamic> json) => _$AttendanceLinesMFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceLinesMToJson(this);
*/
}
