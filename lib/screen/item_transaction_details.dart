import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/item/Header.dart';
import 'package:glowrpt/model/item/Lines.dart';
import 'package:glowrpt/model/item/Quantity.dart';
import 'package:glowrpt/model/transaction/StoreM.dart';
import 'package:glowrpt/print/PdfServiece.dart';
import 'package:glowrpt/screen/item/ItemCreateScreen.dart';
import 'package:glowrpt/screen/sales_documents_screen.dart';
import 'package:glowrpt/service/DateService.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/other/headder_card.dart';
import 'package:glowrpt/widget/other/key_val_col.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../model/DocumentSplitter.dart';
import 'item_details_screen.dart';
import 'package:get/get.dart';

class ItemTransactionDetails extends StatefulWidget {
  String apiKey;
  String id;
  String storeId;

  ItemTransactionDetails({
    required this.apiKey,
    required this.id,
    this.storeId = "",
  });

  @override
  _ItemTransactionDetailsState createState() => _ItemTransactionDetailsState();
}

class _ItemTransactionDetailsState extends State<ItemTransactionDetails>
    with SingleTickerProviderStateMixin {
  List<Lines> detailsList = [];

  bool isLoading = false;

  String qyery = "";

  List<Lines>? fullList;

  Quantity? quantity;

  Header? headder;
  var list = ["Ask Details"];
  String? _selected;

  String? fromDate;
  var tabController;

  String? todate;
  List<String> defalutDateListCurrentMonth =
      DateService.getDefaultDateOfCurrentMonth();

  List<StoreM>? sotoreList;

  @override
  void initState() {
    super.initState();
    _selected = list.first;
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    getTransaction();
  }

  @override
  Widget build(BuildContext context) {
    bool selecteIndicatorColor = false;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 16),
            // height: 200,
            color: AppColor.background,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppBar(
                    leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Card(
                        elevation: 4,
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColor.title,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(44)),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          headder?.Item_Name ?? "",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          headder?.GrpName ?? "",
                          style: textTheme.caption,
                        ),
                      ],
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemDetailsScreen(
                                          itemNo: widget.id,
                                          api_key: widget.apiKey,
                                        )));
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            color: AppColor.vyaparIcon,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 90,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    HeadderCard(
                      title: "Purchase Quantity".tr,
                      amount: quantity?.PurchaseQuantity.toString() ?? "0",
                    ),
                    HeadderCard(
                      title: "Sales Quantity".tr,
                      amount: quantity?.SalesQuantity.toString() ?? "0",
                    ),
                    HeadderCard(
                      title: "Sales Return Quantity".tr,
                      amount: quantity?.SalesReturnQuantity.toString() ?? "0",
                    ),
                    HeadderCard(
                      title: "Purchase Return Quantity".tr,
                      amount:
                          quantity?.PurchaseReturnQuantity.toString() ?? "0",
                    ),
                    HeadderCard(
                      title: "Goods Receipt Quantity".tr,
                      amount: quantity?.GoodsReceiptQuantity.toString() ?? "0",
                    ),
                    HeadderCard(
                      title: "Goods Issue Quantity".tr,
                      amount: quantity?.GoodsIssueQuantity.toString() ?? "0",
                    ),
                  ]),
                ),
                Card(
                  elevation: 6,
                  child: ListTile(
                    //TODO : fixthis
                    title: Text("On Hand ${headder?.OnHand ?? ""}"),
                    subtitle: Text(
                        "Cost ${MyKey.currencyFromat(headder?.Cost.toString() ?? "0", decimmalPlace: 0)}"),
                    leading: Transform.rotate(
                        angle: -2.5,
                        child: Icon(
                          Icons.arrow_circle_up_outlined,
                          color: AppColor.positiveGreen,
                          size: 40,
                        )),
                    trailing: SizedBox(
                      width: 150,
                      child: DaysSelectorWidget(
                        valueChanged: (list) {
                          fromDate = list.first;
                          todate = list.last;
                          getTransaction();
                        },
                        intialText: "Select date".tr,
                        hideTriling: true,
                        dateTypes: DateService.dateTypesYearBased,
                      ),
                    ),
/*                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.notifications_on_outlined,
                              color: AppColor.vyaparIcon,
                            ),
                            Text(
                              "Reminder",
                              style: textTheme.caption,
                            )
                          ],
                        ),
                        PopupMenuButton(
                          padding: EdgeInsets.zero,
                          // initialValue: choices[_selection],
                          itemBuilder: (BuildContext context) {
                            return list.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                          onSelected: (item) {
                            _selected = item;
                          },
                        )
                        */ /*   IconButton(
                            onPressed: () {


                            }, icon: Icon(Icons.more_vert))*/ /*
                      ],
                    ),*/
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12, right: 12, left: 12),
            height: 65,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search Transactions".tr,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.black45)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.black45))),
              onChanged: (text) {
                qyery = text.toLowerCase();
                appLayFilter();
              },
            ),
          ),
          Expanded(
            child: !isLoading
                ? Column(
                    children: [
                      TabBar(
                          indicatorColor: Colors
                              .blue, // Color for the selected tab indicator
                          unselectedLabelColor:
                              Colors.grey, // Color for unselected tabs
                           labelColor: Colors.blue, //
                           unselectedLabelStyle: TextStyle(color: Colors.grey),
                        indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                          controller: tabController,
                          tabs: ["Transaction".tr, "By Store".tr]
                              .map((e) => Tab(
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          color: Colors.blue.shade700),
                                    ),
                                  ))
                              .toList()),
                      Expanded(
                          child: TabBarView(
                        controller: tabController,
                        children: [
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: detailsList.length,
                              // separatorBuilder: (_, __) => Divider(),
                              itemBuilder: (context, postion) {
                                var item = detailsList[postion];
                                if (item.Transaction == "Opening Balance" &&
                                    item.Quantity == 0) {
                                  return Container();
                                }
                                return InkWell(
                                  onTap: () async {
                                    var document = DocumentSplitter(
                                        document: item.Transaction);
                                    if (item.Transaction == "Opening Balance" ||
                                        item.Transaction ==
                                            "Future Transactions") {
                                      Toast.show("Extracting ");
                                      List<Lines> list = await Serviece
                                          .getInventoryOpeningBalance(
                                              context: context,
                                              api_key: widget.apiKey,
                                              fromDate: item.TransactionDate,
                                              itemNo: widget.id);
                                      fullList?.remove(item);
                                      fullList?.insertAll(postion, list);
                                      appLayFilter();
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SalesDocumentsScreen(
                                                    type: item.Source_Type
                                                        .toString(),
                                                    Sequence: document.sequence
                                                        .split(" ")
                                                        .last,
                                                    InitNo: document.initNumber,
                                                    RecNum: document.recNo,
                                                    slNo: item.SI_No ?? 0,
                                                  )));
                                    }
                                  },
                                  child: Card(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    // color: AppColor.chartBacground,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Align(
                                                child: Text(
                                                  "${DateFormat("dd MMM yy").format(DateFormat("dd/MM/yyyy").parse(item.TransactionDate))}",
                                                  style: textTheme.caption,
                                                ),
                                                alignment: Alignment.topRight,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                      child: Text(
                                                          item.PartyName ??
                                                              "")),
                                                  Text("${item.StrName}",
                                                      style: textTheme.caption),
                                                ],
                                              ),
                                              SizedBox(height: 6),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Visibility(
                                                    child: Text(
                                                        "Qty: ${item.Quantity.toString()}",
                                                        style:
                                                            textTheme.caption),
                                                    visible: !(postion == 0 &&
                                                        item.Quantity == 0),
                                                  ),
                                                  Text(
                                                    "Stock ${item.RunningTotal.toString()}",
                                                    style: textTheme.caption,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "${item.Transaction}"),
                                                      SizedBox(height: 4),
                                                      Text(
                                                          "Price: ${MyKey.currencyFromat(item.Price.toString(), decimmalPlace: 0)}")
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons.print,
                                                            color:
                                                                Colors.black45,
                                                          )),
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons.share,
                                                            color:
                                                                Colors.black45,
                                                          )),
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.more_vert,
                                                          color: Colors.black45,
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8,
                                                                right: 0),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          ListView.builder(
                              itemCount: sotoreList?.length,
                              itemBuilder: (context, position) {
                                var item = sotoreList?[position];
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ItemTransactionDetails(
                                                  id: widget.id,
                                                  apiKey: widget.apiKey,
                                                  storeId:
                                                      item!.Str_Id.toString(),
                                                )));
                                  },
                                  title: Text(item!.StrName.toString()),
                                  trailing: Text(item.Quantity.toString()),
                                  subtitle: Text(item.Str_Id.toString()),
                                );
                              })
                        ],
                      )),
                    ],
                  )
                : Center(
                    child: CupertinoActivityIndicator(),
                  ),
          )
        ],
      ),
    );
  }

  Future<void> getTransaction() async {
    setState(() {
      isLoading = true;
    });
    var data = await Serviece.getInventoryPostList(
        context: context,
        api_key: widget.apiKey,
        fromDate: fromDate ?? defalutDateListCurrentMonth.first,
        toDate: todate ?? defalutDateListCurrentMonth.last,
        itemNo: widget.id,
        storeCode: widget.storeId);
    isLoading = false;
    // hedder = THeadderM.fromJson(data["Header"][0]);
    List details = data["Lines"];
    print("detailss:*****************$details");
    fullList = details.map((e) => Lines.fromJson(e)).toList();

    List byStore = data["ByStore"];
    sotoreList = byStore.map((e) => StoreM.fromJson(e)).toList();

    List quantity = data["Quantity"];
    this.quantity = Quantity.fromJson(quantity.first);

    List headder = data["Header"];
    this.headder = Header.fromJson(headder.first);

    appLayFilter();
  }

  void appLayFilter() {
    detailsList.clear();
    if (qyery.isEmpty) {
      detailsList.addAll(fullList!);
    } else {
      detailsList.addAll(fullList!.where(
          (element) => element.toString().toLowerCase().contains(qyery)));
    }
    setState(() {});
  }
}
