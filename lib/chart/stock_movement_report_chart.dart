import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:glowrpt/model/sale/StockMoveM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

class StockMovementReportChart extends StatefulWidget {
  @override
  State<StockMovementReportChart> createState() =>
      _StockMovementReportChartState();
}

class _StockMovementReportChartState extends State<StockMovementReportChart> {
  CompanyRepository? compRepo;

  List<StockMoveM>? reportList;
  bool stock = true;
  bool debtors = true;
  bool creditors = true;
  bool total = true;

  late num yMax;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    if (reportList != null) {
      getMaxY();
    }
    // return  Center(child: Text("Under Progress"),);

    return reportList != null
        ? Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      Container(
                        margin: containerMargin,
                        decoration: containerDecoration,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    child: Icon(
                                      Icons.circle,
                                      size: 18,
                                      color: AppColor.phonePeColor,
                                    ),
                                  ),
                                  Text(
                                    "Stock",
                                    style: textTheme.caption!.copyWith(
                                        color: stock ? AppColor.barBlue : null),
                                  ),
                                ],
                                mainAxisSize: MainAxisSize.min,
                              ),
                              onTap: () {
                                setState(() {
                                  stock = !stock;
                                  saveToPref();
                                });
                              },
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  debtors = !debtors;
                                  saveToPref();
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    child: Icon(
                                      Icons.circle,
                                      size: 18,
                                      color: AppColor.title,
                                    ),
                                  ),
                                  Text(
                                    "Debtors",
                                    style: textTheme.caption!.copyWith(
                                        color:
                                            debtors ? AppColor.barBlue : null),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  creditors = !creditors;
                                  saveToPref();
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    child: Icon(
                                      Icons.circle,
                                      size: 18,
                                      color: AppColor.negativeRed,
                                    ),
                                  ),
                                  Text(
                                    "Creditors",
                                    style: textTheme.caption!.copyWith(
                                        color: creditors
                                            ? AppColor.barBlue
                                            : null),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  total = !total;
                                  saveToPref();
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    child: Icon(
                                      Icons.circle,
                                      size: 18,
                                      color: AppColor.positiveGreen,
                                    ),
                                  ),
                                  Text(
                                    "Total",
                                    style: textTheme.caption!.copyWith(
                                        color: total ? AppColor.barBlue : null),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                axisNameSize:30 ,
                                sideTitles: SideTitles(
                                  interval: 1.0,
                                  showTitles: true,
                                  reservedSize: 35,
                                  // getTitlesWidget: (value, meta) {
                                  //   if (value >= 0 &&
                                  //       value < reportList!.length) {
                                  //     return Text(
                                  //         reportList![value.toInt()].MMonth);
                                  //     // reportList![value.toInt()].MMonth;
                                  //   }
                                  //   return Text("No Data");
                                  // },
                                  getTitlesWidget: (value, meta) => Container(
                                     margin: EdgeInsets.all(4),
                                    child: Text("${reportList?[value.toInt()].MMonth}",)),                                  // getTitles: (data) =>
                                  
                                ),
                              ),
                              // leftTitles:
                              //  AxisTitles(
                              //   sideTitles: SideTitles(
                              //     showTitles: true,
                              //     interval: yMax / 6.5,
                              //       reservedSize: 28,
                              //   )
                              // ),
                              show: true,
                              // bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,reservedSize: 22,getTitlesWidget: (data, meta) =>
                              // reportList?[data.toInt()].MMonth))
                            ),
                            // titlesData: FlTitlesData(
                            //   show: true,
                            //   bottomTitles: SideTitles(
                            //     getTitles: (data) =>
                            //         reportList[data.toInt()].MMonth,
                            //     showTitles: true,
                            //     reservedSize: 22,
                            //     getTextStyles: (context, value) =>
                            //         textTheme.caption,
                            //     margin: 8,
                            //   ),
                            
                            // leftTitles: SideTitles(
                            //   showTitles: true,
                            //   getTextStyles: (context, value) =>
                            //       textTheme.caption,
                            //   interval: yMax / 6.5,
                            //   reservedSize: 28,
                            //   margin: 12,
                            // ),
                            gridData:
                                FlGridData(horizontalInterval: (yMax / 6.5)),
                            maxX: reportList!.length.toDouble() - 1,
                            lineBarsData: [
                              if (stock)
                                LineChartBarData(
                                    spots: reportList!
                                        .map((e) => FlSpot(
                                            reportList!.indexOf(e).toDouble(),
                                            e.Stock.toDouble()))
                                        .toList(),
                                    isCurved: false,
                                    color: AppColor.phonePeColor,
                                    dotData: FlDotData(show: false)),
                              if (debtors)
                                LineChartBarData(
                                    spots: reportList!
                                        .map((e) => FlSpot(
                                            reportList!.indexOf(e).toDouble(),
                                            e.Debtor.toDouble()))
                                        .toList(),
                                    isCurved: false,
                                    color: AppColor.title,
                                    dotData: FlDotData(show: false)),
                              if (creditors)
                                LineChartBarData(
                                    spots: reportList!
                                        .map((e) => FlSpot(
                                            reportList!.indexOf(e).toDouble(),
                                            e.Creditor.toDouble()))
                                        .toList(),
                                    isCurved: false,
                                    color: AppColor.negativeRed,
                                    dotData: FlDotData(show: false)),
                              if (total)
                                LineChartBarData(
                                    spots: reportList!
                                        .map((e) => FlSpot(
                                            reportList!.indexOf(e).toDouble(),
                                            e.Total.toDouble()))
                                        .toList(),
                                    isCurved: false,
                                    color: AppColor.positiveGreen,
                                    dotData: FlDotData(show: false)),
                            ],
                          ),
                          // borderData: FlBorderData(
                          //     show: true,
                          //     border: Border(
                          //         bottom: BorderSide(color: Colors.black12),
                          //         left: BorderSide(color: Colors.black12))),
                          // gridData:
                          //     FlGridData(horizontalInterval: (yMax / 6.5)),
                          // maxY: yMax,
                          // maxX: reportList?.length.toDouble() - .8,
                          // lineBarsData:
                          //  [
                          //   if (stock)
                          //     LineChartBarData(
                          //         spots: reportList!
                          //             .map((e) => FlSpot(
                          //                 reportList!.indexOf(e).toDouble(),
                          //                 e.Stock!.toDouble()))
                          //             .toList(),
                          //         isCurved: false,
                          //         // colors: [AppColor.phonePeColor],
                          //         dotData: FlDotData(show: false)),
                          //   if (debtors)
                          //     LineChartBarData(
                          //         spots: reportList!
                          //             .map((e) => FlSpot(
                          //                 reportList!.indexOf(e).toDouble(),
                          //                 e.Debtor!.toDouble()))
                          //             .toList(),
                          //         isCurved: false,
                          //         // colors: [AppColor.title],
                          //         dotData: FlDotData(show: false)),
                          //   if (creditors)
                          //     LineChartBarData(
                          //         spots: reportList!
                          //             .map((e) => FlSpot(
                          //                 reportList!.indexOf(e).toDouble(),
                          //                 e.Creditor!.toDouble()))
                          //             .toList(),
                          //         isCurved: false,
                          //         // colors: [AppColor.negativeRed],
                          //         dotData: FlDotData(show: false)),
                          //   if (total)
                          //     LineChartBarData(
                          //         spots: reportList!
                          //             .map((e) => FlSpot(
                          //                 reportList!.indexOf(e).toDouble(),
                          //                 e.Total!.toDouble()))
                          //             .toList(),
                          //         isCurved: false,
                          //         // colors: [AppColor.positiveGreen],
                          //         dotData: FlDotData(show: false)),
                          // ],
                        ),
                        // swapAnimationDuration: Duration(milliseconds: 500),
                      ),
                      // ),
                    ],
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      columns: [
                        DataColumn(label: Text("Month")),
                        DataColumn(label: Text("Stock"), numeric: true),
                        DataColumn(label: Text("Debtors"), numeric: true),
                        DataColumn(label: Text("Creditors"), numeric: true),
                        DataColumn(label: Text("All"), numeric: true),
                      ],
                      rows: reportList!
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e.MMonth)),
                                DataCell(Text(
                                    MyKey.currencyFromat(e.Stock.toString()))),
                                DataCell(Text(
                                    MyKey.currencyFromat(e.Debtor.toString()))),
                                DataCell(Text(MyKey.currencyFromat(
                                    e.Creditor.toString()))),
                                DataCell(Text(
                                    MyKey.currencyFromat(e.Total.toString()))),
                              ]))
                          .toList()),
                ),
              )
            ],
          )
        : Center(
            child: CupertinoActivityIndicator(),
          );
  }

  Future<void> loadData() async {
    reportList = await Serviece.getStockMovementReport(
        context: context, api_key: compRepo!.getSelectedApiKey());
    reportList = reportList!.map((e) {
      e.Creditor = -e.Creditor;
      return e;
    }).toList();
    setState(() {});
  }

  void saveToPref() {}

  num? getMaxY() {
    List<num> dataList = [100];
    if (stock) dataList.addAll(reportList!.map((e) => e.Stock ?? 0).toList());
    if (creditors)
      dataList.addAll(reportList!.map((e) => e.Creditor ?? 0).toList());
    if (debtors)
      dataList.addAll(reportList!.map((e) => e.Debtor ?? 0).toList());
    if (total) dataList.addAll(reportList!.map((e) => e.Total ?? 0).toList());
    yMax = (dataList
            .reduce((value, element) => value < element ? element : value)) *
        1.1;
  }
}
