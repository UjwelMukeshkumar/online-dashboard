import 'package:json_annotation/json_annotation.dart';

//part 'EmployeeM.g.dart';

@JsonSerializable()
class EmployeeM {
  String EmpName;
  String EmpImage;
  String Designation;
  String Department;
  String Manager;
  String ManagerImg;

  factory EmployeeM.fromJson(Map<String, dynamic> json) {
    return EmployeeM(
      EmpName: json["EmpName"],
      EmpImage: json["EmpImage"],
      Designation: json["Designation"],
      Department: json["Department"],
      Manager: json["Manager"],
      ManagerImg: json["ManagerImg"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Department": this.Department,
    };
  }

  EmployeeM({
    required this.EmpName,
    required this.EmpImage,
    required this.Designation,
    required this.Department,
    required this.Manager,
    required this.ManagerImg,
  });

/*
  factory EmployeeM.fromJson(Map<String, dynamic> json) => _$EmployeeMFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeMToJson(this);
*/
}
