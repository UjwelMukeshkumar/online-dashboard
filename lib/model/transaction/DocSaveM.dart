import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'DocSaveM.g.dart';

@JsonSerializable()
class DocSaveM {
  String Db;
  String LoginID;
  num LoginNo;
  List<FreightDataBean> freightData;
  List<HeaderDataBean> headerData;
  List<LineDataBean> lineData;
  String server;
  String? savemode;


  DocSaveM({
    required this.Db,
    required this.LoginID,
    required this.LoginNo,
    required this.freightData,
    required this.headerData,
    required this.lineData,
    required this.server,
     this.savemode,

  });

  factory DocSaveM.fromJson(Map<String, dynamic> json) {
    return DocSaveM(
      Db: json["Db"],
      LoginID: json["LoginID"],
      LoginNo: json["LoginNo"],
      freightData: List.of(json["freightData"])
          .map((i) => FreightDataBean.fromJson(i))
          .toList(),
      headerData: List.of(json["headerData"])
          .map((i) => HeaderDataBean.fromJson(i))
          .toList(),
      lineData: List.of(json["lineData"])
          .map((i) => LineDataBean.fromJson(i))
          .toList(),
      server: json["server"],
      savemode:json["savemode"],
    );
  }

  /*
  factory DocSaveM.fromJson(Map<String, dynamic> json) =>
      _$DocSaveMFromJson(json);

  Map<String, dynamic> toJson() => _$DocSaveMToJson(this);
*/
  String toFullJson() => json.encode({
        'Db': Db,
        'LoginID': LoginID,
        'LoginNo': LoginNo.toString(),
        'freightData': freightData.map((e) => e.toJson()).toList(),
        'headerData': headerData.map((e) => e.toJson()).toList(),
        'lineData': lineData.map((e) => e.toJson()).toList(),
        'server': server,
        'savemode': savemode

      });

  Map<String, dynamic> toStringJson() => {
        'Db': Db,
        'LoginID': LoginID,
        'LoginNo': LoginNo.toString(),
        'freightData': json.encode(freightData),
        'headerData': json.encode(headerData),
        'lineData': json.encode(lineData),
        'server': server,
        'savemode': savemode

      };
}

@JsonSerializable()
class LineDataBean {
  num? Sl_No;
  String? Item_No;
  String? Item_Name;
  String? Barcode;
  num? Quantity;
  num? FOC;
  String? IsInclusive;
  num? Price;
  num? PriceFC;
  num? Discount;
  String? BatchCode;
  String? BatchBarcode;
  String? UOM;
  num? UOM_quantity;
  num? Total;
  num? DiscountPercHeader;
  num? DiscAmountHeader;
  num? NetTotal;
  num? Store_Code;
  String? Taxcode;
  num? Tax_Rate;
  num? Cost;
  num? Open_Qty;
  String? Source_Type;
  num? SourceRecNum;
  num? Source_Line_No;
  num? SourceSequence;
  num? SourceInitNo;
  num? TaxAmount;
  num? Onhand;
  String? LineStatus;
  String? SalesPersonName;
  String? LineRemarks;
  num? PreTaxTotal;
  num? SellingPrice;
  num? SellingDis;
  String? Supplier;

  LineDataBean({
    this.Sl_No,
    this.Item_No,
    this.Item_Name,
    this.Barcode,
    this.Quantity,
    this.FOC,
    this.IsInclusive,
    this.Price,
    this.PriceFC,
    this.Discount,
    this.BatchCode,
    this.BatchBarcode,
    this.UOM,
    this.UOM_quantity,
    this.Total,
    this.DiscountPercHeader,
    this.DiscAmountHeader,
    this.NetTotal,
    this.Store_Code,
    this.Taxcode,
    this.Tax_Rate,
    this.Cost,
    this.Open_Qty,
    this.Source_Type,
    this.SourceRecNum,
    this.Source_Line_No,
    this.SourceSequence,
    this.SourceInitNo,
    this.TaxAmount,
    this.Onhand,
    this.LineStatus,
    this.PreTaxTotal,
    this.SellingPrice,
    this.SellingDis,
    this.SalesPersonName,
    this.LineRemarks,
    this.Supplier,
  });

