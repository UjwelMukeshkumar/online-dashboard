import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/model/employe/PayrollDetailsM.dart';
import 'package:glowrpt/model/manager/NextNumM.dart';
import 'package:glowrpt/model/manager/payroll/PayrollDeatilsM.dart';
import 'package:glowrpt/model/manager/payroll/PayrollInsertM.dart';
import 'package:glowrpt/model/manager/payroll/PayrollLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

//todo for fahal you are not touched this document
class PayrollDetailsScreen extends StatefulWidget {
  String firstDate;
  String lastDate;
  PayrollLoadBean item;
  String totalWorkingDays;

  PayrollDetailsScreen({
  required  this.firstDate,
  required  this.lastDate,
  required  this.item,
  required  this.totalWorkingDays,
  });

  @override
  _PayrollDetailsScreenState createState() => _PayrollDetailsScreenState();
}

class _PayrollDetailsScreenState extends State<PayrollDetailsScreen> {
   CompanyRepository? compRepo;

  PayrollDeatilsM? payrollDetails;

  List<SeriesComboboxBean>? sequenceList;

  SeriesComboboxBean? selectedSequence;

  int? nextNumber;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadPayRollDetails();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var space = SizedBox(
      height: 30,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Payroll Details".tr),
      ),
      body: SafeArea(
        child: payrollDetails != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  payrollDetails!.PayrollDetails.first.EmpName,
                                  style: textTheme.headline6,
                                ),
                              ),
                              Text(
                                payrollDetails!.PayrollDetails.first.Designation,
                                style: textTheme.caption
                                    !.copyWith(color: AppColor.title),
                              ),
                              if (payrollDetails!.PayrollDetails.first.Mobile !=
                                      null &&
                                  payrollDetails
                                      !.PayrollDetails.first.Mobile!.isNotEmpty)
                                Text(
                                  "(${payrollDetails!.PayrollDetails.first.Mobile})",
                                  style: textTheme.caption,
                                )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 16),
                            margin: containerMargin,
                            decoration: containerDecoration,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: ListTile(
                                      title: Text("Salary",
                                          style: textTheme.caption),
                                      subtitle: Text(
                                        MyKey.currencyFromat(
                                            payrollDetails
                                                    !.PayrollDetails.first.Salary
                                                    .toString() ??
                                                "0",
                                            decimmalPlace: 0),
                                        style: textTheme.headline6,
                                      ),
                                    )),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors.black12,
                                    ),
                                    Expanded(
                                        child: ListTile(
                                      title: Text("StatutoryCharges",
                                          style: textTheme.caption),
                                      subtitle: Text(
                                          MyKey.currencyFromat(payrollDetails
                                                  !.PayrollDetails
                                                  .first
                                                  .StatutoryCharges
                                                  .toString()) ??
                                              "",
                                          style: textTheme.headline6),
                                    )),
                                  ],
                                ),
                                /*  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                              text: TextSpan(
                                  text:
                                  "${headder?.CmpTxt == "More" ? "Great you" : "You"} ${widget.isSale ? "Have Sold for" : "purchased"} ",
                                  style: textTheme.caption,
                                  children: [
                                    TextSpan(
                                        text:
                                        "${MyKey.currencyFromat(headder?.AmntComparison?.toString() ?? "0", decimmalPlace: 0)} ${headder?.CmpTxt ?? ""}",
                                        style: TextStyle(
                                            color: headder?.CmpTxt == "More"
                                                ? AppColor.notificationBackgroud
                                                : AppColor.red)),
                                    TextSpan(text: " compared to last week, same day,")
                                  ])),
                        )*/
                              ],
                            ),
                          ),
                          DropdownButton(
                            isExpanded: true,
                            value: selectedSequence,
                            items: sequenceList
                                !.map(
                                    (e) => DropdownMenuItem<SeriesComboboxBean>(
                                          child: Text(e.SeriesName),
                                          value: e,
                                        ))
                                .toList(),
                            onChanged: (selected) {
                              setState(() {
                                selectedSequence = selected;
                                getNextSequence();
                              });
                            },
                          ),
                          if (payrollDetails!.SalaryDetails.isNotEmpty) ...[
                            space,
                            ListTile(
                              title: Text("Salary Details",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Divider(
                              height: 0,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: payrollDetails!.SalaryDetails.length,
                                itemBuilder: (context, position) {
                                  var item =
                                      payrollDetails!.SalaryDetails[position];
                                  return Card(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: ListTile(
                                      title: Text(item.BrickCode),
                                      subtitle: Text(MyKey.currencyFromat(
                                          item.Salary.toString())),
                                    ),
                                  );
                                })
                          ],
                          if (payrollDetails!.SalaryDetails.isNotEmpty) ...[
                            space,
                            ListTile(
                              title: Text("Attendance Details",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Divider(
                              height: 0,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount:
                                    payrollDetails!.AttendaceDetails.length,
                                itemBuilder: (context, position) {
                                  var item =
                                      payrollDetails!.AttendaceDetails[position];
                                  return Card(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: ListTile(
                                      title: Text(item.AttendanceName),
                                    ),
                                  );
                                })
                          ],
                        ],
                      ),
                    ),
                    FractionallySizedBox(
                        widthFactor: 1,
                        child: ElevatedButton(
                            onPressed: insertPayRol, child: Text("ADD")))
                  ],
                ),
              )
            : Center(
                child: CupertinoActivityIndicator(),
              ),
      ),
    );
  }

  Future<void> loadPayRollDetails() async {
/*    payrollDetails = await Serviece.payRollDetails(
        context: context,
        api_key: compRepo.getSelectedApiKey(),
        FromDate: widget.firstDate,
        ToDate: widget.lastDate,
        EmployeeCode: widget.item.EmployeeCode,
        TotalWorkingDays: widget.totalWorkingDays);*/
    sequenceList = payrollDetails!.SeriesCombobox;
    selectedSequence = sequenceList!.firstWhere((element) =>
        element.Series_Id ==
        payrollDetails!.DefaultSeriesDetails.first.Sequence);
    nextNumber = payrollDetails!.DefaultSeriesDetails.first.RecNum.toInt();
    setState(() {});
  }

  Future<void> getNextSequence() async {
    nextNumber = await Serviece.getSequence(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        Series_Id: selectedSequence!.Series_Id.toString(),
        form_id: "4753");
  }

  Future<void> insertPayRol() async {
    bool isSuccess = await insertPayRoll(
      compRepo: compRepo!,
      dateList: [widget.firstDate, widget.lastDate],
      payrollDetails: payrollDetails!,
      workingDays: widget.totalWorkingDays,
      sequence: selectedSequence!.Series_Id.toString(),
      nextNumber: nextNumber!,
      context: context,
    );
    if (isSuccess == true) {
      Navigator.pop(context, true);
    }
  }
}
