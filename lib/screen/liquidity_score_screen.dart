import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/chart/liquidity/BarChartCash.dart';
import 'package:glowrpt/chart/liquidity/BarChartInOut.dart';
import 'package:glowrpt/chart/liquidity/BarChartTarget.dart';
import 'package:glowrpt/model/other/LiquidityScoreM.dart';
import 'package:glowrpt/model/other/RationM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/drw_arch_widget.dart';
import 'package:glowrpt/widget/other/loader_widget.dart';

import 'dart:async';
import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:speedometer/speedometer.dart';
import 'package:rxdart/rxdart.dart';

class LiquidityScoreScreen extends StatefulWidget {
  // DocM docM;
  List<String> dateListLine;
  User selectedItem;

  // String type;
  String title;

  LiquidityScoreScreen({
    required this.dateListLine,
    required this.title,
    required this.selectedItem,
  });

  @override
  _LiquidityScoreScreenState createState() => _LiquidityScoreScreenState();
}

class _LiquidityScoreScreenState extends State<LiquidityScoreScreen> {
  LiquidityScoreM? liqudityScore;

  @override
  void initState() {
    super.initState();
    print("Slected User ${widget.selectedItem.toJson()}");

    // String frmdate="03/06/2021";
    //  String todate="03/06/2021";
    Serviece.getLiquidityScore(context, widget.selectedItem.apiKey,
            widget.dateListLine.first, widget.dateListLine.last)
        .then((value) {
      setState(() {
        liqudityScore = value;
      });
    });
  }

  RationM? rationM;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    if (liqudityScore != null && liqudityScore!.ratios!.length > 0) {
      rationM = liqudityScore!.ratios!.first;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Liquidity Score"),
      ),
      // backgroundColor: Colors.amberAccent,
      backgroundColor: Colors.white,
      body: liqudityScore != null
          ? ListView(
              children: [
                ListTile(
                  title: Text(
                    "Working Capital",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.symmetric(vertical: 18),
                              color: AppColor.chartBacground,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    "QUICK RATION",
                                    style: textTheme.subtitle1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.info,
                                          color: AppColor.warning,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          rationM!.quickRatio.toString(),
                                          style: textTheme.headline6,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.symmetric(vertical: 18),
                              color: AppColor.chartBacground,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text("CURRENT RATIO",
                                      // "${liqudityScore.payable.first.total.toString()}",
                                      style: textTheme.subtitle1),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.check_circle,
                                          color: AppColor.greenDark,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          rationM!.currentRatio.toString(),
                                          style: textTheme.headline6,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          // height: double.infinity,
                          margin: EdgeInsets.only(top: 4, left: 2, bottom: 2),
                          // padding: EdgeInsets.symmetric(vertical: 18),
                          color: AppColor.chartBacground,
                          // alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("CASH BALANCE",
                                  // "${liqudityScore.payable.first.total.toString()}",
                                  style: textTheme.subtitle1),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  MyKey.currencyFromat(
                                      (rationM!.cashIn - rationM!.cashOut)
                                          .toString()),
                                  style: textTheme.headline6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "IN ${MyKey.currencyFromat(rationM!.cashIn.toString())}",
                                  style: textTheme.subtitle2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "OUT ${MyKey.currencyFromat(rationM!.cashOut.toString())}",
                                  style: textTheme.subtitle2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // SpedoMeterWidget(counter: 20,),
                Visibility(
                    visible: liqudityScore!.cash!.isNotEmpty,
                    child: BarChartCash(
                      liqudityScore: liqudityScore!,
                    )),
                ListTile(
                  title: Text(
                    "CASH CONVERSION",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: AppColor.chartBacground,
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(28),
                        child: Text(
                          "DAY SALES OUTSTANDING",
                          style: textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: DrawArchWidget(
                          readingPercent: rationM!.daySalesOutstanding,
                          text: "${rationM!.daySalesOutstanding}",
                          stroke: 20,
                          colorList: [
                            AppColor.greenLigt,
                            AppColor.green,
                            AppColor.greenDark
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      BarChartInOut(
                        liqudityScore: liqudityScore!,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 20,
                              width: 20,
                              color: AppColor.greenLigt,
                              margin: EdgeInsets.all(4)),
                          Text(
                            "Account Receivable Turnover",
                            style: textTheme.caption,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              height: 20,
                              width: 20,
                              color: AppColor.greenDark,
                              margin: EdgeInsets.all(4)),
                          Text(
                            "Account Payable Turnover",
                            style: textTheme.caption,
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                  color: AppColor.chartBacground,
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(28),
                        child: Text(
                          "DAY PAYABLE OUTSTANDING",
                          style: textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: DrawArchWidget(
                          readingPercent: rationM!.daysPayableOutstanding,
                          text: "${rationM!.daysPayableOutstanding}",
                          stroke: 20,
                          colorList: [
                            AppColor.redLigt,
                            AppColor.red,
                            AppColor.redDark
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      BarChartTarget(
                        liqudityScore: liqudityScore!,
                      )
                    ],
                  ),
                ),
                //
                // PieChartTest(),
                // BarChartSample2(),
                // BarChartSample1()
              ],
            )
          : LoaderWidget(),
    );
  }
}
// "Day_Sales_Outstanding": 9.209,
// "CurrentRatio": 0.000,
// "QuickRatio": 0.000,
// "CashIn": 185647114.051,
// "CashOut": 42725022.445
// "Days_Payable_Outstanding": -7.875,
