import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/TransactionM.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';

class GraphRowWidget extends StatelessWidget {
  bool isBold;
  String title;
  double amount;
  List<TransactionM> transactions;

  // double yAxisHiegt = 10000000;

  GraphRowWidget({
  required this.isBold,
  required this.title,
  required this.amount,
  required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) return Container();
    return Card(
      color: AppColor.chartBacground,
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                flex: 10,
                child: Text(title,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight:
                            isBold ? FontWeight.w600 : FontWeight.w300))),
            Expanded(
                flex: 10,
                child: Text(MyKey.currencyFromat(amount.toString()),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight:
                            isBold ? FontWeight.w600 : FontWeight.w300))),
            Expanded(
                flex: 15,
                child: Container(
                  height: 50,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: transactions
                          .reduce((value, element) =>
                              element.getValue > value.getValue
                                  ? element
                                  : value)
                          .getValue,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.transparent,
                            getTooltipItem: (BarChartGroupData group,
                                    int groupIndex,
                                    BarChartRodData rod,
                                    int rodIndex) =>
                                null),
                      ),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: transactions
                          .asMap()
                          .map((k, v) {
                            var nV = BarChartGroupData(
                              x: k,
                              barRods: [
                                BarChartRodData(
                                  toY: v.getValue,
                                    fromY: v.getValue,
                                    width: 12,
                                    color: v.getValue > 0
                                        ? AppColor.barColor
                                        : Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.zero)),
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
                )),
          ],
        ),
      ),
    );
  }
}
