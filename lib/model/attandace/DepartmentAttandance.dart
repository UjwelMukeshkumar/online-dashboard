import 'package:json_annotation/json_annotation.dart';

//part 'DepartmentAttandance.g.dart';

@JsonSerializable()
class DepartmentAttandance {
  String Name;
  num Present;
  num Leave;

  DepartmentAttandance({required this.Name, required this.Present, required this.Leave});

  factory DepartmentAttandance.fromJson(Map<String, dynamic> json) {
    return DepartmentAttandance(
      Name: json["Name"],
      Present: json["Present"],
      Leave: json["Leave"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Name": this.Name,
      "Present": this.Present,
      "Leave": this.Leave,
    };
  }
//

/*
  factory DepartmentAttandance.fromJson(Map<String, dynamic> json) => _$DepartmentAttandanceFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentAttandanceToJson(this);
*/
}

