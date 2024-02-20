import 'package:json_annotation/json_annotation.dart';

//part 'EmpM.g.dart';

@JsonSerializable()
class EmpM {
  String EmpName;
  String DateFrom;
  String DateTo;
  String Reason;
  String ApprovalLevel;

  EmpM({required this.EmpName,required this.DateFrom, required this.DateTo, required this.Reason,required this.ApprovalLevel});

  factory EmpM.fromJson(Map<String, dynamic> json) {
    return EmpM(
      EmpName: json["EmpName"],
      DateFrom: json["DateFrom"],
      DateTo: json["DateTo"],
      Reason: json["Reason"],
      ApprovalLevel: json["ApprovalLevel"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "EmpName": this.EmpName,
      "DateFrom": this.DateFrom,
      "DateTo": this.DateTo,
      "Reason": this.Reason,
      "ApprovalLevel": this.ApprovalLevel,
    };
  }
//

/*
  factory EmpM.fromJson(Map<String, dynamic> json) => _$EmpMFromJson(json);

  Map<String, dynamic> toJson() => _$EmpMToJson(this);
*/
}

