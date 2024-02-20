/*
// @dart=2.7
*/
import 'package:json_annotation/json_annotation.dart';

//part 'ReciptHeadderM.g.dart';

@JsonSerializable()
class ReciptHeadderM {
  String PartyCode;
  String PartyType;
  String api_key;
  num CashAmount;
  num CreditAmount;
  String CardName;
  String Date;
  num CardNum;
  num CheckAmount;
  String ChequeDueDate;
  num ChequeNum;
  num TrsfrAmount;
  String TrsfrRef;
  String IsPaymentOnAccount;
  String DocRefNo;
  num? SalesPerson;
  num PaymentOnAccount;
  num? RecTotal;
  String Remarks;
  num Document;
  num DiscountAmount;
  num TotalBillAmount;
  num CashAccount;
  num CardAccount;
  num BankAccount;
  num ChequeAccount;
  num AfterDiscount;

  ReciptHeadderM({
    required this.PartyCode,
    this.SalesPerson,
    required this.DocRefNo,
    required this.PartyType,
    required this.api_key,
    required this.CashAmount,
    required this.CreditAmount,
    required this.CardName,
    required this.Date,
    required this.CardNum,
    required this.CheckAmount,
    required this.ChequeDueDate,
    required this.ChequeNum,
    required this.TrsfrAmount,
    required this.TrsfrRef,
    required this.IsPaymentOnAccount,
    required this.PaymentOnAccount,
    this.RecTotal,
    required this.Remarks,
    required this.Document,
    required this.DiscountAmount,
    required this.TotalBillAmount,
    required this.CashAccount,
    required this.CardAccount,
    required this.BankAccount,
    required this.ChequeAccount,
    required this.AfterDiscount,
  });

  factory ReciptHeadderM.fromJson(Map<String, dynamic> json) {
    return ReciptHeadderM(
      PartyCode: json["PartyCode"],
      PartyType: json["PartyType"],
      api_key: json["api_key"],
      CashAmount: json["CashAmount"],
      CreditAmount: json["CreditAmount"],
      CardName: json["CardName"],
      Date: json["Date"],
      CardNum: json["CardNum"],
      CheckAmount: json["CheckAmount"],
      ChequeDueDate: json["ChequeDueDate"],
      ChequeNum: json["ChequeNum"],
      TrsfrAmount: json["TrsfrAmount"],
      TrsfrRef: json["TrsfrRef"],
      IsPaymentOnAccount: json["IsPaymentOnAccount"],
      DocRefNo: json["DocRefNo"],
      SalesPerson: json["SalesPerson"],
      PaymentOnAccount: (json["PaymentOnAccount"]),
      RecTotal: json["RecTotal"],
      Remarks: json["Remarks"],
      Document: json["Document"],
      DiscountAmount: json["DiscountAmount"],
      TotalBillAmount: json["TotalBillAmount"],
      CashAccount: json["CashAccount"],
      CardAccount: json["CardAccount"],
      BankAccount: json["BankAccount"],
      ChequeAccount: json["ChequeAccount"],
      AfterDiscount: json["AfterDiscount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "PartyCode": this.PartyCode,
      "PartyType": this.PartyType,
      "api_key": this.api_key,
      "CashAmount": this.CashAmount,
      "CreditAmount": this.CreditAmount,
      "CardName": this.CardName,
      "Date": this.Date,
      "CardNum": this.CardNum,
      "CheckAmount": this.CheckAmount,
      "ChequeDueDate": this.ChequeDueDate,
      "ChequeNum": this.ChequeNum,
      "TrsfrAmount": this.TrsfrAmount,
      "TrsfrRef": this.TrsfrRef,
      "IsPaymentOnAccount": this.IsPaymentOnAccount,
      "DocRefNo": this.DocRefNo,
      "SalesPerson": this.SalesPerson,
      "PaymentOnAccount": this.PaymentOnAccount,
      "RecTotal": this.RecTotal,
      "Remarks": this.Remarks,
      "Document": this.Document,
      "DiscountAmount": this.DiscountAmount,
      "TotalBillAmount": this.TotalBillAmount,
      "CashAccount": this.CashAccount,
      "CardAccount": this.CardAccount,
      "BankAccount": this.BankAccount,
      "ChequeAccount": this.ChequeAccount,
      "AfterDiscount": this.AfterDiscount,
    };
  }
//

/*
  factory ReciptHeadderM.fromJson(Map<String, dynamic> json) =>
      _$ReciptHeadderMFromJson(json);

  Map<String, dynamic> toJson() => _$ReciptHeadderMToJson(this);
*/
}
