import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'ExpenceLoadM.g.dart';

@JsonSerializable()
class ExpenceLoadM {
  List<ListBean> Lists;
  List<TaxListBean> TaxList;
  List<DefaultAccountsBean> DefaultAccounts;

  ExpenceLoadM({
    required this.Lists,
    required this.TaxList,
    required this.DefaultAccounts,
  });

  factory ExpenceLoadM.fromJson(Map<String, dynamic> json) {
    return ExpenceLoadM(
      Lists: List.of(json["List"]).map((i) => ListBean.fromJson(i)).toList(),
      TaxList:
          List.of(json["TaxList"]).map((i) => TaxListBean.fromJson(i)).toList(),
      DefaultAccounts: List.of(json["DefaultAccounts"])
          .map((i) => DefaultAccountsBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "List": jsonEncode(this.Lists),
      "TaxList": jsonEncode(this.TaxList),
      "DefaultAccounts": jsonEncode(this.DefaultAccounts),
    };
  }
//

/*
  factory ExpenceLoadM.fromJson(Map<String, dynamic> json) => _$ExpenceLoadMFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenceLoadMToJson(this);
*/
}

@JsonSerializable()
class DefaultAccountsBean {
  num CashAccount;
  num CardAccount;
  num BankAccount;
  num ChequeAccount;
  String Cash;
  String Card;
  String Bank;
  String Cheque;

  factory DefaultAccountsBean.fromJson(Map<String, dynamic> json) {
    return DefaultAccountsBean(
      CashAccount: json["CashAccount"],
      CardAccount: json["CardAccount"],
      BankAccount: json["BankAccount"],
      ChequeAccount: json["ChequeAccount"],
      Cash: json["Cash"],
      Card: json["Card"],
      Bank: json["Bank"],
      Cheque: json["Cheque"],
    );
  }

  DefaultAccountsBean({
    required this.CashAccount,
    required this.CardAccount,
    required this.BankAccount,
    required this.ChequeAccount,
    required this.Cash,
    required this.Card,
    required this.Bank,
    required this.Cheque,
  });

/*
  factory DefaultAccountsBean.fromJson(Map<String, dynamic> json) => _$DefaultAccountsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultAccountsBeanToJson(this);
*/
}

@JsonSerializable()
class TaxListBean {
  String TaxCode;
  String Name;
  num Rate;

  TaxListBean({
    required this.TaxCode,
    required this.Name,
    required this.Rate,
  });

  factory TaxListBean.fromJson(Map<String, dynamic> json) {
    return TaxListBean(
      TaxCode: json["TaxCode"],
      Name: json["Name"],
      Rate: json["Rate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TaxCode": this.TaxCode,
      "Name": this.Name,
      "Rate": this.Rate,
    };
  }
//

/*
  factory TaxListBean.fromJson(Map<String, dynamic> json) => _$TaxListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TaxListBeanToJson(this);
*/
}

@JsonSerializable()
class ListBean {
  num Code;
  String Name;

  ListBean({
  required  this.Code,
   required this.Name,
  });

  factory ListBean.fromJson(Map<String, dynamic> json) {
    return ListBean(
      Code: json["Code"],
      Name: json["Name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Code": this.Code,
      "Name": this.Name,
    };
  }

  /*
  factory ListBean.fromJson(Map<String, dynamic> json) => _$ListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ListBeanToJson(this);
*/

  @override
  String toString() {
    return Name;
  }
}
