import 'package:json_annotation/json_annotation.dart';

//part 'PendingBillsM.g.dart';

@JsonSerializable()
class PendingBillsM {
  String Document;
  String PostDate;

  factory PendingBillsM.fromJson(Map<String, dynamic> json) {
    return PendingBillsM(
      Document: json["Document"],
      PostDate: json["PostDate"],
      BalanceDue: json["BalanceDue"],
    );
  }

  num BalanceDue;

  Map<String, dynamic> toJson() {
    return {
      "Document": this.Document,
      "PostDate": this.PostDate,
      "BalanceDue": this.BalanceDue,
    };
  }

  PendingBillsM({
  required  this.Document,
  required  this.PostDate,
  required  this.BalanceDue,
  });

/*
  factory PendingBillsM.fromJson(Map<String, dynamic> json) => _$PendingBillsMFromJson(json);

  Map<String, dynamic> toJson() => _$PendingBillsMToJson(this);
*/
}
