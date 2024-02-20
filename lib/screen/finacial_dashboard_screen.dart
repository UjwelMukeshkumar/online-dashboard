import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/FinancialDashBoardM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/graph_card_widget.dart';
import 'package:glowrpt/widget/other/graph_row_widget.dart';
import 'package:glowrpt/widget/other/loader_widget.dart';

class FinacialDashboardScreen extends StatefulWidget {
  // DocM docM;
  List<String> dateListLine;
  User selectedItem;

  // String type;
  // String title;

  FinacialDashboardScreen({
  required  this.dateListLine,
   required this.selectedItem,
  });

  @override
  _FinacialDashboardScreenState createState() =>
      _FinacialDashboardScreenState();
}

class _FinacialDashboardScreenState extends State<FinacialDashboardScreen> {
   FinancialDashBoardM? finacialList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var data =
        finacialList == null ? null : finacialList!.financialDashBoard.first;
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial DashBoard"),
      ),
      body: finacialList != null
          ? ListView(
              children: [
                GraphCardWidget(
                  title: "RETURN ON ASSETS",
                  conintText: "${data!.returnOnAsset}",
                  transactions: finacialList!.returnonAssetGraph,
                  chartType: ChartType.bar,
                ),
                GraphCardWidget(
                  title: "WORKING CAPITAL RATIO",
                  conintText: "${data.workingCapitalRatio}",
                  transactions: finacialList!.workingCapitalRatioGraph,
                  chartType: ChartType.line,
                ),
                GraphCardWidget(
                  title: "RETURN ON EQUITY",
                  conintText: "${data.returnOnEquity}",
                  transactions: finacialList!.returnOnEquityGraph,
                  chartType: ChartType.line,
                ),
                GraphCardWidget(
                  title: "DEBT-EQUITY RATIO",
                  conintText: "${data.debitEquity}",
                  transactions: finacialList!.debitEquityGraph,
                  chartType: ChartType.linefill,
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(6),
                  color: Colors.black54,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    "BALANCE SHEET",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.white),
                  ),
                ),
                GraphRowWidget(
                  title: "TOTAL ASSETS",
                  amount: data.totalAsset,
                  transactions: finacialList!.totalAssetsGraph,
                  isBold: true,
                ),
                GraphRowWidget(
                  title: "Current Assets",
                  amount: data.currentAsset,
                  transactions: finacialList!.currentAssetsGraph,
                  isBold: false,
                ),
                GraphRowWidget(
                  title: "Cash",
                  amount: data.cash,
                  transactions: finacialList!.cashGraph,
                  isBold: false,
                ),
                GraphRowWidget(
                  title: "Account Receivable",
                  amount: data.accountPayables,
                  transactions: finacialList!.accountReceviablesGraph,
                  isBold: false,
                ),
                GraphRowWidget(
                  title: "Inventory",
                  amount: data.inventory,
                  transactions: finacialList!.inventoryGraph,
                  isBold: false,
                ),
                // GraphRowWidget(title: "Long-Term Assets",amount: data.,transactions: finacialList.lo,isBold: false,),
                GraphRowWidget(
                  title: "TOTAL LIABILITIES",
                  amount: data.totalLiabilities,
                  transactions: finacialList!.totalLiabilitiesGraph,
                  isBold: true,
                ),
                GraphRowWidget(
                  title: "Current Liabilities",
                  amount: data.currentLiabilities,
                  transactions: finacialList!.currentLiabilitiesGraph,
                  isBold: true,
                ),
                GraphRowWidget(
                  title: "Accounts Payable",
                  amount: data.accountPayables,
                  transactions: finacialList!.accountPayablesGraph,
                  isBold: false,
                ),
                // GraphRowWidget(title: "Other Liabilities",amount: data.o,transactions: finacialList.accountPayablesGraph,isBold: false,),
                GraphRowWidget(
                  title: "Shareholder Equity",
                  amount: data.shareholdersEquity,
                  transactions: finacialList!.shareholderEquityGraph,
                  isBold: true,
                ),
                GraphRowWidget(
                  title: "Common Stock",
                  amount: data.commonStock,
                  transactions: finacialList!.commonstockGraph,
                  isBold: false,
                ),
                GraphRowWidget(
                  title: "Current Earnings",
                  amount: data.currentEarnigs,
                  transactions: finacialList!.currentEarningGraph,
                  isBold: false,
                ),
              ],
            )
          : LoaderWidget(),
    );
  }

  void loadData() {
    Serviece.geFinancialDashBoard(context, widget.selectedItem.apiKey,
            widget.dateListLine.first, widget.dateListLine.last)
        .then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Oops Someting went wrong please retry'),
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
          finacialList = value;
        });
    });
  }
}
