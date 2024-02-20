import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/ReimpurseM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ReimbursementScreen extends StatefulWidget {
  @override
  _ReimbursementScreenState createState() => _ReimbursementScreenState();
}

class _ReimbursementScreenState extends State<ReimbursementScreen> {
  CompanyRepository? compRepo;

  List<ListBean>? reimpursList;

  List<String> dateListLine = MyKey.getDefaultDateListAsToday();

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity".tr),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              child: reimpursList == null
                  ? CupertinoActivityIndicator()
                  : DaysSelectorWidget(
                      valueChanged: (list) {
                        dateListLine = list;
                        setState(() {});
                        loadData();
                      },
                      intialText: dateListLine.last,
                    )),


          Expanded(
            child: reimpursList != null
                ? ListView.separated(
                    separatorBuilder: (_, __) => Divider(
                          thickness: 2,
                        ),
                    itemCount: reimpursList!.length,
                    itemBuilder: (context, index) {
                      var item = reimpursList![index];
                      return ListTile(
                        title: Text(item.Activity.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(item.Date),
                        trailing: SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(item.ApprovalLevel,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(height: 4),
                              Text(
                                item.Amount,
                                style: TextStyle(
                                    color: getColors(item.ApprovalLevel)),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: CupertinoActivityIndicator(),
                  ),
          )
        ],
      ),
    );
  }

  Future<void> loadData() async {
    // dateListLine.first
    // dateListLine.last
    var response = await Serviece.getReimbursment(
        context: context, api_key: compRepo!.getSelectedApiKey());
         
    //  print('Activity response is: ${response.Lists.length}');

    setState(() {
      reimpursList = response.Lists;
    });
  }

  Color getColors(String approvalLevel) {
    //TODO : fixthis
    switch (approvalLevel) {
      case "No Action Taken":
        return Colors.grey;
      case "HR Manager Rejected":
        return Colors.red;
      case "HR Manager Approved":
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
