import 'package:json_annotation/json_annotation.dart';

//part 'PartySearchM.g.dart';

@JsonSerializable()
class PartySearchM {
  late String? CVCode;
  late num? Code;
  late String? EmpCode;
  String? CVName;
  String? EmpName;
  String? Type;
  String? Name;
  num? Balance;
  num? GLAccount;
  num? EmpID;

  get code => CVCode ?? EmpCode ?? Code.toString();
  String get name => CVName ?? Name ?? EmpName.toString();
  get account => GLAccount.toString() ?? code.toString();

  PartySearchM({
     this.CVCode,
    this.CVName,
    this.Balance,
    this.GLAccount,
    this.Name,
    this.Code,
    this.Type,
    this.EmpName,
    this.EmpCode,
    this.EmpID,
  });

  factory PartySearchM.fromJson(Map<String, dynamic> json) {
    return PartySearchM(
      CVCode: json["CVCode"],
      Code: json["Code"],
      EmpCode: json["EmpCode"],
      CVName: json["CVName"],
      EmpName: json["EmpName"],
      Type: json["Type"],
      Name: json["Name"],
      Balance: json["Balance"],
      GLAccount: json["GLAccount"],
      EmpID: json["EmpID"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "CVCode": this.CVCode,
      "Code": this.Code,
      "EmpCode": this.EmpCode,
      "CVName": this.CVName,
      "EmpName": this.EmpName,
      "Type": this.Type,
      "Name": this.Name,
      "Balance": this.Balance,
      "GLAccount": this.GLAccount,
      "EmpID": this.EmpID,
    };
  }

  /*
  factory PartySearchM.fromJson(Map<String, dynamic> json) =>
      _$PartySearchMFromJson(json);

  Map<String, dynamic> toJson() => _$PartySearchMToJson(this);
*/
  @override
  String toString() {
    if (name.length == 0) {
      return "No Name";
    }
    return name;
  }
}

// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
// class PartySearchM {
//   late String CVCode;
//   late dynamic Code;
//   late dynamic EmpCode;
//   String? CVName;
//   String? EmpName;
//   String? Type;
//   String? Name;
//   num? Balance;
//   num? GLAccount;
//   num? EmpID;

//   PartySearchM({
//     required this.CVCode,
//     this.CVName,
//     this.Balance,
//     this.GLAccount,
//     this.Name,
//     this.Code,
//     this.Type,
//     this.EmpName,
//     this.EmpCode,
//     this.EmpID,
//   });

//   factory PartySearchM.fromJson(Map<String, dynamic> json) {
//     return PartySearchM(
//       CVCode: json["CVCode"],
//       Code: json["Code"],
//       EmpCode: json["EmpCode"],
//       CVName: json["CVName"],
//       EmpName: json["EmpName"],
//       Type: json["Type"],
//       Name: json["Name"],
//       Balance: json["Balance"],
//       GLAccount: json["GLAccount"],
//       EmpID: json["EmpID"],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "CVCode": this.CVCode,
//       "Code": this.Code,
//       "EmpCode": this.EmpCode,
//       "CVName": this.CVName,
//       "EmpName": this.EmpName,
//       "Type": this.Type,
//       "Name": this.Name,
//       "Balance": this.Balance,
//       "GLAccount": this.GLAccount,
//       "EmpID": this.EmpID,
//     };
//   }

//   get code => CVCode ?? EmpCode ?? Code;
//   String get name => CVName ?? Name ?? EmpName!;
//   get account => GLAccount.toString() ?? code.toString();

//   @override
//   String toString() {
//     if (name.length == 0) {
//       return "No Name";
//     }
//     return name;
//   }
// }

