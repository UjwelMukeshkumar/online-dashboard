import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:glowrpt/model/item/ItemTopM.dart';
import 'package:glowrpt/model/other/GroupM.dart';
import 'package:glowrpt/model/sale/GroupSaleM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/doc_approve_paginated.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/other/cahched_img.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../other/tab_child.dart';

// ignore: must_be_immutable
class HorizontalItemListWidget extends StatefulWidget {
  String title;
  bool isSale;

  HorizontalItemListWidget({
    required this.isSale,
    required this.title,
  });

  @override
  State<HorizontalItemListWidget> createState() =>
      _HorizontalItemListWidgetState();
}

class _HorizontalItemListWidgetState extends State<HorizontalItemListWidget> {
  List<ItemTopM>? itemList;

  CompanyRepository? compRepo;

  List<GroupSaleM>? groups;

  int slectedPosition = 0;
  PagewiseLoadController<ItemTopM>? _pageLoadController;

  List<String>? dateList;

  @override
  void initState() {
    super.initState();
    dateList = MyKey.getDefaultDateListAsToday();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    _pageLoadController = PagewiseLoadController<ItemTopM>(
        pageSize: 20, pageFuture: (pageIndex) => loadItems(pageIndex!));
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          dateList!=null?
          DaysSelectorWidget(
            valueChanged: (date) {
              dateList = date;
              _pageLoadController!.reset();
            },
          ):Text("No data Found"),
          if (groups != null)
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: groups!.length,
                  itemBuilder: (context, position) {
                    var item = groups![position];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          slectedPosition = position;
                          _pageLoadController!.reset();
                        });
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TabChild(
                            title: item.Name,
                            postion: position,
                            selectedPosition: slectedPosition,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
      //  ElevatedButton(onPressed: () async {
      //       var dataList = await loadItems(0);
      //       dataList.forEach((element) {
      //         print(element.Item_Name);
      //       });
      //     }, child: Text("Testing")),
          SizedBox(
            height: 180,
            child: PagewiseListView<ItemTopM>(
                shrinkWrap: true,
                noItemsFoundBuilder: (_) => Text("No Details Fount".tr),
                scrollDirection: Axis.horizontal,
                pageLoadController: _pageLoadController,
                // pageSize: 20,
                // pageFuture: (pageIndex) => loadItems(pageIndex),
                itemBuilder: (context, entry, position) {
                  var item = entry;

                  return Card(
                    margin: EdgeInsets.all(4),
                    child: AspectRatio(
                      aspectRatio: .5,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: CachedImg(
                                  url: item.Image,
                                  itemName: item.Item_Name,
                        
                                ),
                              ),
                            ),
                          ),
                          Text(
                            item.Item_Name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "${item.Qty}",
                                  style: textTheme.subtitle2!
                                      .copyWith(fontSize: 12),
                                  children: [
                                    TextSpan(
                                        text: " Qty".tr,
                                        style: textTheme.caption),
                                    TextSpan(
                                        text:
                                            "  ${MyKey.currencyFromat(item.SalesAmount.toString(), sign: "")}"),
                                    TextSpan(
                                        text: " Rs", style: textTheme.caption),
                                  ]))
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<List<ItemTopM>> loadItems(int pageIndex) async {
    print("Load item called");
    // var result=await Serviece.soldCount(context: context,api_key: compRepo.getSelectedApiKey(),fromdate: MyKey.getCurrentDate(),todate: MyKey.getCurrentDate());
    var response = await Serviece.topsellingPurchasingItems(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        isSale: widget.isSale,
        fromdate: dateList!.first,
        todate: dateList!.last,
        pageNo: pageIndex + 1,
        GrpId: groups == null ? 0 : groups![slectedPosition].GrpId.toInt());
    List list = response["List"];
    List groupList = response["GroupList"];
    setState(() {
      groups = [];
      var list = groupList.map((e) => GroupSaleM.fromJson(e)).toList();
      groups!.add(GroupSaleM(GrpId: 0, Name: "All"));
      groups!.addAll(list);
    });
    return list.map((e) => ItemTopM.fromJson(e)).toList();
    // return itemList;
    // setState(() {});
  }
}
