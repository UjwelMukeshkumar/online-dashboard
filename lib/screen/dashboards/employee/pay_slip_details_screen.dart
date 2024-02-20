import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/PaySlipM.dart';
import 'package:glowrpt/model/employe/PayrollDetailsM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/service/DateService.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/employee/month_selection_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class PaySlipDetailsScreen extends StatefulWidget {
  PaySlipM item;
  List<String> selectedDate;
  bool isManager;
  bool fromCreatPayroll;
  String? totalWorkingDays;

  PaySlipDetailsScreen({
    required this.item,
    required this.selectedDate,
    required this.isManager,
    this.fromCreatPayroll = false,
    this.totalWorkingDays,
  });

  @override
  State<PaySlipDetailsScreen> createState() => _PaySlipDetailsScreenState();
}

class _PaySlipDetailsScreenState extends State<PaySlipDetailsScreen> {
   CompanyRepository? compRepo;

  PayrollDetailsM? details;

   double? takeHome;

   num? totaldeduction;

   double? gross;

   double? takeHomePercent;

   double? deductionPercent;

  @override
  void initState() {
    super.initState();

    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadPayrollDetails();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    double radius = 40;
    var space = SizedBox(
      height: 30,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Pay Slip".tr),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MonthSelectionWidget(
                initialDate: widget.selectedDate,
                valueChanged: (date) {
                  widget.selectedDate = date;
                  setState(() {});
                  loadPayrollDetails();
                },
              ),
            ),
            Expanded(
                child: details != null
                    ? ListView(
                        children: [
                          AspectRatio(
                            aspectRatio: 2.5,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    // color: Colors.red,
                                    child: PieChart(
                                      PieChartData(
                                          pieTouchData: PieTouchData(
                                              touchCallback:
                                                  (pieTouchResponse, data) {
                                            setState(() {
                                              /*        final desiredTouch = pieTouchResponse.touchInput
                            is! PointerExitEvent &&
                                pieTouchResponse.touchInput is! PointerUpEvent;
                            if (desiredTouch &&
                                pieTouchResponse.touchedSection != null) {
                              touchedIndex = pieTouchResponse
                                  .touchedSection.touchedSectionIndex;
                            } else {
                              touchedIndex = -1;
                            }*/
                                            });
                                          }),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 2,
                                          centerSpaceRadius: 30,
                                          sections: [
                                            PieChartSectionData(
                                              color: AppColor.positiveGreen,
                                              value: takeHomePercent,
                                              title:
                                                  '${takeHomePercent ?? "0"}%',
                                              showTitle: false,
                                              radius: radius,
                                              titleStyle: TextStyle(
                                                  // fontSize: fontSize,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xffffffff)),
                                            ),
                                            PieChartSectionData(
                                              color: Colors.amberAccent,
                                              value: deductionPercent,
                                              title:
                                                  '${deductionPercent!.toInt()}%',
                                              showTitle: false,
                                              radius: radius,
                                              titleStyle: TextStyle(
                                                  // fontSize: fontSize,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xffffffff)),
                                            ),
                                          ]),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            "TAKE HOME".tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.positiveGreen),
                                          ),
                                          subtitle: Text(
                                            "${MyKey.currencyFromat(takeHome.toString())}",
                                            style: textTheme.headline6!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "DEDUCTIONS".tr,
                                            style: TextStyle(
                                                color: Colors.amberAccent,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Text(
                                            "${MyKey.currencyFromat(totaldeduction.toString())}",
                                            style: textTheme.headline6!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 3,
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "${'Total Gross Pay'.tr} : ${MyKey.currencyFromat(gross.toString())}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Earnings (A)".tr,
                              style: TextStyle(color: AppColor.positiveGreen),
                            ),
                          ),
                          Divider(
                            height: 0,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: details!.Earnings.length,
                              itemBuilder: (context, postion) {
                                var item = details!.Earnings[postion];
                                return ListTile(
                                  title: Text(item.BrickCode ?? ""),
                                  trailing: Text(MyKey.currencyFromat(
                                      item.Salary.toString())),
                                );
                              }),
                          ListTile(
                            title: Text(
                              "Total Earnings".tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              "${MyKey.currencyFromat(gross.toString())}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          space,
                          ListTile(
                            title: Text(
                              "Deductions (B)".tr,
                              style: TextStyle(color: Colors.amberAccent),
                            ),
                          ),
                          Divider(
                            height: 0,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: details!.Deductions.length,
                              itemBuilder: (context, postion) {
                                var item = details!.Deductions[postion];
                                return ListTile(
                                  title: Text(item.BrickCode ?? ""),
                                  trailing: Text(MyKey.currencyFromat(
                                      item.Salary.abs().toString())),
                                );
                              }),
                          ListTile(
                            title: Text(
                              "Total Deductions".tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              "${MyKey.currencyFromat(totaldeduction.toString())}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          space,
                          ListTile(
                            title: Text(
                              "TAKE HOME (A) - (B)".tr,
                              style: TextStyle(
                                  color: AppColor.positiveGreen,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              MyKey.currencyFromat(
                                takeHome.toString(),
                              ),
                              style: TextStyle(
                                  color: AppColor.positiveGreen,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          space,
                          Visibility(
                            visible: widget.isManager &&
                                details!.StatutoryCharges.length > 0,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Statutory Charges".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: details!.StatutoryCharges.length,
                                    itemBuilder: (context, postion) {
                                      var item =
                                          details!.StatutoryCharges[postion];
                                      return ListTile(
                                        title: Text(item.BrickCode),
                                        trailing: Text(MyKey.currencyFromat(
                                            item.StatutoryCharges.toString())),
                                      );
                                    }),
                                space,
                              ],
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Attendance".tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            height: 0,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: details!.Attendance.length,
                              itemBuilder: (context, postion) {
                                var item = details!.Attendance[postion];
                                return ExpansionTile(
                                  title: Text(item.AttendanceName),
                                  children: [
                                    ListTile(title: Text(item.FirstPunch)),
                                    ListTile(title: Text(item.LastPunch))
                                  ],
                                );
                              }),
                          ListTile(
                            title: Text(
                              "Actual Salary".tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            height: 0,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: details!.SalaryBricks.length,
                              itemBuilder: (context, postion) {
                                var item = details!.SalaryBricks[postion];
                                return ListTile(
                                  title: Text(item.BrickCode),
                                  subtitle: Text(MyKey.currencyFromat(
                                      item.Amount.toString())),
                                );
                              }),
                          space
                        ],
                      )
                    : Center(
                        child: CupertinoActivityIndicator(),
                      ))
          ],
        ));
  }

  Future<void> loadPayrollDetails() async {
    if (widget.fromCreatPayroll) {
      details = await Serviece.payRollDetails(
          context: context,
          api_key: compRepo!.getSelectedApiKey(),
          FromDate: widget.selectedDate.first,
          ToDate: widget.selectedDate.last,
          EmployeeCode: widget.item.EmployeeCode,
          TotalWorkingDays: widget.totalWorkingDays.toString());
    } else {
      details = await Serviece.getPayrollDetails(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        FromDate: widget.selectedDate.first,
        ToDate: widget.selectedDate.last,
        EmpCode: widget.item.EmployeeCode,
        PayNo: widget.item.PayNo.toString(),
      );
    }

    totaldeduction = details!.Deductions
        .map((e) => e.Salary)
        .toList()
        .fold(0.0, (previousValue, e) => previousValue + e)
        .abs();
    gross = details!.Earnings
        .map((e) => e.Salary)
        .toList()
        .fold(0, (previousValue, e) => previousValue! + e);
    takeHome = gross! - totaldeduction!;
    if (gross != 0) {
      takeHomePercent = takeHome! / gross! * 100;
      deductionPercent = totaldeduction! / gross! * 100;
    } else {
      takeHomePercent = 0;
      deductionPercent = 0;
    }

    setState(() {});
  }
}
