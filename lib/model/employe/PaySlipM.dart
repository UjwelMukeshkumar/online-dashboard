import 'package:json_annotation/json_annotation.dart';

//part 'PaySlipM.g.dart';

@JsonSerializable()
class PaySlipM {
  String EmployeeCode;
  String EmpName;
  num Amount;
  num PayNo;

  PaySlipM({required this.EmployeeCode, required this.EmpName, required this.Amount, required this.PayNo});

  factory PaySlipM.fromJson(Map<String, dynamic> json) {
    return PaySlipM(
      EmployeeCode: json["EmployeeCode"],
      EmpName: json["EmpName"],
      Amount: json["Amount"],
      PayNo: json["PayNo"],
    );
  }
//

/*
  factory PaySlipM.fromJson(Map<String, dynamic> json) => _$PaySlipMFromJson(json);

  Map<String, dynamic> toJson() => _$PaySlipMToJson(this);
*/
}

