import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'ConsiceM.g.dart';

@JsonSerializable()
class ConsiceM {
  List<UserListBean> UserList;
  List<DocumetListBean> DocumetList;

  ConsiceM({
    required this.UserList,
   required  this.DocumetList,
  });

  factory ConsiceM.fromJson(Map<String, dynamic> json) {
    return ConsiceM(
      UserList: List.of(json["UserList"])
          .map((i) => UserListBean.fromJson(i))
          .toList(),
      DocumetList: List.of(json["DocumetList"])
          .map((i) => DocumetListBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "UserList": jsonEncode(this.UserList),
      "DocumetList": jsonEncode(this.DocumetList),
    };
  }
//

/*
  factory ConsiceM.fromJson(Map<String, dynamic> json) =>
      _$ConsiceMFromJson(json);

  Map<String, dynamic> toJson() => _$ConsiceMToJson(this);
*/
}

@JsonSerializable()
class DocumetListBean {
  String Document;
  num Amount;
  @JsonKey(name: "No Of Bills")
  num NoOfBills;
  num CmpAmount;
  String DocType;

  Map<String, dynamic> toJson() {
    return {
      "Document": this.Document,
      "Amount": this.Amount,
      "No Of Bills": this.NoOfBills,
      "CmpAmount": this.CmpAmount,
      "DocType": this.DocType,
    };
  }

  factory DocumetListBean.fromJson(Map<String, dynamic> json) {
    return DocumetListBean(
      Document: json["Document"],
      Amount: json["Amount"],
      NoOfBills: json["No Of Bills"],
      CmpAmount: json["CmpAmount"],
      DocType: json["DocType"],
    );
  }

  DocumetListBean({
    required this.Document,
    required this.Amount,
    required this.NoOfBills,
    required this.CmpAmount,
    required this.DocType,
  });

/*
  factory DocumetListBean.fromJson(Map<String, dynamic> json) =>
      _$DocumetListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DocumetListBeanToJson(this);
*/
}

@JsonSerializable()
class UserListBean {
  num? User_Id;
  String User_Name;

  UserListBean({this.User_Id, required this.User_Name});

  factory UserListBean.fromJson(Map<String, dynamic> json) {
    return UserListBean(
      User_Id: json["User_Id"],
      User_Name: json["User_Name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "User_Id": this.User_Id,
      "User_Name": this.User_Name,
    };
  }
}
