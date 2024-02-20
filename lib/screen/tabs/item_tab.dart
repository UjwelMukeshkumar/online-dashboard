import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/ItemLedgerM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/model/other/LedgerHeadderM.dart';
import 'package:glowrpt/model/other/LedgerM.dart';
import 'package:glowrpt/screen/item/ItemCreateScreen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import '../item_list_screen.dart';
import '../item_transaction_details.dart';

class ItemTabs extends StatefulWidget {
  String type;
  String? value;
  String? title;

  ItemTabs({
    required this.type,
    this.value,
    this.title,
  });

  @override
  _ItemTabsState createState() => _ItemTabsState();
}

class _ItemTabsState extends State<ItemTabs>
    with AutomaticKeepAliveClientMixin {
  CompanyRepository? companyRepo;

  List<ItemLedgerM> ledgersList = [];

  LedgerHeadderM? ledgerHeadder;

  List<ItemLedgerM>? fullList;

  String query = "";

  bool hasMoreData = true;
  int pageNo = 0;
  String? fromDate;

  String? todate;

  String? Stkval;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.value == null, //or serch will conflict
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (text) async {
                    print("One submit");
                    query = text.toLowerCase();
                    pageNo = 0;
                    ledgersList.clear();
                    hasMoreData = true;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      labelText: "Search",
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColor.title,
                      ),
                      suffixIcon: widget.type == "I"
                          ? InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ItemCreateScreen(
                                            title: widget.title,
                                            type: widget.type)));
                                return;
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                padding: EdgeInsets.symmetric(horizontal: 18),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: AppColor.title,
                                    ),
                                    SizedBox(width: 2, height: 10),
                                    Text(
                                      "Create ${widget.title}",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35))),
                              ),
                            )
                          : null),
                )),
              ],
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoadMore(
            onLoadMore: () async {
              pageNo++;
              var bool = await getLedgers();
              print("page No  ************************************************ "
                  "$pageNo $bool");
              return bool == true;
            },
            isFinish: !hasMoreData,
            textBuilder: (statue) {
              if (statue == LoadMoreStatus.loading) {
                return "Please wait";
              } else if (statue == LoadMoreStatus.nomore) {
                return "No More items";
              } else if (statue == LoadMoreStatus.fail) {
                return "Failed";
              } else if (statue == LoadMoreStatus.idle) {
                return "Ideal";
              }
              return "";
            },
            child: ListView.separated(
                separatorBuilder: (_, __) => Divider(),
                itemCount: (ledgersList.length > 20 && widget.type == "S")
                    ? 20
                    : ledgersList.length,
                itemBuilder: (context, postion) {
                  var item = ledgersList[postion];
                  var textTheme = Theme.of(context).textTheme;
                  return InkWell(
                    onTap: () {
                      if (widget.type == "I" || widget.type == "C") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemTransactionDetails(
                                      // type: widget.type,
                                      id: item.itemId(),
                                      apiKey:
                                          companyRepo!.getSelectedUser().apiKey,
                                      // fromDate: fromDate,
                                      // todate: todate,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemListScreen(
                                      title: item.title(),
                                      type: widget.type,
                                      id: item.itemId().toString(),
                                      apiKey:
                                          companyRepo!.getSelectedUser().apiKey,
                                    ),),);
                      }
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title(),
                                  style: textTheme.subtitle1?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              Text(
                                item.Onhand.toString(),
                                style: textTheme.subtitle2?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: item.getColorOnhand()),
                              ),
                              if (widget.type == "I" || widget.type == "C") ...[
                                SizedBox(width: 5),
                                Text(
                                  item.UOM.toString(),
                                  style: textTheme.subtitle2?.copyWith(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ]
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.itemId().toString(),
                                  style: textTheme.bodySmall
                                      ?.copyWith(fontSize: 10)),
                              SizedBox(width: 20),
                              Text(
                                MyKey.currencyFromat(item.StockValue.toString(),
                                    decimmalPlace: 0),
                                style: textTheme.titleMedium?.copyWith(
                                    color: item.getColor(), fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        )),
      ],
    );
  }

  Future<bool> getLedgers() async {
    var dateFormater = DateFormat("dd/MM/yyyy");
    var date = DateTime.now();
    var monthBigin = date.subtract(Duration(days: date.day - 1));
    fromDate = dateFormater.format(monthBigin);
    todate = dateFormater.format(date);

    var data = await Serviece.getItemLedger(
        context: context,
        api_key: companyRepo!.getSelectedUser().apiKey,
        type: widget.type,
        fromDate: fromDate.toString(),
        toDate: todate.toString(),
        pageNo: pageNo.toString(),
        value: widget.value ?? query);
    hasMoreData = false;
    if (date == null) {
      print("Data is null");
      return false;
    }
    List lines = data["Details"];
    fullList = lines.map((e) {
      return ItemLedgerM.fromJson(e);
    }).toList();
    ledgersList.addAll(fullList!);
    print(fullList);
    hasMoreData = fullList!.length > 0;
    setState(() {});
    return hasMoreData;
  }

  getColor(LedgerM item) =>
      item.balance! < 0 ? AppColor.negativeRed : AppColor.positiveGreen;

  getColorOnhand(ItemLedgerM item) =>
      item.Onhand! < 0 ? AppColor.negativeRed : AppColor.positiveGreen;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
