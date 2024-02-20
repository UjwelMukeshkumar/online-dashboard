import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/attandance/view_attendance_widget.dart';
import 'package:glowrpt/screen/dashboards/sales/stock_movement_report_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/other/attandance_widget.dart';
import 'package:glowrpt/widget/other/bottom_sheet.dart';
import 'package:glowrpt/widget/other/caroser_slider_widget.dart';
import 'package:glowrpt/widget/other/cash_report_widget.dart';
import 'package:glowrpt/widget/main_tabs/brand_list_widget.dart';
import 'package:glowrpt/widget/main_tabs/category_list_widget.dart';
import 'package:glowrpt/widget/main_tabs/item_sale_report_widget.dart';
import 'package:glowrpt/widget/other/ledger_buttons.dart';
import 'package:glowrpt/widget/other/list_tile_button.dart';
import 'package:glowrpt/widget/hrm/hrm_menu.dart';
import 'package:glowrpt/widget/main_tabs/taxcode_list_widget.dart';
import 'package:glowrpt/widget/manager/tab_wise_report_widget.dart';
import 'package:glowrpt/widget/manager/total_branch_details_widget.dart';
import 'package:glowrpt/widget/main_tabs/party_groups_widget.dart';
import 'package:glowrpt/widget/other/read_your_business_widget.dart';
import 'package:glowrpt/widget/other/recievable_payable_cash_widget.dart';
import 'package:glowrpt/widget/main_tabs/sales_purchase_widget.dart';
import 'package:glowrpt/widget/main_tabs/section_list_widget.dart';
import 'package:provider/provider.dart';

import '../ItemLedgerScreen.dart';
import '../company_manager_screen.dart';
import '../route/routes_screen_orderable.dart';
import '../route/select_route_screen1.dart';
import 'package:get/get.dart';

class ManagerDashBoardWidget extends StatefulWidget {
  @override
  State<ManagerDashBoardWidget> createState() => _ManagerDashBoardWidgetState();
}

class _ManagerDashBoardWidgetState extends State<ManagerDashBoardWidget> {
  CompanyRepository? companyRep;
  List<User> usersList = [];
  User? _selectedItem;
  List<String>? dateListLine;
  String? arryApiKey;

  @override
  void initState() {
    
    super.initState();
    companyRep = Provider.of<CompanyRepository>(context, listen: false);
    usersList = companyRep!.getAllUser();
    _selectedItem = usersList.firstWhere(
        (element) => element.identity == companyRep!.getSelectedUser().identity);
    dateListLine = MyKey.getDefaultDateListAsToday();
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 36);
    var space8 = SizedBox(height: 8);
    return Container(
      child: Column(
        children: [
          TotalBranchDetailsWidget(),

          Visibility(
            visible: ((usersList?.length ?? 0) > 1 && false),
            child: AppCard(
              child: Column(
                children: [
                  Container(
                    // color: AppColor.background,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Container(
                        color: Colors.white,
                        child: DropdownButton<User>(
                          isExpanded: true,
                          value: _selectedItem,
                          underline: Container(),
                          elevation: 12,
                          itemHeight: 75,
                          items: usersList
                              .map<DropdownMenuItem<User>>(
                                  (e) => DropdownMenuItem<User>(
                                        child: Container(
                                          // padding: EdgeInsets.all(22),
                                          child: ListTile(
                                            title: Text(e.organisation ?? ""),
                                            contentPadding: EdgeInsets.all(8),
                                            horizontalTitleGap: 0,
                                            subtitle: Text(e.username ?? ""),
                                            leading: Container(
                                                height: double.infinity,
                                                child: Icon(
                                                  Icons.account_balance,
                                                  color: AppColor.title,
                                                )),
                                          ),
                                        ),
                                        value: e,
                                      ))
                              .toList(),
                          onChanged: (item) {
                            setState(() {
                              _selectedItem = item;
                              companyRep!.updateSelectedUser(_selectedItem!);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          TabWiseReportWidget(),
          LedgerButtons(),
          ViewAttendanceWidget(),
          // space8,
          CaroserSliderWidget(),
          RecievablePayableCashWidget(),
          ListTileButton(
              title: "Stock Movement".tr,
              icon: CupertinoIcons.chart_bar_square,
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StockMovementReportScreen()));
              }),
          // space,
          // if (_selectedItem != null) SectionListWidget(true),
          CashReportWidget(
              selectedItem: _selectedItem!, dateListLine: dateListLine!),
          ListTileButton(
              title: "Routes".tr,
              icon: Icons.route,
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectRouteScreen1()));
              }),
          if (_selectedItem != null) AttandanceWidget(_selectedItem!),
          ReadYourBusinessWidget(
            selectedItem: _selectedItem!,
            dateListLine: dateListLine!,
          ),
          MyBottomSheet(
            "",
            isBottomSheet: false,
          ),
          ListTileButton(
              title: "Manage Company".tr,
              icon: CupertinoIcons.rectangle_stack_fill_badge_minus,
              onTap: manageCompany),
        ],
      ),
    );
  }

  Future<void> manageCompany() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CompanyManagerScreen()));
    usersList = companyRep!.getAllUser();
    arryApiKey = usersList.map((e) => e.apiKey).join(",");
    _selectedItem = usersList.firstWhere(
        (element) => element.identity == companyRep!.getSelectedUser().identity);
  }
}
