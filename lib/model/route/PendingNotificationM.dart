import 'package:json_annotation/json_annotation.dart';

//part 'PendingNotificationM.g.dart';

@JsonSerializable()
class PendingNotificationM {
  num RequestID;
  String EmpCode;
  String EmpName;
  String RouteName;

  factory PendingNotificationM.fromJson(Map<String, dynamic> json) {
    return PendingNotificationM(
      RequestID: json["RequestID"],
      EmpCode: json["EmpCode"],
      EmpName: json["EmpName"],
      RouteName: json["RouteName"],
      RouteId: json["RouteId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "RequestID": this.RequestID,
      "EmpCode": this.EmpCode,
      "EmpName": this.EmpName,
      "RouteName": this.RouteName,
      "RouteId": this.RouteId,
    };
  }

  num RouteId;

  PendingNotificationM({
   required this.RequestID,
   required this.EmpCode,
   required this.EmpName,
   required this.RouteName,
   required this.RouteId,
  });

/*
  factory PendingNotificationM.fromJson(Map<String, dynamic> json) => _$PendingNotificationMFromJson(json);

  Map<String, dynamic> toJson() => _$PendingNotificationMToJson(this);
*/
}
