import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'NextNumM.g.dart';

@JsonSerializable()
class NextNumM {
  List<NextNumBean> NextNum;

  NextNumM({required this.NextNum});

  factory NextNumM.fromJson(Map<String, dynamic> json) {
    return NextNumM(
      NextNum:
          List.of(json["NextNum"]).map((i) => NextNumBean.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "NextNum": jsonEncode(this.NextNum),
    };
  }
//

/*
  factory NextNumM.fromJson(Map<String, dynamic> json) => _$NextNumMFromJson(json);

  Map<String, dynamic> toJson() => _$NextNumMToJson(this);
*/
}

@JsonSerializable()
class NextNumBean {
  num Column1;

  NextNumBean({required this.Column1});

  Map<String, dynamic> toJson() {
    return {
      "Column1": this.Column1,
    };
  }

  factory NextNumBean.fromJson(Map<String, dynamic> json) {
    return NextNumBean(
      Column1: json["Column1"],
    );
  }
//

/*
  factory NextNumBean.fromJson(Map<String, dynamic> json) => _$NextNumBeanFromJson(json);

  Map<String, dynamic> toJson() => _$NextNumBeanToJson(this);
*/
}