  factory LineDataBean.fromJson(Map<String, dynamic> json) {
    return LineDataBean(
      Sl_No: json["Sl_No"],
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Barcode: json["Barcode"],
      Quantity: json["Quantity"],
      FOC: json["FOC"],
      IsInclusive: json["IsInclusive"],
      Price: json["Price"],
      PriceFC: json["PriceFC"],
      Discount: json["Discount"],
      BatchCode: json["BatchCode"],
      BatchBarcode: json["BatchBarcode"],
      UOM: json["UOM"],
      UOM_quantity: json["UOM_quantity"],
      Total: json["Total"],
      DiscountPercHeader: json["DiscountPercHeader"],
      DiscAmountHeader: json["DiscAmountHeader"],
      NetTotal: json["NetTotal"],
      Store_Code: json["Store_Code"],
      Taxcode: json["Taxcode"],
      Tax_Rate: json["Tax_Rate"],
      Cost: json["Cost"],
      Open_Qty: json["Open_Qty"],
      Source_Type: json["Source_Type"],
      SourceRecNum: json["SourceRecNum"],
      Source_Line_No: json["Source_Line_No"],
      SourceSequence: json["SourceSequence"],
      SourceInitNo: json["SourceInitNo"],
      TaxAmount: json["TaxAmount"],
      Onhand: json["Onhand"],
      LineStatus: json["LineStatus"],
      SalesPersonName: json["SalesPersonName"],
      LineRemarks: json["LineRemarks"],
      PreTaxTotal: json["PreTaxTotal"],
      SellingPrice: json["SellingPrice"],
      SellingDis: json["SellingDis"],
      Supplier: json["Supplier"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Sl_No": this.Sl_No,
      "Item_No": this.Item_No,
      "Item_Name": this.Item_Name,
      "Barcode": this.Barcode,
      "Quantity": this.Quantity,
      "FOC": this.FOC,
      "IsInclusive": this.IsInclusive,
      "Price": this.Price,
      "PriceFC": this.PriceFC,
      "Discount": this.Discount,
      "BatchCode": this.BatchCode,
      "BatchBarcode": this.BatchBarcode,
      "UOM": this.UOM,
      "UOM_quantity": this.UOM_quantity,
      "Total": this.Total,
      "DiscountPercHeader": this.DiscountPercHeader,
      "DiscAmountHeader": this.DiscAmountHeader,
      "NetTotal": this.NetTotal,
      "Store_Code": this.Store_Code,
      "Taxcode": this.Taxcode,
      "Tax_Rate": this.Tax_Rate,
      "Cost": this.Cost,
      "Open_Qty": this.Open_Qty,
      "Source_Type": this.Source_Type,
      "SourceRecNum": this.SourceRecNum,
      "Source_Line_No": this.Source_Line_No,
      "SourceSequence": this.SourceSequence,
      "SourceInitNo": this.SourceInitNo,
      "TaxAmount": this.TaxAmount,
      "Onhand": this.Onhand,
      "LineStatus": this.LineStatus,
      "SalesPersonName": this.SalesPersonName,
      "LineRemarks": this.LineRemarks,
      "PreTaxTotal": this.PreTaxTotal,
      "SellingPrice": this.SellingPrice,
      "SellingDis": this.SellingDis,
      "Supplier": this.Supplier,
    };
  }
//

/*
  factory LineDataBean.fromJson(Map<String, dynamic> json) =>
      _$LineDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LineDataBeanToJson(this);
*/
}

@JsonSerializable()
class HeaderDataBean {
  num? Sequence;
  String? PartyCode;
  String? PartyName;
  String? Date;
  String? ReferenceDate;
  String? DueDate;
  num? Amount;
  num? PriceList;
  num? Store;
  num? DiscountAmt;
  num? NetAmt;
  String? Doc_Status;
  String? GLAccount;
  num? Freight_Charge;
  num? RoundingAmount;
  String? RoundingAccount;
  String? TAX1;
  String? TAX2;
  String? FormNo;
  String? Remarks;
  num? DiscountPercHeader;
  var SalesPerson;
  String? DocRefNo;
  num? TaxAmount;
  num? Document;
  String? Status;
  num? RecNum;
  num? InitNo;
  num? SourceRecNum;
  num? SourceSequence;
  num? SourceInitNo;
  num? TargetRecNum;
  num? TargetSequence;
  num? TargetInitNo;
  num? Attempt;
  num? KFCGST;
  String? InterState;
  num? CardAccount;
  num? CardAmount;
  num? CardHolder;
  String? CardValidDate;
  num? CardNumber;
  num? CashAccount;
  num? CashAmount;
  num? ExchangeRate;
  num? Payment_Id;
  String? DispatchNo;

 
  num get recceivedAmount=>CashAmount!+CardAmount!;

  HeaderDataBean({
    this.Sequence,
    this.PartyCode,
    this.PartyName,
    this.Date,
    this.ReferenceDate,
    this.DueDate,
    this.Amount,
    this.PriceList,
    this.Store,
    this.DiscountAmt,
    this.NetAmt,
    this.Doc_Status,
    this.GLAccount,
    this.Freight_Charge,
    this.RoundingAmount,
    this.RoundingAccount,
    this.TAX1,
    this.TAX2,
    this.FormNo,
    this.Remarks,
    this.DiscountPercHeader,
    this.SalesPerson,
    this.DocRefNo,
    this.TaxAmount,
    this.Document,
    this.Status,
    this.RecNum,
    this.InitNo,
    this.SourceRecNum,
    this.SourceSequence,
    this.SourceInitNo,
    this.TargetRecNum,
    this.TargetSequence,
    this.TargetInitNo,
    this.Attempt,
    this.KFCGST,
    this.InterState,
    this.CardAccount,
    this.CardAmount,
    this.CardHolder,
    this.CardValidDate,
    this.CardNumber,
    this.CashAccount,
    this.CashAmount,
    this.ExchangeRate,
    this.Payment_Id,
    this.DispatchNo,
  });

