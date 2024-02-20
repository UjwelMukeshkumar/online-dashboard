// To parse this JSON data, do
//
//     final attandanceM = attandanceMFromJson(jsonString);

import 'dart:convert';

AttandanceM attandanceMFromJson(String str) =>
    AttandanceM.fromJson(json.decode(str));

String attandanceMToJson(AttandanceM data) => json.encode(data.toJson());

class AttandanceM {
  AttandanceM({
   required this.employeeId,
   required this.empName,
   required this.punchTime,
   required this.onDuty,
   required this.present,
  });

  int employeeId;
  String empName;
  String punchTime;
  String? onDuty;
  double present;

  factory AttandanceM.fromJson(Map<String, dynamic> json) => AttandanceM(
        employeeId: json["EmployeeID"] == null ? null : json["EmployeeID"],
        empName: json["EmpName"] == null ? null : json["EmpName"],
        punchTime: json["PunchTime"] == null ? null : json["PunchTime"],
        onDuty: json["OnDuty"] == null ? null : json["OnDuty"].toString(),
        present: json["Present"] == null ? null : json["Present"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "EmployeeID": employeeId == null ? null : employeeId,
        "EmpName": empName == null ? null : empName,
        "PunchTime": punchTime == null ? null : punchTime,
        "OnDuty": onDuty == null ? null : onDuty,
        "Present": present == null ? null : present,
      };
}
