import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/transaction_details.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/other/flexible_widget.dart';
import 'package:glowrpt/widget/other/headder_item_widget.dart';
import 'package:glowrpt/widget/other/line_headder_widget.dart';
import 'package:glowrpt/widget/other/line_item_widget.dart';
import 'package:glowrpt/widget/other/loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/other/DocM.dart';
import '../model/other/User.dart';

class HeadderDetails extends StatefulWidget {
  List<String> dateListLine;
  User selectedItemRemoveMe;
  HeadderParm headderParm;
  bool showDetails;
  HeadderDetails({
    required this.dateListLine,
    required this.selectedItemRemoveMe,
    required this.headderParm,
    this.showDetails = false,
  });

  @override
  _HeadderDetailsState createState() => _HeadderDetailsState();
}

class _HeadderDetailsState extends State<HeadderDetails> {
  Map? dataSet;

  List? heaDerList;

  CompanyRepository? companyRepo;

  @override
  void initState() {
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
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
            if (widget.headderParm.isDateDipend!)
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
            if (heaDerList != null) ...[
              Expanded(
                child: ListView.builder(
                    itemCount: heaDerList!.length,
                    itemBuilder: (context, position) {
                      Map item = heaDerList![position];
                      return InkWell(
                        onTap: () {
                          if (widget.headderParm.endPont == "ACC") //account
                          {
                            print(widget.dateListLine);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransactionDetails(
                                          type: "A",
                                          id: item["CD"],
                                          apiKey:
                                              companyRepo!.getSelectedApiKey(),
                                          fromDate: widget.dateListLine.first,
                                          todate: widget.dateListLine.last,
                                          title: widget.headderParm.title
                                              .toString(),
                                          // RecNum: item.,
                                        )));
                          }
                        },
                        child: FlexibleWidget(
                          item: item,
                          headderParm: widget.headderParm,
                          position: position,
                        ),
                      );
                    }),
              ),
              getFooterWidget(textTheme)
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
    if (widget.headderParm.isDateDipend! && widget.dateListLine.length < 2)
      return;
    dataSet = await Serviece.getHomedocForHedder(
      context,
      companyRepo!.getSelectedApiKey(),
      widget.headderParm.isDateDipend! ? widget.dateListLine.first : "",
      widget.headderParm.isDateDipend! ? widget.dateListLine.last : "",
      widget.headderParm.endPont,
      1,
      "",
      type: widget.headderParm.type.toString(),
      params: widget.headderParm.params.toString(),
      // details: widget.showDetails ? "Y" : null,
      details: widget.showDetails ? "Y" : "",
    );
    if (dataSet != null) {
      heaDerList = dataSet![widget.headderParm.tableName];
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
      return heaDerList!
          .map((h) => h[key])
          .fold(0.0, (value, element) => value + element);
    } else {
      return "";
    }
  }

  getFooterWidget(TextTheme textTheme) {
    if (widget.headderParm.summationField == null ||
        widget.headderParm.summationField!.isEmpty) {
      return Container();
    }
    if (widget.headderParm.displayType == DisplayType.rowType) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: HedderItemWidget(
            headderParm: widget.headderParm,
            position: 0,
            isGrand: true,
            item: widget.headderParm.paramsOrder!.asMap().map((key, value) {
              return MapEntry(value,
                  getValue(key, value, widget.headderParm.summationField!));
            }),
          ),
        ),
      );
    } else {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: widget.headderParm.summationField!
                .map((e) =>
                    // int position=widget.summationFileld.indexOf(e);
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            "$e",
                            style: textTheme.subtitle1,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              MyKey.currencyFromat(heaDerList!
                                  .map((h) => h[e])
                                  .fold(0.0, (value, element) => value + element)
                                  .toString()),
                              style: textTheme.headline6,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        )
                      ],
                    ))
                .toList(),
          ),
        ),
      );
    }
  }
}
