import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/screen/counter_closing_document_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/KeyValues.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';

import '../model/other/DocM.dart';
import '../model/other/User.dart';
import 'package:get/get.dart';

class CounterClosingScreen extends StatefulWidget {
  List<String> dateListLine;
  User selectedItem;
  HeadderParm headderParm;

  CounterClosingScreen({
  required  this.dateListLine,
  required  this.selectedItem,
   required this.headderParm,
  });

  @override
  _CounterClosingScreenState createState() => _CounterClosingScreenState();
}

class _CounterClosingScreenState extends State<CounterClosingScreen> {
  Map? dataSet;

  List? heaDerList;

  var total;

  @override
  void initState() {
    super.initState();
    updateLines();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.chartBacground,
      appBar: AppBar(
        title: Text("${widget.headderParm.title}"),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: DaysSelectorWidget(
                valueChanged: (list) {
                  widget.dateListLine = list;
                  updateLines();
                },
                intialText: widget.dateListLine[1],
              ),
            ),
            // LineHeadderWidget(widget.docM),
            if (heaDerList != null) ...[
              Expanded(
                child: ListView.builder(
                    itemCount: heaDerList!.length,
                    itemBuilder: (context, position) {
                      Map item = heaDerList![position];
                      Map itemCopy = Map();
                      itemCopy.addAll(item);
                      return ExpansionTile(
                        title: ListTile(
                          title: Text(item["User_Name"]),
                          trailing: Text(MyKey.currencyFromat(
                              item["Total"].toString(),
                              decimmalPlace: 0)),
                        ),
                        children: [
                          Card(
                            child: Column(
                              children: [
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: KeyValues(
                                        keys: "Cash Amount".tr,
                                        values: MyKey.currencyFromat(
                                            itemCopy["Cash Amount"].toString(),
                                            decimmalPlace: 0)),
                                  ),
                                  onTap: () {
                                    openCounterClosing("CS", item["User_Id"]);
                                  },
                                ),
                                Divider(height: 0),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: KeyValues(
                                      keys: "Card Amount".tr,
                                      values: MyKey.currencyFromat(
                                          itemCopy["Card Amount"].toString(),
                                          decimmalPlace: 0),
                                    ),
                                  ),
                                  onTap: () {
                                    openCounterClosing("CR", item["User_Id"]);
                                  },
                                ),
                                Divider(height: 0),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: KeyValues(
                                      keys: "Bank Amount".tr,
                                      values: MyKey.currencyFromat(
                                          itemCopy["Bank Amount"].toString(),
                                          decimmalPlace: 0),
                                    ),
                                  ),
                                  onTap: () {
                                    openCounterClosing("CB", item["User_Id"]);
                                  },
                                ),
                                Divider(height: 0),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: KeyValues(
                                      keys: "Cheque Amount".tr,
                                      values: MyKey.currencyFromat(
                                          itemCopy["Cheque Amount"].toString(),
                                          decimmalPlace: 0),
                                    ),
                                  ),
                                  onTap: () {
                                    openCounterClosing("CQ", item["User_Id"]);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              ),
              Card(
                child: ListTile(
                  title: Text("Total".tr),
                  trailing: Text(
                      "${MyKey.currencyFromat(total.toString(), decimmalPlace: 0)}"),
                ),
              )
            ] else
              Expanded(
                  child: Center(
                child: CupertinoActivityIndicator(),
                // child: LoaderWidget(),
              ))
          ],
        ),
      ),
    );
  }

  Future<void> updateLines() async {
    if (widget.dateListLine.length < 2) return;
    dataSet = await Serviece.getHomedocForHedder(
        context,
        widget.selectedItem.apiKey,
        widget.dateListLine.first,
        widget.dateListLine.last,
        widget.headderParm.endPont,
        1,
        "",
        type: widget.headderParm.type!);
    if (dataSet != null) {
      heaDerList = dataSet![widget.headderParm.tableName];
      var lines = dataSet!["Total"];
      if (lines != null && lines.length > 0) {
        total = lines[0]["Total"];
      }
    } else {
      heaDerList = [];
    }
    setState(() {});
  }

  getValue(int position, var key, List<String> summationField) {
    bool toCalculate = widget.headderParm.summationField!.contains(key);
    if (position == 0) {
      return "Total";
    } else if (toCalculate) {
      return "Null";
      /* return heaDerList
          .map((h) => h[key])
          .fold(0, (value, element) => value + element);*/
    } else {
      return "";
    }
  }

  void openCounterClosing(String type, var userId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CounterClosingDocumentScreen(
                  type: type,
                  fromDate: widget.dateListLine.first,
                  toDate: widget.dateListLine.last,
                  userId: userId.toString(),
                )));
  }
}
