import 'package:json_annotation/json_annotation.dart';

//part 'PayrollInsertM.g.dart';

@JsonSerializable()
class PayrollInsertM {
  String Category;
  String Department;
  String Designation;
  String DocDate;
  String EmployeeCode;
  String FromDate;
  String JoiningDate;
  String Mobile;
  String Nationality;
  String PanCaordNum;
  String PermenantAddress;
  String RecNum;
  String Salary;
  String SalaryList;
  String Sequence;

  Map<String, dynamic> toJson() {
    return {
      "Category": this.Category,
      "Department": this.Department,
      "Designation": this.Designation,
      "DocDate": this.DocDate,
      "EmployeeCode": this.EmployeeCode,
      "FromDate": this.FromDate,
      "JoiningDate": this.JoiningDate,
      "Mobile": this.Mobile,
      "Nationality": this.Nationality,
      "PanCaordNum": this.PanCaordNum,
      "PermenantAddress": this.PermenantAddress,
      "RecNum": this.RecNum,
      "Salary": this.Salary,
      "SalaryList": this.SalaryList,
      "Sequence": this.Sequence,
      "StatutoryCharges": this.StatutoryCharges,
      "TaxNum": this.TaxNum,
      "ToDate": this.ToDate,
      "TotalWorkingDays": this.TotalWorkingDays,
      "WorkShift": this.WorkShift,
      "api_key": this.api_key,
      "initNo": this.initNo,
    };
  }

  String StatutoryCharges;
  String TaxNum;
  String ToDate;
  String TotalWorkingDays;
  String WorkShift;
  String api_key;
  String initNo;

  PayrollInsertM({
    required this.Category,
    required this.Department,
    required this.Designation,
    required this.DocDate,
    required this.EmployeeCode,
    required this.FromDate,
    required this.JoiningDate,
    required this.Mobile,
    required this.Nationality,
    required this.PanCaordNum,
    required this.PermenantAddress,
    required this.RecNum,
    required this.Salary,
    required this.SalaryList,
    required this.Sequence,
    required this.StatutoryCharges,
    required this.TaxNum,
    required this.ToDate,
    required this.TotalWorkingDays,
    required this.WorkShift,
    required this.api_key,
    required this.initNo,
  });

  factory PayrollInsertM.fromJson(Map<String, dynamic> json) {
    return PayrollInsertM(
      Category: json["Category"],
      Department: json["Department"],
      Designation: json["Designation"],
      DocDate: json["DocDate"],
      EmployeeCode: json["EmployeeCode"],
      FromDate: json["FromDate"],
      JoiningDate: json["JoiningDate"],
      Mobile: json["Mobile"],
      Nationality: json["Nationality"],
      PanCaordNum: json["PanCaordNum"],
      PermenantAddress: json["PermenantAddress"],
      RecNum: json["RecNum"],
      Salary: json["Salary"],
      SalaryList: json["SalaryList"],
      Sequence: json["Sequence"],
      StatutoryCharges: json["StatutoryCharges"],
      TaxNum: json["TaxNum"],
      ToDate: json["ToDate"],
      TotalWorkingDays: json["TotalWorkingDays"],
      WorkShift: json["WorkShift"],
      api_key: json["api_key"],
      initNo: json["initNo"],
    );
  }
//

/*
  factory PayrollInsertM.fromJson(Map<String, dynamic> json) => _$PayrollInsertMFromJson(json);

  Map<String, dynamic> toJson() => _$PayrollInsertMToJson(this);
*/
}

@JsonSerializable()
class SalaryListBean {
  num Account;
  String BrickCode;
  num CtrlAccount;
  String EmployeeCode;
  num ReverseChargeAccount;
  num Salary;
  num StatutoryCharges;

  SalaryListBean({
    required this.Account,
    required this.BrickCode,
    required this.CtrlAccount,
    required this.EmployeeCode,
    required this.ReverseChargeAccount,
    required this.Salary,
    required this.StatutoryCharges,
  });

  factory SalaryListBean.fromJson(Map<String, dynamic> json) {
    return SalaryListBean(
      Account: json["Account"],
      BrickCode: json["BrickCode"],
      CtrlAccount: json["CtrlAccount"],
      EmployeeCode: json["EmployeeCode"],
      ReverseChargeAccount: json["ReverseChargeAccount"],
      Salary: json["Salary"],
      StatutoryCharges: json["StatutoryCharges"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Account": this.Account,
      "BrickCode": this.BrickCode,
      "CtrlAccount": this.CtrlAccount,
      "EmployeeCode": this.EmployeeCode,
      "ReverseChargeAccount": this.ReverseChargeAccount,
      "Salary": this.Salary,
      "StatutoryCharges": this.StatutoryCharges,
    };
  }
//

/*
  factory SalaryListBean.fromJson(Map<String, dynamic> json) => _$SalaryListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SalaryListBeanToJson(this);
*/
}
