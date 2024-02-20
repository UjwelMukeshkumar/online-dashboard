import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/salestrends/tab/sales_trend_tab.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:provider/provider.dart';

import '../ItemLedgerScreen.dart';
import 'package:get/get.dart';

class SalesTrendsScreen extends StatefulWidget {
  bool isSale;
  User selectedComp;
  String? catId;

  SalesTrendsScreen({
    required this.isSale,
    required this.selectedComp,
     this.catId,
  });

  @override
  _SalesTrendsScreenState createState() => _SalesTrendsScreenState();
}

class _SalesTrendsScreenState extends State<SalesTrendsScreen>
    with SingleTickerProviderStateMixin {
  var tabController;
  List<String> tabs = [
    "Today".tr,
    "Yesterday".tr,
    "Last 7 day".tr,
    "Last 30 days".tr,
    "This Month".tr
  ];

  @override
  void initState() {
    super.initState();
    /*selectedComp = Provider.of<CompanyRepository>(context, listen: false)
        .getSelectedUser();*/
    tabController =
        TabController(length: tabs.length, initialIndex: 0, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text("Sales Trends ${widget.selectedComp.organisation}"),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Choose a timeline".tr,
                      style: textTheme.bodyText2,
                    ),
                  ),
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
                          tabController: tabController,
                          title: e,
                          postion: tabs.indexOf(e),
                          color: AppColor.notificationBackgroud,
                        );
                      }).toList()),
                ],
              )),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            SalesTrendTab(
                "&Type=Day&days=7", 1, widget.isSale, widget.selectedComp,
                catId: widget.catId.toString()),
            //Today
            SalesTrendTab(
                "&Type=YesterDay&days=7", 2, widget.isSale, widget.selectedComp,
                catId: widget.catId.toString()),
            //Yesterday
            SalesTrendTab(
                "&Type=Week&days=1", 3, widget.isSale, widget.selectedComp,
                catId: widget.catId.toString()),
            //last 7 day
            SalesTrendTab(
                "&Type=30 day&days=30", 4, widget.isSale, widget.selectedComp,
                catId: widget.catId.toString()),
            //Last 30 days
            SalesTrendTab(
                "&Type=Month&days=1", 5, widget.isSale, widget.selectedComp,
                catId: widget.catId.toString()),
            //Month
          ],
        ));
  }
}
