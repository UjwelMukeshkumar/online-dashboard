import 'package:flutter/material.dart';
import 'package:glowrpt/chart/bar_chart_multi.dart';
import 'package:glowrpt/chart/ccc/line_chart_error.dart';

import 'package:glowrpt/model/other/CccM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/loader_widget.dart';

class CashConvertionCycle extends StatefulWidget {
  List<String> dateListLine;
  User selectedItem;

  CashConvertionCycle({
    required this.dateListLine,
    required this.selectedItem,
  });

  @override
  _CashConvertionCycleState createState() => _CashConvertionCycleState();
}

class _CashConvertionCycleState extends State<CashConvertionCycle> {
  CccM? ccc;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (ccc == null) {
      return Scaffold(
        body: LoaderWidget(),
      );
    }
    var textTheme = Theme.of(context).textTheme;
    var data = ccc!.cashConversionCycle!.first;
    var headline4 =
        textTheme.headline4!.copyWith(color: AppColor.chartBacground);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cash Conversion Cycle"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Financial KPI Dashboard",
              style: textTheme.headline6,
            ),
          ),
          Card(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Current Working Capital",
                      style: textTheme.subtitle1,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Current Awsets",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    "${MyKey.currencyFromat(data.currentAsset.toString())}",
                    style: TextStyle(color: Colors.white),
                  ),
                  tileColor: AppColor.barBlueDark,
                ),
                ListTile(
                  title: Text("Cash"),
                  trailing:
                      Text("${MyKey.currencyFromat(data.cash.toString())}"),
                ),
                ListTile(
                  title: Text("Accounts Receivable"),
                  trailing: Text(
                      "${MyKey.currencyFromat(data.accountReceviables.toString())}"),
                ),
                ListTile(
                  title: Text("Inventory"),
                  trailing: Text(
                      "${MyKey.currencyFromat(data.inventory.toString())}"),
                ),
                ListTile(
                  title: Text("Pre_Pid Expenses"),
                  trailing: Text(
                      "${MyKey.currencyFromat(data.prePaidExpenses.toString())}"),
                ),
                ListTile(
                  title: Text(
                    "Current Liabilities",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    "${MyKey.currencyFromat(data.currentLiabilities.toString())}",
                    style: TextStyle(color: Colors.white),
                  ),
                  tileColor: AppColor.barBlue,
                ),
                ListTile(
                  title: Text("Accounts Payable"),
                  trailing: Text(
                      "${MyKey.currencyFromat(data.accountPayables.toString())}"),
                ),
                ListTile(
                  title: Text("Credit Card Debit"),
                  trailing: Text(
                      "${MyKey.currencyFromat(data.creditCardDebt.toString())}"),
                ),
                ListTile(
                  title: Text("Bank Operating Credit"),
                  trailing: Text(
                      "${MyKey.currencyFromat(data.bankOperatingCredit.toString())}"),
                ),
                ListTile(
                  title: Text("Accrued Expenses"),
                  trailing: Text(
                      "${MyKey.currencyFromat(data.accuredExpenses.toString())}"),
                ),
                ListTile(
                  title: Text("Taxes Payable"),
                  trailing: Text(
                      "${MyKey.currencyFromat(data.taxPayable.toString())}"),
                ),
                ListTile(
                  title: Text(
                    "Working Capital",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    "${MyKey.currencyFromat(data.workingCapital.toString())}",
                    style: TextStyle(color: Colors.white),
                  ),
                  tileColor: AppColor.barBlue,
                ),
                ListTile(
                  title: Text(
                    "Current Ratio",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    "${MyKey.currencyFromat(data.currentRatio.toString(), sign: "")}",
                    style: TextStyle(color: Colors.white),
                  ),
                  tileColor: AppColor.barBlue,
                ),
              ],
            ),
          ),
          Card(
              child: Column(
            children: [
              ListTile(
                title: Text("Cash Conversion Cycle in Days - Last 3 Years"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardTile(
                    textTheme: textTheme,
                    footer: "DSO",
                    headder: data.daySalesOutstanding,
                  ),
                  Text(
                    "+",
                    style: headline4,
                  ),
                  CardTile(
                    textTheme: textTheme,
                    footer: "DIO",
                    headder: data.daysInventoryOutstanding,
                  ),
                  Text(
                    "-",
                    style: headline4,
                  ),
                  CardTile(
                    textTheme: textTheme,
                    footer: "DPO",
                    headder: data.daysPayableOutstanding,
                  ),
                  Text(
                    "=",
                    style: headline4,
                  ),
                  CardTile(
                    textTheme: textTheme,
                    footer: "CCC",
                    headder: data.cashConversionCycle,
                    textColor: AppColor.red91,
                  ),
                  // Text("Okay")
                ],
              ),
              SizedBox(
                height: 12,
              ),
              BarChartMulti(ccc!),
            ],
          )),
          SizedBox(
            height: 10,
          ),
          Card(
            margin: EdgeInsets.all(4),
            child: LineChartError(ccc!.vendorPaymentErrorRate!),
          )
        ],
      ),
    );
  }

  void loadData() {
    Serviece.geCashConvertionCycle(context, widget.selectedItem.apiKey,
            widget.dateListLine.first, widget.dateListLine.last)
        .then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Oops Someting went wrong please retry'),
          duration: Duration(minutes: 1),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () {
              loadData();
            },
          ),
        ));
      }
      if (mounted)
        setState(() {
          ccc = value;
        });
    });
  }
}

class CardTile extends StatelessWidget {
  final double headder;
  final String footer;
  final Color? textColor;

  const CardTile({
    Key? key,
    required this.headder,
    required this.footer,
    this.textColor,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.chartBacground,
      // height: 90,
      // width: 90,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              headder.toStringAsFixed(1),
              style: textTheme.headline6!
                  .copyWith(color: textColor ?? AppColor.notificationBackgroud),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              footer,
              style: textTheme.headline6!.copyWith(color: Colors.black26),
            ),
          ),
        ],
      ),
    );
  }
}
