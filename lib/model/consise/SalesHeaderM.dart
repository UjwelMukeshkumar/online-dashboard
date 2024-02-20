// To parse this JSON data, do
//
//     final salesHeaderM = salesHeaderMFromJson(jsonString);

import 'dart:convert';

SalesHeaderM salesHeaderMFromJson(String str) =>
    SalesHeaderM.fromJson(json.decode(str));

String salesHeaderMToJson(SalesHeaderM data) => json.encode(data.toJson());

/*{
"Document": "Sales-POS B/50471-0",
"PartyCode": "CUSTOMER",
"PartyName": "CASH CUSTOMER",
"Date": "24/07/2021",
"Total": 5.00,
"Freight_Charge": 0.00,
"DiscountAmt": 0.00,
"DiscountPerc": 0.0,
"TaxAmount": 0.80,
"PartyCode1": "CUSTOMER"
}*/
class SalesHeaderM {
  SalesHeaderM({
    this.document,
   required this.partyCode,
   required this.partyName,
   required this.date,
   required this.total,
   required this.freightCharge,
   required this.discountAmt,
   required this.discountPerc,
   required this.taxAmount,
  });

  String? document;
  String partyCode;
  String partyName;
  String date;
  double total;
  double freightCharge;
  double discountAmt;
  double discountPerc;
  double taxAmount;

  factory SalesHeaderM.fromJson(Map<String, dynamic> json) => SalesHeaderM(
        document: json["Document"] == null ? "" : json["Document"]??"",
        partyCode: json["PartyCode"] == null ? "" : json["PartyCode"],
        partyName: json["PartyName"] == null ? "" : json["PartyName"],
        date: json["Date"] == null ? "" : json["Date"],
        total: json["Total"] == null ? null : json["Total"].toDouble(),
        freightCharge: json["Freight_Charge"] == null
            ? null
            : json["Freight_Charge"].toDouble(),
        discountAmt:
            json["DiscountAmt"] == null ? null : json["DiscountAmt"].toDouble(),
        discountPerc: json["DiscountPerc"] == null
            ? null
            : json["DiscountPerc"].toDouble(),
        taxAmount:
            json["TaxAmount"] == null ? null : json["TaxAmount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Document": document == null ? null : document,
        "PartyCode": partyCode == null ? null : partyCode,
        "PartyName": partyName == null ? null : partyName,
        "Date": date == null ? null : date,
        "Total": total == null ? null : total,
        "Freight_Charge": freightCharge == null ? null : freightCharge,
        "DiscountAmt": discountAmt == null ? null : discountAmt,
        "DiscountPerc": discountPerc == null ? null : discountPerc,
        "TaxAmount": taxAmount == null ? null : taxAmount,
      };
}
