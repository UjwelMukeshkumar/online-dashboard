import 'package:flutter/material.dart';
import 'package:glowrpt/chart/section_category_trends_tab.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/salestrends/tab/sales_trend_tab.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:provider/provider.dart';

import '../ItemLedgerScreen.dart';
import 'package:get/get.dart';

class SectionCatTrendsScreen extends StatefulWidget {
  bool? isSale;
  bool isCategory;
  SectionCatTrendsScreen({
     this.isSale,
    required this.isCategory,
  });

  @override
  _SectionCatTrendsScreenState createState() => _SectionCatTrendsScreenState();
}

class _SectionCatTrendsScreenState extends State<SectionCatTrendsScreen>
    with SingleTickerProviderStateMixin {
  var tabController;
  List<String> tabs = [
    "Today".tr,
    "Yesterday".tr,
    "Last 7 day".tr,
    "Last 30 days".tr,
    "This Month".tr
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
          title: Text("${widget.isCategory ? "Category" : "Section"} Trend".tr +
              "${selectedComp!.organisation}"),
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
            SectionCategoryTrendsTab(
              "&Type=Day&days=7",
              1,
              widget.isSale??false,
              isCategory: widget.isCategory,
            ), //Today
            SectionCategoryTrendsTab(
              "&Type=YesterDay&days=7",
              2,
              widget.isSale??false,
              isCategory: widget.isCategory,
            ), //Yesterday
            SectionCategoryTrendsTab(
              "&Type=Week&days=1",
              3,
              widget.isSale??false,
              isCategory: widget.isCategory,
            ), //last 7 day
            SectionCategoryTrendsTab(
              "&Type=30 day&days=30",
              4,
              widget.isSale??false,
              isCategory: widget.isCategory,
            ), //Last 30 days
            SectionCategoryTrendsTab(
              "&Type=Month&days=1",
              5,
              widget.isSale??false,
              isCategory: widget.isCategory,
            ), //Month
          ],
        ));
  }
}
