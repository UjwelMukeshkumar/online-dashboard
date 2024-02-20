import 'package:json_annotation/json_annotation.dart';

// part 'PosInvoiceHeadderM.g.dart';

@JsonSerializable()
class PosInvoiceHeadderM {
  num Sequence;
  num RecNum;
  num Document;
  String PartyCode;
  String Date;
  num LineTotal;
  num DiscountAmt;
  num NetAmt;
  num Freight_Charge;
  num RoundingAmount;
  num DiscountPerc;
  num TaxAmount;
  num CardAmount;
  String VoucherNumber;
  String CardMobileNumber;
  String CardNumber;
  num CashAmount;
  num TrfsAmount;
  String BankRefNumber;
  num TotalTendered;
  num TenderedBalance;
  num CashTendered;
  String InterState;

  PosInvoiceHeadderM({
  required this.Sequence,
  required this.RecNum,
  required this.Document,
  required this.PartyCode,
  required this.Date,
  required this.LineTotal,
  required this.DiscountAmt,
  required this.NetAmt,
  required this.Freight_Charge,
  required this.RoundingAmount,
  required this.DiscountPerc,
  required this.TaxAmount,
  required this.CardAmount,
  required this.VoucherNumber,
  required this.CardMobileNumber,
  required this.CardNumber,
  required this.CashAmount,
  required this.TrfsAmount,
  required this.BankRefNumber,
  required this.TotalTendered,
  required this.TenderedBalance,
  required this.CashTendered,
  required this.InterState,
  });

  factory PosInvoiceHeadderM.fromJson(Map<String, dynamic> json) {
    return PosInvoiceHeadderM(
      Sequence: json["Sequence"],
      RecNum: json["RecNum"],
      Document: json["Document"],
      PartyCode: json["PartyCode"],
      Date: json["Date"],
      LineTotal: json["LineTotal"],
      DiscountAmt: json["DiscountAmt"],
      NetAmt: json["NetAmt"],
      Freight_Charge: json["Freight_Charge"],
      RoundingAmount: json["RoundingAmount"],
      DiscountPerc: json["DiscountPerc"],
      TaxAmount: json["TaxAmount"],
      CardAmount: json["CardAmount"],
      VoucherNumber: json["VoucherNumber"],
      CardMobileNumber: json["CardMobileNumber"],
      CardNumber: json["CardNumber"],
      CashAmount: json["CashAmount"],
      TrfsAmount: json["TrfsAmount"],
      BankRefNumber: json["BankRefNumber"],
      TotalTendered: json["TotalTendered"],
      TenderedBalance: json["TenderedBalance"],
      CashTendered: json["CashTendered"],
      InterState: json["InterState"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Sequence": this.Sequence,
      "RecNum": this.RecNum,
      "Document": this.Document,
      "PartyCode": this.PartyCode,
      "Date": this.Date,
      "LineTotal": this.LineTotal,
      "DiscountAmt": this.DiscountAmt,
      "NetAmt": this.NetAmt,
      "Freight_Charge": this.Freight_Charge,
      "RoundingAmount": this.RoundingAmount,
      "DiscountPerc": this.DiscountPerc,
      "TaxAmount": this.TaxAmount,
      "CardAmount": this.CardAmount,
      "VoucherNumber": this.VoucherNumber,
      "CardMobileNumber": this.CardMobileNumber,
      "CardNumber": this.CardNumber,
      "CashAmount": this.CashAmount,
      "TrfsAmount": this.TrfsAmount,
      "BankRefNumber": this.BankRefNumber,
      "TotalTendered": this.TotalTendered,
      "TenderedBalance": this.TenderedBalance,
      "CashTendered": this.CashTendered,
      "InterState": this.InterState,
    };
  }
//

  /*factory PosInvoiceHeadderM.fromJson(Map<String, dynamic> json) =>
      _$PosInvoiceHeadderMFromJson(json);

  Map<String, dynamic> toJson() => _$PosInvoiceHeadderMToJson(this);*/
}
