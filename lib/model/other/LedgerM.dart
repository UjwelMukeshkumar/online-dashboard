import 'dart:convert';

LedgerM ledgerMFromJson(String str) => LedgerM.fromJson(json.decode(str));

String ledgerMToJson(LedgerM data) => json.encode(data.toJson());

class LedgerM {
  LedgerM({
    this.cvCode,
    this.cvName,
    this.balance,
    this.text,
    this.code,
    this.name,
    this.empCode,
    this.empName,
  });

  String? cvCode;
  String? cvName;
  double? balance;
  String? text;
  int? code;
  String? name;
  String? empCode;
  String? empName;

  dynamic getLeadingTitle() => cvName ?? name ?? empName ?? "";

  dynamic getLeadingSubtitle() => cvCode ?? code ?? empCode ?? "";

  dynamic getTrailingTitle() => balance??0.0;

  dynamic getTrailingSubtitle() => text??"";

  factory LedgerM.fromJson(Map<String, dynamic> json) => LedgerM(
        cvCode: json["CVCode"] == null ? null : json["CVCode"],
        cvName: json["CVName"] == null ? null : json["CVName"],
        balance: json["Balance"] == null ? null : json["Balance"].toDouble(),
        text: json["Text"] == null ? null : json["Text"],
        code: json["Code"] == null ? null : json["Code"],
        name: json["Name"] == null ? null : json["Name"],
        empCode: json["EmpCode"] == null ? null : json["EmpCode"],
        empName: json["EmpName"] == null ? null : json["EmpName"],
      );

  Map<String, dynamic> toJson() => {
        "CVCode": cvCode == null ? null : cvCode,
        "CVName": cvName == null ? null : cvName,
        "Balance": balance == null ? null : balance,
        "Text": text == null ? null : text,
        "Code": code == null ? null : code,
        "Name": name == null ? null : name,
        "EmpCode": empCode == null ? null : empCode,
        "EmpName": empName == null ? null : empName,
      };
}
