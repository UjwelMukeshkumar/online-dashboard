// To parse this JSON data, do
//
//     final tHeadderM = tHeadderMFromJson(jsonString);

import 'dart:convert';

THeadderM tHeadderMFromJson(String str) => THeadderM.fromJson(json.decode(str));

String tHeadderMToJson(THeadderM data) => json.encode(data.toJson());

class THeadderM {
  THeadderM({
   required this.code,
   required this.name,
   required this.fromDate,
   required this.todate,
   required this.openingBalance,
   required this.debit,
   required this.credit,
   required this.periodicBalance,
   required this.closingBalance,
   required this.reportType,
  });

  String code;
  String name;
  String fromDate;
  String todate;
  double openingBalance;
  double debit;
  double credit;
  double periodicBalance;
  double closingBalance;
  String reportType;

  factory THeadderM.fromJson(Map<String, dynamic> json) => THeadderM(
        code: json["Code"] == null ? "" : json["Code"],
        name: json["Name"] == null ? "" : json["Name"],
        fromDate: json["FromDate"] == null ? "" : json["FromDate"],
        todate: json["Todate"] == null ? "" : json["Todate"].toString(),
        openingBalance: json["OpeningBalance"] == null
            ? 0.0
            : json["OpeningBalance"].toDouble(),
        debit: json["Debit"] == null ? 0.0 : json["Debit"].toDouble(),
        credit: json["Credit"] == null ? 0.0 : json["Credit"].toDouble(),
        periodicBalance: json["PeriodicBalance"] == null
            ? 0.0
            : json["PeriodicBalance"].toDouble(),
        closingBalance: json["ClosingBalance"] == null
            ? 0.0
            : json["ClosingBalance"].toDouble(),
        reportType: json["ReportType"] == null ? "" : json["ReportType"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code == null ? null : code,
        "Name": name == null ? null : name,
        "FromDate": fromDate == null ? null : fromDate,
        "Todate": todate == null ? null : todate,
        "OpeningBalance": openingBalance == null ? null : openingBalance,
        "Debit": debit == null ? null : debit,
        "Credit": credit == null ? null : credit,
        "PeriodicBalance": periodicBalance == null ? null : periodicBalance,
        "ClosingBalance": closingBalance == null ? null : closingBalance,
        "ReportType": reportType == null ? null : reportType,
      };
}
