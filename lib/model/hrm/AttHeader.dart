// ignore: unused_import
import 'package:json_annotation/json_annotation.dart';

//part 'AttHeader.g.dart';

@JsonSerializable()
class AttHeader {
  String api_key;
  String DocDate;
  String Remarks;
  String InitNo;
  String RecNum;
  String Sequence;

  AttHeader({
  required  this.api_key,
  required  this.DocDate,
  required  this.Remarks,
  required  this.InitNo,
  required  this.RecNum,
  required  this.Sequence,
  });

  factory AttHeader.fromJson(Map<String, dynamic> json) {
    return AttHeader(
      api_key: json["api_key"],
      DocDate: json["DocDate"],
      Remarks: json["Remarks"],
      InitNo: json["InitNo"],
      RecNum: json["RecNum"],
      Sequence: json["Sequence"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "api_key": this.api_key,
      "DocDate": this.DocDate,
      "Remarks": this.Remarks,
      "InitNo": this.InitNo,
      "RecNum": this.RecNum,
      "Sequence": this.Sequence,
    };
  }
//

/*
  factory AttHeader.fromJson(Map<String, dynamic> json) =>
      _$AttHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$AttHeaderToJson(this);
*/
}
