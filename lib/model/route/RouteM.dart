import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'RouteM.g.dart';

@JsonSerializable()
class RouteM {
  String? EMPCode;
  num? RouteID;
  String? RouteName;
  String? RouteBegin;
  String? RouteEnd;
  bool? inactive;
  RouteM({
    this.EMPCode,
    this.RouteID,
    this.RouteName,
    this.inactive,
    this.RouteBegin,
    this.RouteEnd,
  });

  factory RouteM.fromJson(Map<String, dynamic> json) {
    return RouteM(
      EMPCode: json["EMPCode"],
      RouteID: (json["RouteID"]),
      RouteName: json["RouteName"],
      RouteBegin: json["RouteBegin"],
      RouteEnd: json["RouteEnd"],
      inactive: json["inactive"]?.toLowerCase() == 'true',
    );
  }
  bool get isRouteBigin => RouteBegin == "Y";
  bool get isRouteEnd => RouteEnd == "Y";

  String get getText {
    if (isRouteBigin && !isRouteEnd) {
      return "Ongoing";
    }
    if (isRouteBigin && isRouteEnd) {
      return "Finished";
    }
    return "";
  }

  Color get getColor {
    if (isRouteBigin && !isRouteEnd) {
      return Colors.green;
    }
    if (isRouteBigin && isRouteEnd) {
      return Colors.black45;
    }
    return Colors.orange;
  }
//

/*
  factory RouteM.fromJson(Map<String, dynamic> json) => _$RouteMFromJson(json);

  Map<String, dynamic> toJson() => _$RouteMToJson(this);
*/
}
