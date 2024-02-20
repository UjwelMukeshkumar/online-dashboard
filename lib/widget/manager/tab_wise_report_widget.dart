import 'package:flutter/material.dart';
import 'package:glowrpt/screen/ItemLedgerScreen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/widget/main_tabs/brand_list_widget.dart';
import 'package:glowrpt/widget/main_tabs/category_list_widget.dart';
import 'package:glowrpt/widget/main_tabs/item_sale_report_widget.dart';
import 'package:glowrpt/widget/main_tabs/party_groups_widget.dart';
import 'package:glowrpt/widget/main_tabs/sales_purchase_widget.dart';
import 'package:glowrpt/widget/main_tabs/section_list_widget.dart';
import 'package:glowrpt/widget/main_tabs/taxcode_list_widget.dart';

import '../other/app_card.dart';
import 'package:get/get.dart';

class TabWiseReportWidget extends StatefulWidget {
  @override
  State<TabWiseReportWidget> createState() => _TabWiseReportWidgetState();
}

class _TabWiseReportWidgetState extends State<TabWiseReportWidget>
    with SingleTickerProviderStateMixin {
  var tabController;
  List<String> tabs = [
    "Bills".tr,
    "Category".tr,
    "Section".tr,
    "Item".tr,
    "Customer".tr,
    "Customer Group".tr,
    "Supplier".tr,
    "Supplier Group".tr,
    "Brand".tr,
    "TaxCode".tr
  ];
  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: tabs.length, initialIndex: 0, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
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
          // "Customer","Customer Group","Supplier","Supplier Group"
          SizedBox(
            height: MediaQuery.of(context).size.height * .55,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                SalesPurchaseWidget(true),
                CategoryListWidget(true),
                SectionListWidget(true),
                IitemSaleReportWidget(true),
                PartyGroupsWidget(
                  isSupplier: false,
                  isGroups: false,
                ),
                PartyGroupsWidget(
                  isSupplier: false,
                  isGroups: true,
                ),
                PartyGroupsWidget(
                  isSupplier: true,
                  isGroups: false,
                ),
                PartyGroupsWidget(
                  isSupplier: true,
                  isGroups: true,
                ),
                BrandListWidget(true),
                TaxcodeListWidget(true)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
