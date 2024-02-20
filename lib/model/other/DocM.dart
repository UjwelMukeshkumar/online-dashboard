import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// part 'DocM.g.dart';

@JsonSerializable()
class DocM {
  List<HeaderBean>? Header;
  List<LinesBean> Lines;

  DocM({
   this.Header,
    required this.Lines,
  });

  factory DocM.fromJson(Map<String, dynamic> json) {
    return DocM(
      Header:
          List.of(json["Header"]).map((i) => HeaderBean.fromJson(i)).toList(),
      Lines: List.of(json["Lines"]).map((i) => LinesBean.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Header": jsonEncode(this.Header),
      "Lines": jsonEncode(this.Lines),
    };
  }
//

  /*factory DocM.fromJson(Map<String, dynamic> json) => _$DocMFromJson(json);

  Map<String, dynamic> toJson() => _$DocMToJson(this);*/
}

@JsonSerializable()
class LinesBean {
  String PartyName;
  String Time;
  num NetAmt;
  num GPPercent;
  num Sequence;
  num RecNum;
  num InitNo;
  String Type;

  LinesBean({
    required this.PartyName,
    required this.Time,
    required this.NetAmt,
    required this.GPPercent,
    required this.Sequence,
    required this.RecNum,
    required this.InitNo,
    required this.Type,
  });

  factory LinesBean.fromJson(Map<String, dynamic> json) {
    return LinesBean(
      PartyName: json["PartyName"]??"",
      Time: json["Time"]??"",
      NetAmt: json["NetAmt"]??0,
      GPPercent: json["GPPercent"]??0,
      Sequence: json["Sequence"]??0,
      RecNum: json["RecNum"]??0,
      InitNo: json["InitNo"]??0,
      Type: json["Type"]??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "PartyName": this.PartyName,
      "Time": this.Time,
      "NetAmt": this.NetAmt,
      "GPPercent": this.GPPercent,
      "Sequence": this.Sequence,
      "RecNum": this.RecNum,
      "InitNo": this.InitNo,
      "Type": this.Type,
    };
  }
//

  /*factory LinesBean.fromJson(Map<String, dynamic> json) =>
      _$LinesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LinesBeanToJson(this);*/
}

class HeaderBean {
  num BillNo;
  num Amount;
  num GP;
  num TotalGrossProfit;
  num TotalCredit;
  num TotalReceipt;
  num AverageBaskutValue;
  num TotalPageNum;
  num PageNo;
  num TaxAmount;
  num Sales;
  num SalesReturn;
  num RoundingAmount;

  HeaderBean({
  required  this.BillNo,
  required  this.Amount,
  required  this.GP,
  required  this.TotalGrossProfit,
  required  this.TotalCredit,
  required  this.PageNo,
  required  this.TotalReceipt,
  required  this.AverageBaskutValue,
  required  this.TotalPageNum,
  required  this.Sales,
  required  this.SalesReturn,
  required  this.TaxAmount,
  required  this.RoundingAmount,
  });

  factory HeaderBean.fromJson(Map<String, dynamic> json) {
    return HeaderBean(
      BillNo: json["Bill No"]??0,
      Amount: json["Amount"]??0,
      GP: json["GP"]??0,
      TotalGrossProfit: json["TotalGrossProfit"]??0,
      TotalCredit: json["TotalCredit"]??0,
      TotalReceipt: json["TotalReceipt"]??0,
      AverageBaskutValue: json["AverageBaskutValue"]??0,
      TotalPageNum: json["TotalPageNum"]??0,
      PageNo: json["PageNo"],
      TaxAmount: json["TaxAmount"]??0,
      Sales: json["Sales"]??0,
      SalesReturn: json["SalesReturn"]??0,
      RoundingAmount: json["RoundingAmount"]??0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Bill No": this.BillNo,
      "Amount": this.Amount,
      "GP": this.GP,
      "TotalGrossProfit": this.TotalGrossProfit,
      "TotalCredit": this.TotalCredit,
      "TotalReceipt": this.TotalReceipt,
      "AverageBaskutValue": this.AverageBaskutValue,
      "TotalPageNum": this.TotalPageNum,
      "PageNo": this.PageNo,
      "TaxAmount": this.TaxAmount,
      "Sales": this.Sales,
      "SalesReturn": this.SalesReturn,
      "RoundingAmount": this.RoundingAmount,
    };
  }
//

  /* factory HeaderBean.fromJson(Map<String, dynamic> json) =>
      _$HeaderBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HeaderBeanToJson(this);*/
}
