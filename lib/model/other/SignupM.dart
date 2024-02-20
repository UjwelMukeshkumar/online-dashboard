import 'package:json_annotation/json_annotation.dart';

// part 'SignupM.g.dart';

@JsonSerializable()
class SignupM {
  num Org_Id;
  String Organisation;
  String UserName;
  String Password;

  SignupM({
  required  this.Org_Id,
  required  this.Organisation,
  required  this.UserName,
  required  this.Password,
  });

  factory SignupM.fromJson(Map<String, dynamic> json) {
    return SignupM(
      Org_Id: json["Org_Id"],
      Organisation: json["Organisation"],
      UserName: json["UserName"],
      Password: json["Password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Org_Id": this.Org_Id,
      "Organisation": this.Organisation,
      "UserName": this.UserName,
      "Password": this.Password,
    };
  }
//

  /*factory SignupM.fromJson(Map<String, dynamic> json) =>
      _$SignupMFromJson(json);

  Map<String, dynamic> toJson() => _$SignupMToJson(this);*/
}
