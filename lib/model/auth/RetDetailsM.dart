import 'package:json_annotation/json_annotation.dart';

//part 'RetDetailsM.g.dart';

@JsonSerializable()
class RetDetailsM {
  num RequestId;
  num PassKey;
  String UserName;
  num Key1;
  num Key2;
  num Key3;

  RetDetailsM({
    required this.RequestId,
    required this.PassKey,
    required this.UserName,
    required this.Key1,
    required this.Key2,
    required this.Key3,
  });

  factory RetDetailsM.fromJson(Map<String, dynamic> json) {
    return RetDetailsM(
      RequestId: json["RequestId"],
      PassKey: json["PassKey"],
      UserName: json["UserName"],
      Key1: json["Key1"],
      Key2: json["Key2"],
      Key3: json["Key3"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "RequestId": this.RequestId,
      "PassKey": this.PassKey,
      "UserName": this.UserName,
      "Key1": this.Key1,
      "Key2": this.Key2,
      "Key3": this.Key3,
    };
  }
//

/*
  factory RetDetailsM.fromJson(Map<String, dynamic> json) => _$RetDetailsMFromJson(json);

  Map<String, dynamic> toJson() => _$RetDetailsMToJson(this);
*/
}
