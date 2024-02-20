import 'package:flutter/material.dart';
import 'package:glowrpt/library/DateFactory.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';

import 'package:get/get.dart';
import '../ItemLedgerScreen.dart';
import 'BranchDetailsTab.dart';

class BranchWiseDetailsScreen extends StatefulWidget {
  @override
  _BranchWiseDetailsScreenState createState() =>
      _BranchWiseDetailsScreenState();
}

class _BranchWiseDetailsScreenState extends State<BranchWiseDetailsScreen>
    with SingleTickerProviderStateMixin {
  var tabController;

  late DateTime today;

  @override
  void initState() {
    
    super.initState();
    today = DateTime.now();
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
          title: Text("Branch Details".tr),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Choose a timeline to view analytical data".tr,
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
          // physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: <Widget>[
            BranchDetailsTab(
              position: 1,
              fromDate: MyKey.displayDateFormat.format(today),
              toDate: MyKey.displayDateFormat.format(today),
            ), //Today
            BranchDetailsTab(
              position: 2,
              fromDate: MyKey.displayDateFormat
                  .format(today.subtract(Duration(days: 1))),
              toDate: MyKey.displayDateFormat
                  .format(today.subtract(Duration(days: 1))),
            ), //Yesterday
            BranchDetailsTab(
              position: 3,
              fromDate: MyKey.displayDateFormat
                  .format(today.subtract(Duration(days: 7))),
              toDate: MyKey.displayDateFormat.format(today),
            ), //last 7 day
            BranchDetailsTab(
              position: 4,
              fromDate: MyKey.displayDateFormat
                  .format(today.subtract(Duration(days: 30))),
              toDate: MyKey.displayDateFormat.format(today),
            ), //Last 30 days
            BranchDetailsTab(
              position: 5,
              fromDate: MyKey.displayDateFormat
                  .format(DateTime(today.year, today.month, 1)),
              toDate: MyKey.displayDateFormat.format(today),
            ),

            //last 3 month
            BranchDetailsTab(
              position: 6,
              fromDate: today.getLast3MonthFirstDay.asString,
              toDate: today.getLastDayOfPreviousMonth.asString,
            ),
            //this yeear
            BranchDetailsTab(
              position: 7,
              fromDate: today.getThisYearFirstDay.asString,
              toDate: today.asString,
            ),
            //last year
            BranchDetailsTab(
              position: 8,
              fromDate: today.getLastYearFirstDay.asString,
              toDate: today.getLastYearLastDay.asString,
            ),
            //custome
            BranchDetailsTab(
              position: 8,
              fromDate: MyKey.displayDateFormat
                  .format(DateTime(today.year, today.month, 1)),
              toDate: MyKey.displayDateFormat.format(today),
            ), //Month
          ],
        ));
  }
}
