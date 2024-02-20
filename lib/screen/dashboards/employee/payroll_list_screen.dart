import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/PaySlipM.dart';
import 'package:glowrpt/repo/DashBoardProvider.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/employee/pay_slip_details_screen.dart';
import 'package:glowrpt/service/DateService.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/employee/month_selection_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class PayrollListScreen extends StatefulWidget {
  bool isManager;

  PayrollListScreen({required this.isManager});

  @override
  State<PayrollListScreen> createState() => _PayrollListScreenState();
}

class _PayrollListScreenState extends State<PayrollListScreen> {
   CompanyRepository? compRepo;

  List<PaySlipM>? paySlips;

  List<String> datList = DateService.getDefaultDateOfLastMonth();

   DashBoardRepository? dashBoardRepo;

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    dashBoardRepo = Provider.of<DashBoardRepository>(context, listen: false);
    loadPaySlip();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pay Slip".tr),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MonthSelectionWidget(
                initialDate: datList,
                valueChanged: (date) {
                  datList = date;
                  setState(() {});
                  loadPaySlip();
                },
              ),
            ),
            Expanded(
              child: paySlips != null
                  ? ListView.builder(
                      itemCount: paySlips!.length,
                      // ignore: missing_return
                      itemBuilder: (context, position) {
                        var item = paySlips![position];
                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            onTap: () => openDetailsPage(item),
                            title: Text(item.EmpName),
                            subtitle: Text(
                                MyKey.currencyFromat(item.Amount.toString())),
                            /* leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.PayNo.toString(),style: Theme.of(context).textTheme.headline6,),
                    ),*/
                          ),
                        );
                      })
                  : Center(
                      child: CupertinoActivityIndicator(),
                    ),
            )
          ],
        ));
  }

  Future<void> loadPaySlip() async {
    paySlips = await Serviece.getPayroll(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        fromdate: datList.first,
        todate: datList.last,
        type: widget.isManager ? "M" : "E");
    if (dashBoardRepo!.dashBoards == DashBoardType.EmployeeDashboard) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => PaySlipDetailsScreen(
            item: paySlips!.first,
            selectedDate: datList,
            isManager: widget.isManager,
          ),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 0),
        ),
      );
    } else {
      setState(() {});
    }
  }

  void openDetailsPage(PaySlipM item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaySlipDetailsScreen(
                  item: item,
                  selectedDate: datList,
                  isManager: widget.isManager,
                )));
  }
}
