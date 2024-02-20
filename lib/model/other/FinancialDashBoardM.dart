// To parse this JSON data, do
//
//     final financialDashBoardM = financialDashBoardMFromJson(jsonString);

import 'dart:convert';

import 'package:glowrpt/model/other/TransactionM.dart';

FinancialDashBoardM financialDashBoardMFromJson(String str) =>
    FinancialDashBoardM.fromJson(json.decode(str));

String financialDashBoardMToJson(FinancialDashBoardM data) =>
    json.encode(data.toJson());

class FinancialDashBoardM {
  FinancialDashBoardM({
    required this.totalAssetsGraph,
    required this.currentAssetsGraph,
    required this.currentLiabilitiesGraph,
    required this.totalLiabilitiesGraph,
    required this.otherLiabilitiesGraph,
    required this.cashGraph,
    required this.accountReceviablesGraph,
    required this.accountPayablesGraph,
    required this.shareholderEquityGraph,
    required this.commonstockGraph,
    required this.currentEarningGraph,
    required this.debitEquityGraph,
    required this.inventoryGraph,
    required this.workingCapitalRatioGraph,
    required this.returnonAssetGraph,
    required this.returnOnEquityGraph,
    required this.financialDashBoard,
  });

  List<TransactionM> totalAssetsGraph;
  List<TransactionM> currentAssetsGraph;
  List<TransactionM> currentLiabilitiesGraph;
  List<TransactionM> totalLiabilitiesGraph;
  List<TransactionM> otherLiabilitiesGraph;
  List<TransactionM> cashGraph;
  List<TransactionM> accountReceviablesGraph;
  List<TransactionM> accountPayablesGraph;
  List<TransactionM> shareholderEquityGraph;
  List<TransactionM> commonstockGraph;
  List<TransactionM> currentEarningGraph;
  List<TransactionM> debitEquityGraph;
  List<TransactionM> inventoryGraph;
  List<TransactionM> workingCapitalRatioGraph;
  List<TransactionM> returnonAssetGraph;
  List<TransactionM> returnOnEquityGraph;
  List<FinancialDashBoardHm> financialDashBoard;

  factory FinancialDashBoardM.fromJson(Map<String, dynamic> json) =>
      FinancialDashBoardM(
        totalAssetsGraph: List<TransactionM>.from(json['TotalAssetsGraph'].map((x)=>TransactionM.fromJson(x))),
        currentAssetsGraph: List<TransactionM>.from(json['CurrentAssetsGraph'].map((x)=>TransactionM.fromJson(x))),
        currentLiabilitiesGraph: List<TransactionM>.from(json['CurrentLiabilitiesGraph'].map((x)=>TransactionM.fromJson(x))),
        totalLiabilitiesGraph: List<TransactionM>.from(json['TotalLiabilitiesGraph'].map((x)=>TransactionM.fromJson(x))),
        otherLiabilitiesGraph: List<TransactionM>.from(json['OtherLiabilitiesGraph'].map((x)=>TransactionM.fromJson(x))),
        cashGraph: List<TransactionM>.from(json['CashGraph'].map((x)=>TransactionM.fromJson(x))),
        accountReceviablesGraph: List<TransactionM>.from(json['AccountReceviablesGraph'].map((x)=>TransactionM.fromJson(x))),
        accountPayablesGraph: List<TransactionM>.from(json['AccountPayablesGraph'].map((x)=>TransactionM.fromJson(x))),
        shareholderEquityGraph: List<TransactionM>.from(json['ShareholderEquityGraph'].map((x)=>TransactionM.fromJson(x))),
        commonstockGraph: List<TransactionM>.from(json['CommonstockGraph'].map((x)=>TransactionM.fromJson(x))),
        currentEarningGraph: List<TransactionM>.from(json['CurrentEarningGraph'].map((x)=>TransactionM.fromJson(x))),
        debitEquityGraph: List<TransactionM>.from(json['DebitEquityGraph'].map((x)=>TransactionM.fromJson(x))),
        inventoryGraph: List<TransactionM>.from(json['InventoryGraph'].map((x)=>TransactionM.fromJson(x))),
        workingCapitalRatioGraph: List<TransactionM>.from(json['WorkingCapitalRatioGraph'].map((x)=>TransactionM.fromJson(x))),
        returnonAssetGraph: List<TransactionM>.from(json['ReturnonAssetGraph'].map((x)=>TransactionM.fromJson(x))),
        returnOnEquityGraph: List<TransactionM>.from(json['Return_On_EquityGraph'].map((x)=>TransactionM.fromJson(x))),
        financialDashBoard: List<FinancialDashBoardHm>.from(json['FinancialDashBoard'].map((x)=>TransactionM.fromJson(x)))

      );
  // FinancialDashBoardM(
  //   totalAssetsGraph: json["TotalAssetsGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(
  //           json["TotalAssetsGraph"].map((x) => TransactionM.fromJson(x))),
  //   currentAssetsGraph: json["CurrentAssetsGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["CurrentAssetsGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   currentLiabilitiesGraph: json["CurrentLiabilitiesGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["CurrentLiabilitiesGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   totalLiabilitiesGraph: json["TotalLiabilitiesGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["TotalLiabilitiesGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   otherLiabilitiesGraph: json["OtherLiabilitiesGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["OtherLiabilitiesGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   cashGraph: json["CashGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(
  //           json["CashGraph"].map((x) => TransactionM.fromJson(x))),
  //   accountReceviablesGraph: json["AccountReceviablesGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["AccountReceviablesGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   accountPayablesGraph: json["AccountPayablesGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["AccountPayablesGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   shareholderEquityGraph: json["ShareholderEquityGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["ShareholderEquityGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   commonstockGraph: json["CommonstockGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(
  //           json["CommonstockGraph"].map((x) => TransactionM.fromJson(x))),
  //   currentEarningGraph: json["CurrentEarningGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["CurrentEarningGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   debitEquityGraph: json["DebitEquityGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(
  //           json["DebitEquityGraph"].map((x) => TransactionM.fromJson(x))),
  //   inventoryGraph: json["InventoryGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(
  //           json["InventoryGraph"].map((x) => TransactionM.fromJson(x))),
  //   workingCapitalRatioGraph: json["WorkingCapitalRatioGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["WorkingCapitalRatioGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   returnonAssetGraph: json["ReturnonAssetGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["ReturnonAssetGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   returnOnEquityGraph: json["Return_On_EquityGraph"] == null
  //       ? null
  //       : List<TransactionM>.from(json["Return_On_EquityGraph"]
  //           .map((x) => TransactionM.fromJson(x))),
  //   financialDashBoard: json["FinancialDashBoard"] == null
  //       ? null
  //       : List<FinancialDashBoardHm>.from(json["FinancialDashBoard"]
  //           .map((x) => FinancialDashBoardHm.fromJson(x))),
  // );

