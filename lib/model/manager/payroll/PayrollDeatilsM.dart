import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// 'PayrollDeatilsM.g.dart';

@JsonSerializable()
class PayrollDeatilsM {
  List<PayrollDetailsBean> PayrollDetails;
  List<SalaryDetailsBean> SalaryDetails;
  List<AttendaceDetailsBean> AttendaceDetails;
  List<DefaultSeriesDetailsBean> DefaultSeriesDetails;
  List<SeriesComboboxBean> SeriesCombobox;

  PayrollDeatilsM({
    required this.PayrollDetails,
    required this.SalaryDetails,
    required this.AttendaceDetails,
    required this.DefaultSeriesDetails,
    required this.SeriesCombobox,
  });

  Map<String, dynamic> toJson() {
    return {
      "PayrollDetails": jsonEncode(this.PayrollDetails),
      "SalaryDetails": jsonEncode(this.SalaryDetails),
      "AttendaceDetails": jsonEncode(this.AttendaceDetails),
      "DefaultSeriesDetails": jsonEncode(this.DefaultSeriesDetails),
      "SeriesCombobox": jsonEncode(this.SeriesCombobox),
    };
  }

  factory PayrollDeatilsM.fromJson(Map<String, dynamic> json) {
    return PayrollDeatilsM(
      PayrollDetails: List.of(json["PayrollDetails"])
          .map((i) => PayrollDetailsBean.fromJson(i))
          .toList(),
          SalaryDetails: List.of(json['SalaryDetails']).map((e) => SalaryDetailsBean.fromJson(e)).toList(),
          AttendaceDetails: List.of(json['AttendaceDetails']).map((e) => AttendaceDetailsBean.fromJson(json)).toList(),
          DefaultSeriesDetails: List.of(json["DefaultSeriesDetails"]).map((e) => DefaultSeriesDetailsBean.fromJson(e)).toList(),
          SeriesCombobox: List.of(json["SeriesCombobox"]).map((e) => SeriesComboboxBean.fromJson(e)).toList(),
      // SalaryDetails: [],
      // AttendaceDetails: [],
      // DefaultSeriesDetails: [],
      // SeriesCombobox: [],
    );
  }
//

/*
  factory PayrollDeatilsM.fromJson(Map<String, dynamic> json) => _$PayrollDeatilsMFromJson(json);

  Map<String, dynamic> toJson() => _$PayrollDeatilsMToJson(this);
*/
}

@JsonSerializable()
class SeriesComboboxBean {
  num Series_Id;
  String SeriesName;

  SeriesComboboxBean({
    required this.Series_Id,
    required this.SeriesName,
  });

