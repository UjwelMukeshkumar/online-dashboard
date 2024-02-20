import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/hrm/EmpM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

class LeaveEmployeesScreen extends StatefulWidget {
  @override
  State<LeaveEmployeesScreen> createState() => _LeaveEmployeesScreenState();
}

class _LeaveEmployeesScreenState extends State<LeaveEmployeesScreen> {
   CompanyRepository? compRepo;

  List<EmpM>? employeeList;

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    getEmployeeLoad();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Absents List"),
      ),
      body: employeeList != null
          ? ListView.builder(
              itemCount: employeeList!.length,
              itemBuilder: (context, position) {
                var item = employeeList![position];
                return Container(
                  padding: EdgeInsets.only(bottom: 16),
                  margin: containerMargin,
                  decoration: containerDecoration,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 12,),
                      Text(item.EmpName),
                      Row(
                        children: [
                          Expanded(
                              child: ListTile(
                            title: Text("Reason"),
                            subtitle: Text(
                              item.Reason,
                              style: textTheme.caption,
                            ),
                          )),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.black12,
                          ),
                          Expanded(
                              child: ListTile(
                            title: Text("Status"),
                            subtitle: Text(item.ApprovalLevel,
                                style: textTheme.caption),
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                            text: TextSpan(
                                text:
                                    "${MyKey.getDispayDateFromWb(item.DateFrom)}",
                                style: textTheme.subtitle2,
                                children: [
                              TextSpan(
                                text: "To ",
                                style: textTheme.caption,
                              ),
                              TextSpan(
                                  text:
                                      "${MyKey.getDispayDateFromWb(item.DateTo)}")
                            ])),
                      ),
                    ],
                  ),
                );
              })
          : Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }

  Future<void> getEmployeeLoad() async {
    employeeList = await Serviece.getEmployeeAbsentList(
        context: context, api_key: compRepo!.getSelectedApiKey());
    setState(() {});
  }
}
