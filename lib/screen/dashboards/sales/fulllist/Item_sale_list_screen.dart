import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:glowrpt/model/item/ItemSaleReportM.dart';
import 'package:glowrpt/model/other/CatSectionM.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/cat_section_item.dart';
import 'package:glowrpt/widget/other/flexible_widget.dart';
import 'package:glowrpt/widget/other/line_item_widget.dart';
import 'package:provider/provider.dart';

import '../item_with_gp_screeen.dart';
import 'package:get/get.dart';

class ItemSaleListScreen extends StatefulWidget {
  bool? isSale;
  List<String>? dateListLine;

  ItemSaleListScreen({this.isSale, this.dateListLine});

  @override
  State<ItemSaleListScreen> createState() => _ItemSaleListScreenState();
}

class _ItemSaleListScreenState extends State<ItemSaleListScreen> {
  late CompanyRepository compRepo;

  // List<String> dateListLine;
  List<ItemSaleReportM>? linesList;
  DocM? docM;

  int pageSize = 100;

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    // dateListLine = MyKey.getDefaultDateListAsToday();
    //loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Sales".tr),
      ),
      body: PagewiseListView<ItemSaleReportM>(
          pageSize: pageSize,
          noItemsFoundBuilder: (_) => Text("No Details Found".tr),
          pageFuture: (pageNo) => loadData(pageNo! + 1),
          itemBuilder: (context, item, position) {
            return FlexibleWidget(
              item: item.toJson(),
              position: position,
              headderParm: HeadderParm(
                  displayType: DisplayType.rowType,
                  paramsFlex: [
                    8,
                    1,
                    2
                  ],
                  dataType: [
                    DataType.textType,
                    DataType.numberNonCurrenncy0,
                    DataType.numberType0
                  ],
                  paramsOrder: [
                    "Item_Name",
                    "Quantity",
                    "SalesAmount"
                  ]),
            );
          }),
    );
  }

  Future<List<ItemSaleReportM>> loadData(int pageNo) async {
    var data = await Serviece.getItemSalesReport(
        context,
        compRepo.getSelectedApiKey(),
        widget.dateListLine!.first,
        widget.dateListLine!.last,
        pageNo,
        widget.isSale!,
        IsPageing: "Y",
        pageSize: pageSize);

    var lise = List<ItemSaleReportM>.from(
        data["List"].map((x) => ItemSaleReportM.fromJson(x)));
    return lise;
  }
}
