//import 'package:json_annotation/json_annotation.dart';

//part 'ExpenceM.g.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ExpenceM {
  num Account;
  String AccountName;
  num Amount;

  ExpenceM({
  required this.Account,
  required this.AccountName,
  required this.Amount,
  });

/*
  factory ExpenceM.fromJson(Map<String, dynamic> json) => _$ExpenceMFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenceMToJson(this);
*/
}
