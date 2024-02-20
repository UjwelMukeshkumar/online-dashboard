import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'PunchM.g.dart';

@JsonSerializable()
class PunchM {
  List<HeaderBean> Header;
  List<LinesBean> Lines;
  List<Table2Bean> Table2;

  factory PunchM.fromJson(Map<String, dynamic> json) {
    return PunchM(
      Header:
          List.of(json["Header"]).map((i) => HeaderBean.fromJson(i)).toList(),
      Lines: List.of(json["Lines"]).map((i) => LinesBean.fromJson(i)).toList(),
      Table2:
          List.of(json["ClName"]).map((i) => Table2Bean.fromJson(i)).toList(),
    );
  }
/*  "data": {
  "Header": [],
  "Lines": [],
  "ClName": []*/

  Map<String, dynamic> toJson() {
    return {
      "Header": jsonEncode(this.Header),
      "Lines": jsonEncode(this.Lines),
      "ClName": jsonEncode(this.Table2),
    };
  }

  PunchM({
    required this.Header,
    required this.Lines,
    required this.Table2,
  });
/*

  factory PunchM.fromJson(Map<String, dynamic> json) => _$PunchMFromJson(json);

  Map<String, dynamic> toJson() => _$PunchMToJson(this);
*/
}

@JsonSerializable()
class Table2Bean {
  String PunchTime;

  Table2Bean({required this.PunchTime});

  factory Table2Bean.fromJson(Map<String, dynamic> json) {
    return Table2Bean(
      PunchTime: json["PunchTime"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "PunchTime": this.PunchTime,
    };
  }
//

/*
  factory Table2Bean.fromJson(Map<String, dynamic> json) =>
      _$Table2BeanFromJson(json);

  Map<String, dynamic> toJson() => _$Table2BeanToJson(this);
*/
}

@JsonSerializable()
class LinesBean {
  String PT;

  LinesBean({required this.PT});

  factory LinesBean.fromJson(Map<String, dynamic> json) {
    return LinesBean(
      PT: json["PT"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "PT": this.PT,
    };
  }
//

/*
  factory LinesBean.fromJson(Map<String, dynamic> json) =>
      _$LinesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LinesBeanToJson(this);
*/
}

@JsonSerializable()
class HeaderBean {
  String? ShiftBeginTime;
  String? ShiftEndTime;
  String? FirstPunch;
  String? LastPunch;

  HeaderBean({
    this.ShiftBeginTime,
    this.ShiftEndTime,
    this.FirstPunch,
  this.LastPunch,
  });

  factory HeaderBean.fromJson(Map<String, dynamic> json) {
    return HeaderBean(
      ShiftBeginTime: json["ShiftBeginTime"],
      ShiftEndTime: json["ShiftEndTime"],
      FirstPunch: json["FirstPunch"],
      LastPunch: json["LastPunch"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ShiftBeginTime": this.ShiftBeginTime,
      "ShiftEndTime": this.ShiftEndTime,
      "FirstPunch": this.FirstPunch,
      "LastPunch": this.LastPunch,
    };
  }
//

/*
  factory HeaderBean.fromJson(Map<String, dynamic> json) =>
      _$HeaderBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HeaderBeanToJson(this);
*/
}
