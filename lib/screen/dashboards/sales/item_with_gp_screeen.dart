import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:glowrpt/model/other/CatSectionM.dart';
import 'package:glowrpt/model/sale/ItemWithGpM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/item_details_screen.dart';
import 'package:glowrpt/screen/salestrends/section_cat_trends_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

import '../../salestrends/sales_trends_screen.dart';
import 'package:get/get.dart';

class ItemWithGpScreeen extends StatefulWidget {
  CatSectionM? item;
  String? type;
  int? id;
  List<String>? dateList;
  bool isSale;

  ItemWithGpScreeen(
      {this.item, this.type, this.id, this.dateList, this.isSale = true});

  @override
  _ItemWithGpScreeenState createState() => _ItemWithGpScreeenState();
}

class _ItemWithGpScreeenState extends State<ItemWithGpScreeen> {
  late CompanyRepository compRepo;

  @override
  void initState() {

    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${widget.item?.title}"),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SalesTrendsScreen(
                                isSale: widget.isSale,
                                selectedComp: compRepo.getSelectedUser(),
                                catId: widget.item?.id.toString(),
                              )));
                },
                child: Visibility(
                  visible: widget.type == "G",
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Sales Trend".tr,
                      style: TextStyle(
                          color: AppColor.notificationBackgroud,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                  ),
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          // Text("${widget.item.toJson()}"),
          Expanded(
            child: PagewiseListView<ItemWithGpM>(
              pageSize: 20,
              noItemsFoundBuilder: (_) => Text("No Details Found".tr),
              pageFuture: (pageIndex) => getItems(pageIndex! + 1),
              itemBuilder: (context, item, position) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemDetailsScreen(
                                    itemNo: item.Item_No.toString(),
                                    api_key: compRepo.getSelectedApiKey(),
                                  )));
                    },
                    title: Text(item.Item_Name??""),
                    subtitle:
                        Text(MyKey.currencyFromat(item.SalesAmount.toString())),
                    trailing:
                    item.GPPercent!=null?
                     Text("${item.GPPercent?.toStringAsFixed(0)}%"):Text("0%")
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  getItems(int pageNo) {
    if (widget.type == DocType.category) {
      if (widget.isSale) {
        return Serviece.catItems(
            context: context,
            api_key: compRepo.getSelectedApiKey(),
            FromDate: widget.dateList!.first,
            ToDate: widget.dateList!.last,
            pageNo: pageNo.toString(),
            id: widget.id!);
      } else {
        return Serviece.catItemsPr(
            context: context,
            api_key: compRepo.getSelectedApiKey(),
            FromDate: widget.dateList!.first,
            ToDate: widget.dateList!.last,
            pageNo: pageNo.toString(),
            id: widget.id!);
      }
    }
    if (widget.type == DocType.section) {
      if (widget.isSale) {
        return Serviece.secItems(
            context: context,
            api_key: compRepo.getSelectedApiKey(),
            FromDate: widget.dateList!.first,
            ToDate: widget.dateList!.last,
            pageNo: pageNo.toString(),
            id: widget.id!);
      } else {
        return Serviece.secItemsPr(
            context: context,
            api_key: compRepo.getSelectedApiKey(),
            FromDate: widget.dateList!.first,
            ToDate: widget.dateList!.last,
            pageNo: pageNo.toString(),
            id: widget.id!);
      }
    }
  }
}
