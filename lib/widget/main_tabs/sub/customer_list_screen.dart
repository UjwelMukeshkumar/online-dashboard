import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:glowrpt/model/party/PartyGroupM.dart';
import 'package:glowrpt/model/sale/ItemLstM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/main_tabs/party_groups_widget.dart';
import 'package:glowrpt/widget/main_tabs/sub/sales_item_by_supplier_screen.dart';
import 'package:glowrpt/widget/other/party_group_item.dart';
import 'package:provider/provider.dart';

import 'item_bill_list_screen.dart';

class CustomerListScreen extends StatefulWidget {
  List<String> dateListLine;
  PartyGroupM partyGroupM;
  bool isSupplier;

  CustomerListScreen({
  required  this.dateListLine,
  required  this.partyGroupM,
  required  this.isSupplier,
  });

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
 CompanyRepository? compRepo;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // settings = Provider.of<SettingsManagerRepository>(context);
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    // if (dateListLine == null) dateListLine = MyKey.getDefaultDateListAsToday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSupplier ? "Supplier" : "Customer"),
      ),
      body: PagewiseListView<PartyGroupM>(
        noItemsFoundBuilder: (_) => Text("No Details Fount"),
        pageFuture: (pageNo) => loadPages(pageNo!),
        pageSize: 20,
        itemBuilder: (context, item, position) {
          return InkWell(
            onTap: () {
              if (widget.isSupplier) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SalesItemBySupplierScreen(
                      item: item, dataList: widget.dateListLine);
                }));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ItemBillListScreen(
                      item: item,
                      dataList: widget.dateListLine,
                      isSupplier: widget.isSupplier);
                }));
              }
            },
            child: PartyGroupItem(
              position: position,
              item: item,
              // type: DocType.section,
              apiKey: compRepo!.getSelectedApiKey(),
            ),
          );
        },
      ),
    );
  }

  Future<List<PartyGroupM>> loadPages(int pageNo) async {
    var response = await Serviece.getParyGroups(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        apiPageNumber: pageNo + 1,
        FromDate: widget.dateListLine.first,
        ToDate: widget.dateListLine.last,
        CVtype: widget.isSupplier ? "S" : "C",
        isGroup: false,
        CVGroup: widget.partyGroupM.getId.toString());
    return List<PartyGroupM>.from(
        response["List"].map((e) => PartyGroupM.fromJson(e)));
  }
}
