import 'package:flutter/material.dart';
import 'package:glowrpt/chart/section_category_trends_tab.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/salestrends/tab/sales_trend_tab.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:provider/provider.dart';

import '../ItemLedgerScreen.dart';
import 'item_trends_tab.dart';
import 'package:get/get.dart';

class ItemTrendsScreen extends StatefulWidget {
  bool? isSale;

  ItemTrendsScreen({this.isSale});

  @override
  _ItemTrendsScreenState createState() => _ItemTrendsScreenState();
}

class _ItemTrendsScreenState extends State<ItemTrendsScreen>
    with SingleTickerProviderStateMixin {
  var tabController;
  List<String> tabs = [
    "Today",
    "Yesterday",
    "Last 7 day",
    "Last 30 days",
    "This Month"
  ];

  User? selectedComp;

  @override
  void initState() {
    
    super.initState();
    selectedComp = Provider.of<CompanyRepository>(context, listen: false)
        .getSelectedUser();
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
          title: Text(
              "Item ${widget.isSale! ? "Sales" : "Purchase"} Trend ${selectedComp!.organisation}"),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Choose a timeline to view".tr,
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
            ItemTrendsTab(
              1,
              widget.isSale!,
            ), //Today
            ItemTrendsTab(
              2,
              widget.isSale!,
            ), //Yesterday
            ItemTrendsTab(
              3,
              widget.isSale!,
            ), //last 7 day
            ItemTrendsTab(
              4,
              widget.isSale!,
            ), //Last 30 days
            ItemTrendsTab(
              5,
              widget.isSale!,
            ), //Month
          ],
        ));
  }
}
