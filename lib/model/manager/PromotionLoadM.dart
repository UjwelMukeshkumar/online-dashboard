import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'PromotionLoadM.g.dart';

@JsonSerializable()
class PromotionLoadM {
  List<PromotionBean> promotion;
  List<SubpromotionBean> subpromotion;

  Map<String, dynamic> toJson() {
    return {
      "promotion": jsonEncode(this.promotion),
      "subpromotion": jsonEncode(this.subpromotion),
    };
  }

  factory PromotionLoadM.fromJson(Map<String, dynamic> json) {
    return PromotionLoadM(
      promotion: List.of(json["promotion"])
          .map((i) => PromotionBean.fromJson(i))
          .toList(),
      subpromotion: List.of(json["subpromotion"])
          .map((i) => SubpromotionBean.fromJson(i))
          .toList(),
    );
  }

  PromotionLoadM({
    required this.promotion,
    required this.subpromotion,
  });

/*
  factory PromotionLoadM.fromJson(Map<String, dynamic> json) => _$PromotionLoadMFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionLoadMToJson(this);
*/
}

@JsonSerializable()
class SubpromotionBean {
  num Id;
  num PromotionId;
  String Name;
  bool selected;

  SubpromotionBean({
    required this.Id,
    required this.PromotionId,
    required this.Name,
    required this.selected,
  });

  factory SubpromotionBean.fromJson(Map<String, dynamic> json) {
    return SubpromotionBean(
      Id: json["Id"],
      PromotionId: (json["PromotionId"]),
      Name: json["Name"],
      selected: json["selected"]?.toLowerCase() == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": this.Id,
      "PromotionId": this.PromotionId,
      "Name": this.Name,
      "selected": this.selected,
    };
  }

  /*
  factory SubpromotionBean.fromJson(Map<String, dynamic> json) => _$SubpromotionBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SubpromotionBeanToJson(this);
*/

  @override
  String toString() {
    return Name;
  }
}

@JsonSerializable()
class PromotionBean {
  num Id;
  String Name;
  bool selected;
  PromotionBean({
    required this.Id,
    required this.Name,
    required this.selected,
  });

  factory PromotionBean.fromJson(Map<String, dynamic> json) {
    return PromotionBean(
      Id: json["Id"],
      Name: json["Name"],
      selected: json["selected"]?.toLowerCase() == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": this.Id,
      "Name": this.Name,
      "selected": this.selected,
    };
  }

  /*
  factory PromotionBean.fromJson(Map<String, dynamic> json) => _$PromotionBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionBeanToJson(this);
  @override
*/
  String toString() {
    return Name;
  }
}
