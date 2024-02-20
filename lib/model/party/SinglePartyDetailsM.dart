import 'package:json_annotation/json_annotation.dart';

//part 'SinglePartyDetailsM.g.dart';

@JsonSerializable()
class SinglePartyDetailsM {
  String CVCode;
  String CVName;
  num CVGroup;
  String Barcode;
  num Balance;
  String ContactPerson;
  num GLAccount;
  String Branch;
  num CreditLimit;
  String Description;
  String MobileNo;
  String Email;
  num Discount;
  num PaymentTerms;
  String PaymentTermsName;
  num PriceList;
  String PriceListName;
  String? Type;
  num SalesPerson;
  String SalesPersonName;
  String TAX1;
  String TAX2;
  String FormNo;
  String Address;
  String CVInterState;

  factory SinglePartyDetailsM.fromJson(Map<String, dynamic> json) {
    return SinglePartyDetailsM(
      CVCode: json["CVCode"] ?? "",
      CVName: json["CVName"] ?? "",
      CVGroup: json["CVGroup"] ?? 0,
      Barcode: json["Barcode"] ?? "",
      Balance: json["Balance"] ?? 0,
      ContactPerson: json["ContactPerson"] ?? "",
      GLAccount: json["GLAccount"] ?? 0,
      Branch: json["Branch"] ?? "",
      CreditLimit: json["CreditLimit"] ?? 0,
      Description: json["Description"] ?? "",
      MobileNo: json["MobileNo"] ?? "",
      Email: json["Email"] ?? "",
      Discount: json["Discount"] ?? 0,
      PaymentTerms: json["PaymentTerms"] ?? 0,
      PaymentTermsName: json["PaymentTermsName"] ?? "",
      PriceList: (json["PriceList"]) ?? 0,
      PriceListName: json["PriceListName"] ?? "",
      Type: json["Type"] ?? "",
      SalesPerson: json["SalesPerson"] ?? 0,
      SalesPersonName: json["SalesPersonName"] ?? "",
      TAX1: json["TAX1"] ?? "",
      TAX2: json["TAX2"] ?? "",
      FormNo: json["FormNo"] ?? "",
      Address: json["Address"] ?? "",
      CVInterState: json["CVInterState"] ?? "",
    );
  }

  SinglePartyDetailsM({
    required this.CVCode,
    required this.CVName,
    required this.CVGroup,
    required this.Barcode,
    required this.Balance,
    required this.ContactPerson,
    required this.GLAccount,
    required this.Branch,
    required this.CreditLimit,
    required this.Description,
    required this.MobileNo,
    required this.Email,
    required this.Discount,
    required this.PaymentTerms,
    required this.PaymentTermsName,
    required this.PriceList,
    required this.PriceListName,
     this.Type,
    required this.SalesPerson,
    required this.SalesPersonName,
    required this.TAX1,
    required this.TAX2,
    required this.FormNo,
    required this.Address,
    required this.CVInterState,
  });

/*
  factory SinglePartyDetailsM.fromJson(Map<String, dynamic> json) => _$SinglePartyDetailsMFromJson(json);

  Map<String, dynamic> toJson() => _$SinglePartyDetailsMToJson(this);
*/
}
