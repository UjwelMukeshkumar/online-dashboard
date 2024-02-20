import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../pos/AuthM.dart';

// part 'DefaultM.g.dart';

@JsonSerializable()
class DefaultM {
  List<DetailsBean>? Details;
  List<AuthM> Auth;

  DefaultM({
    this.Details,
   required this.Auth,
  });

  factory DefaultM.fromJson(Map<String, dynamic> json) {
    return DefaultM(
      Details: json["Details"] == null
          ? []
          : List.of(json["Details"])
              .map((i) => DetailsBean.fromJson(i))
              .toList(),
      Auth: json["Auth"] == null
          ? []
          : List.of(json["Auth"]).map((i) => AuthM.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Details": jsonEncode(this.Details),
      "Auth": jsonEncode(this.Auth),
    };
  }
//

  /*factory DefaultM.fromJson(Map<String, dynamic> json) => _$DefaultMFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultMToJson(this);*/
}

@JsonSerializable()
class DetailsBean {
  String? CVCode;
  String? CVName;
  num? PriceList;

  DetailsBean({ this.CVCode,this.CVName, this.PriceList});

  factory DetailsBean.fromJson(Map<String, dynamic> json) {
    return DetailsBean(
      CVCode: json["CVCode"],
      CVName: json["CVName"],
      PriceList: json["PriceList"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "CVCode": this.CVCode,
      "CVName": this.CVName,
      "PriceList": this.PriceList,
    };
  }
//

  /*factory DetailsBean.fromJson(Map<String, dynamic> json) => _$DetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsBeanToJson(this);*/
}
