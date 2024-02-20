import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/LedgerHeadderM.dart';
import 'package:glowrpt/screen/tabs/item_tab.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../repo/Provider.dart';
import '../util/Serviece.dart';

//https://dashboardtest.atlassian.net/browse/DAS-61
class ItemLedgerScreen extends StatefulWidget {
  const ItemLedgerScreen({Key? key}) : super(key: key);

  @override
  _ItemLedgerScreenState createState() => _ItemLedgerScreenState();
}

class _ItemLedgerScreenState extends State<ItemLedgerScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  List<String> tabs = [
    "Item".tr,
    "Category".tr,
    "Section".tr,
    "Brand".tr,
    "Manufacturer".tr,
    "Supplier".tr
  ];

  LedgerHeadderM? ledgerHeadder;

  num response = 0;
  CompanyRepository? companyRepo;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: tabs.length, initialIndex: 0, vsync: this);
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    tabController!.addListener(() {
      setState(() {});
    });
    getStockvalue();
  }

  String? barcodeScanRes;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                getStockvalue();
              },
              icon: Icon(Icons.refresh),
              label: Text("${NumberFormat.compact().format(response)}")),
          appBar: AppBar(
            centerTitle: true,
            // leading: Icon(Icons.person_outline),
            title: Text(
              'ITEM LEDGER',
              style: TextStyle(fontSize: 16.0),
            ),
            bottom: PreferredSize(
                child: Column(
                  children: [
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
                preferredSize: Size.fromHeight(60)),
          ),
          // I - Item
          // B - Brand
          // G - category
          // S - Section
          // M - Manufacture
          // C- Common
          body: TabBarView(
            controller: tabController,
            children: <Widget>[
              ItemTabs(
                type: "I",
                title: tabs[0],
              ),
              ItemTabs(
                type: "G",
                title: tabs[1],
              ),
              ItemTabs(
                type: "S",
                title: tabs[2],
              ),
              ItemTabs(
                type: "B",
                title: tabs[3],
              ),
              ItemTabs(
                type: "M",
                title: tabs[4],
              ),
              ItemTabs(
                type: "V",
                title: tabs[5],
              ),
            ],
          )),
    );
  }

  Future<void> getStockvalue() async {
    response = await Serviece.StockValue(
      context: context,
      api_key: companyRepo!.getSelectedUser().apiKey,
    );
    setState(() {});
  }
}

class TabChild extends StatelessWidget {
  TabController tabController;
  String title;
  int postion;
  Color color;

  TabChild({
  required  this.tabController,
  required  this.title,
  required  this.postion,
    this.color = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        title.tr,
        style: TextStyle(
            color: tabController.index == postion ? color : Colors.black26),
      ),
      decoration: BoxDecoration(
          color: tabController.index == postion
              ? color.withOpacity(.1)
              : Colors.transparent,
          border: Border.all(
              width: 1,
              color: tabController.index == postion ? color : Colors.black26),
          borderRadius: BorderRadius.all(Radius.circular(24))),
    );
  }
}
