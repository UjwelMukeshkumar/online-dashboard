import 'package:json_annotation/json_annotation.dart';

// part 'EmpAttandanceM.g.dart';

// "EmployeeID": "1",
// "EmployeeName": "2",
// "AttendanceValue": "3",
// "AttendanceName": "4"

@JsonSerializable()
class EmpAttandanceM {
  @JsonKey(name: "1")
  String EmployeeID;
  @JsonKey(name: "2")
  String EmployeeName;
  @JsonKey(name: "3")
  num? AttendanceValue;
  @JsonKey(name: "4")
  String? AttendanceName;

  EmpAttandanceM({
  required  this.EmployeeID,
  required  this.EmployeeName,
   this.AttendanceValue,
    this.AttendanceName,
  });

  factory EmpAttandanceM.fromJson(Map<String, dynamic> json) {
    return EmpAttandanceM(
      EmployeeID: json["1"],
      EmployeeName: json["2"],
      AttendanceValue: json["3"],
      AttendanceName: json["4"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "1": this.EmployeeID,
      "2": this.EmployeeName,
      "3": this.AttendanceValue,
      "4": this.AttendanceName,
    };
  }
//

  /*factory EmpAttandanceM.fromJson(Map<String, dynamic> json) =>
      _$EmpAttandanceMFromJson(json);

  Map<String, dynamic> toJson() => _$EmpAttandanceMToJson(this);*/
}
