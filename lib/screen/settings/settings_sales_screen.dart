import 'package:flutter/material.dart';
import 'package:glowrpt/repo/SettingsSalesRepository.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SettingsSalesScreen extends StatefulWidget {
  @override
  _SettingsSalesScreenState createState() => _SettingsSalesScreenState();
}

class _SettingsSalesScreenState extends State<SettingsSalesScreen> {
  SettingsSalesRepository? repo;

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    repo = Provider.of<SettingsSalesRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    var divider = Divider(indent: 16, endIndent: 26, height: 0);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Dashboard Settings".tr),
      ),
      body: ListView(
        children: [
/*          CheckboxListTile(
              value: repo.section,
              onChanged: (val) => repo.section = val,
              title: Text("Section")),
          divider,
          CheckboxListTile(
              value: repo.category,
              onChanged: (val) => repo.category = val,
              title: Text("Category")),
          divider,
          CheckboxListTile(
              value: repo.whatChangedSince,
              onChanged: (val) => repo.whatChangedSince = val,
              title: Text("What Changed Since")),
          divider,
          CheckboxListTile(
              value: repo.menuItems,
              onChanged: (val) => repo.menuItems = val,
              title: Text("Menu Items")),*/
          ExpansionTile(
            title: Text("Read Your Business".tr),
            children: [
              CheckboxListTile(
                  value: repo!.Sales,
                  onChanged: (val) => repo!.Sales = val!,
                  title: Text("Sales".tr)),
              divider,
              CheckboxListTile(
                  value: repo!.SalesOrder,
                  onChanged: (val) => repo!.SalesOrder = val!,
                  title: Text("Sales Order".tr)),
              divider,
              CheckboxListTile(
                  value: repo!.SalesReturn,
                  onChanged: (val) => repo!.SalesReturn = val!,
                  title: Text("Sales Return".tr)),
              divider,
              CheckboxListTile(
                  value: repo!.Purchase,
                  onChanged: (val) => repo!.Purchase = val!,
                  title: Text("Purchase".tr)),
              divider,
              CheckboxListTile(
                  value: repo!.PurchaseOrder,
                  onChanged: (val) => repo!.PurchaseOrder = val!,
                  title: Text("Purchase Order".tr)),
              divider,
              CheckboxListTile(
                  value: repo!.PurchaseReturn,
                  onChanged: (val) => repo!.PurchaseReturn = val!,
                  title: Text("Purchase Return".tr)),
              divider,
              CheckboxListTile(
                  value: repo!.POS,
                  onChanged: (val) => repo!.POS = val!,
                  title: Text("POS".tr)),
              divider,
              CheckboxListTile(
                  value: repo!.POSOrder,
                  onChanged: (val) => repo!.POSOrder = val!,
                  title: Text("POS Order".tr)),
              divider,
              CheckboxListTile(
                  value: repo!.POSReturn,
                  onChanged: (val) => repo!.POSReturn = val!,
                  title: Text("POS Return".tr)),
              divider,
              CheckboxListTile(
                  value: repo!.Lossreport,
                  onChanged: (val) => repo!.Lossreport = val!,
                  title: Text("Loss report".tr)),
              divider,
              CheckboxListTile(
                  value: repo!.CreditSale,
                  onChanged: (val) => repo!.CreditSale = val!,
                  title: Text("Credit Sale".tr)),
              divider,
              /*  CheckboxListTile(
                  value: repo.ManualJournal,
                  onChanged: (val) => repo.ManualJournal = val,
                  title: Text("Manual Journal")),
              divider,
              CheckboxListTile(
                  value: repo.CategoryStock,
                  onChanged: (val) => repo.CategoryStock = val,
                  title: Text("Category Stock")),
              divider,
              CheckboxListTile(
                  value: repo.DayBook,
                  onChanged: (val) => repo.DayBook = val,
                  title: Text("Day Book")),
              divider,
              CheckboxListTile(
                  value: repo.CashFlow,
                  onChanged: (val) => repo.CashFlow = val,
                  title: Text("Cash Flow")),
              divider,
              CheckboxListTile(
                  value: repo.TrialBalance,
                  onChanged: (val) => repo.TrialBalance = val,
                  title: Text("Trial Balance")),
              divider,
              CheckboxListTile(
                  value: repo.ProfitAndLoss,
                  onChanged: (val) => repo.ProfitAndLoss = val,
                  title: Text("Profit & Loss")),*/
            ],
          ),
          /* ExpansionTile(
            title: Text("Cash report"),
            children: [
              divider,
              CheckboxListTile(
                  value: repo.CashandBank,
                  onChanged: (val) => repo.CashandBank = val,
                  title: Text("Cash and Bank")),
              divider,
              CheckboxListTile(
                  value: repo.CounterClosing,
                  onChanged: (val) => repo.CounterClosing = val,
                  title: Text("Counter Closing")),
              divider,
              CheckboxListTile(
                  value: repo.Receivable,
                  onChanged: (val) => repo.Receivable = val,
                  title: Text("Receivable")),
              divider,
              CheckboxListTile(
                  value: repo.Payable,
                  onChanged: (val) => repo.Payable = val,
                  title: Text("Payable")),
              divider,
              CheckboxListTile(
                  value: repo.Accountpayments,
                  onChanged: (val) => repo.Accountpayments = val,
                  title: Text("Account payments")),
              divider,
              CheckboxListTile(
                  value: repo.Payments,
                  onChanged: (val) => repo.Payments = val,
                  title: Text("Payments")),
              divider,
              CheckboxListTile(
                  value: repo.Accountreceipts,
                  onChanged: (val) => repo.Accountreceipts = val,
                  title: Text("Account receipts")),
              divider,
              CheckboxListTile(
                  value: repo.Receipts,
                  onChanged: (val) => repo.Receipts = val,
                  title: Text("Receipts")),
            ],
          ),
          ExpansionTile(
            title: Text("Health of your business"),
            children: [
              CheckboxListTile(
                  value: repo.LiquidityScor,
                  onChanged: (val) => repo.LiquidityScor = val,
                  title: Text("Liquidity Score")),
              divider,
              CheckboxListTile(
                  value: repo.FinancialDashBoar,
                  onChanged: (val) => repo.FinancialDashBoar = val,
                  title: Text("Financial DashBoard")),
              divider,
              CheckboxListTile(
                  value: repo.DebitCreditAnalysi,
                  onChanged: (val) => repo.DebitCreditAnalysi = val,
                  title: Text("Debit Credit Analysis")),
              divider,
              CheckboxListTile(
                  value: repo.CashConventionCycl,
                  onChanged: (val) => repo.CashConventionCycl = val,
                  title: Text("Cash Convention Cycle")),
              divider,
              CheckboxListTile(
                  value: repo.ProfitRatio,
                  onChanged: (val) => repo.ProfitRatio = val,
                  title: Text("Profit Ratio")),
            ],
          )*/
        ],
      ),
    );
  }
}