  factory SeriesComboboxBean.fromJson(Map<String, dynamic> json) {
    return SeriesComboboxBean(
      Series_Id: json["Series_Id"],
      SeriesName: json["SeriesName"],
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
  factory SeriesComboboxBean.fromJson(Map<String, dynamic> json) => _$SeriesComboboxBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesComboboxBeanToJson(this);
*/
}

@JsonSerializable()
class DefaultSeriesDetailsBean {
  num RecNum;
  num Sequence;
  dynamic DefaultPrintDesign;

  DefaultSeriesDetailsBean({
    required this.RecNum,
    required this.Sequence,
    required this.DefaultPrintDesign,
  });

  factory DefaultSeriesDetailsBean.fromJson(Map<String, dynamic> json) {
    return DefaultSeriesDetailsBean(
      RecNum: json["RecNum"],
      Sequence: json["Sequence"],
      DefaultPrintDesign: json["DefaultPrintDesign"],
    );
  }
//

/*
  factory DefaultSeriesDetailsBean.fromJson(Map<String, dynamic> json) => _$DefaultSeriesDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultSeriesDetailsBeanToJson(this);
*/
}

@JsonSerializable()
class AttendaceDetailsBean {
  String DocDate;
  String EmployeeID;
  String EmpName;
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

  AttendaceDetailsBean({
    required this.DocDate,
    required this.EmployeeID,
    required this.EmpName,
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
  });

  factory AttendaceDetailsBean.fromJson(Map<String, dynamic> json) {
    return AttendaceDetailsBean(
      DocDate: json["DocDate"],
      EmployeeID: json["EmployeeID"],
      EmpName: json["EmpName"],
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
      "DocDate": this.DocDate,
      "EmployeeID": this.EmployeeID,
      "EmpName": this.EmpName,
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
    };
  }
//

/*
  factory AttendaceDetailsBean.fromJson(Map<String, dynamic> json) => _$AttendaceDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AttendaceDetailsBeanToJson(this);
*/
}

@JsonSerializable()
class SalaryDetailsBean {
  String EmployeeCode;
  String BrickCode;
  num Salary;
  num StatutoryCharges;
  num Account;
  dynamic ReverseChargeAccount;
  num CtrlAccount;

  SalaryDetailsBean({
    required this.EmployeeCode,
    required this.BrickCode,
    required this.Salary,
    required this.StatutoryCharges,
    required this.Account,
    required this.ReverseChargeAccount,
    required this.CtrlAccount,
  });

  factory SalaryDetailsBean.fromJson(Map<String, dynamic> json) {
    return SalaryDetailsBean(
      EmployeeCode: json["EmployeeCode"],
      BrickCode: json["BrickCode"],
      Salary: json["Salary"],
      StatutoryCharges: json["StatutoryCharges"],
      Account: json["Account"],
      ReverseChargeAccount: json["ReverseChargeAccount"],
      CtrlAccount: json["CtrlAccount"],
    );
  }
//

/*
  factory SalaryDetailsBean.fromJson(Map<String, dynamic> json) => _$SalaryDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SalaryDetailsBeanToJson(this);
*/
}

@JsonSerializable()
class PayrollDetailsBean {
  String EmployeeCode;
  String EmpName;
  dynamic EmpCategory;
  String Designation;
  String Department;
  String WrkShift;
  String Nationality;
  String JoiningDate;
  String Taxnum;
  String PancardNum;
  String PermntAddress;
  String? Mobile;
  num Salary;
  num StatutoryCharges;

  PayrollDetailsBean({
    required this.EmployeeCode,
    required this.EmpName,
    required this.EmpCategory,
    required this.Designation,
    required this.Department,
    required this.WrkShift,
    required this.Nationality,
    required this.JoiningDate,
    required this.Taxnum,
    required this.PancardNum,
    required this.PermntAddress,
    required this.Mobile,
    required this.Salary,
    required this.StatutoryCharges,
  });

  factory PayrollDetailsBean.fromJson(Map<String, dynamic> json) {
    return PayrollDetailsBean(
      EmployeeCode: json["EmployeeCode"],
      EmpName: json["EmpName"],
      EmpCategory: json["EmpCategory"],
      Designation: json["Designation"],
      Department: json["Department"],
      WrkShift: json["WrkShift"],
      Nationality: json["Nationality"],
      JoiningDate: json["JoiningDate"],
      Taxnum: json["Taxnum"],
      PancardNum: json["PancardNum"],
      PermntAddress: json["PermntAddress"],
      Mobile: json["Mobile"],
      Salary: json["Salary"],
      StatutoryCharges: json["StatutoryCharges"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "EmployeeCode": this.EmployeeCode,
      "EmpName": this.EmpName,
      "EmpCategory": this.EmpCategory,
      "Designation": this.Designation,
      "Department": this.Department,
      "WrkShift": this.WrkShift,
      "Nationality": this.Nationality,
      "JoiningDate": this.JoiningDate,
      "Taxnum": this.Taxnum,
      "PancardNum": this.PancardNum,
      "PermntAddress": this.PermntAddress,
      "Mobile": this.Mobile,
      "Salary": this.Salary,
      "StatutoryCharges": this.StatutoryCharges,
    };
  }

//

/*
  factory PayrollDetailsBean.fromJson(Map<String, dynamic> json) => _$PayrollDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PayrollDetailsBeanToJson(this);
*/
}
