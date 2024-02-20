import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'PayrollLoadM.g.dart';

@JsonSerializable()
class PayrollLoadM {
  List<PayrollLoadBean> PayrollLoad;

  PayrollLoadM({required this.PayrollLoad});

  factory PayrollLoadM.fromJson(Map<String, dynamic> json) {
    return PayrollLoadM(
      PayrollLoad: List.of(json["PayrollLoad"])
          .map((i) => PayrollLoadBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "PayrollLoad": jsonEncode(this.PayrollLoad),
    };
  }
//

/*
  factory PayrollLoadM.fromJson(Map<String, dynamic> json) => _$PayrollLoadMFromJson(json);

  Map<String, dynamic> toJson() => _$PayrollLoadMToJson(this);
*/
}

@JsonSerializable()
class PayrollLoadBean {
  String EmployeeCode;
  String EmpName;
  num Salary;
  num StatutoryCharges;
  num Attendance;
  num NetPay;
  bool isHide;
  num CTC;

  // PayrollLoadBean({
  //   required this.EmployeeCode,
  //   required this.EmpName,
  //   required this.Salary,
  //   required this.StatutoryCharges,
  //   required this.Attendance,
  //   required this.NetPay,
  //   required this.CTC,
  // });
  PayrollLoadBean({
    required this.isHide,
    required this.EmployeeCode,
    required this.Attendance,
    required this.CTC,
    required this.EmpName,
    required this.NetPay,
    required this.Salary,
    required this.StatutoryCharges,
  });

  factory PayrollLoadBean.fromJson(Map<String, dynamic> json) {
    return PayrollLoadBean(
      Salary: json["Salary"],
      EmployeeCode: json['EmployeeCode'],
      EmpName: json['EmpName'],
      Attendance: json['Attendance'],
      CTC: json['CTC'],
      NetPay: json['NetPay'],
      StatutoryCharges: json['StatutoryCharges'],
      isHide: json['isHide']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "EmployeeCode": this.EmployeeCode,
      "EmpName": this.EmpName,
      "Salary": this.Salary,
      "StatutoryCharges": this.StatutoryCharges,
      "Attendance": this.Attendance,
      "NetPay": this.NetPay,
      "isHide": this.isHide,
      "CTC": this.CTC,
    };
  }
//

/*
  factory PayrollLoadBean.fromJson(Map<String, dynamic> json) => _$PayrollLoadBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PayrollLoadBeanToJson(this);
*/
}
