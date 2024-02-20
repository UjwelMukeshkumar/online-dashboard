import 'package:flutter/material.dart';
import 'package:glowrpt/model/item/ItemTopM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/other/bottom_sheet.dart';
import 'package:glowrpt/widget/other/caroser_slider_widget.dart';
import 'package:glowrpt/widget/main_tabs/category_list_widget.dart';
import 'package:glowrpt/widget/item/horizontal_item_list/horizontal_item_list_widget.dart';
import 'package:glowrpt/widget/main_tabs/item_sale_report_widget.dart';
import 'package:glowrpt/widget/other/ledger_buttons.dart';
import 'package:glowrpt/widget/manager/total_branch_details_widget.dart';
import 'package:glowrpt/widget/main_tabs/sales_purchase_widget.dart';
import 'package:glowrpt/widget/main_tabs/section_list_widget.dart';
import 'package:provider/provider.dart';

import '../ItemLedgerScreen.dart';
import '../doc_approve_paginated.dart';
import 'package:get/get.dart';

class PurchaseDashBoards extends StatefulWidget {
  @override
  _PurchaseDashBoardsState createState() => _PurchaseDashBoardsState();
}

class _PurchaseDashBoardsState extends State<PurchaseDashBoards>
    with SingleTickerProviderStateMixin {
  var tabController;
  List<String> tabs = ["Purchase", "Category", "Section", "Item Purchase"];

   CompanyRepository? compRepo;

  List<ItemTopM>? itemList;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadItems();
    tabController =
        TabController(length: tabs.length, initialIndex: 0, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TotalBranchDetailsWidget(),
      DocApprovePaginated(
        DocType: DocType.purchase,
        title: "Approve Purchase",
      ),
      DocApprovePaginated(
        DocType: DocType.purchaseOrder,
        title: "Approve Purchase Order",
      ),
        DocApprovePaginated(
        DocType: DocType.purchaseReturn,
        title: "Approve Purchase Return",
      ),
      LedgerButtons(),
      MyBottomSheet(
        "Suppliers",
        isBottomSheet: false,
      ),
      CaroserSliderWidget(),
      HorizontalItemListWidget(
        isSale: false,
        title: "Top purchasing items",
      ),
      AppCard(
        child: Column(
          children: [
            TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.black.withOpacity(0.3),
                labelColor: Colors.red,
                indicatorColor: Colors.white,
                controller: tabController,
                labelPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                tabs: tabs.map((e) {
                  return TabChild(
                    tabController: tabController,
                    title: e,
                    postion: tabs.indexOf(e),
                    color: AppColor.notificationBackgroud,
                  );
                }).toList()),
            SizedBox(
              height: MediaQuery.of(context).size.height * .65,
              child: Container(
                // color: Colors.red,
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    SalesPurchaseWidget(false),
                    CategoryListWidget(false), //Yesterday
                    SectionListWidget(false), //last 7 day
                    IitemSaleReportWidget(false),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }

  Future<void> loadItems() async {
    itemList = await Serviece.topsellingPurchasingItems(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        isSale: false,
        fromdate: MyKey.getCurrentDate(),
        todate: MyKey.getCurrentDate());
    setState(() {});
  }
}
