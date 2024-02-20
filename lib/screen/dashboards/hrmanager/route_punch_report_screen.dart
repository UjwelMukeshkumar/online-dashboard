import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/library/AppSctring.dart';
import 'package:glowrpt/library/DateFactory.dart';
import 'package:glowrpt/model/hrm/RoutPunchM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/hrm/route_punch_widget.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:provider/provider.dart';

class RoutePunchReportScreen extends StatefulWidget {
  const RoutePunchReportScreen({ Key? key}) : super(key: key);

  @override
  State<RoutePunchReportScreen> createState() => _RoutePunchReportScreenState();
}

class _RoutePunchReportScreenState extends State<RoutePunchReportScreen> {
   CompanyRepository? compRepo;

  List<String> dateListLine = MyKey.getDefaultDateListAsToday();

   List<RoutPunchM>? routePunchList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Punch Report"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: DaysSelectorWidget(
              valueChanged: (list) {
                dateListLine = list;
                routePunchList!.clear();
                setState(() {});
                loadData();
              },
              intialText: dateListLine.last,
            ),
          ),
          Expanded(
            child: routePunchList != null
                ? SingleChildScrollView(
                  child: ListView.builder(
              shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: routePunchList!.length,
                      itemBuilder: (context, postion) {
                        var item = routePunchList![postion];
                        // return Text(item.EmpName);
                        return RoutePunchWidget(item);
                      }),
                )
                : Center(
                    child: CupertinoActivityIndicator(),
                  ),
          )
        ],
      ),
    );
  }

  Future<void> loadData() async {
    // compRepo.getSelectedUser()
    routePunchList = await Serviece.getRoutePunchReport(
      api_key: compRepo!.getSelectedApiKey(),
      context: context,
      fromDate: dateListLine.first,
      toDate: dateListLine.last,
    );
    setState(() {});
  }

  // isImageAvailable(String img) => img != null && img.length > 3;



}
