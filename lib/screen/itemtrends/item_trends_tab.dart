import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/chart/cat_section_chart.dart';
import 'package:glowrpt/model/item/ItemTrendsM.dart';
import 'package:glowrpt/model/trend/CatSecTrendM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ItemTrendsTab extends StatefulWidget {
  bool? isCategory;
  String? urlPart;
  int? index;
  bool? isSale;
  String? fromDate;
  String? toDate;

  ItemTrendsTab(this.index, this.isSale, {this.isCategory});

  @override
  _ItemTrendsTabState createState() => _ItemTrendsTabState();
}

class _ItemTrendsTabState extends State<ItemTrendsTab> {
  CompanyRepository? companyRepo;

  CatSecTrendM? catSectionM;
  List<ItemTrendsM> heaDerList = [];
  bool hasMoreData = true;
  int pageNo = 0;
  Map? totalMap;
  Map? dataSet;

  @override
  void initState() {
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return LoadMore(
      isFinish: !hasMoreData,
      onLoadMore: () async {
        pageNo++;
        var bool = await updateLines();
        return bool;
      },
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
      child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: heaDerList.length,
          itemBuilder: (context, position) {
            var item = heaDerList[position];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Card(
                margin: EdgeInsets.all(8),
                // color: AppColor.background,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                item.Item_Name,
                                style: textTheme.subtitle1,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Text(
                            "MRP ${MyKey.currencyFromat(item.MRP.toString(), decimmalPlace: 0)}",
                            style: textTheme.caption,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ListTile(
                            title: Text(
                              "Amount".tr,
                              style: textTheme.caption,
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  MyKey.currencyFromat(
                                      item.SalesAmount.toString(),
                                      decimmalPlace: 0),
                                  style: textTheme.headline6,
                                ),
                                Text(
                                  "GP ${item.GP}",
                                  style: textTheme.caption,
                                ),
                              ],
                            ),
                          )),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.black12,
                          ),
                          Expanded(
                              child: ListTile(
                            title:
                                Text("Quantity".tr, style: textTheme.caption),
                            subtitle: Text("${item.Quantity}",
                                style: textTheme.headline6),
                          )),
                        ],
                      ),
                      /*         Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16),
                            child: RichText(
                                text: TextSpan(
                                    text:
                                        "${item.SalesAmount} has contributed ",
                                    style: textTheme.caption,
                                    children: [
                                  TextSpan(
                                    text: "${item.MRP}% ",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: "of total sale")
                                ])),
                          ), */
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<bool> updateLines() async {
    if (!mounted) return false;

    dataSet = await Serviece.getItemSalesTrend(
      context: context,
      apiKey: companyRepo!.getSelectedApiKey(),
      fromDate: getData(widget.index!),
      toDate: MyKey.getCurrentDate(),
      pageNumber: pageNo,
      isSale: widget.isSale!,
    );

    if (mounted) {
      if (dataSet != null) {
        List dataList = dataSet?["List"];
        try {
          totalMap = dataSet?["PageNO"][0];
        } catch (e) {
          print(e);
        }
        hasMoreData = dataList.length > 0;
        heaDerList
            .addAll(dataList.map((e) => ItemTrendsM.fromJson(e)).toList());
      }
      if (mounted) {
        setState(() {});
      }
    }
    return hasMoreData;

    // dataSet = await Serviece.getItemSalesTrend(
    //     context: context,
    //     apiKey: companyRepo!.getSelectedApiKey(),
    //     fromDate: getData(widget.index!),
    //     toDate: MyKey.getCurrentDate(),
    //     pageNumber: pageNo,
    //     isSale: widget.isSale!);
    // if (dataSet != null) {
    //   List dataList = dataSet?["List"];
    //   try {
    //     totalMap = dataSet?["PageNo"][0];
    //   } catch (e) {
    //     // totalMap=0;
    //     print(e);
    //   }

    //   hasMoreData = dataList.length > 0;
    //   heaDerList.addAll(dataList.map((e) => ItemTrendsM.fromJson(e)).toList());
    // }
    // setState(() {});
    // return hasMoreData;
  }
}
