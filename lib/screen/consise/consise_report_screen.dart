import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/consise/ConsiceM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/app_date_widget.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../ItemLedgerScreen.dart';
import 'consice_tab_screen.dart';

class ConsiseReportScreen extends StatefulWidget {
  @override
  _ConsiseReportScreenState createState() => _ConsiseReportScreenState();
}

class _ConsiseReportScreenState extends State<ConsiseReportScreen>
    with TickerProviderStateMixin {
  late CompanyRepository companyRepo;

  List<UserListBean>? usersList;
  late TabController tabController;

  List<String> slectedDateList = MyKey.getDefaultDateListAsToday();

  @override
  void initState() {
    
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadTata();
  }

  @override
  Widget build(BuildContext context) {
    return usersList != null
        ? Scaffold(
            appBar: AppBar(
              title: Text("Concise Report".tr),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: Column(
                  children: [
                    DaysSelectorWidget(
                      valueChanged: (dateList) {
                        slectedDateList = dateList;

                        loadTata();
                      },
                    ),
                    TabBar(
                      isScrollable: true,
                      labelPadding: EdgeInsets.all(4),
                      unselectedLabelColor: Colors.black.withOpacity(0.3),
                      labelColor: Colors.red,
                      indicatorColor: Colors.white,
                      controller: tabController,
                      tabs: usersList
                          !.map((e) => TabChild(
                                tabController: tabController,
                                title: e.User_Name,
                                postion: usersList!.indexOf(e),
                                color: AppColor.notificationBackgroud,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
                controller: tabController,
                children: usersList
                    !.map((e) => ConsiceTabScreen(e, slectedDateList))
                    .toList()),
          )
        : Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
  }

  Future<void> loadTata() async {
    ConsiceM? data = await Serviece.getConciseRport(
      context: context,
      api_key: companyRepo.getSelectedApiKey(),
      userId: "",
      dtRange: "",
      frmdate: slectedDateList.first,
      todate: slectedDateList.last,
    );

    usersList = data!.UserList;

    usersList!.insert(0, UserListBean(User_Id: null, User_Name: "All"));

    tabController =
        TabController(length: usersList!.length, initialIndex: 0, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    setState(() {});
  }
}
