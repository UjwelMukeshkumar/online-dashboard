import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/LiquidityScoreM.dart';
import 'package:glowrpt/model/other/TransactionM.dart';
import 'dart:math';

import 'package:glowrpt/util/Constants.dart';

class BarChartCash extends StatefulWidget {
  LiquidityScoreM liqudityScore;

  BarChartCash({required this.liqudityScore});

  @override
  State<StatefulWidget> createState() => BarChartCashState();
}

class BarChartCashState extends State<BarChartCash> {
  List<TransactionM>? cashList;
  late double yAxisHiegt;

  @override
  void initState() {
    super.initState();
    cashList = widget.liqudityScore.cash;
    double largeNumber = cashList!
        .map((e) => e.getValue)
        .fold(0, (value, element) => element > value ? element : value);
    yAxisHiegt =
        pow(10, largeNumber.toString().split(".").first.length - 1).toDouble() *
            (int.parse(largeNumber.toString().substring(0, 1)) + 1);
    print("yAxisHiegt $yAxisHiegt");
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Under Progress"),);
    /*return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        margin: EdgeInsets.zero,
        color: AppColor.chartBacground,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Cash at end of month',
                    style: Theme.of(context).textTheme.caption),
              ),
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: yAxisHiegt,
                  barTouchData: BarTouchData(
                    enabled: false,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipPadding: const EdgeInsets.all(0),
                      tooltipMargin: 8,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.y.round().toString(),
                          TextStyle(
                              color: Colors.transparent,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              letterSpacing: -1,),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      rotateAngle: -30,
                      reservedSize: 30,
                      getTextStyles: (context, value) => const TextStyle(
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      margin: 20,
                      getTitles: (double value) {
                        int number = value.toInt();
                        return cashList[number].mMonth.substring(0, 3);
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (context, value) => const TextStyle(
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      interval: yAxisHiegt / 5,
                      margin: 15,
                      reservedSize: 40,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: widget.liqudityScore.cash
                      .asMap()
                      .map((k, v) {
                        var nV = BarChartGroupData(
                          x: k,
                          barRods: [
                            BarChartRodData(
                                y: v.getValue,
                                width: 12,
                                // colors: [AppColor.barColor],
                                colors: v.getValue > 0
                                    ? [AppColor.barColor]
                                    : [Colors.red],
                                borderRadius: BorderRadius.all(Radius.zero)),
                          ],
                          // barsSpace: 50,
                          showingTooltipIndicators: [0],
                        );
                        return MapEntry(k, nV);
                      })
                      .values
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
