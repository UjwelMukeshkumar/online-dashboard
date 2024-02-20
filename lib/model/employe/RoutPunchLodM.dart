import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'RoutPunchLodM.g.dart';

@JsonSerializable()
class RoutPunchLodM {
  List<TypesBean> Types;

  factory RoutPunchLodM.fromJson(Map<String, dynamic> json) {
    return RoutPunchLodM(
      Types: List.of(json["Types"])
          .map((i) => TypesBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Types": jsonEncode(this.Types),
    };
  }

  RoutPunchLodM({required this.Types});

  // factory RoutPunchLodM.fromJson(Map<String, dynamic> json) => _$RoutPunchLodMFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$RoutPunchLodMToJson(this);
}

@JsonSerializable()
class TypesBean {
  String Type;

  Map<String, dynamic> toJson() {
    return {
      "Type": this.Type,
    };
  }

  TypesBean({required this.Type});

  factory TypesBean.fromJson(Map<String, dynamic> json) {
    return TypesBean(
      Type: json["Type"],
    );
  }
//

/*
  factory TypesBean.fromJson(Map<String, dynamic> json) => _$TypesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TypesBeanToJson(this);
*/
}

