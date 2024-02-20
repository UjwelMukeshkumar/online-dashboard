/*
// @dart=2.9
// */
import 'package:json_annotation/json_annotation.dart';

//part 'AccountDataM.g.dart';

@JsonSerializable()
class AccountDataM {
  num LineEntry;
  num AccountNo;
  num CollectedSum;
  num Details;
  String AccountName;

  AccountDataM({
  required this.LineEntry,
  required this.AccountNo,
  required this.CollectedSum,
  required this.Details,
  required this.AccountName,
  });

  factory AccountDataM.fromJson(Map<String, dynamic> json) {
    return AccountDataM(
      LineEntry: json["LineEntry"],
      AccountNo: json["AccountNo"],
      CollectedSum: json["CollectedSum"],
      Details: json["Details"],
      AccountName: json["AccountName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "LineEntry": this.LineEntry,
      "AccountNo": this.AccountNo,
      "CollectedSum": this.CollectedSum,
      "Details": this.Details,
      "AccountName": this.AccountName,
    };
  }
//

/*
  factory AccountDataM.fromJson(Map<String, dynamic> json) =>
      _$AccountDataMFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDataMToJson(this);
*/
}
