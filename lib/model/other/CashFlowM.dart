// // To parse this JSON data, do
// //
// //     final cashFlowM = cashFlowMFromJson(jsonString);
//
// import 'dart:convert';
//
// CashFlowM cashFlowMFromJson(String str) => CashFlowM.fromJson(json.decode(str));
//
// String cashFlowMToJson(CashFlowM data) => json.encode(data.toJson());
//
// class CashFlowM {
//   CashFlowM({
//     this.cashCustomer,
//     this.debtors,
//     this.otherOperation,
//     this.inventoryPurchase,
//     this.genAndAdminExpenses,
//     this.selingandDistributionExpenses,
//     this.indirectExpenses,
//     this.incomeTaxes,
//     this.salesOfFixedAsset,
//     this.collectionOfLoanandPaid,
//     this.saleOfInverstment,
//     this.purchaseOfFixedAsset,
//     this.makingLoanandOthers,
//     this.purchaseOfInvenstment,
//     this.issueOfShareAndSecurities,
//     this.borrowings,
//     this.buybackIfShareAndSecurities,
//     this.repaymentOfLoan,
//     this.dividends,
//     this.sdf,
//   });
//
//   double? cashCustomer;
//   double? debtors;
//   double? otherOperation;
//   double? inventoryPurchase;
//   double? genAndAdminExpenses;
//   double? selingandDistributionExpenses;
//   double? indirectExpenses;
//   double? incomeTaxes;
//   double? salesOfFixedAsset;
//   double? collectionOfLoanandPaid;
//   double? saleOfInverstment;
//   double? purchaseOfFixedAsset;
//   double? makingLoanandOthers;
//   double? purchaseOfInvenstment;
//   double? issueOfShareAndSecurities;
//   double? borrowings;
//   double? buybackIfShareAndSecurities;
//   double? repaymentOfLoan;
//   double? dividends;
//   String? sdf;
//
//   factory CashFlowM.fromJson(Map<String, dynamic> json) => CashFlowM(
//         cashCustomer:
//             json["CashCustomer"] == null ? null : json["CashCustomer"],
//         debtors: json["Debtors"] == null ? null : json["Debtors"],
//         otherOperation:
//             json["OtherOperation"] == null ? null : json["OtherOperation"],
//         inventoryPurchase: json["InventoryPurchase"] == null
//             ? null
//             : json["InventoryPurchase"],
//         genAndAdminExpenses: json["GenAndAdminExpenses"] == null
//             ? null
//             : json["GenAndAdminExpenses"],
//         selingandDistributionExpenses:
//             json["SelingandDistributionExpenses"] == null
//                 ? null
//                 : json["SelingandDistributionExpenses"],
//         indirectExpenses: json["IndirectExpenses"] == null
//             ? null
//             : json["IndirectExpenses"].toDouble(),
//         incomeTaxes: json["IncomeTaxes"] == null ? null : json["IncomeTaxes"],
//         salesOfFixedAsset: json["SalesOfFixedAsset"] == null
//             ? null
//             : json["SalesOfFixedAsset"],
//         collectionOfLoanandPaid: json["CollectionOfLoanandPaid"] == null
//             ? null
//             : json["CollectionOfLoanandPaid"],
//         saleOfInverstment: json["SaleOfInverstment"] == null
//             ? null
//             : json["SaleOfInverstment"],
//         purchaseOfFixedAsset: json["PurchaseOfFixedAsset"] == null
//             ? null
//             : json["PurchaseOfFixedAsset"],
//         makingLoanandOthers: json["MakingLoanandOthers"] == null
//             ? null
//             : json["MakingLoanandOthers"],
//         purchaseOfInvenstment: json["PurchaseOfInvenstment"] == null
//             ? null
//             : json["PurchaseOfInvenstment"],
//         issueOfShareAndSecurities: json["Issue of share and securities"] == null
//             ? null
//             : json["Issue of share and securities"],
//         borrowings: json["Borrowings"] == null ? null : json["Borrowings"],
//         buybackIfShareAndSecurities:
//             json["Buyback if share and securities"] == null
//                 ? null
//                 : json["Buyback if share and securities"],
//         repaymentOfLoan:
//             json["RepaymentOfLoan"] == null ? null : json["RepaymentOfLoan"],
//         dividends: json["Dividends"] == null ? null : json["Dividends"],
//         sdf: json["sdf"] == null ? null : json["sdf"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "CashCustomer": cashCustomer == null ? null : cashCustomer,
//         "Debtors": debtors == null ? null : debtors,
//         "OtherOperation": otherOperation == null ? null : otherOperation,
//         "InventoryPurchase":
//             inventoryPurchase == null ? null : inventoryPurchase,
//         "GenAndAdminExpenses":
//             genAndAdminExpenses == null ? null : genAndAdminExpenses,
//         "SelingandDistributionExpenses": selingandDistributionExpenses == null
//             ? null
//             : selingandDistributionExpenses,
//         "IndirectExpenses": indirectExpenses == null ? null : indirectExpenses,
//         "IncomeTaxes": incomeTaxes == null ? null : incomeTaxes,
//         "SalesOfFixedAsset":
//             salesOfFixedAsset == null ? null : salesOfFixedAsset,
//         "CollectionOfLoanandPaid":
//             collectionOfLoanandPaid == null ? null : collectionOfLoanandPaid,
//         "SaleOfInverstment":
//             saleOfInverstment == null ? null : saleOfInverstment,
//         "PurchaseOfFixedAsset":
//             purchaseOfFixedAsset == null ? null : purchaseOfFixedAsset,
//         "MakingLoanandOthers":
//             makingLoanandOthers == null ? null : makingLoanandOthers,
//         "PurchaseOfInvenstment":
//             purchaseOfInvenstment == null ? null : purchaseOfInvenstment,
//         "Issue of share and securities": issueOfShareAndSecurities == null
//             ? null
//             : issueOfShareAndSecurities,
//         "Borrowings": borrowings == null ? null : borrowings,
//         "Buyback if share and securities": buybackIfShareAndSecurities == null
//             ? null
//             : buybackIfShareAndSecurities,
//         "RepaymentOfLoan": repaymentOfLoan == null ? null : repaymentOfLoan,
//         "Dividends": dividends == null ? null : dividends,
//         "sdf": sdf == null ? null : sdf,
//       };
// }
///////////////////////////////////////////////////////////////////////////////////

