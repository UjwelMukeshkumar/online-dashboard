import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'RequestDetailsM.g.dart';

@JsonSerializable()
class RequestDetailsM {
  List<RequestDetailsBean> RequestDetails;
  List<DeviceTokensBean> DeviceTokens;

  RequestDetailsM({
    required this.RequestDetails,
    required this.DeviceTokens,
  });

  factory RequestDetailsM.fromJson(Map<String, dynamic> json) {
    return RequestDetailsM(
      RequestDetails: List.of(json["RequestDetails"])
          .map((i) => RequestDetailsBean.fromJson(i))
          .toList(),
      DeviceTokens: List.of(json["DeviceTokens"])
          .map((i) => DeviceTokensBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "RequestDetails": jsonEncode(this.RequestDetails),
      "DeviceTokens": jsonEncode(this.DeviceTokens),
    };
  }

//

/*
  factory RequestDetailsM.fromJson(Map<String, dynamic> json) => _$RequestDetailsMFromJson(json);

  Map<String, dynamic> toJson() => _$RequestDetailsMToJson(this);
*/
}

@JsonSerializable()
class DeviceTokensBean {
  String DeviceToken;

  DeviceTokensBean({required this.DeviceToken});

  factory DeviceTokensBean.fromJson(Map<String, dynamic> json) {
    return DeviceTokensBean(
      DeviceToken: json["DeviceToken"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "DeviceToken": this.DeviceToken,
    };
  }
//

/*
  factory DeviceTokensBean.fromJson(Map<String, dynamic> json) => _$DeviceTokensBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTokensBeanToJson(this);
*/
}

@JsonSerializable()
class RequestDetailsBean {
  num Org_Id;
  num RequestID;
  String MobileNo;

  RequestDetailsBean({
  required this.Org_Id,
  required this.RequestID,
  required this.MobileNo,
  });

  factory RequestDetailsBean.fromJson(Map<String, dynamic> json) {
    return RequestDetailsBean(
      Org_Id: json["Org_Id"],
      RequestID: json["RequestID"],
      MobileNo: json["MobileNo"],
    );
  }
//

/*
  factory RequestDetailsBean.fromJson(Map<String, dynamic> json) => _$RequestDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RequestDetailsBeanToJson(this);
*/
}
