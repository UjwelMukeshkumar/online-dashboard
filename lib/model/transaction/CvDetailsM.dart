import 'package:json_annotation/json_annotation.dart';

//part 'CvDetailsM.g.dart';

@JsonSerializable()
class CvDetailsM {
  String CVCode;
  String CVName;
  num CVGroup;
  String GSTNo;
  num Balance;
  num PriceList;
  String Address;
  num PinCode;
  num State;
  dynamic State_Name;

  factory CvDetailsM.fromJson(Map<String, dynamic> json) {
    return CvDetailsM(
      CVCode: json["CVCode"],
      CVName: json["CVName"],
      CVGroup: json["CVGroup"],
      GSTNo: json["GSTNo"],
      Balance: json["Balance"],
      PriceList: json["PriceList"],
      Address: json["Address"],
      PinCode: json["PinCode"],
      State: json["State"],
      State_Name: json["State_Name"],
      PriceListName: json["PriceListName"],
      CVGroupName: json["CVGroupName"],
      MobileNo: json["MobileNo"],
      Email: json["Email"],
      GSTType: json["GSTType"],
    );
  }

  String PriceListName;
  String CVGroupName;
  String MobileNo;
  String Email;
  String GSTType;

  CvDetailsM({
  required  this.CVCode,
  required  this.CVName,
  required  this.CVGroup,
  required  this.GSTNo,
  required  this.Balance,
  required  this.PriceList,
  required  this.Address,
  required  this.PinCode,
  required  this.State,
  required  this.State_Name,
  required  this.PriceListName,
  required  this.CVGroupName,
  required  this.MobileNo,
  required  this.Email,
  required  this.GSTType,
  });

  Map<String, dynamic> toJson() {
    return {
      "CVCode": this.CVCode,
      "CVName": this.CVName,
      "CVGroup": this.CVGroup,
      "GSTNo": this.GSTNo,
      "Balance": this.Balance,
      "PriceList": this.PriceList,
      "Address": this.Address,
      "PinCode": this.PinCode,
      "State": this.State,
      "State_Name": this.State_Name,
      "PriceListName": this.PriceListName,
      "CVGroupName": this.CVGroupName,
      "MobileNo": this.MobileNo,
      "Email": this.Email,
      "GSTType": this.GSTType,
    };
  }

/*
  factory CvDetailsM.fromJson(Map<String, dynamic> json) => _$CvDetailsMFromJson(json);

  Map<String, dynamic> toJson() => _$CvDetailsMToJson(this);
*/
}