  Map<String, dynamic> toJson() => {
        "TotalAssetsGraph": totalAssetsGraph == null
            ? null
            : List<dynamic>.from(totalAssetsGraph.map((x) => x.toJson())),
        "CurrentAssetsGraph": currentAssetsGraph == null
            ? null
            : List<dynamic>.from(currentAssetsGraph.map((x) => x.toJson())),
        "CurrentLiabilitiesGraph": currentLiabilitiesGraph == null
            ? null
            : List<dynamic>.from(
                currentLiabilitiesGraph.map((x) => x.toJson())),
        "TotalLiabilitiesGraph": totalLiabilitiesGraph == null
            ? null
            : List<dynamic>.from(totalLiabilitiesGraph.map((x) => x.toJson())),
        "OtherLiabilitiesGraph": otherLiabilitiesGraph == null
            ? null
            : List<dynamic>.from(otherLiabilitiesGraph.map((x) => x)),
        "CashGraph": cashGraph == null
            ? null
            : List<dynamic>.from(cashGraph.map((x) => x.toJson())),
        "AccountReceviablesGraph": accountReceviablesGraph == null
            ? null
            : List<dynamic>.from(accountReceviablesGraph.map((x) => x)),
        "AccountPayablesGraph": accountPayablesGraph == null
            ? null
            : List<dynamic>.from(accountPayablesGraph.map((x) => x)),
        "ShareholderEquityGraph": shareholderEquityGraph == null
            ? null
            : List<dynamic>.from(shareholderEquityGraph.map((x) => x.toJson())),
        "CommonstockGraph": commonstockGraph == null
            ? null
            : List<dynamic>.from(commonstockGraph.map((x) => x.toJson())),
        "CurrentEarningGraph": currentEarningGraph == null
            ? null
            : List<dynamic>.from(currentEarningGraph.map((x) => x.toJson())),
        "DebitEquityGraph": debitEquityGraph == null
            ? null
            : List<dynamic>.from(debitEquityGraph.map((x) => x.toJson())),
        "InventoryGraph": inventoryGraph == null
            ? null
            : List<dynamic>.from(inventoryGraph.map((x) => x.toJson())),
        "WorkingCapitalRatioGraph": workingCapitalRatioGraph == null
            ? null
            : List<dynamic>.from(
                workingCapitalRatioGraph.map((x) => x.toJson())),
        "ReturnonAssetGraph": returnonAssetGraph == null
            ? null
            : List<dynamic>.from(returnonAssetGraph.map((x) => x.toJson())),
        "Return_On_EquityGraph": returnOnEquityGraph == null
            ? null
            : List<dynamic>.from(returnOnEquityGraph.map((x) => x.toJson())),
        "FinancialDashBoard": financialDashBoard == null
            ? null
            : List<dynamic>.from(financialDashBoard.map((x) => x.toJson())),
      };
}

