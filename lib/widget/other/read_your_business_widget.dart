import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/DashBoardProvider.dart';
import 'package:glowrpt/repo/SettingsManagerRepository.dart';
import 'package:glowrpt/repo/SettingsPurchaseRepository.dart';
import 'package:glowrpt/repo/SettingsSalesRepository.dart';
import 'package:glowrpt/screen/cash_flow_details.dart';
import 'package:glowrpt/screen/details_screen.dart';
import 'package:glowrpt/screen/hedder_details.dart';
import 'package:glowrpt/screen/hedder_details_paginated.dart';
import 'package:glowrpt/screen/tbtl_details_screen.dart';
import 'package:glowrpt/screen/transaction/customer%20_ways_sales_report.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'grid_tile_widget.dart';

class ReadYourBusinessWidget extends StatefulWidget {
  // DocM docM;
  User selectedItem;
  List<String> dateListLine;

  ReadYourBusinessWidget(
      {required this.selectedItem, required this.dateListLine});

  @override
  _ReadYourBusinessWidgetState createState() => _ReadYourBusinessWidgetState();
}

class _ReadYourBusinessWidgetState extends State<ReadYourBusinessWidget>
    with AutomaticKeepAliveClientMixin {
  bool isExpand = false;

  SettingsManagerRepository? settingManager;
  SettingsSalesRepository? settingSales;

  SettingsPurchaseRepository? settingPurchase;

  DashBoardRepository? dashBoardRepo;
  DashBoardType? dashBordTypes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dashBoardRepo = Provider.of<DashBoardRepository>(context);
    settingManager = Provider.of<SettingsManagerRepository>(context);
    settingSales = Provider.of<SettingsSalesRepository>(context);
    settingPurchase = Provider.of<SettingsPurchaseRepository>(context);
    dashBordTypes = dashBoardRepo!.dashBoards;
  }

  @override
  Widget build(BuildContext context) {
    var itemList = getWidgetlist();
    return Visibility(
      /*   visible: (settingManager.Sales ||
          settingManager.SalesOrder ||
          settingManager.SalesReturn ||
          settingManager.Purchase ||
          settingManager.PurchaseOrder ||
          settingManager.PurchaseReturn ||
          settingManager.POS ||
          settingManager.POSOrder ||
          settingManager.POSReturn ||
          settingManager.Lossreport ||
          settingManager.CreditSale ||
          settingManager.ManualJournal ||
          settingManager.CategoryStock ||
          settingManager.DayBook ||
          settingManager.CashFlow ||
          settingManager.TrialBalance ||
          settingManager.ProfitAndLoss ||
          settingManager.Accountreceipts ||
          settingManager.Receipts),*/
      child: AppCard(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          // color: Color(0xfffafaff),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Read Your Business".tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: getItemCount(itemList.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, postion) {
                    // return Text("Position $postion");
                    if (!isExpand && postion == 5) {
                      return GridTileWidget(
                        title: "See More".tr,
                        widget: Icon(Icons.more_vert),
                        onTap: () {
                          setState(() {
                            isExpand = true;
                          });
                        },
                      );
                    }
                    return itemList[postion];
                  })
            ],
          ),
        ),
      ),
    );
  }

  void openDatailScreen(String s, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  dateListLine: widget.dateListLine,
                  selectedItem: widget.selectedItem,
                  type: s,
                  title: title,
                )));
  }

  void openDatailScreenAny(HeadderParm headderParm) {
    if (headderParm.isPaginated != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HeadderDetailsPaginated(
                    dateListLine: widget.dateListLine,
                    selectedUserRemoveMe: widget.selectedItem,
                    headderParm: headderParm,
                  )));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HeadderDetails(
                    dateListLine: widget.dateListLine,
                    selectedItemRemoveMe: widget.selectedItem,
                    headderParm: headderParm,
                  )));
    }
  }

  void openCashFlow(HeadderParm? headderParm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (headderParm != null) {
            return CashFlowDetails(
              dateListLine: widget.dateListLine,
              selectedItem: widget.selectedItem,
              headderParm: headderParm,
            );
          } else {
            return const CupertinoActivityIndicator();
          }
        },
      ),
    );
  }

  // void openCashFlow(HeadderParm? headderParm) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => headderParm != null
  //             ? CashFlowDetails(
  //                 dateListLine: widget.dateListLine,
  //                 selectedItem: widget.selectedItem,
  //                 headderParm: headderParm,
  //               )
  //             : const CupertinoActivityIndicator()),
  //   );
  // }

  void openTbTlScreen(HeadderParm headderParm) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TbtlDetailsScreen(
                  dateListLine: widget.dateListLine,
                  selectedItem: widget.selectedItem,
                  headderParm: headderParm,
                )));
  }

  void openCustomerWaysSalesReportScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CustomerWaysSalesReport(),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  List<Widget> getWidgetlist() {
    var sale = GridTileWidget(
      title: "Sales".tr,
      widget: Image.asset("assets/icons/sale.png"),
      onTap: () => openDatailScreen("SI", "Sales"),
    );
    var saledOrder = GridTileWidget(
      title: "Sales Order".tr,
      subIconData: Icons.list,
      widget: Image.asset("assets/icons/sale.png"),
      onTap: () => openDatailScreen("SO", "Sales Order"),
    );
    var salesReturn = GridTileWidget(
      title: "Sales Return".tr,
      subIconData: Icons.keyboard_return,
      widget: Image.asset("assets/icons/sale.png"),
      onTap: () => openDatailScreen("SR", "Sales Return"),
    );
    var purchase = GridTileWidget(
      title: "Purchase".tr,
      widget: Image.asset("assets/icons/purchase.png"),
      onTap: () => openDatailScreen("PI", "Purchase"),
    );
    var purchaseOrder = GridTileWidget(
      title: "Purchase Order".tr,
      subIconData: Icons.list,
      widget: Image.asset("assets/icons/purchase.png"),
      onTap: () => openDatailScreen("PO", "Purchase Order"),
    );
    var purchaseReturn = GridTileWidget(
      title: "Purchase Return".tr,
      subIconData: Icons.keyboard_return,
      widget: Image.asset("assets/icons/purchase.png"),
      onTap: () => openDatailScreen("PR", "Purchase Return"),
    );
    var pos = GridTileWidget(
      title: "POS".tr,
      widget: Image.asset("assets/icons/pos.png"),
      onTap: () => openDatailScreen("SP", "POS"),
    );
    var posOrder = GridTileWidget(
      title: "POS Order".tr,
      subIconData: Icons.list,
      widget: Image.asset("assets/icons/pos.png"),
      onTap: () => openDatailScreen("PS", "POS Order"),
    );
    var posReturn = GridTileWidget(
      title: "POS Return".tr,
      subIconData: Icons.keyboard_return,
      widget: Image.asset("assets/icons/pos.png"),
      onTap: () => openDatailScreen("RP", "POS Return"),
    );
    var lossRport = GridTileWidget(
      title: "Loss report".tr,
      widget: Image.asset("assets/icons/currency.png"),
      subWidget: Icon(
        Icons.download_outlined,
        color: AppColor.notificationBackgroud,
      ),
      onTap: () {
        var headderParm = HeadderParm(
            title: "Loss Report".tr,
            isPaginated: true,
            summationField: [],
            paramsOrder: [
              // "BillNo",
              "PartyName",
              "Barcode",
              "Item_Name",
              "Price",
              "Loss"
            ],
            endPont: "LSR",
            tableName: "List",
            dataType: [
              // DataType.textType,
              DataType.textType,
              DataType.textType,
              DataType.textType,
              DataType.numberNonCurrenncy0,
              DataType.percentType,
            ],
            paramsFlex: [12, 6, 14, 4, 6],
            displayType: DisplayType.rowType);
        openDatailScreenAny(headderParm);
      },
    );
    var credtSale = GridTileWidget(
      title: "Credit Sale".tr,
      widget: Image.asset("assets/icons/credit.png"),
      subWidget: Image.asset(
        'assets/icons/sale.png',
        color: AppColor.notificationBackgroud,
      ),
      onTap: () {
        var headderParm = HeadderParm(
            isPaginated: true,
            title: "Credit Sale".tr,
            type: "Cr",
            summationField: ["NetAmt", "CreditAmount"],
            displayType: DisplayType.gridType);
        openDatailScreenAny(headderParm);
      },
    );
    var manualJurnal = GridTileWidget(
      title: "Manual Journal".tr,
      widget: Image.asset("assets/icons/jurnal.png"),
      onTap: () {
        var headderParm = HeadderParm(
            title: "Manual Journal",
            type: "MJ",
            summationField: ["Amount"],
            isPaginated: true,
            paramsOrder: [
              "Time",
              "Particular",
              "Remarks",
              "Amount",
              "Cr/Dr",
              "Document"
            ],
            dataType: [
              DataType.textType,
              DataType.textType,
              DataType.textType,
              DataType.numberType0,
              DataType.textType,
              DataType.textType,
            ],
            paramsFlex: [4, 10, 10, 6, 3, 7],
            displayType: DisplayType.gridType);
        openDatailScreenAny(headderParm);
      },
    );
    var categoryStock = GridTileWidget(
      title: "Category Stock".tr,
      widget: Image.asset("assets/icons/category.png"),
      subWidget: Image.asset("assets/icons/stock.png"),
      onTap: () {
        var headderParm = HeadderParm(
            title: "Category Stock",
            type: "CS",
            summationField: ["StockValue"],
            displayType: DisplayType.rowType,
            paramsOrder: ["ItemGroup", "StockValue"],
            dataType: [DataType.textType, DataType.numberType],
            paramsFlex: [3, 2]);
        openDatailScreenAny(headderParm);
      },
    );
    var dayBook = GridTileWidget(
      title: "Day Book".tr,
      widget: Image.asset("assets/icons/day_book.png"),
      onTap: () {
        // return;
        var headderParm = HeadderParm(
            title: "Day Book",
            type: "DB",
            // summationField: ["Amount"],
            summationField: [],
            displayType: DisplayType.rowType,
            paramsOrder: ["Leadger", "Voucher", "Amount", "cr/dr"],
            dataType: [
              DataType.textType,
              DataType.textType,
              DataType.numberType,
              DataType.textType,
            ],
            paramsFlex: [5, 3, 5, 1]);
        openDatailScreenAny(headderParm);
      },
    );
    var cashFlow = GridTileWidget(
      title: "Cash Flow".tr,
      widget: Image.asset("assets/icons/flow.png"),
      subWidget: Image.asset(
        "assets/icons/cash.png",
        color: AppColor.notificationBackgroud,
      ),
      onTap: () {
        var headderParm = HeadderParm(
            title: "Cash Flow",
            type: "CF",
            summationField: [],
            paramsFlex: [7, 5],
            displayType: DisplayType.gridType);
        openCashFlow(headderParm);
      },
    );
    var trialBalance = GridTileWidget(
      title: "Trial Balance".tr,
      widget: Image.asset("assets/icons/trial_balance.png"),
      onTap: () {
        var headderParm = HeadderParm(
            title: "Trial Balance",
            type: "TB",
            endPont: "TBPL",
            tableName: "List");
        openTbTlScreen(headderParm);
      },
    );
    var profitAndLoss = GridTileWidget(
      title: "Profit & Loss".tr,
      widget: Image.asset("assets/icons/profit_lose.png"),
      onTap: () {
        var headderParm = HeadderParm(
            title: "Profit & Loss",
            endPont: "TBPL",
            type: "PL",
            tableName: "List");
        openTbTlScreen(headderParm);
      },
    );

    var customerWaysSalesReport = GridTileWidget(
      // widget: Icon(Icons.point_of_sale_sharp),
       widget: Image.asset("assets/icons/customer_ways_report.png"),
      title: "Sales Report".tr,
      onTap: () {
        openCustomerWaysSalesReportScreen();
      },
    );

    var isExpands = GridTileWidget(
      title: "Collapse".tr,
      widget: Icon(Icons.more_vert),
      onTap: () {
        setState(() {
          isExpand = false;
        });
      },
    );
    if (dashBordTypes == DashBoardType.MangerDashboard)
      return [
        if (settingManager!.Sales) sale,
        if (settingManager!.SalesOrder) saledOrder,
        if (settingManager!.SalesReturn) salesReturn,
        if (settingManager!.Purchase) purchase,
        if (settingManager!.PurchaseOrder) purchaseOrder,
        if (settingManager!.PurchaseReturn) purchaseReturn,
        if (settingManager!.POS) pos,
        if (settingManager!.POSOrder) posOrder,
        if (settingManager!.POSReturn) posReturn,
        if (settingManager!.Lossreport) lossRport,
        if (settingManager!.CreditSale) credtSale,
        if (settingManager!.ManualJournal) manualJurnal,
        if (settingManager!.CategoryStock) categoryStock,
        if (settingManager!.DayBook) dayBook,
        if (settingManager!.CashFlow) cashFlow,
        if (settingManager!.TrialBalance) trialBalance,
        if (settingManager!.ProfitAndLoss) profitAndLoss,
        if (settingManager!.CustomerWaysSalesReport) customerWaysSalesReport,
        if (isExpand) isExpands
      ];

    if (dashBordTypes == DashBoardType.SalesDashboard ||
        dashBordTypes == DashBoardType.PurchaseDashboard)
      return [
        if (settingManager!.Sales) sale,
        if (settingManager!.SalesOrder) saledOrder,
        if (settingManager!.SalesReturn) salesReturn,
        if (settingManager!.Purchase) purchase,
        if (settingManager!.PurchaseOrder) purchaseOrder,
        if (settingManager!.PurchaseReturn) purchaseReturn,
        if (settingManager!.POS) pos,
        if (settingManager!.POSOrder) posOrder,
        if (settingManager!.POSReturn) posReturn,
        if (settingManager!.Lossreport) lossRport,
        if (settingManager!.CreditSale) credtSale,
        if (isExpand) isExpands
      ];

    if (dashBordTypes == DashBoardType.AccountsDashboard)
      return [
        if (settingManager!.ManualJournal) manualJurnal,
        if (settingManager!.CategoryStock) categoryStock,
        if (settingManager!.DayBook) dayBook,
        if (settingManager!.CashFlow) cashFlow,
        if (settingManager!.TrialBalance) trialBalance,
        if (settingManager!.ProfitAndLoss) profitAndLoss,
        if (isExpand) isExpands
      ];
    return [];
  }

  int getItemCount(int length) {
    if (length <= 6 || isExpand) {
      return length;
    } else {
      return 6;
    }
  }
}
