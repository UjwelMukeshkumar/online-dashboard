import 'package:flutter/material.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:glowrpt/model/DocumentSplitter.dart';
import 'package:glowrpt/model/sale/PendingBillsM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

import '../../sales_documents_screen.dart';
import 'package:get/get.dart';

class PendingBillsList extends StatefulWidget {
  String? code;

  PendingBillsList({this.code});

  @override
  State<PendingBillsList> createState() => _PendingBillsListState();
}

class _PendingBillsListState extends State<PendingBillsList> {
  late CompanyRepository compRepo;

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return PagewiseListView<PendingBillsM>(
        pageSize: 10,
        noItemsFoundBuilder: (_) => Text("No Details Found".tr),
        pageFuture: (index) => Serviece.getPendingBills(
            context: context,
            api_key: compRepo.getSelectedApiKey(),
            pageNo: (index! + 1).toString(),
            code: widget.code!),
        itemBuilder: (context, item, position) {
          String type = item.Document.split(" ").first;
          String doc = item.Document.split(" ").last;
          var document = DocumentSplitter(document: doc);
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SalesDocumentsScreen(
                              type: type,
                              Sequence: document.sequence,
                              InitNo: document.initNumber,
                              RecNum: document.recNo,
                            )));
              },
              title: Text(MyKey.currencyFromat(item.BalanceDue.toString())),
              subtitle: Text(item.PostDate),
              trailing: Text(item.Document),
            ),
          );
        });
  }
}
