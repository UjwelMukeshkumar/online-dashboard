// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
// part "User.g.dart";

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

@JsonSerializable()
class User {
  String? get identity => organisation! + userCode!;
  String? server;
  String? db;
  int? loginNo;
  String? loginId;
  String? username;
  int? isSessionExpired;
  String? userCode;
  String? password;
  String? syskey;
  String? isEditor;
  String? defualtLanguage;
  String? languagesList;
  String? organisation;
  String? companyEmail;
  String? isDashboard;
  String? logoImage;
  int? orgId;
  int? loggedOrgId;
  int? userId;
  String apiKey;
  String? mobile;
  int? errorNo;
  String? UserBranches;
  String? MangerDB;
  String? SalesDB;
  String? AccountDB;
  String? EmployeeDB;
  String? PurchaseDB;
  String? HRMDB;
  String? RTMDB;
  String? ExportingOrg;
  String? STKDB;

  User({
    this.server,
    this.db,
    this.loginNo,
    this.loginId,
     this.username,
     this.userCode,
    this.password,
    this.syskey,
    this.isEditor,
    this.defualtLanguage,
    this.languagesList,
    this.organisation,
    this.companyEmail,
    this.isDashboard,
    this.logoImage,
    this.orgId,
    this.loggedOrgId,
    this.userId,
     this.apiKey="",
    this.mobile,
    this.errorNo,
    this.isSessionExpired,
    this.UserBranches,
    this.MangerDB,
    this.SalesDB,
    this.AccountDB,
    this.EmployeeDB,
    this.PurchaseDB,
    this.HRMDB,
    this.RTMDB,
    this.ExportingOrg,
    this.STKDB,
  });

/*  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);*/

  factory User.fromJson(Map<String, dynamic> json) => User(
        server: json["server"],
        db: json["DB"],
        loginNo: json["LoginNo"],
        loginId: json["LoginID"],
        username: json["Username"],
        userCode: json["userCode"],
        password: json["password"],
        syskey: json["syskey"],
        isEditor: json["IsEditor"],
        defualtLanguage: json["DefualtLanguage"],
        languagesList: json["LanguagesList"],
        organisation: json["Organisation"],
        companyEmail: json["CompanyEmail"],
        isDashboard: json["IsDashboard"],
        logoImage: json["logoImage"],
        orgId: json["OrgId"],
        loggedOrgId: json["LoggedOrgID"],
        userId: json["UserId"],
        apiKey: json["api_key"],
        mobile: json["Mobile"].toString(),
        errorNo: json["ErrorNo"],
        isSessionExpired: json["isSessionExpired"] ?? 0,
        UserBranches: json["UserBranches"],
        MangerDB: json["MangerDB"],
        SalesDB: json["SalesDB"],
        AccountDB: json["AccountDB"],
        EmployeeDB: json["EmployeeDB"],
        PurchaseDB: json["PurchaseDB"],
        HRMDB: json["HRMDB"],
        RTMDB: json["RTMDB"],
        STKDB: json["STKDB"],
        ExportingOrg: json["ExportingOrg"],
      );
  String toJsonString() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "server": server,
        "DB": db,
        "LoginNo": loginNo,
        "LoginID": loginId,
        "Username": username,
        "userCode": userCode,
        "password": password,
        "syskey": syskey,
        "IsEditor": isEditor,
        "DefualtLanguage": defualtLanguage,
        "LanguagesList": languagesList,
        "Organisation": organisation,
        "CompanyEmail": companyEmail,
        "IsDashboard": isDashboard,
        "logoImage": logoImage,
        "OrgId": orgId,
        "LoggedOrgID": loggedOrgId,
        "UserId": userId,
        "api_key": apiKey,
        "Mobile": mobile,
        "ErrorNo": errorNo,
        "identity": identity,
        "isSessionExpired": isSessionExpired,
        "UserBranches": UserBranches,
        "MangerDB": MangerDB,
        "SalesDB": SalesDB,
        "AccountDB": AccountDB,
        "EmployeeDB": EmployeeDB,
        "PurchaseDB": PurchaseDB,
        "HRMDB": HRMDB,
        "RTMDB": RTMDB,
        "STKDB": STKDB,
        "ExportingOrg": ExportingOrg,
      };
}
