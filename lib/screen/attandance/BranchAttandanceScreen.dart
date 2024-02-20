import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/AnalaticsM.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/model/attandace/AttandanceBranchM.dart';
import 'package:glowrpt/model/attandace/AttandanceM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/flexible_widget.dart';

import 'department_attandance_screen.dart';
import 'package:get/get.dart';

class BranchAttandanceScreen extends StatefulWidget {
  String apiKeys;
  String fromDate;
  String todate;
  HeadderParm headderParm;

  BranchAttandanceScreen({
   required this.apiKeys,
   required this.fromDate,
   required this.todate,
   required this.headderParm,
  });

  @override
  _BranchAttandanceScreenState createState() => _BranchAttandanceScreenState();
}

class _BranchAttandanceScreenState extends State<BranchAttandanceScreen> {
   List? attandanceList;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.headderParm.title}"),
        ),
        body: attandanceList != null
            ? ListView.builder(
                itemCount: attandanceList?.length,
                itemBuilder: (context, postion) {
                  var item =
                      AttandanceBranchM.fromJson(attandanceList?[postion]);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DepartmentAttandanceScreen(
                                    item: item,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Card(
                        margin: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(item.Branch),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(4),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text("Present ${item.CmpPresent}".tr,
                                              style: textTheme.caption),
                                          Text(
                                            (item.Present ?? "").toString(),
                                            style: textTheme.headline6,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(4),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Absent ${item.CmpAbsent}".tr,
                                            style: textTheme.caption,
                                          ),
                                          Text((item.Absent ?? "").toString(),
                                              // "GP ${data?.gp}%",
                                              style: textTheme.headline6),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Center(
                child: CupertinoActivityIndicator(),
              ));
  }

  Future<void> loadDetails() async {
    attandanceList = await Serviece.getBranchBrsg(
        context: context,
        arryApiKey: widget.apiKeys,
        fromDate: widget.fromDate,
        toDate: widget.todate,
        DtRange: widget.headderParm.dateRange!,
        endPont: widget.headderParm.endPont);
    setState(() {});
  }
}
