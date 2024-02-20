import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/TransactionM.dart';
import 'package:glowrpt/util/Constants.dart';

enum ChartType { bar, line, linefill }

class GraphCardWidget extends StatelessWidget {
  String title;
  String conintText;
  List<TransactionM> transactions;
  ChartType chartType;
  double yAxisHiegt = 100;

   FlTitlesData? titlesData;

  BarTouchData? barTouchData;

  FlBorderData? flBorderData;

  GraphCardWidget({
    required this.title,
    required this.conintText,
    required this.transactions,
    required this.chartType,
  });

  @override
  Widget build(BuildContext context) {
    if (chartType == ChartType.linefill) {
      yAxisHiegt = 1.0;
    }
    var textTheme = Theme.of(context).textTheme;
    titlesData = FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
        ))
        // bottomTitles: SideTitles(
        //   showTitles: true,
        //   rotateAngle: -30,
        //   reservedSize: 30,
        //   getTextStyles: (context, value) => const TextStyle(
        //       color: Color(0xff7589a2),
        //       fontWeight: FontWeight.bold,
        //       fontSize: 14),
        //   margin: 20,
        //   getTitles: (double value) {
        //     int number = value.toInt();
        //     return transactions[number].mMonth.substring(0, 3);
        //   },
        // ),
        // leftTitles: SideTitles(
        //   showTitles: false,
        //   getTextStyles: (context, value) => const TextStyle(
        //       color: Color(0xff7589a2),
        //       fontWeight: FontWeight.bold,
        //       fontSize: 14),
        //   interval: yAxisHiegt / 5,
        //   margin: 15,
        //   reservedSize: 40,
        // ),
        );
    barTouchData = BarTouchData(
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
            rod.fromY.round().toString(),
            TextStyle(
                color: Colors.transparent,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: -1),
          );
        },
      ),
    );
    flBorderData = FlBorderData(
        show: true,
        border:
            Border(bottom: BorderSide(color: AppColor.notificationBackgroud)));
    return Container(
      color: AppColor.chartBacground,
      margin: EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            color: Colors.black54,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              title,
              style: textTheme.subtitle1!.copyWith(color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.all(22),
            height: 100,
            width: 100,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Center(
              child: Text(
                conintText,
                style: textTheme.headline4!.copyWith(color: AppColor.barColor),
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 2,
            child: getChart(),
          ),
        ],
      ),
    );
  }

  getChart() {
    if (chartType == ChartType.bar) {
      return BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: yAxisHiegt,
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: flBorderData,
          barGroups: transactions
              .asMap()
              .map((k, v) {
                var nV = BarChartGroupData(
                  x: k,
                  barRods: [
                    BarChartRodData(
                        fromY: v.getValue,
                        width: 12,
                        toY:v.getValue, 
                        // colors: [AppColor.barColor],

                        color: v.getValue > 0 ? AppColor.barColor : Colors.red,
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
      );
    } else if (chartType == ChartType.line || chartType == ChartType.linefill) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: LineChart(LineChartData(
            titlesData: titlesData!,
            borderData: flBorderData,
            maxY: yAxisHiegt,
            // maxX: 12,
            gridData: FlGridData(
              show: false,
            ),
            lineBarsData: [
              LineChartBarData(
                  color: AppColor.barColor,
                  barWidth: 2,
                  isCurved: true,
                  dotData: FlDotData(show: chartType != ChartType.linefill),
                  belowBarData: BarAreaData(
                      show: chartType == ChartType.linefill,
                      color: AppColor.barColor),
                  spots: transactions
                      .asMap()
                      .map((k, v) {
                        return MapEntry(k, FlSpot(k.toDouble(), v.getValue));
                      })
                      .values
                      .toList())
            ])),
      );
    }
  }
}
