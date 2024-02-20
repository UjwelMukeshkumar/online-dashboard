// To parse this JSON data, do
//
//     final cccM = cccMFromJson(jsonString);

import 'dart:convert';

CccM cccMFromJson(String str) => CccM.fromJson(json.decode(str));

String cccMToJson(CccM data) => json.encode(data.toJson());

class CccM {
  CccM({
     this.dpoDsoDioGraph,
     this.vendorPaymentErrorRate,
     this.cashConversionCycle,
  });

  List<DpoDsoDioGraph>? dpoDsoDioGraph;
  List<VendorPaymentErrorRate>? vendorPaymentErrorRate;
  List<CashConversionCycle>? cashConversionCycle;

  factory CccM.fromJson(Map<String, dynamic> json) => CccM(
        dpoDsoDioGraph: List<DpoDsoDioGraph>.from(
            json["DPO_DSO_DIO_Graph"].map((x) => DpoDsoDioGraph.fromJson(x))),
        vendorPaymentErrorRate: List<VendorPaymentErrorRate>.from(
            json['VendorPaymentErrorRate']
                .map((x) => VendorPaymentErrorRate.fromJson(x))),
        cashConversionCycle: List<CashConversionCycle>.from(
            json['CashConversionCycle']
                .map((x) => CashConversionCycle.fromJson(x))),

        // vendorPaymentErrorRate: json["VendorPaymentErrorRate"] == null
        //     ? null
        //     : List<VendorPaymentErrorRate>.from(json["VendorPaymentErrorRate"]
        //         .map((x) => VendorPaymentErrorRate.fromJson(x))),
        // cashConversionCycle: json["CashConversionCycle"] == null
        //     ? null
        //     : List<CashConversionCycle>.from(json["CashConversionCycle"]
        //         .map((x) => CashConversionCycle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "DPO_DSO_DIO_Graph": dpoDsoDioGraph == null
            ? null
            : List<dynamic>.from(dpoDsoDioGraph!.map((x) => x.toJson())),
        "VendorPaymentErrorRate": vendorPaymentErrorRate == null
            ? null
            : List<dynamic>.from(vendorPaymentErrorRate!.map((x) => x.toJson())),
        "CashConversionCycle": cashConversionCycle == null
            ? null
            : List<dynamic>.from(cashConversionCycle!.map((x) => x.toJson())),
      };
}

class CashConversionCycle {
  CashConversionCycle({
    required this.currentAsset,
    required this.currentLiabilities,
    required this.cash,
    required this.accountReceviables,
    required this.accountPayables,
    required this.inventory,
    required this.banKLoans,
    required this.taxPayable,
    required this.otherPayable,
    required this.workingCapital,
    required this.currentRatio,
    required this.daysInventoryOutstanding,
    required this.daysPayableOutstanding,
    required this.daySalesOutstanding,
    required this.cashConversionCycle,
    required this.prePaidExpenses,
    required this.creditCardDebt,
    required this.bankOperatingCredit,
    required this.accuredExpenses,
    required this.sdfds,
  });

  double currentAsset;
  double currentLiabilities;
  double cash;
  double accountReceviables;
  double accountPayables;
  double inventory;
  double banKLoans;
  double taxPayable;
  double otherPayable;
  double workingCapital;
  double currentRatio;
  double daysInventoryOutstanding;
  double daysPayableOutstanding;
  double daySalesOutstanding;
  double cashConversionCycle;
  double prePaidExpenses;
  double creditCardDebt;
  double bankOperatingCredit;
  double accuredExpenses;
  String sdfds;

