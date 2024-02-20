import 'package:json_annotation/json_annotation.dart';

// part 'AttandanceBranchM.g.dart';

@JsonSerializable()
class AttandanceBranchM {
  String Branch;
  num Present;
  num Absent;
  num CmpPresent;
  num CmpAbsent;

  AttandanceBranchM(
      {required this.Branch,
      required this.Present,
      required this.Absent,
      required this.CmpPresent,
      required this.CmpAbsent});

  factory AttandanceBranchM.fromJson(Map<String, dynamic> json) {
    return AttandanceBranchM(
      Branch: json["Branch"],
      Present: json["Present"],
      Absent: json["Absent"],
      CmpPresent: json["CmpPresent"],
      CmpAbsent: json["CmpAbsent"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Branch": this.Branch,
      "Present": this.Present,
      "Absent": this.Absent,
      "CmpPresent": this.CmpPresent,
      "CmpAbsent": this.CmpAbsent,
    };
  }

//

/*  factory AttandanceBranchM.fromJson(Map<String, dynamic> json) =>
      _$AttandanceBranchMFromJson(json);

  Map<String, dynamic> toJson() => _$AttandanceBranchMToJson(this);*/

}
