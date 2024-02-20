import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:glowrpt/model/other/CccM.dart';
import 'package:glowrpt/util/Constants.dart';

class BarChartMulti extends StatefulWidget {
  CccM ccc;

  BarChartMulti(this.ccc);

  @override
  State<StatefulWidget> createState() => BarChartMultiState();
}

class BarChartMultiState extends State<BarChartMulti> {
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, DpoDsoDioGraph>> dataMap =
        Map<String, Map<String, DpoDsoDioGraph>>();
    widget.ccc.dpoDsoDioGraph!.forEach((element) {
      if (dataMap.containsKey(element.yYear))
        dataMap[element.yYear]![element.type] = element;
      else
        dataMap[element.yYear] = {element.type: element};
    });
    return Center(child: Text("Under Progress"),);
   /* return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.66,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: BarTouchData(
                    enabled: true,
                    allowTouchBarBackDraw: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.black,
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
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              letterSpacing: -1),
                        );
                      },
                    )),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) =>
                        const TextStyle(color: Color(0xff939393), fontSize: 10),
                    margin: 10,
                    getTitles: (double value) {
                      return dataMap.keys.toList()[value.toInt()];
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(
                        color: Color(
                          0xff939393,
                        ),
                        fontSize: 10),
                    margin: 0,
                  ),
                  *//*    rightTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context,value) => const TextStyle(
                        color: Color(
                          0xff939393,
                        ),
                        fontSize: 10),
                    margin: 0,
                    getTitles: (d)=>"done",
                  ),*//*
                ),

                *//*  gridData: FlGridData(
                  // show: true,
                  checkToShowHorizontalLine: (value) => value % 10 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: const Color(0xffe7e8ec),
                    strokeWidth: 1,
                  ),
                ),*//*
                borderData: FlBorderData(
                  show: false,
                ),
                groupsSpace: 40,
                barGroups: getData(dataMap),
              ),
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                color: AppColor.barBlueLigt,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("DSO"),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 20,
                height: 20,
                color: AppColor.barBlue,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("DIO"),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 20,
                height: 20,
                color: AppColor.barBlueDark,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("DPO"),
              ),
              SizedBox(
                width: 10,
              ),
              // Container(width: 20,height: 20,color: AppColor.barBlueLigt,),Text("DSO"),SizedBox(width: 10,),
            ],
          ),
        )
      ],
    );*/
  }

 /* List<BarChartGroupData> getData(
      Map<String, Map<String, DpoDsoDioGraph>> dataMap) {
    return dataMap.keys.map((e) {
      var dso = dataMap[e]["DSO"].total;
      var dio = dataMap[e]["DIO"].total;
      var dpo = dataMap[e]["DPO"].total;
      return BarChartGroupData(x: dataMap.keys.toList().indexOf(e),
          // barsSpace: 400,
          barRods: [
            BarChartRodData(
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                ),
                y: (dso + dio + dpo),
                width: 40,
                rodStackItems: [
                  BarChartRodStackItem(0, dso, AppColor.barBlueLigt),
                  BarChartRodStackItem(dso, (dio + dso), AppColor.barBlue),
                  BarChartRodStackItem(
                      (dio + dso), (dso + dio + dpo), AppColor.barBlueDark),
                ],
                borderRadius: const BorderRadius.all(Radius.zero)),
          ], showingTooltipIndicators: [
        23,
        45
      ]);
    }).toList();
  }*/
}
