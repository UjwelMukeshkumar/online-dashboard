import 'package:flutter/material.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';

import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:glowrpt/model/item/InvoiceM.dart';
import 'package:glowrpt/model/party/PartyGroupM.dart';
import 'package:glowrpt/model/sale/SalesItemM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

import 'item_bill_list_screen.dart';

class SalesItemBySupplierScreen extends StatefulWidget {
  List<String> dataList;
  PartyGroupM item;

  SalesItemBySupplierScreen({
   required this.dataList,
   required this.item,
  });

  @override
  State<SalesItemBySupplierScreen> createState() =>
      _SalesItemBySupplierScreenState();
}

class _SalesItemBySupplierScreenState extends State<SalesItemBySupplierScreen> {
   CompanyRepository? compRepo;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
      ),
      body: PagewiseListView<SalesItemM>(
        pageSize: 20,
        noItemsFoundBuilder: (_) => Text("No Details Fount"),
        pageFuture: (pageIndex) => getItems(pageIndex! + 1),
        itemBuilder: (context, item, position) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ItemBillListScreen(
                    item: widget.item,
                    dataList: widget.dataList,
                    isSupplier: true,
                  );
                }));
              },
              title: Text(item.Item_Name),
              subtitle: Text(MyKey.currencyFromat(item.SalesAmount.toString())),
              trailing: Text(item.Quantity.toString()),
            ),
          );
        },
      ),
    );
  }

  Future<List<SalesItemM>> getItems(int i) async {
    return await Serviece.getSalesItemBySupplier(
      context: context,
      api_key: compRepo!.getSelectedApiKey(),
      apiPageNumber: i,
      FromDate: widget.dataList.first,
      ToDate: widget.dataList.last,
      partyCode: widget.item.getId,
    );
  }
}
