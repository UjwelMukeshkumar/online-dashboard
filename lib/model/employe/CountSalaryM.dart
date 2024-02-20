//import 'package:json_annotation/json_annotation.dart';

//part 'CountSalaryM.g.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CountSalaryM {
  num TotalEmployee;

  factory CountSalaryM.fromJson(Map<String, dynamic> json) {
    return CountSalaryM(
      TotalEmployee: json["TotalEmployee"],
      Salary: json["Salary"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TotalEmployee": this.TotalEmployee,
      "Salary": this.Salary,
    };
  }

  num Salary;

  CountSalaryM({
    required this.TotalEmployee,
    required this.Salary,
  });

/*
  factory CountSalaryM.fromJson(Map<String, dynamic> json) => _$CountSalaryMFromJson(json);

  Map<String, dynamic> toJson() => _$CountSalaryMToJson(this);
*/
}
