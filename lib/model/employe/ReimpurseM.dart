import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'ReimpurseM.g.dart';

@JsonSerializable()
class ReimpurseM {
  @JsonKey(name: "List")
  List<ListBean> Lists;

  ReimpurseM({required this.Lists});

  factory ReimpurseM.fromJson(Map<String, dynamic> json) {
    return ReimpurseM(
      Lists: List.of(json["List"]).map((i) => ListBean.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "List": jsonEncode(this.Lists),
    };
  }
//

/*
  factory ReimpurseM.fromJson(Map<String, dynamic> json) =>
      _$ReimpurseMFromJson(json);

  Map<String, dynamic> toJson() => _$ReimpurseMToJson(this);
*/
}

@JsonSerializable()
class ListBean {
  num RequestID;
  String Activity;
  String Amount;
  String ApprovalLevel;
  String Date;

  ListBean(
      {required this.RequestID,
      required this.Activity,
      required this.Amount,
      required this.ApprovalLevel,
      required this.Date});

  factory ListBean.fromJson(Map<String, dynamic> json) {
    return ListBean(
      RequestID: json["RequestID"],
      Activity: json["Activity"],
      Amount: json["Amount"].toString(),
      ApprovalLevel: json["ApprovalLevel"],
      Date: json["Date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "RequestID": this.RequestID,
      "Activity": this.Activity,
      "Amount": this.Amount,
      "ApprovalLevel": this.ApprovalLevel,
      "Date": this.Date,
    };
  }
//

/*
  factory ListBean.fromJson(Map<String, dynamic> json) =>
      _$ListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ListBeanToJson(this);
*/
}
