import 'package:glowrpt/util/MyKey.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'AttandanceEmpM.g.dart';

// "Date": "1",
// "AttendanceValue": "2",
// "AttendanceName": "3"
@JsonSerializable()
class AttandanceEmpM {
  @JsonKey(name: "1")
  String date;
  @JsonKey(name: "2")
  num attendanceValue;
  @JsonKey(name: "3")
  String attendanceName;
  DateTime get getFormatedDate => MyKey.dateWebFormat.parse(date);

  AttandanceEmpM({required this.date, required this.attendanceValue,required this.attendanceName});

  factory AttandanceEmpM.fromJson(Map<String, dynamic> json) {
    return AttandanceEmpM(
      date: json["1"],
      attendanceValue: json["2"],
      attendanceName: json["3"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "1": this.date,
      "2": this.attendanceValue,
      "3": this.attendanceName,
    };
  }
//

/*
  factory AttandanceEmpM.fromJson(Map<String, dynamic> json) =>
      _$AttandanceEmpMFromJson(json);

  Map<String, dynamic> toJson() => _$AttandanceEmpMToJson(this);
*/
}