class CashFlowM {
  CashFlowM({
    this.cashCustomer,
    this.debtors,
    this.otherOperation,
    this.inventoryPurchase,
    this.genAndAdminExpenses,
    this.selingandDistributionExpenses,
    this.indirectExpenses,
    this.incomeTaxes,
    this.salesOfFixedAsset,
    this.collectionOfLoanandPaid,
    this.saleOfInverstment,
    this.purchaseOfFixedAsset,
    this.makingLoanandOthers,
    this.purchaseOfInvenstment,
    this.issueOfShareAndSecurities,
    this.borrowings,
    this.buybackIfShareAndSecurities,
    this.repaymentOfLoan,
    this.dividends,
    this.sdf,
  });

  double? cashCustomer;
  double? debtors;
  double? otherOperation;
  double? inventoryPurchase;
  double? genAndAdminExpenses;
  double? selingandDistributionExpenses;
  double? indirectExpenses;
  double? incomeTaxes;
  double? salesOfFixedAsset;
  double? collectionOfLoanandPaid;
  double? saleOfInverstment;
  double? purchaseOfFixedAsset;
  double? makingLoanandOthers;
  double? purchaseOfInvenstment;
  double? issueOfShareAndSecurities;
  double? borrowings;
  double? buybackIfShareAndSecurities;
  double? repaymentOfLoan;
  double? dividends;
  String? sdf;

  factory CashFlowM.fromJson(Map<String, dynamic> json) {
    return CashFlowM(
      cashCustomer: json["CashCustomer"]?.toDouble(),
      debtors: json["Debtors"]?.toDouble(),
      otherOperation: json["OtherOperation"]?.toDouble(),
      inventoryPurchase: json["InventoryPurchase"]?.toDouble(),
      genAndAdminExpenses: json["GenAndAdminExpenses"]?.toDouble(),
      selingandDistributionExpenses:
          json["SelingandDistributionExpenses"]?.toDouble(),
      indirectExpenses: json["IndirectExpenses"]?.toDouble(),
      incomeTaxes: json["IncomeTaxes"]?.toDouble(),
      salesOfFixedAsset: json["SalesOfFixedAsset"]?.toDouble(),
      collectionOfLoanandPaid: json["CollectionOfLoanandPaid"]?.toDouble(),
      saleOfInverstment: json["SaleOfInverstment"]?.toDouble(),
      purchaseOfFixedAsset: json["PurchaseOfFixedAsset"]?.toDouble(),
      makingLoanandOthers: json["MakingLoanandOthers"]?.toDouble(),
      purchaseOfInvenstment: json["PurchaseOfInvenstment"]?.toDouble(),
      issueOfShareAndSecurities:
          json["Issue of share and securities"]?.toDouble(),
      borrowings: json["Borrowings"]?.toDouble(),
      buybackIfShareAndSecurities:
          json["Buyback if share and securities"]?.toDouble(),
      repaymentOfLoan: json["RepaymentOfLoan"]?.toDouble(),
      dividends: json["Dividends"]?.toDouble(),
      sdf: json["sdf"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "CashCustomer": cashCustomer,
      "Debtors": debtors,
      "OtherOperation": otherOperation,
      "InventoryPurchase": inventoryPurchase,
      "GenAndAdminExpenses": genAndAdminExpenses,
      "SelingandDistributionExpenses": selingandDistributionExpenses,
      "IndirectExpenses": indirectExpenses,
      "IncomeTaxes": incomeTaxes,
      "SalesOfFixedAsset": salesOfFixedAsset,
      "CollectionOfLoanandPaid": collectionOfLoanandPaid,
      "SaleOfInverstment": saleOfInverstment,
      "PurchaseOfFixedAsset": purchaseOfFixedAsset,
      "MakingLoanandOthers": makingLoanandOthers,
      "PurchaseOfInvenstment": purchaseOfInvenstment,
      "Issue of share and securities": issueOfShareAndSecurities,
      "Borrowings": borrowings,
      "Buyback if share and securities": buybackIfShareAndSecurities,
      "RepaymentOfLoan": repaymentOfLoan,
      "Dividends": dividends,
      "sdf": sdf,
    };
  }
}
