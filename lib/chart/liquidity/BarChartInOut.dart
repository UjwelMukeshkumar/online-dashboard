import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/LiquidityScoreM.dart';
import 'package:glowrpt/model/other/TransactionM.dart';
import 'dart:math';

import 'package:glowrpt/util/Constants.dart';

class BarChartInOut extends StatefulWidget {
  LiquidityScoreM liqudityScore;

  BarChartInOut({required this.liqudityScore});

  @override
  State<StatefulWidget> createState() => BarChartInOutState();
}

class BarChartInOutState extends State<BarChartInOut> {
  List<TransactionM>? payable;
  List<TransactionM>? recievable;
  late double yAxisHiegt;

  @override
  void initState() {
    super.initState();
    payable = widget.liqudityScore.accountPayable;
    recievable = widget.liqudityScore.accountReceviable;
    double largeNumber = payable
        !.followedBy(recievable!)
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
   /* return AspectRatio(
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
                child: Text('AR TURNOVER VS AP TURNOVER',
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
                              letterSpacing: -1),
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
                        return payable[number].mMonth.substring(0, 3);
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
                  barGroups: payable
                      .asMap()
                      .map((k, pitem) {
                        var ritem =
                            TransactionM(amount: 0, mMonth: "", total: 0);
                        if (recievable.length >= (k + 1)) {
                          ritem = recievable[k];
                        }
                        var nV = BarChartGroupData(
                          x: k,
                          barRods: [
                            BarChartRodData(
                                y: pitem.getValue,
                                width: 8,
                                colors: [AppColor.greenDark],
                                borderRadius: BorderRadius.all(Radius.zero)),
                            BarChartRodData(
                                y: ritem.getValue,
                                width: 8,
                                colors: [AppColor.greenLigt],
                                borderRadius: BorderRadius.all(Radius.zero)),
                          ],
                          barsSpace: 8,
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
