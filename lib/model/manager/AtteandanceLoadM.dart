import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'AtteandanceLoadM.g.dart';

@JsonSerializable()
class AtteandanceLoadM {
  List<AttendanceNameBean> AttendanceName;
  List<DefaultsBean> Defaults;
  List<SeriesBean> Series;
  List<EmployeesBean> Employees;

  AtteandanceLoadM(
      {required this.AttendanceName,
      required this.Defaults,
      required this.Series,
      required this.Employees});

  factory AtteandanceLoadM.fromJson(Map<String, dynamic> json) {
    return AtteandanceLoadM(
      AttendanceName: List.of(json["AttendanceName"])
          .map((i) => AttendanceNameBean.fromJson(i))
          .toList(),
      Defaults: List.of(json["Defaults"])
          .map((i) => DefaultsBean.fromJson(i))
          .toList(),
      Series:
          List.of(json["Series"]).map((i) => SeriesBean.fromJson(i)).toList(),
      Employees: List.of(json["Employees"])
          .map((i) => EmployeesBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "AttendanceName": jsonEncode(this.AttendanceName),
      "Defaults": jsonEncode(this.Defaults),
      "Series": jsonEncode(this.Series),
      "Employees": jsonEncode(this.Employees),
    };
  }
//

/*
  factory AtteandanceLoadM.fromJson(Map<String, dynamic> json) => _$AtteandanceLoadMFromJson(json);

  Map<String, dynamic> toJson() => _$AtteandanceLoadMToJson(this);
*/
}

@JsonSerializable()
class EmployeesBean {
  String EmpCode;
  String EmpName;

  EmployeesBean({required this.EmpCode, required this.EmpName});

  factory EmployeesBean.fromJson(Map<String, dynamic> json) {
    return EmployeesBean(
      EmpCode: json["EmpCode"],
      EmpName: json["EmpName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "EmpCode": this.EmpCode,
      "EmpName": this.EmpName,
    };
  }
//

/*
  factory EmployeesBean.fromJson(Map<String, dynamic> json) => _$EmployeesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeesBeanToJson(this);
*/
}

@JsonSerializable()
class SeriesBean {
  num? Series_Id;
  // num Series_Id;
  String SeriesName;
  

  SeriesBean({
    // required this.Series_Id,
    this.Series_Id,
    required this.SeriesName,
  
  });

  factory SeriesBean.fromJson(Map<String, dynamic> json) {
    return SeriesBean(
      SeriesName: json["SeriesName"],
      // Series_Id: json['Series_Id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Series_Id": this.Series_Id,
      "SeriesName": this.SeriesName,
    };
  }
//

/*
  factory SeriesBean.fromJson(Map<String, dynamic> json) => _$SeriesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesBeanToJson(this);
*/
}

@JsonSerializable()
class DefaultsBean {
  num RecNum;
  num Sequence;
  dynamic DefaultPrintDesign;

  DefaultsBean(
      {required this.RecNum, required this.Sequence, this.DefaultPrintDesign});

  factory DefaultsBean.fromJson(Map<String, dynamic> json) {
    return DefaultsBean(
      RecNum: json["RecNum"],
      Sequence: (json["Sequence"]),
      DefaultPrintDesign: json["DefaultPrintDesign"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "RecNum": this.RecNum,
      "Sequence": this.Sequence,
      "DefaultPrintDesign": this.DefaultPrintDesign,
    };
  }

//

/*
  factory DefaultsBean.fromJson(Map<String, dynamic> json) => _$DefaultsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultsBeanToJson(this);
*/
}

@JsonSerializable()
class AttendanceNameBean {
  String? AttendanceName;
  String? AttendanceShortName;
  num? AttendanceValue;

  AttendanceNameBean(
      { this.AttendanceName,
       this.AttendanceShortName,
       this.AttendanceValue});

  factory AttendanceNameBean.fromJson(Map<String, dynamic> json) {
    return AttendanceNameBean(
      AttendanceName: json["AttendanceName"] as String? ??"",
      AttendanceShortName: json["AttendanceShortName"] as String? ??"",
      AttendanceValue: json["AttendanceValue"] as num? ??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "AttendanceName": this.AttendanceName,
      "AttendanceShortName": this.AttendanceShortName,
      "AttendanceValue": this.AttendanceValue,
    };
  }

//

//

  /*factory AttendanceNameBean.fromJson(Map<String, dynamic> json) => _$AttendanceNameBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceNameBeanToJson(this);*/
}