  factory HeaderDataBean.fromJson(Map<String, dynamic> json) {
    return HeaderDataBean(
      Sequence: json["Sequence"],
      PartyCode: json["PartyCode"],
      PartyName: json["PartyName"],
      Date: json["Date"],
      ReferenceDate: json["ReferenceDate"],
      DueDate: json["DueDate"],
      Amount: json["Amount"],
      PriceList: json["PriceList"],
      Store: json["Store"],
      DiscountAmt: json["DiscountAmt"],
      NetAmt: json["NetAmt"],
      Doc_Status: json["Doc_Status"],
      GLAccount: json["GLAccount"],
      Freight_Charge: json["Freight_Charge"],
      RoundingAmount: json["RoundingAmount"],
      RoundingAccount: json["RoundingAccount"],
      TAX1: json["TAX1"],
      TAX2: json["TAX2"],
      FormNo: json["FormNo"],
      Remarks: json["Remarks"],
      DiscountPercHeader: json["DiscountPercHeader"],
      SalesPerson: json["SalesPerson"],
      DocRefNo: json["DocRefNo"],
      TaxAmount: (json["TaxAmount"]),
      Document: json["Document"],
      Status: json["Status"],
      RecNum: json["RecNum"],
      InitNo: json["InitNo"],
      SourceRecNum: json["SourceRecNum"],
      SourceSequence: json["SourceSequence"],
      SourceInitNo: json["SourceInitNo"],
      TargetRecNum: json["TargetRecNum"],
      TargetSequence: json["TargetSequence"],
      TargetInitNo: json["TargetInitNo"],
      Attempt: json["Attempt"],
      KFCGST: json["KFCGST"],
      InterState: json["InterState"],
      CardAccount: json["CardAccount"],
      CardAmount: json["CardAmount"],
      CardHolder: json["CardHolder"],
      CardValidDate: json["CardValidDate"],
      CardNumber: json["CardNumber"],
      CashAccount: json["CashAccount"],
      CashAmount: json["CashAmount"],
      ExchangeRate: json["ExchangeRate"],
      Payment_Id: json["Payment_Id"],
      DispatchNo: json["DispatchNo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Sequence": this.Sequence,
      "PartyCode": this.PartyCode,
      "PartyName": this.PartyName,
      "Date": this.Date,
      "ReferenceDate": this.ReferenceDate,
      "DueDate": this.DueDate,
      "Amount": this.Amount,
      "PriceList": this.PriceList,
      "Store": this.Store,
      "DiscountAmt": this.DiscountAmt,
      "NetAmt": this.NetAmt,
      "Doc_Status": this.Doc_Status,
      "GLAccount": this.GLAccount,
      "Freight_Charge": this.Freight_Charge,
      "RoundingAmount": this.RoundingAmount,
      "RoundingAccount": this.RoundingAccount,
      "TAX1": this.TAX1,
      "TAX2": this.TAX2,
      "FormNo": this.FormNo,
      "Remarks": this.Remarks,
      "DiscountPercHeader": this.DiscountPercHeader,
      "SalesPerson": this.SalesPerson,
      "DocRefNo": this.DocRefNo,
      "TaxAmount": this.TaxAmount,
      "Document": this.Document,
      "Status": this.Status,
      "RecNum": this.RecNum,
      "InitNo": this.InitNo,
      "SourceRecNum": this.SourceRecNum,
      "SourceSequence": this.SourceSequence,
      "SourceInitNo": this.SourceInitNo,
      "TargetRecNum": this.TargetRecNum,
      "TargetSequence": this.TargetSequence,
      "TargetInitNo": this.TargetInitNo,
      "Attempt": this.Attempt,
      "KFCGST": this.KFCGST,
      "InterState": this.InterState,
      "CardAccount": this.CardAccount,
      "CardAmount": this.CardAmount,
      "CardHolder": this.CardHolder,
      "CardValidDate": this.CardValidDate,
      "CardNumber": this.CardNumber,
      "CashAccount": this.CashAccount,
      "CashAmount": this.CashAmount,
      "ExchangeRate": this.ExchangeRate,
      "Payment_Id": this.Payment_Id,
      "DispatchNo": this.DispatchNo,
    };
  }
//

/*
  factory HeaderDataBean.fromJson(Map<String, dynamic> json) =>
      _$HeaderDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HeaderDataBeanToJson(this);
*/
}

@JsonSerializable()
class FreightDataBean {
  num? AccountCode;
  String? AccountName;
  num? Amount;

  FreightDataBean({
    this.AccountCode,
    this.AccountName,
    this.Amount,
  });

  factory FreightDataBean.fromJson(Map<String, dynamic> json) {
    return FreightDataBean(
        Amount: json["Amount"],
        AccountCode: json['AccountCode'],
        AccountName: json['AccountName']);
  }

  Map<String, dynamic> toJson() {
    return {
      "AccountCode": this.AccountCode,
      "AccountName": this.AccountName,
      "Amount": this.Amount,
    };
  }
//

/*
  factory FreightDataBean.fromJson(Map<String, dynamic> json) =>
      _$FreightDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FreightDataBeanToJson(this);
*/
}
