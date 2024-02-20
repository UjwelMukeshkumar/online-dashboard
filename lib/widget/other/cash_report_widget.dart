import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/SettingsManagerRepository.dart';
import 'package:glowrpt/screen/counter_closing.dart';
import 'package:glowrpt/screen/hedder_details.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:provider/provider.dart';

import 'grid_tile_row_widget.dart';
import 'grid_tile_widget.dart';
import 'package:get/get.dart';

class CashReportWidget extends StatefulWidget {
  User selectedItem;
  List<String> dateListLine;

  CashReportWidget({required this.selectedItem,required this.dateListLine});

  @override
  _CashReportWidgetState createState() => _CashReportWidgetState();
}

class _CashReportWidgetState extends State<CashReportWidget> {
   SettingsManagerRepository? setting;

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    setting = Provider.of<SettingsManagerRepository>(context);
  }

  // 5. Supplier payments
  // 6. Expense payments
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var itemList = getWidget(textTheme);
    return Visibility(
      visible: (setting!.CashandBank ||
          setting!.CounterClosing ||
          setting!.Receivable ||
          setting!.Payable ||
          setting!.Accountpayments ||
          setting!.Payments),
      child: AppCard(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Cash Report".tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: itemList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 3),
                itemBuilder: (context, postion) {
                  return Row(
                    children: [
                      if (postion.isOdd)
                        VerticalDivider(
                          width: 0,
                          indent: 8,
                          endIndent: 8,
                        ),
                      Expanded(child: itemList[postion])
                    ],
                  );
                }),
            SizedBox(height: 32)
          ],
        ),
      ),
    );
  }

  getWidget(TextTheme textTheme) {
    return [
      if (setting!.CashandBank)
        GridTileRowWidget(
          title: "Cash and Bank".tr,
          widget: Image.asset(
            "assets/icons/cash_bank.png",
            // color: AppColor.title,
          ),
          onTap: () {
            var headderParm = HeadderParm(
                title: "Cash and Bank".tr,
                type: "CB",
                summationField: ["Balance"],
                displayType: DisplayType.rowType,
                paramsOrder: ["Account", "Balance"],
                dataType: [DataType.textType, DataType.numberType],
                paramsFlex: [3, 2]);
            openDatailScreenAny(
                context: context,
                dateListLine: widget.dateListLine,
                headderParm: headderParm,
                selectedUserRemoveMe: widget.selectedItem);
          },
        ),
      if (setting!.CounterClosing)
        GridTileRowWidget(
          title: "Counter Closing".tr,
          widget: Image.asset("assets/icons/cash_counter.png"),
          subIconData: Icons.closed_caption_rounded,
          onTap: () {
            var headderParm = HeadderParm(
                title: "Counter Closing".tr,
                type: "CC",
                summationField: ["Total", "CashAmount", "Diffrence"],
                displayType: DisplayType.gridType,
                paramsOrder: ["User_Name", "Total", "CashAmount", "Diffrence"],
                dataType: [
                  DataType.textType,
                  DataType.numberType0,
                  DataType.numberType0,
                  DataType.numberType0
                ],
                paramsFlex: [5, 4, 4, 3]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CounterClosingScreen(
                          dateListLine: widget.dateListLine,
                          selectedItem: widget.selectedItem,
                          headderParm: headderParm,
                        )));
          },
        ),
      if (setting!.Receivable)
        GridTileRowWidget(
          title: "Receivable".tr,
          // subIconData: Icons.keyboard_return,
          widget: Image.asset(
            "assets/icons/recievable.png",
            color: AppColor.title,
          ),
          onTap: () {
            var headderParm = HeadderParm(
                isPaginated: true,
                title: "Receivable",
                type: "Rc",
                summationField: ["Total_Balance_Due"],
                displayType: DisplayType.gridType);
            openDatailScreenAny(
                context: context,
                dateListLine: widget.dateListLine,
                headderParm: headderParm,
                selectedUserRemoveMe: widget.selectedItem);
          },
        ),
      if (setting!.Payable)
        GridTileRowWidget(
          title: "Payable".tr,
          widget: Image.asset(
            "assets/icons/payable.png",
            color: AppColor.title,
          ),
          onTap: () {
            var headderParm = HeadderParm(
                title: "Payable",
                isPaginated: true,
                type: "PY",
                paramsFlex: [1, 2, 3],
                dataType: [
                  DataType.textType,
                  DataType.numberType,
                  DataType.percentType
                ],
                summationField: ["Total_Balance_Due"],
                displayType: DisplayType.gridType);
            openDatailScreenAny(
                context: context,
                dateListLine: widget.dateListLine,
                headderParm: headderParm,
                selectedUserRemoveMe: widget.selectedItem);
          },
        ),
      if (setting!.Accountpayments)
        GridTileRowWidget(
          title: "Account payments".tr,
          widget: Image.asset("assets/icons/payable.png"),
          subWidget: Icon(
            Icons.account_balance,
            size: 14,
            color: AppColor.notificationBackgroud,
          ),
          onTap: () {
            var headderParm = HeadderParm(
                isPaginated: true,
                title: "Account payments",
                type: "PA",
                displayType: DisplayType.gridType,
                // endPont: "TBPL",
                tableName: "Header");
            openDatailScreenAny(
                context: context,
                dateListLine: widget.dateListLine,
                headderParm: headderParm,
                selectedUserRemoveMe: widget.selectedItem);
          },
        ),
      if (setting!.Payments)
        GridTileRowWidget(
          title: "Payments".tr,
          widget: Image.asset("assets/icons/payable.png"),
          subWidget: Icon(
            Icons.playlist_add_check_sharp,
            size: 14,
            color: AppColor.notificationBackgroud,
          ),
          onTap: () {
            var headderParm = HeadderParm(
                isPaginated: true,
                title: "Payments",
                type: "OP",
                displayType: DisplayType.gridType,
                // endPont: "TBPL",
                tableName: "Lines");
            openDatailScreenAny(
                context: context,
                dateListLine: widget.dateListLine,
                headderParm: headderParm,
                selectedUserRemoveMe: widget.selectedItem);
          },
        ),
      if (setting!.Accountreceipts)
        GridTileRowWidget(
          title: "Account Receipts".tr,
          widget: Image.asset("assets/icons/recievable.png"),
          subWidget: Icon(Icons.account_balance,
              size: 14, color: AppColor.notificationBackgroud),
          onTap: () {
            var headderParm = HeadderParm(
                isPaginated: true,
                title: "Account receipts",
                type: "RA",
                displayType: DisplayType.gridType,
                // endPont: "TBPL",
                tableName: "Header");
            openDatailScreenAny(
                context: context,
                dateListLine: widget.dateListLine,
                headderParm: headderParm,
                selectedUserRemoveMe: widget.selectedItem);
          },
        ),
      if (setting!.Receipts)
        GridTileRowWidget(
          title: "Receipts".tr,
          widget: Image.asset("assets/icons/recievable.png"),
          subWidget: Icon(Icons.playlist_add_check_sharp,
              size: 14, color: AppColor.notificationBackgroud),
          onTap: () {
            var headderParm = HeadderParm(
                isPaginated: true,
                title: "Receipts",
                type: "IP",
                displayType: DisplayType.gridType,
                // endPont: "TBPL",
                tableName: "Lines");
            openDatailScreenAny(
                context: context,
                dateListLine: widget.dateListLine,
                headderParm: headderParm,
                selectedUserRemoveMe: widget.selectedItem);
          },
        ),
    ];
  }
}