class FinancialDashBoardHm {
  FinancialDashBoardHm({
  required  this.totalAsset,
  required  this.currentAsset,
  required  this.currentLiabilities,
  required  this.cash,
  required  this.accountReceviables,
  required  this.accountPayables,
  required  this.inventory,
  required  this.totalLiabilities,
  required  this.shareholdersEquity,
  required  this.commonStock,
  required  this.returnOnAsset,
  required  this.workingCapitalRatio,
  required  this.debitEquity,
  required  this.returnOnEquity,
  required  this.currentEarnigs,
    // this.test,
  });

  double totalAsset;
  double currentAsset;
  double currentLiabilities;
  double cash;
  double accountReceviables;
  double accountPayables;
  double inventory;
  double totalLiabilities;
  double shareholdersEquity;
  double commonStock;
  double returnOnAsset;
  double workingCapitalRatio;
  double debitEquity;
  double returnOnEquity;
  double currentEarnigs;
  // String test;

  factory FinancialDashBoardHm.fromJson(Map<String, dynamic> json) =>
      FinancialDashBoardHm(
        totalAsset:
            json["TotalAsset"] == null ? null : json["TotalAsset"].toDouble(),
        currentAsset: json["CurrentAsset"] == null
            ? null
            : json["CurrentAsset"].toDouble(),
        currentLiabilities: json["CurrentLiabilities"] == null
            ? null
            : json["CurrentLiabilities"].toDouble(),
        cash: json["Cash"] == null ? null : json["Cash"].toDouble(),
        accountReceviables: json["AccountReceviables"] == null
            ? null
            : json["AccountReceviables"],
        accountPayables:
            json["AccountPayables"] == null ? null : json["AccountPayables"],
        inventory:
            json["Inventory"] == null ? null : json["Inventory"].toDouble(),
        totalLiabilities: json["TotalLiabilities"] == null
            ? null
            : json["TotalLiabilities"].toDouble(),
        shareholdersEquity: json["ShareholdersEquity"] == null
            ? null
            : json["ShareholdersEquity"].toDouble(),
        commonStock: json["CommonStock"] == null ? null : json["CommonStock"],
        returnOnAsset: json["Return on Asset"] == null
            ? null
            : json["Return on Asset"].toDouble(),
        workingCapitalRatio: json["Working Capital Ratio"] == null
            ? null
            : json["Working Capital Ratio"].toDouble(),
        debitEquity:
            json["DebitEquity"] == null ? null : json["DebitEquity"].toDouble(),
        returnOnEquity: json["Return_On_Equity"] == null
            ? null
            : json["Return_On_Equity"].toDouble(),
        currentEarnigs: json["CurrentEarnigs"] == null
            ? null
            : json["CurrentEarnigs"].toDouble(),
        // test: json["test"] == null ? null : json["test"],
      );

  Map<String, dynamic> toJson() => {
        "TotalAsset": totalAsset == null ? null : totalAsset,
        "CurrentAsset": currentAsset == null ? null : currentAsset,
        "CurrentLiabilities":
            currentLiabilities == null ? null : currentLiabilities,
        "Cash": cash == null ? null : cash,
        "AccountReceviables":
            accountReceviables == null ? null : accountReceviables,
        "AccountPayables": accountPayables == null ? null : accountPayables,
        "Inventory": inventory == null ? null : inventory,
        "TotalLiabilities": totalLiabilities == null ? null : totalLiabilities,
        "ShareholdersEquity":
            shareholdersEquity == null ? null : shareholdersEquity,
        "CommonStock": commonStock == null ? null : commonStock,
        "Return on Asset": returnOnAsset == null ? null : returnOnAsset,
        "Working Capital Ratio":
            workingCapitalRatio == null ? null : workingCapitalRatio,
        "DebitEquity": debitEquity == null ? null : debitEquity,
        "Return_On_Equity": returnOnEquity == null ? null : returnOnEquity,
        "CurrentEarnigs": currentEarnigs == null ? null : currentEarnigs,
        // "test": test == null ? null : test,
      };
}
