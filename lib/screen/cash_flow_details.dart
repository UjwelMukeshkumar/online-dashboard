
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/CashFlowM.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/other/headder_item_widget.dart';
import 'package:glowrpt/widget/other/line_headder_widget.dart';
import 'package:glowrpt/widget/other/line_item_widget.dart';
import 'package:glowrpt/widget/other/loader_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/other/DocM.dart';
import '../model/other/User.dart';

class CashFlowDetails extends StatefulWidget {
  final List<String>? dateListLine;
  final User selectedItem;
  final HeadderParm headderParm;

  CashFlowDetails({
    required this.dateListLine,
    required this.selectedItem,
    required this.headderParm,
  });

  @override
  _CashFlowDetailsState createState() => _CashFlowDetailsState();
}

class _CashFlowDetailsState extends State<CashFlowDetails> {
  Map? dataSet;

  CashFlowM? cashFlow;

  @override
  void initState() {
    super.initState();
    updateLines();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var headder3 = textTheme.subtitle2;
    return Scaffold(
      backgroundColor: AppColor.chartBacground,
      appBar: AppBar(
        title: Text("${widget.headderParm.title}"),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: DaysSelectorWidget(
                valueChanged: (list) {
                  list = widget.dateListLine!;
                  // widget.dateListLine = list;
                  updateLines();
                },
                intialText: widget.dateListLine![1],
              ),
            ),
            if (cashFlow != null) ...[
              Expanded(
                child: ListView(
                  children: [
                    Headder(title: "OPERATIONS"),
                    SubHeadding(title: "Cash Receipts from"),
                    ItemWidget(
                        title: "Cash Customers",
                        value: cashFlow!.cashCustomer ?? 0.0),
                    ItemWidget(
                        title: "Debtors", value: cashFlow!.debtors ?? 0.0),
                    ItemWidget(
                        title: "Other Operation",
                        value: cashFlow!.otherOperation ?? 0.0),
                    SubHeadding(title: "Cash Paid for"),
                    ItemWidget(
                        title: "Inventory Purchase",
                        value: cashFlow!.inventoryPurchase ?? 0.0),
                    ItemWidget(
                        title: "Gen and Admin Expense",
                        value: cashFlow!.genAndAdminExpenses ?? 0.0),
                    ItemWidget(
                        title: "Selling and Distribution Expense",
                        value: cashFlow!.selingandDistributionExpenses ?? 0.0),
                    ItemWidget(
                        title: "Indirect Expense",
                        value: cashFlow!.indirectExpenses ?? 0.0),
                    SubHeadding(title: "Operating Cash flow before Tax"),
                    ItemWidget(
                        title: "Income Taxes",
                        value: cashFlow!.incomeTaxes ?? 0.0),
                    Headder(title: "Net Cash flow from operation"),
                    Headder(title: "INVESTING ACTIVITIES"),
                    SubHeadding(title: "Cash Receipts from"),
                    ItemWidget(
                        title: "Sale of Fixed Assets",
                        value: cashFlow!.salesOfFixedAsset ?? 0.0),
                    ItemWidget(
                        title: "Collection of Loan Paid",
                        value: cashFlow!.collectionOfLoanandPaid ?? 0.0),
                    ItemWidget(
                        title: "Sale of Investment",
                        value: cashFlow!.saleOfInverstment ?? 0.0),
                    SubHeadding(title: "Cash Paid for"),
                    ItemWidget(
                        title: "Purchase of Fixed Assets",
                        value: cashFlow!.purchaseOfFixedAsset ?? 0.0),
                    ItemWidget(
                        title: "Making Loan to others",
                        value: cashFlow!.makingLoanandOthers ?? 0.0),
                    ItemWidget(
                        title: "Purchase of Investment",
                        value: cashFlow!.purchaseOfInvenstment ?? 0.0),
                    Headder(title: "Net Cash flow from Investing Activities"),
                    Headder(title: "FINANCING ACTIVITIES"),
                    SubHeadding(title: "Cash Receipts from"),
                    ItemWidget(
                        title: "Issue of Share and Securities",
                        value: cashFlow!.issueOfShareAndSecurities ?? 0.0),
                    ItemWidget(
                        title: "Borrowings",
                        value: cashFlow!.borrowings ?? 0.0),
                    SubHeadding(title: "Cash Paid for"),
                    ItemWidget(
                        title: "Buyback if Share and Securities",
                        value: cashFlow!.buybackIfShareAndSecurities ?? 0.0),
                    ItemWidget(
                        title: "Repayment of Loan",
                        value: cashFlow!.repaymentOfLoan ?? 0.0),
                    ItemWidget(
                        title: "Dividends", value: cashFlow!.dividends ?? 0.0),
                    Headder(title: "Net Cash flow from Financing Activities"),
                    Headder(title: "Net Increase?(Decrease in cash"),
                  ],
                ),
              )
            ] else
              Expanded(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              )
          ],
        ),
      ),
    );
  }

  _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Not supported");
    }
  }

  Future<void> updateLines() async {
    if (widget.dateListLine!.length < 2) return;
    dataSet = await Serviece.getHomedocForHedder(
        context,
        widget.selectedItem.apiKey,
        widget.dateListLine!.first,
        widget.dateListLine!.last,
        widget.headderParm.endPont,
        1,
        "",
        type: widget.headderParm.type!);
    if (dataSet != null) {
      cashFlow = CashFlowM.fromJson(dataSet![widget.headderParm.tableName][0]);
    } else {
      cashFlow = CashFlowM();
    }
    setState(() {});
  }
}

class Headder extends StatelessWidget {
  final String title;

  Headder({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

class SubHeadding extends StatelessWidget {
  final String title;

  SubHeadding({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, top: 16),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String title;
  final double value;

  ItemWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(left: 24),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: textTheme.bodyText2,
            ),
          ),
          Text(
            " :  ",
            style: textTheme.bodyText1,
          ),
          Expanded(
            child: Text(
              MyKey.currencyFromat(value.toString()),
              style: textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
