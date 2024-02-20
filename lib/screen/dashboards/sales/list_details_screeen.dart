import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:glowrpt/model/sale/ItemLstM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ListDetailsScreen extends StatefulWidget {
  String? type;
  String? title;

  ListDetailsScreen({this.type, this.title});

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  late CompanyRepository compRepo;

  List<ItemLstM>? dataList;

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    // loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} Details".tr),
      ),
      body: PagewiseListView<ItemLstM>(
        noItemsFoundBuilder: (_) => Text("No Details Found".tr),
        pageFuture: (pageNo) => Serviece.getListDetails(
            context: context,
            api_key: compRepo.getSelectedApiKey(),
            PageNumber: (pageNo! + 1).toString(),
            type: widget.type!),
        pageSize: 20,
        itemBuilder: (context, item, position) {
          return Card(
            color: AppColor.cardBackground,
            margin: EdgeInsets.all(4),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                title: Text(item.Item_Name),
                trailing: Text(item.triling.toString()),
                leading: Text(item.leading.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
