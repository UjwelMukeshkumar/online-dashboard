import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glowrpt/chart/sles_trends_chart.dart';
import 'package:glowrpt/library/CollectionOperation.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/model/trend/SalesTrendsM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/company_manager_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/manager/tab_wise_report_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SalesTrendTab extends StatefulWidget {
  String urlPart;
  int index;
  bool isSale;
  User user;
  String catId;
  SalesTrendTab(this.urlPart, this.index, this.isSale, this.user,
      {required this.catId});

  @override
  _SalesTrendTabState createState() => _SalesTrendTabState();
}

class _SalesTrendTabState extends State<SalesTrendTab>
    with AutomaticKeepAliveClientMixin {
  // CompanyRepository companyrepo;

  SalesTrendsM? salesTrends;

  CustomerListBean? newCustomer;
  PageController pageController = PageController();

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (pageController.hasClients) if (pageController.page == 0) {
        pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        pageController.previousPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      }
    });
    // companyrepo = Provider.of<CompanyRepository>(context, listen: false);
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var headder = (salesTrends?.Header?.length ?? 0) > 0
        ? salesTrends!.Header.first
        : null;

    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 16),
          margin: containerMargin,
          decoration: containerDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child: ListTile(
                    title: Text("Total Sales".tr, style: textTheme.caption),
                    subtitle: Text(
                      MyKey.currencyFromat(
                          headder?.TotalCollection?.toString() ?? "0",
                          decimmalPlace: 0),
                      style: textTheme.headline6,
                    ),
                  )),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.black12,
                  ),
                  Expanded(
                      child: ListTile(
                    title: Text("No.Of Sales".tr, style: textTheme.caption),
                    subtitle: Text(headder?.TotalPayments?.toString() ?? "",
                        style: textTheme.headline6),
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                    //TODO : fixthis
                    text: TextSpan(
                        text:
                            "${headder?.CmpTxt == "More" ? "Great you".tr : "You".tr} ${widget.isSale ? "Have Sold for" : "purchased"} ",
                        style: textTheme.caption,
                        children: [
                      TextSpan(
                          //TODO : fixthis
                          text:
                              "${MyKey.currencyFromat(headder?.AmntComparison?.toString() ?? "0", decimmalPlace: 0)} ${headder?.CmpTxt ?? ""}",
                          style: TextStyle(
                              color: headder?.CmpTxt == "More"
                                  ? AppColor.notificationBackgroud
                                  : AppColor.red)),
                      TextSpan(text: " compared to last week same day,".tr)
                    ])),
              )
            ],
          ),
        ),
        Container(
          // padding: EdgeInsets.only(bottom: 16),
          margin: containerMargin,
          decoration: containerDecoration,
          child: Row(
            children: [
              Expanded(
                  child: ListTile(
                //TODO : fixthis
                subtitle: Text(
                  "Avg. Basket Value".tr,
                  style: textTheme.caption,
                ),
                title: Text(
                  MyKey.currencyFromat(headder?.AvgAmount?.toString() ?? "0",
                      decimmalPlace: 0),
                  style: textTheme.headline6!
                      .copyWith(color: AppColor.title.withOpacity(.6)),
                ),
              )),
              Container(
                height: 50,
                width: 1,
                color: Colors.black12,
              ),
              Expanded(
                  child: ListTile(
                title: RichText(
                  text: TextSpan(
                      style: textTheme.caption!.copyWith(color: Colors.black87),
                      children: [
                        TextSpan(
                            text:
                                "${MyKey.currencyFromat(headder?.AvgAmntComparison?.toString() ?? "0", decimmalPlace: 0)} ${headder?.AvgAmntCmpTxt ?? ""} ",
                            style: TextStyle(
                                color: headder?.AvgAmntCmpTxt == "More"
                                    ? AppColor.notificationBackgroud
                                    : AppColor.red)),
                        //TODO : fixthis
                        TextSpan(text: " compared to last week same day,".tr)
                      ]),
                ),
              )),
            ],
          ),
        ),
        if (salesTrends != null)
          Container(
            margin: containerMargin,
            decoration: containerDecoration,
            child: AspectRatio(
              aspectRatio: 5,
              child: PageView(
                pageSnapping: true,
                allowImplicitScrolling: true,
                controller: pageController,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.trending_up,
                      color: AppColor.notificationBackgroud,
                    ),
                    title: Text("${newCustomer!.NewCustomer} New Customers".tr),
                    subtitle: RichText(
                      text: TextSpan(style: textTheme.subtitle2, children: [
                        TextSpan(
                            text:
                                "${newCustomer!.NewCustomerCmp} ${newCustomer!.NewCustomerCmpTxt}",
                            style: TextStyle(
                                color: newCustomer?.NewCustomerCmpTxt == "More"
                                    ? AppColor.notificationBackgroud
                                    : AppColor.red)),
                        TextSpan(text: " than ${getTrendText(widget.index)}")
                      ]),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.trending_up,
                      color: AppColor.notificationBackgroud,
                    ),
                    title: Text(
                        //TODO : fixthis
                        "${newCustomer!.RepeatCustomer} Repeat Customers".tr),
                    subtitle: RichText(
                      text: TextSpan(style: textTheme.subtitle2, children: [
                        TextSpan(
                            text:
                                "${newCustomer?.RepeatCustomerCmp} ${newCustomer?.RepeatCustomerTxt}",
                            style: TextStyle(
                                //TODO : fixthis
                                color: newCustomer?.RepeatCustomerTxt == "More"
                                    ? AppColor.notificationBackgroud
                                    : AppColor.red)),
                        // TextSpan(text: " than ${getTrendText(widget.index)}"),
                        TextSpan(
                            text: " ${'than'.tr} ${getTrendText(widget.index)}")
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        if (salesTrends != null)
          Container(
            margin: containerMargin,
            decoration: containerDecoration,
            child: Column(
              children: [
                SizedBox(height: 4),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Icon(
                        Icons.circle,
                        size: 18,
                        color: AppColor.notificationBackgroud,
                      ),
                    ),
                    Text(
                      getCurrentText(),
                      style: textTheme.caption,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Icon(
                        Icons.circle,
                        size: 18,
                        color: AppColor.title,
                      ),
                    ),
                    Text(
                      gerPreviusText().tr,
                      style: textTheme.caption,
                    ),
                  ],
                ),
                if ((salesTrends!.Header?.first?.TotalCollection ?? 0) > 0 &&
                    salesTrends!.current.length > 0 &&
                    salesTrends!.previus.length > 0) ...[
                  Divider(
                    thickness: 2,
                  ),
                  SalesTrendsChart(salesTrends!, widget.index),
                ],
              ],
            ),
          ),
        // TabWiseReportWidget(),
      ],
    );
  }

  Future<void> loadDetails() async {
    salesTrends = await Serviece.salesTrends(
        context: context,
        api_key: widget.user.apiKey,
        date: getData(widget.index),
        urlEndPart: widget.urlPart,
        endPoint: widget.isSale ? "SLT" : "PLT",
        categoryId: widget.catId);
        if(salesTrends!=null&& salesTrends?.CustomerList!=null){
      newCustomer = salesTrends?.CustomerList.tryFirst;
        }
   
    setState(() {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  String getCurrentText() {
    switch (widget.index) {
      case 1:
        return "Today";
      case 2:
        return "Yesterday";
      case 3:
        return "Last 7 days";
      case 4:
        return "Last 30 Days";
      case 5:
        return "This Month";
    }
    return "";
  }

  String gerPreviusText() {
    switch (widget.index) {
      case 1:
      case 2:
        return "Last week same day";
      case 3:
        return "Previous 7 Days";
      case 4:
        return "Previous 30 Days";
      case 5:
        return "Previous Month";
    }
    return "";
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
