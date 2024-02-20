import 'package:flutter/material.dart';
import 'package:glowrpt/model/sale/SlacM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/sales/campains/campagin_list_screen.dart';
import 'package:glowrpt/screen/dashboards/sales/campains/campains_screen.dart';
import 'package:glowrpt/screen/dashboards/sales/list_details_screeen.dart';
import 'package:glowrpt/screen/dashboards/sales/sold_item_list_screen.dart';
import 'package:glowrpt/screen/itemtrends/item_trends_tab.dart';
import 'package:glowrpt/screen/route/select_route_screen1.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/other/bottom_sheet.dart';
import 'package:glowrpt/widget/other/caroser_slider_widget.dart';
import 'package:glowrpt/widget/other/list_tile_button.dart';
import 'package:glowrpt/widget/main_tabs/category_list_widget.dart';
import 'package:glowrpt/widget/item/horizontal_item_list/horizontal_item_list_widget.dart';
import 'package:glowrpt/widget/main_tabs/item_sale_report_widget.dart';
import 'package:glowrpt/widget/other/ledger_buttons.dart';
import 'package:glowrpt/widget/manager/total_branch_details_widget.dart';
import 'package:glowrpt/widget/sales/sales_and_stock_widget.dart';
import 'package:glowrpt/widget/main_tabs/sales_purchase_widget.dart';
import 'package:glowrpt/widget/main_tabs/section_list_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../ItemLedgerScreen.dart';
import '../doc_approve_paginated.dart';
import 'package:get/get.dart';

class SalesDashBoards extends StatefulWidget {
  bool isSatakeHolder;

  SalesDashBoards({this.isSatakeHolder = false});

  @override
  _SalesDashBoardsState createState() => _SalesDashBoardsState();
}

class _SalesDashBoardsState extends State<SalesDashBoards>
    with SingleTickerProviderStateMixin {
  var tabController;
  List<String> tabs = ["Sales", "Category", "Section", "Item Sales"];

  CompanyRepository? compRepo;

  List<SlacM>? slacCount;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    tabController =
        TabController(length: tabs.length, initialIndex: 0, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    loadList();
    /* var _formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: 'Rs', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(numberToFormat);
    print("Formated Number ${_formattedNumber}");*/
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TotalBranchDetailsWidget(),
      Visibility(
        visible: !widget.isSatakeHolder,
        child: AppCard(
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
                      tabController: tabController,
                      title: e,
                      postion: tabs.indexOf(e),
                      color: AppColor.notificationBackgroud,
                    );
                  }).toList()),
              SizedBox(
                height: MediaQuery.of(context).size.height * .55,
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    SalesPurchaseWidget(true),
                    CategoryListWidget(true),
                    SectionListWidget(true),
                    IitemSaleReportWidget(true),
                    //  SizedBox(height: 80),
                    //Month
                  ],
                ),
              ),
            ],
          ),
        ),
        replacement: AppCard(child: SalesPurchaseWidget(true)),
      ),
      Visibility(
        visible: !widget.isSatakeHolder,
        child: ListTileButton(
          title: "Routes".tr,
          icon: Icons.alt_route_outlined,
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SelectRouteScreen1()));
          },
        ),
      ),
      // LedgerButtons(),

      Visibility(
        visible: !widget.isSatakeHolder,
        child: MyBottomSheet(
          "Customers",
          isBottomSheet: false,
        ),
      ),
      ListTileButton(
        title: "Campaigns",
        icon: Icons.local_offer_outlined,
        onTap: () {
          Get.to(() => CampaginListScreen());
        },
      ),
      if (slacCount != null)
        AppCard(
          // margin: EdgeInsets.all(8),
          child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: slacCount?.length,
              itemBuilder: (context, position) {
                var item = slacCount?[position];
                return ListTile(
                  onTap: () => openDetailsPage(item),
                  title: Text(
                    item!.Text,
                    style: TextStyle(color: getColor(item)),
                  ),
                  trailing: Text(item.Count.toString()),
                );
              }),
        ),

      Visibility(
        visible: !widget.isSatakeHolder,
        child: DocApprovePaginated(
          DocType: DocType.sales,
          title: "Approve Sales".tr,
        ),
      ),
      /*   DocApprovePaginated(
        DocType: DocType.salseOrder,
        title: "Approve Sales Order",
      ),*/
      HorizontalItemListWidget(
        title: "Top Selling Items".tr,
        isSale: true,
      ),
      SalesAndStockWidget(
        isStock: true,
      ),
      SalesAndStockWidget(
        isStock: false,
      ),
    ]);
  }

  Future<void> loadList() async {
    slacCount = await Serviece.getSlacCount(
        context: context,
        fromdate: MyKey.getCurrentDate(),
        todate: MyKey.getCurrentDate(),
        api_key: compRepo!.getSelectedApiKey());
    setState(() {});
  }

  getColor(SlacM item) {
    if (item.Text == "Sold With MRP") {
      return AppColor.positiveGreen;
    }
    if (item.Text == "Sold at Loss") {
      return AppColor.negativeRed;
    }
    return null;
  }

  void openDetailsPage(SlacM item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SoldItemListScreen(
                  title: item.Text,
                  fromDate: MyKey.getCurrentDate(),
                  todate: MyKey.getCurrentDate(),
                  type: getType(item.Text),
                )));
  }

  // SLM for Sold with MRP , SLD for Sold with Discount ,SLL Sold at Loss
  getType(String text) {
    if (text == "Sold With MRP") {
      return "SLM";
    } else if (text == "Sold With Discount") {
      return "SLD";
    } else {
      return "SLT";
    }
  }
}

class CardItem extends StatelessWidget {
  Map item;
  List<IconData> icons = [Icons.low_priority];
  double sizeOfContainer;
  int position;

  CardItem(this.item, this.sizeOfContainer, this.position);

  List<Color> colors = [
    AppColor.negativeRed,
    AppColor.positiveGreen,
    AppColor.title,
    AppColor.positiveGreen,
    AppColor.title,
    AppColor.negativeRed,
    AppColor.title,
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var headline4 = textTheme.headline6!.copyWith(color: AppColor.title);
    return SizedBox(
      height: sizeOfContainer,
      width: sizeOfContainer,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${NumberFormat.compact().format(item["Count"])}",
                style: headline4.copyWith(color: colors[position]),
              ),
              SizedBox(
                height: 8,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                runSpacing: 2,
                children: [
                  /* Icon(
                    Icons.adjust,
                    size: 18,
                    // color: AppColor.negativeRed,
                  ),*/
                  ...item["Text"]
                      .toString()
                      .split(" ")
                      .map((e) => Text(e))
                      .toList(),
                  //Text("he ")
                  //Text("${item["Text"]}",overflow: TextOverflow.visible,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
