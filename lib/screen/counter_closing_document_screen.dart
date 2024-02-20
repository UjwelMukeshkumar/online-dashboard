import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/CounterM.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class CounterClosingDocumentScreen extends StatefulWidget {
  String type;
  String userId;
  String fromDate;
  String toDate;

  CounterClosingDocumentScreen({
  required  this.type,
   required this.userId,
   required this.fromDate,
   required this.toDate,
  });

  @override
  _CounterClosingDocumentScreenState createState() =>
      _CounterClosingDocumentScreenState();
}

class _CounterClosingDocumentScreenState
    extends State<CounterClosingDocumentScreen> {
   CompanyRepository? companyRepo;

  List<CounterM> list = [];

  @override
  void initState() {
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Closing Document".tr),
      ),
      body: Column(
        children: list
            .map((e) => ListTile(
                  onTap: () {
                    openDatailScreenAny(
                        context: context,
                        dateListLine: [widget.fromDate, widget.toDate],
                        showDetails: true,
                        headderParm: HeadderParm(
                            title: "Details",
                            endPont: "CounterClosing",
                            params: "&UserId=${widget.userId}",
                            type: e.Type,
                            // summationField: ["Amount", "Balance"],
                            // displayType: DisplayType.rowType,
                            paramsOrder: ["PartyName", "Amount", "Balance"],
                            tableName: "Details",
                            dataType: [
                              DataType.textType,
                              DataType.numberType,
                              DataType.numberType,
                            ],
                            paramsFlex: [2, 2, 2]));
                  },
                  title: Text("${e.Txt}"),
                  trailing: Text(MyKey.currencyFromat(e.amount.toString(),
                      decimmalPlace: 0)),
                ))
            .toList(),
      ),
    );
  }

  Future<void> loadData() async {
    list = await Serviece.CounterClosing(
        api_key: companyRepo!.getSelectedApiKey(),
        context: context,
        type: widget.type,
        userId: widget.userId.toString(),
        fromdate: widget.fromDate,
        today: widget.toDate);
    setState(() {});
  }
}
