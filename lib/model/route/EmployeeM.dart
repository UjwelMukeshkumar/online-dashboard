import 'package:json_annotation/json_annotation.dart';

//part 'EmployeeM.g.dart';

@JsonSerializable()
class RouteEmployeeM {
  String? EmpId;
  String? EmpCode;
  String? EmpName;

  RouteEmployeeM({
    this.EmpId,
    this.EmpCode,
    this.EmpName,
  });

  factory RouteEmployeeM.fromJson(Map<String, dynamic> json) {
    return RouteEmployeeM(
      EmpId: json["EmpId"],
      EmpCode: json["EmpCode"],
      EmpName: json["EmpName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "EmpId": this.EmpId,
      "EmpCode": this.EmpCode,
      "EmpName": this.EmpName,
    };
  }

  /*
  factory RouteEmployeeM.fromJson(Map<String, dynamic> json) => _$RouteEmployeeMFromJson(json);

  Map<String, dynamic> toJson() => _$RouteEmployeeMToJson(this);
*/

  @override
  String toString() {
    return EmpName!;
  }
}
