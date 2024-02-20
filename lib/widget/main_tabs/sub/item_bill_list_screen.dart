import 'package:flutter/material.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart'
//
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:glowrpt/model/item/InvoiceM.dart';
import 'package:glowrpt/model/party/PartyGroupM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/sales_documents_screen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

class ItemBillListScreen extends StatefulWidget {
  List<String> dataList;
  PartyGroupM item;
  bool isSupplier;

  ItemBillListScreen({
   required this.dataList,
   required this.item,
   required this.isSupplier,
  });

  @override
  State<ItemBillListScreen> createState() => _ItemBillListScreenState();
}

class _ItemBillListScreenState extends State<ItemBillListScreen> {
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
        title: Text(widget.isSupplier ? "Items" : "Bills"),
      ),
      body: PagewiseListView<InvoiceM>(
        pageSize: 20,
        noItemsFoundBuilder: (_) => Text("No Details Fount"),
        pageFuture: (pageIndex) => getItems(pageIndex! + 1),
        itemBuilder: (context, item, position) {
          return Card(
            child: ListTile(
              onTap: () {
                if (!widget.isSupplier) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SalesDocumentsScreen(
                                type: item.Type,
                                RecNum: item.RecNum.toString(),
                                InitNo: item.InitNo.toString(),
                                Sequence: item.Sequence.toString(),
                              )));
                }
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemDetailsScreen(
                        itemNo: item.Item_No,
                        api_key: compRepo.getSelectedApiKey(),
                      )));*/
              },
              title: Text(item.Document ?? ""),
              subtitle: Text(MyKey.currencyFromat(item.SalesAmount.toString())),
              trailing: Text(item.GP.toString() + "%"),
            ),
          );
        },
      ),
    );
  }

  Future<List<InvoiceM>> getItems(int i) async {
    return await Serviece.getCustomerInvoiceDetails(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        apiPageNumber: i,
        FromDate: widget.dataList.first,
        ToDate: widget.dataList.last,
        partyCode: widget.item.getId,
        isSupplier: widget.isSupplier);
  }
}
