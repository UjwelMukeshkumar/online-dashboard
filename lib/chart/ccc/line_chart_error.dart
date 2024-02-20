import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/CccM.dart';
import 'package:glowrpt/util/Constants.dart';

class LineChartError extends StatelessWidget {
  List<VendorPaymentErrorRate> vendorPaymentErrorRate;
  LineChartError(this.vendorPaymentErrorRate);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Under Progress"),);
   /* return Column(
      children: [
        ListTile(
          title: Text("Vendor Payment Error Rate - Last 12 Months"),
        ),
        AspectRatio(
          aspectRatio: 1.7,
          child: LineChart(LineChartData(
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
                    return vendorPaymentErrorRate[number]
                        .mMonth
                        .substring(0, 3);
                  },
                ),
                leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(
                        color: Color(0xff7589a2),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    interval: 5,
                    margin: 15,
                    reservedSize: 30,
                    getTitles: (data) => "${data.toInt().toString()}%"),
              ),
              borderData: FlBorderData(
                  show: true,
                  border: Border(
                      bottom: BorderSide(width: 1, color: AppColor.title),
                      left: BorderSide(width: 1, color: AppColor.title))),
              maxY: 25,
              // maxX: 12,
              gridData: FlGridData(
                show: false,
              ),
              lineBarsData: [
                LineChartBarData(
                  
                    colors: [AppColor.barColor],
                    barWidth: 2,
                    isCurved: true,
                    dotData: FlDotData(show: false),
                    spots: vendorPaymentErrorRate
                        .asMap()
                        .map((k, v) {
                          return MapEntry(k, FlSpot(k.toDouble(), v.errorRate));
                        })
                        .values
                        .toList())
              ])),
        ),
      ],
    );*/

  }
}
