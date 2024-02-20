import 'package:glowrpt/util/MyKey.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'DayAttandanceM.g.dart';

// "1": "Date",
// "2": "AttendanceValue"
@JsonSerializable()
class DayAttandanceM {
  @JsonKey(name: "1")
  String Date;
  @JsonKey(name: "2")
  num AttendanceValue;
  DateTime get getFormatedDate => MyKey.dateWebFormat.parse(Date);
  DayAttandanceM({required this.Date,required this.AttendanceValue});

  factory DayAttandanceM.fromJson(Map<String, dynamic> json) {
    return DayAttandanceM(
      Date: json["1"],
      AttendanceValue: json["2"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "1": this.Date,
      "2": this.AttendanceValue,
    };
  }
//

/*
  factory DayAttandanceM.fromJson(Map<String, dynamic> json) =>
      _$DayAttandanceMFromJson(json);

  Map<String, dynamic> toJson() => _$DayAttandanceMToJson(this);
*/
}