  factory CashConversionCycle.fromJson(Map<String, dynamic> json) =>
      CashConversionCycle(
        currentAsset: json["CurrentAsset"] == null
            ? null
            : json["CurrentAsset"].toDouble(),
        currentLiabilities: json["CurrentLiabilities"] == null
            ? null
            : json["CurrentLiabilities"].toDouble(),
        cash: json["Cash"] == null ? null : json["Cash"].toDouble(),
        accountReceviables: json["AccountReceviables"] == null
            ? null
            : json["AccountReceviables"].toDouble(),
        accountPayables: json["AccountPayables"] == null
            ? null
            : json["AccountPayables"].toDouble(),
        inventory:
            json["Inventory"] == null ? null : json["Inventory"].toDouble(),
        banKLoans:
            json["BanKLoans"] == null ? null : json["BanKLoans"].toDouble(),
        taxPayable:
            json["TaxPayable"] == null ? null : json["TaxPayable"].toDouble(),
        otherPayable: json["OtherPayable"] == null
            ? null
            : json["OtherPayable"].toDouble(),
        workingCapital: json["WorkingCapital"] == null
            ? null
            : json["WorkingCapital"].toDouble(),
        currentRatio: json["CurrentRatio"] == null
            ? null
            : json["CurrentRatio"].toDouble(),
        daysInventoryOutstanding: json["Days_Inventory_Outstanding"] == null
            ? null
            : json["Days_Inventory_Outstanding"].toDouble(),
        daysPayableOutstanding: json["Days_Payable_Outstanding"] == null
            ? null
            : json["Days_Payable_Outstanding"].toDouble(),
        daySalesOutstanding: json["Day_Sales_Outstanding"] == null
            ? null
            : json["Day_Sales_Outstanding"].toDouble(),
        cashConversionCycle: json["CashConversionCycle"] == null
            ? null
            : json["CashConversionCycle"].toDouble(),
        prePaidExpenses: json["Pre-PaidExpenses"] == null
            ? null
            : json["Pre-PaidExpenses"].toDouble(),
        creditCardDebt: json["Credit-Card Debt"] == null
            ? null
            : json["Credit-Card Debt"].toDouble(),
        bankOperatingCredit: json["Bank-Operating-Credit"] == null
            ? null
            : json["Bank-Operating-Credit"].toDouble(),
        accuredExpenses: json["Accured-Expenses"] == null
            ? null
            : json["Accured-Expenses"].toDouble(),
        sdfds: json["sdfds"] == null ? null : json["sdfds"],
      );

  Map<String, dynamic> toJson() => {
        "CurrentAsset": currentAsset == null ? null : currentAsset,
        "CurrentLiabilities":
            currentLiabilities == null ? null : currentLiabilities,
        "Cash": cash == null ? null : cash,
        "AccountReceviables":
            accountReceviables == null ? null : accountReceviables,
        "AccountPayables": accountPayables == null ? null : accountPayables,
        "Inventory": inventory == null ? null : inventory,
        "BanKLoans": banKLoans == null ? null : banKLoans,
        "TaxPayable": taxPayable == null ? null : taxPayable,
        "OtherPayable": otherPayable == null ? null : otherPayable,
        "WorkingCapital": workingCapital == null ? null : workingCapital,
        "CurrentRatio": currentRatio == null ? null : currentRatio,
        "Days_Inventory_Outstanding":
            daysInventoryOutstanding == null ? null : daysInventoryOutstanding,
        "Days_Payable_Outstanding":
            daysPayableOutstanding == null ? null : daysPayableOutstanding,
        "Day_Sales_Outstanding":
            daySalesOutstanding == null ? null : daySalesOutstanding,
        "CashConversionCycle":
            cashConversionCycle == null ? null : cashConversionCycle,
        "Pre-PaidExpenses": prePaidExpenses == null ? null : prePaidExpenses,
        "Credit-Card Debt": creditCardDebt == null ? null : creditCardDebt,
        "Bank-Operating-Credit":
            bankOperatingCredit == null ? null : bankOperatingCredit,
        "Accured-Expenses": accuredExpenses == null ? null : accuredExpenses,
        "sdfds": sdfds == null ? null : sdfds,
      };
}

class DpoDsoDioGraph {
  DpoDsoDioGraph({
    required this.yYear,
    required this.total,
    required this.type,
  });

  String yYear;
  double total;
  String type;

  factory DpoDsoDioGraph.fromJson(Map<String, dynamic> json) => DpoDsoDioGraph(
        yYear: json["YYear"] == null ? null : json["YYear"],
        total: json["Total"] == null ? null : json["Total"].toDouble(),
        type: json["Type"] == null ? null : json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "YYear": yYear == null ? null : yYear,
        "Total": total == null ? null : total,
        "Type": type == null ? null : type,
      };
}

class VendorPaymentErrorRate {
  VendorPaymentErrorRate({
    required this.errorRate,
    required this.mMonth,
    required this.yYear,
  });

  double errorRate;
  String mMonth;
  DateTime? yYear;

  factory VendorPaymentErrorRate.fromJson(Map<String, dynamic> json) =>
      VendorPaymentErrorRate(
        errorRate:
            json["ErrorRate"] == null ? null : json["ErrorRate"].toDouble(),
        mMonth: json["MMonth"] == null ? null : json["MMonth"],
        yYear: json["YYear"] == null ? null : DateTime.parse(json["YYear"]),
      );

  Map<String, dynamic> toJson() => {
        "ErrorRate": errorRate == null ? null : errorRate,
        "MMonth": mMonth == null ? null : mMonth,
        "YYear": yYear == null ? null : yYear!.toIso8601String(),
      };
}
