import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/LiquidityScoreM.dart';
import 'package:glowrpt/model/other/TransactionHM.dart';
import 'package:glowrpt/model/other/TransactionM.dart';
import 'dart:math';

import 'package:glowrpt/util/Constants.dart';

class BarChartTarget extends StatefulWidget {
  LiquidityScoreM liqudityScore;

  BarChartTarget({required this.liqudityScore});

  @override
  State<StatefulWidget> createState() => BarChartTargetState();
}

class BarChartTargetState extends State<BarChartTarget> {
  List<TransactionM>? cashList;
 late double yAxisHiegt;

 late TransactionHm payable;

  @override
  void initState() {
    
    super.initState();
    payable = widget.liqudityScore.payable!.first;
    double largeNumber = payable.dueFor30Days.abs();

    yAxisHiegt =
        pow(10, largeNumber.toString().split(".").first.length - 1).toDouble() *
            (int.parse(largeNumber.toString().substring(0, 1)) + 1);
  }

  @override
  Widget build(BuildContext context) {
    double barWidth = 60;
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
                padding: const EdgeInsets.all(18.0),
                child: Text('ACCOUNTS PAYABLE BY PAYMENT TARGET',
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
                          "${(rod.y / 1000).round().toString()}k",
                          TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: -1),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      // rotateAngle: -30,
                      reservedSize: 20,
                      getTextStyles: (context, value) => const TextStyle(
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      margin: 10,
                      getTitles: (double value) {
                        int number = value.toInt();
                        switch (number) {
                          case 0:
                            return '<30 Days';
                            break;
                          case 1:
                            return '<60 Days';
                            break;
                          case 2:
                            return '<90 Days';
                            break;
                          case 3:
                            return '>90 Days';
                            break;
                          default:
                            throw Error();
                        }
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
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                            y: payable.dueFor30Days,
                            width: barWidth,
                            colors: [AppColor.red30],
                            borderRadius: BorderRadius.all(Radius.zero)),
                      ],
                      // barsSpace: 50,
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                            y: payable.dueFor60Days,
                            width: barWidth,
                            colors: [AppColor.red60],
                            borderRadius: BorderRadius.all(Radius.zero)),
                      ],
                      // barsSpace: 50,
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                            y: payable.dueFor90Days,
                            width: barWidth,
                            colors: [AppColor.red90],
                            borderRadius: BorderRadius.all(Radius.zero)),
                      ],
                      // barsSpace: 50,
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                            y: payable.dueFor90AboveDays,
                            width: barWidth,
                            colors: [AppColor.red91],
                            borderRadius: BorderRadius.all(Radius.zero)),
                      ],
                      // barsSpace: 50,
                      showingTooltipIndicators: [0],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
