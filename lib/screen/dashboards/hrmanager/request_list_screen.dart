import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/manager/RequestsM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/request_widget.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class RequestListWidget extends StatefulWidget {
  @override
  State<RequestListWidget> createState() => _RequestListWidgetState();
}

class _RequestListWidgetState extends State<RequestListWidget> {
   CompanyRepository? compRepo;

  List<RequestsM> requestList = [];

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Requests".tr,
              style: textTheme.headline6,
            ),
          ),
          Visibility(
            visible: requestList.length > 0,
            child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: requestList.length,
                itemBuilder: (context, position) {
                  var item = requestList[position];
                  // return Cntain(
                  //   item: item,
                  //   onTap: () {
                  //     loadList();
                  //   },
                  // );
                }),
            replacement: Card(
              color: AppColor.cardBackground,
              child: ListTile(
                title: Text("You don't have any pending request".tr),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadList() async {
    requestList = await Serviece.getRequestList(
        context: context, api_key: compRepo!.getSelectedApiKey());
    setState(() {});
  }
}
