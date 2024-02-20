import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/BalanceM.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'flexible_widget.dart';

class WhatChangedSince extends StatefulWidget {
  @override
  _WhatChangedSinceState createState() => _WhatChangedSinceState();
}

class _WhatChangedSinceState extends State<WhatChangedSince> {
  BalanceM? balanceM;
  int count = 1;
  var dateFormater = DateFormat("dd/MM/yyyy");
  User? localSelecteduser;
  List<String> durations = [
    "Yesterday",
    "Last Week",
    "Last Month",
    "Last Year"
  ];

  String? selectedDuration;
  CompanyRepository? compRepo;
  String? startDate;
  String? endDate;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    compRepo = Provider.of<CompanyRepository>(context);

    selectedDuration = durations.first;
    updateLines();
  }

  @override
  void didUpdateWidget(covariant WhatChangedSince oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("trigger wchc didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var divider = Divider(height: 8);
    return AppCard(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "What changed since",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedDuration,
              items: durations
                  .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e),
                        ),
                        value: e,
                      ))
                  .toList(),
              onChanged: (valeu) {
                setState(() {
                  selectedDuration = valeu!;
                  updateLines();
                });
              },
            ),
          ),
          if (balanceM != null && balanceM!.Details.isNotEmpty) ...[
            Row(
              children: [
                Expanded(child: Text("")),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Amount",
                      textAlign: TextAlign.end, style: textTheme.subtitle2),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Change",
                      textAlign: TextAlign.end, style: textTheme.subtitle2),
                )),
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: balanceM?.Details.length,
                itemBuilder: (context, position) {
                  var item = balanceM?.Details[position];
                  return InkWell(
                    onTap: () {
                      openDatailScreenAny(
                          context: context,
                          dateListLine: [startDate!, endDate!],
                          headderParm: HeadderParm(
                              endPont: "ACC",
                              tableName: "Details",
                              displayType: DisplayType.rowType,
                              title: "${item?.Name} Account",
                              type: item?.Name,
                              isDateDipend: false,
                              paramsOrder: [
                                "NE",
                                "BL"
                              ],
                              dataType: [
                                DataType.textType,
                                DataType.numberNonCurrenncy0
                              ],
                              paramsFlex: [
                                2,
                                1
                              ]),
                          selectedUserRemoveMe: compRepo?.getSelectedUser());
                    },
                    child: FlexibleWidget(
                      position: position,
                      item: item!.toJson(),
                      headderParm: HeadderParm(
                          displayType: DisplayType.rowType,
                          paramsOrder: [
                            // "EmployeeID",
                            "Name",
                            "Total",
                            "Change"
                          ],
                          dataType: [
                            DataType.textType,
                            DataType.numberType0,
                            DataType.numberType0,
                          ],
                          paramsFlex: [
                            1,
                            1,
                            1
                          ]),
                    ),
                  );
                }),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total",
                    style: textTheme.subtitle2,
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "${MyKey.currencyFromat(balanceM?.Details.map((e) => (e.Total ?? 0)).fold(0.0, (previousValue, element) => previousValue + element).toString(), decimmalPlace: 0)}",
                      textAlign: TextAlign.end,
                      style: textTheme.subtitle2),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "${MyKey.currencyFromat(balanceM?.Details.map((e) => (e.Change ?? 0)).fold(0.0, (previousValue, element) => previousValue + (element ?? 0)).toString(), decimmalPlace: 0)}",
                      textAlign: TextAlign.end,
                      style: textTheme.subtitle2),
                )),
              ],
            ),
          ]
        ],
      ),
    );
  }

  Future<void> updateLines() async {
    var date = DateTime.now();

    switch (selectedDuration) {
      case "Yesterday":
        startDate = dateFormater.format(date.add(Duration(days: -1)));
        endDate = dateFormater.format(date.add(Duration(days: -1)));
        break;
      case "Last Week":
        startDate = dateFormater
            .format(date.add(Duration(days: -(date.weekday - 1) - 7)));
        endDate = dateFormater
            .format(date.add(Duration(days: -(date.weekday - 1) - 1)));
        break;
      case "Last Month":
        var prevMonthLastDay = date.subtract(Duration(days: date.day));
        startDate = dateFormater.format(prevMonthLastDay
            .subtract(Duration(days: prevMonthLastDay.day - 1)));
        endDate = dateFormater.format(prevMonthLastDay);
        break;
      case "Last Year":
        var now = DateTime.now();
        var minus = 0;
        if (now.month <= 3) {
          minus = 1;
        }
        var end = DateTime(DateTime.now().year - minus, 3, 31);
        var bigning = DateTime(DateTime.now().year - (minus + 1), 4, 1);
        startDate = dateFormater.format(bigning);
        endDate = dateFormater.format(end);
        break;
    }
    print("Start date $startDate");
    print("End date $endDate");
    // return;
    var dataSet = await Serviece.getWhatChangedSince(context,
        compRepo!.getSelectedApiKey(), selectedDuration!, startDate!, endDate!);
    if (dataSet != null) {
      balanceM = BalanceM.fromJson(dataSet);
      if (mounted) setState(() {});
    }
  }
}
