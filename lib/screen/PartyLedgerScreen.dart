import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/LedgerHeadderM.dart';
import 'package:glowrpt/screen/ItemLedgerScreen.dart';
import 'package:glowrpt/screen/tabs/party_tab.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/other/bottom_sheet.dart';
import 'package:glowrpt/widget/other/headder_card.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

// https://dashboardtest.atlassian.net/browse/DAS-47
class PartyLedgerScreen extends StatefulWidget {
  int pageIndex;
  PartyLedgerScreen({this.pageIndex = 0});

  @override
  _PartyLedgerScreenState createState() => _PartyLedgerScreenState();
}

class _PartyLedgerScreenState extends State<PartyLedgerScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  List<String> tabs = [
    "Customers".tr,
    "Suppliers".tr,
    "Accounts".tr,
    "Employees".tr
  ];

  LedgerHeadderM? ledgerHeadder;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: tabs.length, initialIndex: widget.pageIndex, vsync: this);

    tabController!.addListener(() {
      setState(() {});
    });
  }

  String? barcodeScanRes;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              var tab = tabs[tabController!.index];
              print(tab);
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return MyBottomSheet(tab);
                  });
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            centerTitle: true,
            // leading: Icon(Icons.person_outline),
            title: Text(
              'PARTY LEDGER'.tr,
              style: TextStyle(fontSize: 16.0),
            ),
            bottom: PreferredSize(
                child: Column(
                  children: [
                    SizedBox(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            HeadderCard(
                              title: "Receivable".tr,
                              amount: MyKey.currencyFromat(
                                ledgerHeadder?.TotalReceviables.toString()
                                  ,
                                decimmalPlace: 0,
                              ),
                              // percentage: ledgerHeadder.Purchasecomparison,
                              icon: Icon(Icons.compare_arrows),
                            ),
                            HeadderCard(
                              title: "Payable".tr,
                              amount: MyKey.currencyFromat(
                                ledgerHeadder?.TotalPayables.toString() ,
                                decimmalPlace: 0,
                              ),
                              // percentage: ledgerHeadder.Purchasecomparison,
                              icon: Icon(Icons.compare_arrows),
                            ),
                            HeadderCard(
                              title:
                                  "Receipt (${DateFormat("MMM").format(DateTime.now())})",
                              amount: MyKey.currencyFromat(
                                  ledgerHeadder?.Receipt.toString() ,
                                  decimmalPlace: 0),
                              // percentage: ledgerHeadder?.Receiptcomparison ?? 0,
                              percentage:
                                  ledgerHeadder?.Receiptcomparison.toDouble(),
                              // amount: "4355.56",
                              // icon: Image.asset("assets/icons/trial_balance.png"),
                            ),
                            HeadderCard(
                              title:
                                  "Payment (${DateFormat("MMM").format(DateTime.now())})"
                                      .tr,
                              amount: MyKey.currencyFromat(
                                  ledgerHeadder?.Payment.toString(),
                                  decimmalPlace: 0),
                              // percentage: ledgerHeadder?.Paymentcomparison ?? 0,
                              percentage:
                                  ledgerHeadder?.Paymentcomparison?.toDouble()??0.0,
                              // icon: Icon(Icons.compare_arrows),
                            ),
                            HeadderCard(
                              title:
                                  "Sales (${DateFormat("MMM").format(DateTime.now())})"
                                      .tr,
                              amount: MyKey.currencyFromat(
                                  ledgerHeadder?.Sales.toString(),
                                  decimmalPlace: 0),
                              percentage:
                                  ledgerHeadder?.Salescomparison?.toDouble(),
                              // amount: "4355.56",
                              // icon: Image.asset("assets/icons/trial_balance.png"),
                            ),
                            HeadderCard(
                              title:
                                  "Purchase (${DateFormat("MMM").format(DateTime.now())})"
                                      .tr,
                              amount: MyKey.currencyFromat(
                                  ledgerHeadder?.Purchase.toString() ,
                                  decimmalPlace: 0),
                              percentage:
                                  ledgerHeadder?.Purchasecomparison.toDouble(),
                              // icon: Icon(Icons.compare_arrows),
                            ),
                          ],
                        )
                        // : Text("Testing................"),
                        ),
                    SizedBox(height: 12),
                    TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Colors.black.withOpacity(0.3),
                        labelColor: Colors.red,
                        indicatorColor: Colors.white,
                        controller: tabController,
                        labelPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        tabs: tabs.map((e) {
                          return TabChild(
                            tabController: tabController!,
                            title: e,
                            postion: tabs.indexOf(e),
                          );
                        }).toList())
                  ],
                ),
                preferredSize: Size.fromHeight(160)),
          ),
          body: TabBarView(
            controller: tabController,
            children: <Widget>[
              PartyTab(
                "C",
                valueChanged: (data) {
                  setState(() {
                    ledgerHeadder = data;
                  });
                },
                title: "Receivable".tr,
              ),
              PartyTab(
                "S",
                valueChanged: (data) {
                  setState(() {
                    ledgerHeadder = data;
                  });
                },
                title: "Payable".tr,
              ),
              PartyTab("A", title: "Receivable"),
              PartyTab("E", title: "Receivable"),
            ],
          )),
    );
  }
}
