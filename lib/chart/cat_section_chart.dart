import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/CatSectionM.dart';
import 'package:glowrpt/model/trend/CatSecTrendM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:intl/intl.dart';

class CatSectionChart extends StatelessWidget {
  CatSecTrendM? catSectionM;

  CatSectionChart(this.catSectionM);

  @override
  Widget build(BuildContext context) {
    if (catSectionM == null || catSectionM?.BarDiagram == null) {
      // Return a placeholder or an error widget if catSectionM or BarDiagram is null.
      return Center(child: Text("Data is null or empty."));
    }
    var textTheme = Theme.of(context).textTheme;
    var barDiagram = catSectionM?.BarDiagram;
    // var list = catSectionM.Lists;
    var maxY = barDiagram?.map((e) => e.amount).fold(
        0.0,
        (previousValue, element) =>
            element > previousValue ? element : previousValue);
    //  return Center(child: Text("Under Progress"),);
    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      child: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8, right: 8, bottom: 110, top: 8),
          child: BarChart(
            BarChartData(
              gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (valeu) => (valeu % 5000) == 0),
              titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    axisNameSize: 28,
                    sideTitles: SideTitles(
                      // interval: 1,
                      showTitles: true,
                      reservedSize: 22,
                      getTitlesWidget: (value, meta) {
                        var name = barDiagram?[value.toInt()].name.toString();
                        int length = 10;
                        if (name!.length > length) {
                          return Container(
                              margin: EdgeInsets.all(1),
                              child: Text(
                                name.substring(0, length) + "...",
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.caption,
                              ));
                        } else {
                          return Container(
                            margin: EdgeInsets.all(1),
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.caption,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  // SideTitles(
                  //   rotateAngle: -90,
                  //   // textDirection: TextDirection.LTR,
                  //   // showTitles: true,
                  //   // reservedSize: 22,
                  //   getTextStyles: (context, value) => textTheme.caption,
                  //   getTitles: (value) {
                  //     var name = barDiagram[value.toInt()].name.toString();
                  //     int length = 15;

                  //     if (name.length > length) {
                  //       return name.substring(0, length) + "...";
                  //     } else {
                  //       return name;
                  //     }
                  //   },
                  //   margin: 20,
                  // ),
                  // leftTitles: SideTitles(
                  //   showTitles: true,
                  //   getTextStyles: (context, value) => textTheme.caption,
                  //   reservedSize: 28,
                  //   margin: 12,
                  //   checkToShowTitle: showTitle,
                  // ),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                  ))),
              borderData: FlBorderData(
                  show: true,
                  border: Border(
                      bottom: BorderSide(color: Colors.black12),
                      left: BorderSide(color: Colors.black12))),
              barGroups: barDiagram?.map((e) {
                int index = barDiagram.indexOf(e);
                return BarChartGroupData(x: index, barRods: [
                  BarChartRodData(toY: e.amount, color: Colors.green)
                ]);
              }).toList(),
              maxY: maxY! * 1.1,
            ),
            swapAnimationDuration: Duration(seconds: 3),
            swapAnimationCurve: Curves.linear,
          ),
        ),
      ),
    );
  }
}
