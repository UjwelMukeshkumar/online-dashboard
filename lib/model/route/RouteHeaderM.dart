// ignore: unused_import
import 'package:json_annotation/json_annotation.dart';

//part 'RouteHeaderM.g.dart';

@JsonSerializable()
class RouteHeader {
  String api_key;
  String routeId;
  String EmpCode;

  RouteHeader({
   required this.api_key,
   required this.routeId,
   required this.EmpCode,
  });

  factory RouteHeader.fromJson(Map<String, dynamic> json) {
    return RouteHeader(
      api_key: json["api_key"],
      routeId: json["routeId"],
      EmpCode: json["EmpCode"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "api_key": this.api_key,
      "routeId": this.routeId,
      "EmpCode": this.EmpCode,
    };
  }
//

/*
  factory RouteHeader.fromJson(Map<String, dynamic> json) => _$RouteHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$RouteHeaderToJson(this);
*/
}
