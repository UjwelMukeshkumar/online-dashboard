import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/trend/SalesTrendsM.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:intl/intl.dart';

class SalesTrendsChart extends StatefulWidget {
  SalesTrendsM salesTrends;
  int index;

  SalesTrendsChart(this.salesTrends, this.index);

  @override
  _SalesTrendsChartState createState() => _SalesTrendsChartState();
}

class _SalesTrendsChartState extends State<SalesTrendsChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  late List<TodayBean> current;

  late List<TodayBean> previus;

  late List<TodayBean> bigList;

  late TextTheme textTheme;

  late Iterable<TodayBean> maxVal;

  late double yMax;
  late double yMaxCumulate;

  bool isCumulative = true;

  @override
  void initState() {
    
    super.initState();
    current = widget.salesTrends.current;
    previus = widget.salesTrends.previus;
    yMax = current.followedBy(previus).map((e) => e.LineTotal?.toDouble()).fold(
            0.0,
            (previousValue, element) =>
                previousValue > element! ? previousValue : element) *
        1.1;
    var previusMax = previus.fold(
        0.0, (previousValue, element) => previousValue + element.LineTotal!);
    var currentMax = current.fold(
        0.0, (previousValue, element) => previousValue + element.LineTotal!);
    yMaxCumulate = (previusMax > currentMax ? previusMax : currentMax) * 1.1;

    bigList = current.length > previus.length ? current : previus;
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Center(child: Text("Under Progress"),);
   /* return AspectRatio(
      aspectRatio: 1.2,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              // color: Color(0xff232d37),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 0, bottom: 12),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isCumulative = !isCumulative;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: isCumulative
                                      ? AppColor.positiveGreen
                                      : AppColor.title),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            "Cumulative",
                            style: TextStyle(
                                color: isCumulative
                                    ? AppColor.positiveGreen
                                    : null),
                          ),
                        ),
                      )),
                  Expanded(
                    child: LineChart(
                      getChart(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );*/
  }

/*  LineChartDatagetChart() {
    switch (widget.index) {
      case 1:
      case 2:
        return hourChart();
      case 3:
        return dayChart();
      case 4:
      case 5:
        return monthChart();
    }
  }*/

/*  LineChartData hourChart() {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => textTheme.caption,
          getTitles: (value) {
            var hour = value.toInt();
            return hour.isEven
                ? "|"
                : DateFormat('ha')
                    .format(DateTime(2000, 0, 0, bigList[hour - 1].Time));
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => textTheme.caption,
          reservedSize: 28,
          margin: 12,
          checkToShowTitle: showTitle,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(bottom: BorderSide(color: Colors.black12))),
      gridData: FlGridData(horizontalInterval: (yMax / 6.5)),
      maxX: bigList.length.toDouble(),
      minY: 0,
      maxY: isCumulative ? yMaxCumulate : yMax,
      lineBarsData: [
        LineChartBarData(
            spots: previus
                .map((e) => FlSpot(
                    previus.indexOf(e).toDouble(),
                    (isCumulative
                        ? previus.sublist(0, previus.indexOf(e) + 1).fold(
                            0,
                            (previousValue, element) =>
                                previousValue + element.LineTotal)
                        : e.LineTotal).roundToDouble()))
                .toList(),
            isCurved: false,
            colors: [AppColor.title],
            dotData: FlDotData(show: false)),
        LineChartBarData(
          spots: current
              .map((e) => FlSpot(
                  current.indexOf(e).toDouble(),
                  (isCumulative
                      ? current.sublist(0, current.indexOf(e) + 1).fold(
                          0,
                          (previousValue, element) =>
                              previousValue + element.LineTotal)
                      : e.LineTotal).roundToDouble()))
              .toList(),
          isCurved: false,
          colors: gradientColors,
          dotData: FlDotData(
            show: true,
          ),
        ),
      ],
    );
  }

  LineChartData monthChart() {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => textTheme.caption,
          getTitles: (value) {
            var day = value.toInt();
            switch (day) {
              case 0:
                return "1st";
              case 1:
                return "2nd";
              case 2:
                return "3rd";
              default:
                return "${day}th";
            }
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => textTheme.caption,
          checkToShowTitle: showTitle,
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(bottom: BorderSide(color: Colors.black12))),
      maxX: previus.length.toDouble(),
      minY: 0,
      maxY: isCumulative ? yMaxCumulate : yMax,
      lineBarsData: [
        LineChartBarData(
            spots: previus
                .map((e) => FlSpot(
                    previus.indexOf(e).toDouble(),
                    (isCumulative
                        ? previus.sublist(0, previus.indexOf(e) + 1).fold(
                            0,
                            (previousValue, element) =>
                                previousValue + element.LineTotal)
                        : e.LineTotal).roundToDouble()))
                .toList(),
            isCurved: false,
            colors: [AppColor.title],
            dotData: FlDotData(show: false)),
        LineChartBarData(
          spots: current
              .map((e) => FlSpot(
                  current.indexOf(e).toDouble(),
                  (isCumulative
                      ? current.sublist(0, current.indexOf(e) + 1).fold(
                          0,
                          (previousValue, element) =>
                              previousValue + element.LineTotal)
                      : e.LineTotal).roundToDouble()))
              .toList(),
          isCurved: false,
          colors: gradientColors,
          dotData: FlDotData(show: true),
        ),
      ],
    );
  }

  LineChartData dayChart() {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => textTheme.caption,
          getTitles: (value) {
            var hour = value.toInt();
            return hour.isOdd
                ? "|"
                : DateFormat('dd MMM').format(current[hour].date);
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => textTheme.caption,
          reservedSize: 28,
          margin: 12,
          checkToShowTitle: showTitle,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(bottom: BorderSide(color: Colors.black12))),
      maxX: previus.length.toDouble(),
      minY: 0,
      maxY: isCumulative ? yMaxCumulate : yMax,
      lineBarsData: [
        LineChartBarData(
            spots: previus
                .map((e) => FlSpot(
                    previus.indexOf(e).toDouble(),
                    (isCumulative
                            ? previus.sublist(0, previus.indexOf(e) + 1).fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element.LineTotal)
                            : e.LineTotal)
                        .roundToDouble()))
                .toList(),
            isCurved: false,
            colors: [AppColor.title],
            dotData: FlDotData(show: false)),
        LineChartBarData(
          spots: current
              .map((e) => FlSpot(
                  current.indexOf(e).toDouble(),
                  (isCumulative
                          ? current.sublist(0, current.indexOf(e) + 1).fold(
                              0,
                              (previousValue, element) =>
                                  previousValue + element.LineTotal)
                          : e.LineTotal)
                      .roundToDouble()))
              .toList(),
          isCurved: false,
          colors: gradientColors,
          dotData: FlDotData(show: true),
        ),
      ],
    );
  }*/
}
