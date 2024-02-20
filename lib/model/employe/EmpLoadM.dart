import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'EmpLoadM.g.dart';

@JsonSerializable()
class EmpLoadM {
  List<PendingTaskCountBean> PendingTaskCount;
  List<PendingTaskListBean> PendingTaskList;

  // dynamic PendingTaskList;
  List<AttendanceBean> Attendance;

  factory EmpLoadM.fromJson(Map<String, dynamic> json) {
    return EmpLoadM(
      PendingTaskCount: List.of(json["PendingTaskCount"])
          .map((i) => PendingTaskCountBean.fromJson(i))
          .toList(),
      PendingTaskList: List.of(json["PendingTaskList"])
          .map((i) => PendingTaskListBean.fromJson(i))
          .toList(),
      Attendance: List.of(json["Attendance"])
          .map((i) => AttendanceBean.fromJson(i))
          .toList(),
      EmployeeDetails: List.of(json["EmployeeDetails"])
          .map((i) => EmployeeDetailsBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "PendingTaskCount": jsonEncode(this.PendingTaskCount),
      "PendingTaskList": jsonEncode(this.PendingTaskList),
      "Attendance": jsonEncode(this.Attendance),
      "EmployeeDetails": jsonEncode(this.EmployeeDetails),
    };
  }

  List<EmployeeDetailsBean> EmployeeDetails;

  EmpLoadM({
    required this.PendingTaskCount,
    required this.PendingTaskList,
    required this.Attendance,
    required this.EmployeeDetails,
  });

//

/*
  factory EmpLoadM.fromJson(Map<String, dynamic> json) => _$EmpLoadMFromJson(json);

  Map<String, dynamic> toJson() => _$EmpLoadMToJson(this);
*/
}

@JsonSerializable()
class EmployeeDetailsBean {
  String EmpName;
  String EmpCode;
  int EmpID;
  String Image;

  EmployeeDetailsBean({
    required this.EmpName,
    required this.Image,
    required this.EmpCode,
    required this.EmpID,
  });

  Map<String, dynamic> toJson() {
    return {
      "EmpName": this.EmpName,
      "EmpCode": this.EmpCode,
      "EmpID": this.EmpID,
      "Image": this.Image,
    };
  }

  factory EmployeeDetailsBean.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailsBean(
      EmpName: json["EmpName"],
      EmpCode: json["EmpCode"],
      EmpID: json["EmpID"],
      Image: json["Image"],
    );
  }
//

/*
  factory EmployeeDetailsBean.fromJson(Map<String, dynamic> json) => _$EmployeeDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDetailsBeanToJson(this);
*/
}

@JsonSerializable()
class AttendanceBean {
  String Header;
  num Attendance;

  factory AttendanceBean.fromJson(Map<String, dynamic> json) {
    return AttendanceBean(
      Header: json["Header"],
      Attendance: json["Attendance"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Header": this.Header,
      "Attendance": this.Attendance,
    };
  }

  AttendanceBean({
    required this.Header,
    required this.Attendance,
  });

/*factory AttendanceBean.fromJson(Map<String, dynamic> json) => _$AttendanceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceBeanToJson(this);
*/
}

@JsonSerializable()
class PendingTaskCountBean {
  String Name;
  num count;

  PendingTaskCountBean({
   required this.Name,
   required this.count,
  });

  factory PendingTaskCountBean.fromJson(Map<String, dynamic> json) {
    return PendingTaskCountBean(
      Name: json["Name"], count: json["count"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Name": this.Name,
      "count": this.count,
    };
  }

/*
  factory PendingTaskCountBean.fromJson(Map<String, dynamic> json) => _$PendingTaskCountBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTaskCountBeanToJson(this);
*/
}

@JsonSerializable()
class PendingTaskListBean {
  num TaskNo;
  String Type;
  String StartTime;
  String SourceType;
  String TaskRemarks;
  String FromuserName;
  String ToUserName;
  num ToUser;
  String Status;

  PendingTaskListBean({
    required this.TaskNo,
    required this.Type,
    required this.StartTime,
    required this.SourceType,
    required this.TaskRemarks,
    required this.FromuserName,
    required this.ToUserName,
    required this.ToUser,
    required this.Status,
  });

  factory PendingTaskListBean.fromJson(Map<String, dynamic> json) {
    return PendingTaskListBean(
      TaskNo: json["TaskNo"],
      Type: json["Type"],
      StartTime: json["StartTime"],
      SourceType: json["SourceType"],
      TaskRemarks: json["TaskRemarks"],
      FromuserName: json["FromuserName"],
      ToUserName: json["ToUserName"]??"",
      ToUser: json["ToUser"],
      Status: json["Status"],
    );
  }

/*

*/
/*
  factory PendingTaskListBean.fromJson(Map<String, dynamic> json) => _$PendingTaskListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTaskListBeanToJson(this);
*/
}
///////////////////////////////////////////////////////////////////////////////////
///
///
///


