import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/PaySlipM.dart';
import 'package:glowrpt/model/manager/payroll/PayrollLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/employee/pay_slip_details_screen.dart';
import 'package:glowrpt/screen/dashboards/hrmanager/payroll_details_screen.dart';
import 'package:glowrpt/service/DateService.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/employee/month_selection_widget.dart';
import 'package:provider/provider.dart';

class SelectPayRollScreen extends StatefulWidget {
  @override
  State<SelectPayRollScreen> createState() => _SelectPayRollScreenState();
}

class _SelectPayRollScreenState extends State<SelectPayRollScreen> {
   CompanyRepository? compRepo;

  var formKey = GlobalKey<FormState>();

   List<String>? dateLists;
  List<PayrollLoadBean> filteredList = [];
   PayrollLoadM? payrollLoad;
  TextEditingController tecController = TextEditingController();

  String query = "";

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    var today = DateTime.now();
    dateLists = getEndPointsOfCurrentDate(
        DateTime(today.year, today.month - 1, today.day));
    getDaysExcludingSunday();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay Roll"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MonthSelectionWidget(
                  initialDate: dateLists!,
                  valueChanged: (date) {
                    dateLists = date;
                    setState(() {});
                    getDaysExcludingSunday();
                  },
                ),
              ),
              Form(
                key: formKey,
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Search",
                      ),
                      onChanged: (text) {
                        query = text;
                        filterList();
                      },
                    )),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: tecController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Number Of Days",
                      ),
                      validator: (text) =>
                          text!.isEmpty ? "Enter Number of days" : null,
                    )),
                    /*   TextButton.icon(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            loadPayRoll();
                          }
                        },
                        icon: Icon(Icons.settings),
                        label: Text("Exicute"))*/
                  ],
                ),
              ),
              Expanded(
                  child: payrollLoad != null
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  // prototypeItem: Text("Not loaded"),
                                  itemCount: filteredList.length,
                                  itemBuilder: (context, position) {
                                    var item = filteredList[position];
                                    if (item.isHide == true) {
                                      return Container();
                                    }
                                    return Card(
                                      color: AppColor.cardBackground,
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      child: ListTile(
                                        onTap: () =>
                                            openPayRollDetailsScreen(item),
                                        title: Row(
                                          children: [
                                            Text(item.EmpName),
                                            Text(
                                              " (${MyKey.currencyFromat(item.CTC.toString())})",
                                              style: textTheme.bodySmall!
                                                  .copyWith(
                                                      fontStyle:
                                                          FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Basic: ",
                                                  style: textTheme.caption,
                                                ),
                                                Text(
                                                  MyKey.currencyFromat(
                                                      item.Salary.toString()),
                                                  style: textTheme.subtitle2,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Deductions: ",
                                                    style: textTheme.caption,
                                                  ),
                                                  Text(
                                                      MyKey.currencyFromat(
                                                          item.StatutoryCharges
                                                              .toString()),
                                                      style:
                                                          textTheme.subtitle2),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Net Pay: ",
                                                  style: textTheme.caption,
                                                ),
                                                Text(
                                                    MyKey.currencyFromat(
                                                        item.NetPay.toString()),
                                                    style: textTheme.subtitle2),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                        // trailing: Text(item.Attendance.toString()),
                                      ),
                                    );
                                  }),
                            ),
                            Visibility(
                                visible: filteredList
                                        .where(
                                            (element) => element.isHide != true)
                                        .length >
                                    0,
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: ElevatedButton(
                                    child: Text(
                                        "Add All (${MyKey.currencyFromat(filteredList.where((element) => element.isHide != true).map((e) => e.NetPay).fold(0.0, (previousValue, element) => previousValue + element).toString())})"),
                                    onPressed: addAll,
                                  ),
                                ))
                          ],
                        )
                      : Container())
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadPayRoll() async {
    String firstDate = dateLists!.first;
    String lastDate = dateLists!.last;
    payrollLoad = await Serviece.payRollLoad(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        TotalWorkingDays: tecController.text,
        FromDate: firstDate,
        ToDate: lastDate);
    filterList();
    setState(() {});
  }

  void openPayRollDetailsScreen([PayrollLoadBean? item]) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (contxt) => PaySlipDetailsScreen(
                  selectedDate: dateLists!,
                  item: PaySlipM.fromJson(item!.toJson()),
                  totalWorkingDays: tecController.text,
                  fromCreatPayroll: true,
                  isManager: true,
                )));
  }

  int getDaysExcludingSunday() {
    DateTime first = MyKey.displayDateFormat.parse(dateLists!.first);
    DateTime last = MyKey.displayDateFormat.parse(dateLists!.last);
    int remaining = 7 - first.weekday;
    var deference = last.difference(first).inDays - remaining + 1;
    print("Deference ${deference}");
    var result = deference - (deference / 7).ceil() + remaining;
    print("Result $result");
    tecController.text = result.toString();
    loadPayRoll();
    return result;
  }

  addAll() async {
    print("asyncOne start");
    for (PayrollLoadBean item in payrollLoad!.PayrollLoad) {
      var payrollDetails = await Serviece.payRollFullDetails(
          context: context,
          api_key: compRepo!.getSelectedApiKey(),
          FromDate: dateLists!.first,
          ToDate: dateLists!.last,
          EmployeeCode: item.EmployeeCode,
          TotalWorkingDays: tecController.text);
      bool isSuccess = await insertPayRoll(
        compRepo: compRepo!,
        dateList: dateLists!,
        payrollDetails: payrollDetails,
        workingDays: tecController.text,
        sequence: payrollDetails.DefaultSeriesDetails.first.Sequence.toString(),
        nextNumber: payrollDetails.DefaultSeriesDetails.first.RecNum.toInt(),
        context: context,
      );
      if (isSuccess) {
        setState(() {
          item.isHide = true;
        });
      }
      print("done ${item.EmpName}");
    }
  }

  void filterList() {
    if (payrollLoad == null) {
      return;
    }
    if (query.isEmpty) {
      filteredList = payrollLoad!.PayrollLoad;
    } else {
      filteredList = payrollLoad!.PayrollLoad.where((element) =>
          element.EmpName.toUpperCase().contains(query.toUpperCase())).toList();
    }
    setState(() {});
  }
}
