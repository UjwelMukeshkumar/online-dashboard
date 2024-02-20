import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManagerRepository with ChangeNotifier {
  String _section = "manager section";
  String _category = "manager category";
  String _whatChangedSince = "manager whatChangedSince";
  String _menuItems = "manager menuItems";
  String _scanbarCode = "manager scanbarCode";
  String _Sales = "manager Sales";
  String _SalesOrder = "manager Sales Order";
  String _SalesReturn = "manager Sales Return";
  String _Purchase = "manager Purchase";
  String _PurchaseOrder = "manager Purchase Order";
  String _PurchaseReturn = "manager Purchase Return";
  String _POS = "manager POS";
  String _POSOrder = "manager POS Order";
  String _POSReturn = "manager POS Return";
  String _Lossreport = "manager Loss report";
  String _CreditSale = "manager Credit Sale";
  String _Receivable = "manager Receivable";
  String _Payable = "manager Payable";
  String _ManualJournal = "manager Manual Journal";
  String _CategoryStock = "manager Category Stock";
  String _CashandBank = "manager Cash and Bank";
  String _CounterClosing = "manager Counter Closing";
  String _DayBook = "manager Day Book";
  String _CashFlow = "manager Cash Flow";
  String _TrialBalance = "manager Trial Balance";
  String _ProfitAndLoss = "manager Profit & Loss";
  String _Accountpayments = "manager Account payments";
  String _Accountreceipts = "manager Account receipts";
  String _Payments = "manager Payments";
  String _Receipts = "manager Receipts";
  String _LiquidityScor = "manager Liquidity Score";
  String _FinancialDashBoar = "manager Financial DashBoard";
  String _DebitCreditAnalysi = "manager Debit Credit Analysis";
  String _CashConventionCycl = "manager Cash Convention Cycle";
  String _ProfitRatio = "manager Profit Ratio";
  String _CustomerWaysSalesReport = "manager customer ways sales";

  SharedPreferences pref;

  SettingsManagerRepository(this.pref);

  bool get section => pref.getBool(_section) ?? true;

  set section(bool value) {
    pref.setBool(_section, value);
    notifyListeners();
  }

  bool get category => pref.getBool(_category) ?? true;

  set category(bool value) {
    pref.setBool(_category, value);
    notifyListeners();
  }

  bool get whatChangedSince => pref.getBool(_whatChangedSince) ?? true;

  set whatChangedSince(bool value) {
    pref.setBool(_whatChangedSince, value);
    notifyListeners();
  }

  bool get menuItems => pref.getBool(_menuItems) ?? true;

  set menuItems(bool value) {
    pref.setBool(_menuItems, value);
    notifyListeners();
  }

  bool get scanbarCode => pref.getBool(_scanbarCode) ?? true;

  set scanbarCode(bool value) {
    pref.setBool(_scanbarCode, value);
    notifyListeners();
  }

  bool get Sales => pref.getBool(_Sales) ?? true;
  set Sales(bool value) {
    pref.setBool(_Sales, value);
    notifyListeners();
  }

  bool get SalesOrder => pref.getBool(_SalesOrder) ?? true;
  set SalesOrder(bool value) {
    pref.setBool(_SalesOrder, value);
    notifyListeners();
  }

  bool get SalesReturn => pref.getBool(_SalesReturn) ?? true;
  set SalesReturn(bool value) {
    pref.setBool(_SalesReturn, value);
    notifyListeners();
  }

  bool get Purchase => pref.getBool(_Purchase) ?? true;
  set Purchase(bool value) {
    pref.setBool(_Purchase, value);
    notifyListeners();
  }

  bool get PurchaseOrder => pref.getBool(_PurchaseOrder) ?? true;
  set PurchaseOrder(bool value) {
    pref.setBool(_PurchaseOrder, value);
    notifyListeners();
  }

  bool get PurchaseReturn => pref.getBool(_PurchaseReturn) ?? true;
  set PurchaseReturn(bool value) {
    pref.setBool(_PurchaseReturn, value);
    notifyListeners();
  }

  bool get POS => pref.getBool(_POS) ?? true;
  set POS(bool value) {
    pref.setBool(_POS, value);
    notifyListeners();
  }

  bool get POSOrder => pref.getBool(_POSOrder) ?? true;
  set POSOrder(bool value) {
    pref.setBool(_POSOrder, value);
    notifyListeners();
  }

  bool get POSReturn => pref.getBool(_POSReturn) ?? true;
  set POSReturn(bool value) {
    pref.setBool(_POSReturn, value);
    notifyListeners();
  }

  bool get Lossreport => pref.getBool(_Lossreport) ?? true;
  set Lossreport(bool value) {
    pref.setBool(_Lossreport, value);
    notifyListeners();
  }

  bool get CreditSale => pref.getBool(_CreditSale) ?? true;
  set CreditSale(bool value) {
    pref.setBool(_CreditSale, value);
    notifyListeners();
  }

  bool get Receivable => pref.getBool(_Receivable) ?? true;
  set Receivable(bool value) {
    pref.setBool(_Receivable, value);
    notifyListeners();
  }

  bool get Payable => pref.getBool(_Payable) ?? true;
  set Payable(bool value) {
    pref.setBool(_Payable, value);
    notifyListeners();
  }

  bool get ManualJournal => pref.getBool(_ManualJournal) ?? true;
  set ManualJournal(bool value) {
    pref.setBool(_ManualJournal, value);
    notifyListeners();
  }

  bool get CategoryStock => pref.getBool(_CategoryStock) ?? true;
  set CategoryStock(bool value) {
    pref.setBool(_CategoryStock, value);
    notifyListeners();
  }

  bool get CashandBank => pref.getBool(_CashandBank) ?? true;
  set CashandBank(bool value) {
    pref.setBool(_CashandBank, value);
    notifyListeners();
  }

  bool get CounterClosing => pref.getBool(_CounterClosing) ?? true;
  set CounterClosing(bool value) {
    pref.setBool(_CounterClosing, value);
    notifyListeners();
  }

  bool get DayBook => pref.getBool(_DayBook) ?? true;
  set DayBook(bool value) {
    pref.setBool(_DayBook, value);
    notifyListeners();
  }

  bool get CashFlow => pref.getBool(_CashFlow) ?? true;
  set CashFlow(bool value) {
    pref.setBool(_CashFlow, value);
    notifyListeners();
  }

  bool get TrialBalance => pref.getBool(_TrialBalance) ?? true;
  set TrialBalance(bool value) {
    pref.setBool(_TrialBalance, value);
    notifyListeners();
  }

  bool get ProfitAndLoss => pref.getBool(_ProfitAndLoss) ?? true;
  set ProfitAndLoss(bool value) {
    pref.setBool(_ProfitAndLoss, value);
    notifyListeners();
  }

    bool get CustomerWaysSalesReport => pref.getBool(_CustomerWaysSalesReport) ?? true;
  set CustomerWaysSalesReport(bool value) {
    pref.setBool(_CustomerWaysSalesReport, value);
    notifyListeners();
  }

  bool get Accountpayments => pref.getBool(_Accountpayments) ?? true;
  set Accountpayments(bool value) {
    pref.setBool(_Accountpayments, value);
    notifyListeners();
  }

  bool get Accountreceipts => pref.getBool(_Accountreceipts) ?? true;
  set Accountreceipts(bool value) {
    pref.setBool(_Accountreceipts, value);
    notifyListeners();
  }

  bool get Payments => pref.getBool(_Payments) ?? true;
  set Payments(bool value) {
    pref.setBool(_Payments, value);
    notifyListeners();
  }

  bool get Receipts => pref.getBool(_Receipts) ?? true;
  set Receipts(bool value) {
    pref.setBool(_Receipts, value);
    notifyListeners();
  }

//Helth of your business
  bool get LiquidityScor => pref.getBool(_LiquidityScor) ?? true;
  set LiquidityScor(bool value) {
    pref.setBool(_LiquidityScor, value);
    notifyListeners();
  }

  bool get FinancialDashBoar => pref.getBool(_FinancialDashBoar) ?? true;
  set FinancialDashBoar(bool value) {
    pref.setBool(_FinancialDashBoar, value);
    notifyListeners();
  }

  bool get DebitCreditAnalysi => pref.getBool(_DebitCreditAnalysi) ?? true;
  set DebitCreditAnalysi(bool value) {
    pref.setBool(_DebitCreditAnalysi, value);
    notifyListeners();
  }

  bool get CashConventionCycl => pref.getBool(_CashConventionCycl) ?? true;
  set CashConventionCycl(bool value) {
    pref.setBool(_CashConventionCycl, value);
    notifyListeners();
  }

  bool get ProfitRatio => pref.getBool(_ProfitRatio) ?? true;
  set ProfitRatio(bool value) {
    pref.setBool(_ProfitRatio, value);
    notifyListeners();
  }
}
