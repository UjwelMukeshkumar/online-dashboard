import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/AttandanceListM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/employee/approval/ApprovalScreen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/employee/RequestItem.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class MyAttendanceRequests extends StatefulWidget {
  String element;

  MyAttendanceRequests(this.element);

  @override
  _MyAttendanceRequestsState createState() => _MyAttendanceRequestsState();
}

class _MyAttendanceRequestsState extends State<MyAttendanceRequests> {
  CompanyRepository? compRepo;

  List<String>? dateList;

  List<AttandanceListM>? list;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    dateList = MyKey.getDefaultDateListAsToday();
    getRequestList();
  }

  @override
  Widget build(BuildContext context) {
    print("date is : $dateList");
    print("list is : $list");

    var space = SizedBox(
      height: 12,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.element}"),
      ),
      body: Column(
        children: [
          dateList==null?CupertinoActivityIndicator(): DaysSelectorWidget(
                           valueChanged: (data) {
                             dateList = data;
                             getRequestList();
                           },
                         ),
          // Future<void> getRequestList(BuildContext context) async {
          // if (dateList == null || dateList!.isEmpty) {
          // // Handle the case where dateList is null or empty.
          // return;
          // }
          //
          // final apiKey = compRepo.getSelectedApiKey();
          // final toDate = dateList!.last;
          // final fromDate = dateList!.first;
          //
          // list = await Serviece.getAttandanceList(
          // context: context,
          // api_key: apiKey,
          // ToDate: toDate,
          // FromDate: fromDate,
          // );
          // }

          Expanded(
            child: Center(
              child: list != null
                  ? Visibility(
                      visible: list!.length > 0,
                      child: ListView.builder(
                          itemCount: list!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = list![index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              color: AppColor.cardBackground,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  title: Text(item.AttendanceName.toString()),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Text(item.FirstPunch.toString()),
                                      ),
                                      Text(item.LastPunch.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            );
                            //         return RequestItem(
                            //   title: "${item["EmpName"]}",
                            //   leadLetter:
                            //   "${item["EmpName"].toString().substring(0, 1)}",
                            //   subTitle:
                            //   "${item["AttendanceName"]} - ${item["RequestID"]}",
                            //   trailing1: "${item["CreatedDate"]}",
                            //   trailing2: "${item["ManagerApproval"]}",
                            //   onTap: () {
                            //     String url = "hrm/AttendanceRequestAprooval";
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            //             ApprovalScreen(item, widget.element, url)));
                            //   },
                            // );
                          }),
                      replacement: Text("No Items Found"),
                    )
                  : CupertinoActivityIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getRequestList() async {
    list = await Serviece.getAttandanceList(
      context: context,
      api_key: compRepo!.getSelectedApiKey(),
      ToDate: dateList?.last,
      FromDate: dateList?.first,
    );
    setState(() {});
/*    var url = MyKey.baseUrl + "/hrm/AttendanceRequestList";
    Map params = {
      "api_key": compRepo.getSelectedApiKey(),
      "AppName": MyKey.appName,
      "date":selectedDate
    };
    var result = await MyKey.postWithApiKey(url, params, context);
    if (result != null) {
      setState(() {
        list = result["Details"];
        //list=[];
      });
      if (list.length == 0) {
        Toast.show("No Item fount", context, duration: Toast.LENGTH_LONG);
      }
    }*/
  }
}
