import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'PayrollDetailsM.g.dart';

@JsonSerializable()
class PayrollDetailsM {
  List<EarningsBean> Earnings;
  List<DeductionsBean> Deductions;
  @JsonKey(name: "Earnings&Deductions")
  List<EarningandandDeductionsBean> EarningandandDeductions;
  List<StatutoryChargesBean> StatutoryCharges;
  List<AttendanceBean> Attendance;
  List<SalaryBricksBean> SalaryBricks;

  Map<String, dynamic> toJson() {
    return {
      "Earnings": jsonEncode(this.Earnings),
      "Deductions": jsonEncode(this.Deductions),
      "Earnings&Deductions": jsonEncode(this.EarningandandDeductions),
      "StatutoryCharges": jsonEncode(this.StatutoryCharges),
      "Attendance": jsonEncode(this.Attendance),
      "SalaryBricks": jsonEncode(this.SalaryBricks),
    };
  }

  factory PayrollDetailsM.fromJson(Map<String, dynamic> json) {
    return PayrollDetailsM(
      Earnings: List.of(json["Earnings"])
          .map((i) => EarningsBean.fromJson(i))
          .toList(),
      Deductions: List.of(json["Deductions"])
          .map((i) => DeductionsBean.fromJson(i))
          .toList(),
      EarningandandDeductions: List.of(json["Earnings&Deductions"])
          .map((i) => EarningandandDeductionsBean.fromJson(i))
          .toList(),
      StatutoryCharges: List.of(json["StatutoryCharges"])
          .map((i) => StatutoryChargesBean.fromJson(i))
          .toList(),
      Attendance: List.of(json["Attendance"])
          .map((i) => AttendanceBean.fromJson(i))
          .toList(),
      SalaryBricks: List.of(json["SalaryBricks"])
          .map((i) => SalaryBricksBean.fromJson(i))
          .toList(),
    );
  }

  PayrollDetailsM(
      {required this.Earnings,
      required this.Deductions,
      required this.EarningandandDeductions,
      required this.StatutoryCharges,
      required this.Attendance,
      required this.SalaryBricks});

/*
  factory PayrollDetailsM.fromJson(Map<String, dynamic> json) => _$PayrollDetailsMFromJson(json);

  Map<String, dynamic> toJson() => _$PayrollDetailsMToJson(this);
*/
}

@JsonSerializable()
class AttendanceBean {
  String FirstPunch;
  String LastPunch;
  String AttendanceName;

  Map<String, dynamic> toJson() {
    return {
      "FirstPunch": this.FirstPunch,
      "LastPunch": this.LastPunch,
      "AttendanceName": this.AttendanceName,
    };
  }

  AttendanceBean({required this.FirstPunch, required this.LastPunch, required this.AttendanceName});

  factory AttendanceBean.fromJson(Map<String, dynamic> json) {
    return AttendanceBean(
      FirstPunch: json["FirstPunch"],
      LastPunch: json["LastPunch"],
      AttendanceName: json["AttendanceName"],
    );
  }
//

/*
  factory AttendanceBean.fromJson(Map<String, dynamic> json) => _$AttendanceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceBeanToJson(this);
*/
}

@JsonSerializable()
class StatutoryChargesBean {
  String BrickCode;
  num StatutoryCharges;

  StatutoryChargesBean({required this.BrickCode, required this.StatutoryCharges});

  factory StatutoryChargesBean.fromJson(Map<String, dynamic> json) {
    return StatutoryChargesBean(
      BrickCode: json["BrickCode"]??"",
      StatutoryCharges: json["StatutoryCharges"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "BrickCode": this.BrickCode,
      "StatutoryCharges": this.StatutoryCharges,
    };
  }
//

/*
  factory StatutoryChargesBean.fromJson(Map<String, dynamic> json) => _$StatutoryChargesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$StatutoryChargesBeanToJson(this);
*/
}

@JsonSerializable()
class EarningandandDeductionsBean {
  String Text;
  num Salary;

  EarningandandDeductionsBean({required this.Text, required this.Salary});

  factory EarningandandDeductionsBean.fromJson(Map<String, dynamic> json) {
    return EarningandandDeductionsBean(
      Text: json["Text"],
      Salary: json["Salary"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Text": this.Text,
      "Salary": this.Salary,
    };
  }
//

/*
  factory EarningandandDeductionsBean.fromJson(Map<String, dynamic> json) => _$EarningandandDeductionsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EarningandandDeductionsBeanToJson(this);
*/
}

@JsonSerializable()
class DeductionsBean {
  String BrickCode;
  num Salary;

  DeductionsBean({required this.BrickCode, required this.Salary});

  factory DeductionsBean.fromJson(Map<String, dynamic> json) {
    return DeductionsBean(
      BrickCode: json["BrickCode"]??"",
      Salary: json["Salary"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "BrickCode": this.BrickCode,
      "Salary": this.Salary,
    };
  }
//

/*
  factory DeductionsBean.fromJson(Map<String, dynamic> json) => _$DeductionsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DeductionsBeanToJson(this);
*/
}

@JsonSerializable()
class EarningsBean {
  String BrickCode;
  num Salary;

  Map<String, dynamic> toJson() {
    return {
      "BrickCode": this.BrickCode,
      "Salary": this.Salary,
    };
  }

  factory EarningsBean.fromJson(Map<String, dynamic> json) {
    return EarningsBean(
      BrickCode: json["BrickCode"]??"",
      Salary: json["Salary"],
    );
  }

  EarningsBean({required this.BrickCode, required this.Salary});

/*
  factory EarningsBean.fromJson(Map<String, dynamic> json) => _$EarningsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EarningsBeanToJson(this);
*/
}

@JsonSerializable()
class SalaryBricksBean {
  String BrickCode;
  num Amount;

  SalaryBricksBean({required this.BrickCode, required this.Amount});

  Map<String, dynamic> toJson() {
    return {
      "BrickCode": this.BrickCode,
      "Amount": this.Amount,
    };
  }

  factory SalaryBricksBean.fromJson(Map<String, dynamic> json) {
    return SalaryBricksBean(
      BrickCode: json["BrickCode"],
      Amount: json["Amount"],
    );
  }
//

/*
  factory SalaryBricksBean.fromJson(Map<String, dynamic> json) => _$SalaryBricksBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SalaryBricksBeanToJson(this);
*/
}
