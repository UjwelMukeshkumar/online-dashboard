import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/attandace/AttandanceCountM.dart';
import 'package:glowrpt/model/attandace/AttandanceM.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/model/attandace/EmpAttandanceM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/attandance/attandace_employee_screen.dart';
import 'package:glowrpt/screen/attandance/punch_screen.dart';
import 'package:glowrpt/screen/attandance/view_attandance_screen.dart';
import 'package:glowrpt/screen/attandance/view_attendance_widget.dart';
import 'package:glowrpt/screen/dashboards/hrmanager/leave_employees_screen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/KeyValues.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/other/flexible_widget.dart';
import 'package:glowrpt/widget/other/key_val_col.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class AttandanceWidget extends StatefulWidget {
  User selectedUser;

  AttandanceWidget(this.selectedUser);

  @override
  _AttandanceWidgetState createState() => _AttandanceWidgetState();
}

class _AttandanceWidgetState extends State<AttandanceWidget>
    with AutomaticKeepAliveClientMixin {
  List linesList = [];
  bool showMore = false;

  int viewpageNum = 0;
  int numOfItemPerPage = 5;
  num totalPages = 1;
  int apiPageNumber = 0;
  num numberOfBills = 0;
  var controllre = PageController(keepPage: true, initialPage: 0);
   int? time;

   AttandanceCountM? count;
   CompanyRepository? compRepo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    compRepo = Provider.of<CompanyRepository>(context);
    updateLines();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (linesList != null && linesList.length > 0)
          ? AppCard(
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    title: Text(
                      "Attendance Details".tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: KeyValCol(
                              title: "Present".tr,
                              value: count!.Present.toString()),
                          onTap: () {
                            /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewAttandanceScreen()));*/
                          },
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LeaveEmployeesScreen()));
                            },
                            child: KeyValCol(
                                title: "Leave".tr,
                                value: count!.Leave.toString())),
                        KeyValCol(
                            title: "Roster".tr, value: count!.Roster.toString()),
                      ],
                    ),
                  ),
                  if (linesList.isNotEmpty) ...[
                    ExpandablePageView(
                      controller: controllre,
                      // key: key,
                      onPageChanged: (pageNumber) {
                        setState(() {
                          viewpageNum = pageNumber;
                        });
                        updateLines();
                      },

                      children: List.generate(
                          (numberOfBills / numOfItemPerPage).ceil(),
                          (pageIndex) {
                        return Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: (linesList.length -
                                            (viewpageNum) * numOfItemPerPage) >=
                                        numOfItemPerPage
                                    ? numOfItemPerPage
                                    : (linesList.length -
                                        (viewpageNum) * numOfItemPerPage),
                                itemBuilder: (context, position) {
                                  var index =
                                      ((viewpageNum) * numOfItemPerPage) +
                                          position;
                                  AttandanceM item = linesList[index];
                                  return Stack(
                                    children: [
                                      FlexibleWidget(
                                        position: position,
                                        item: item.toJson(),
                                        headderParm: HeadderParm(
                                            displayType: DisplayType.rowType,
                                            paramsOrder: [
                                              // "EmployeeID",
                                              "EmpName",
                                              "PunchTime",
                                              "OnDuty",
                                              "Present"
                                            ],
                                            dataType: [
                                              // DataType.textType,
                                              DataType.textType,
                                              DataType.textType,
                                              DataType.textType,
                                              DataType.numberNonCurrenncy,
                                            ],
                                            paramsFlex: [
                                              13,
                                              7,
                                              5,
                                              5
                                            ]),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: InkWell(
                                                onTap: () {
                                                  // print("New item ${item.employeeId}");
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PunchScreen(
                                                                empId: item
                                                                    .employeeId
                                                                    .toString(),
                                                                apiKey: compRepo!
                                                                    .getSelectedApiKey(),
                                                                dateTime:
                                                                    DateTime
                                                                        .now(),
                                                              )));
                                                },
                                                child: Container(
                                                  // color: Colors.red,
                                                  height: 40,
                                                ),
                                              )),
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              //taped on attendance count
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                var empAttandanceM =
                                                    EmpAttandanceM.fromJson(
                                                        item.toJson());
                                                empAttandanceM.EmployeeName =
                                                    item.empName;
                                                empAttandanceM.EmployeeID =
                                                    item.employeeId.toString();
                                                return AttandaceEmployeeScreen(
                                                    empAttandanceM);
                                              }));
                                            },
                                            child: Container(
                                              //color: Colors.blue,
                                              height: 40,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                            Align(
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controllre?.previousPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 18,
                                      )),
                                  Text(
                                    "${viewpageNum + 1}/${(numberOfBills / numOfItemPerPage).ceil()}",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        controllre?.nextPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn);
                                      },
                                      icon: Icon(Icons.arrow_forward_ios,
                                          size: 18)),
                                ],
                                mainAxisSize: MainAxisSize.min,
                              ),
                              alignment: Alignment.bottomCenter,
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ],
              ),
            )
          : Container(),
    );
  }

  Future<void> updateLines() async {
    if (time != compRepo!.conpanySwichedAt) {
      linesList.clear();
      viewpageNum = 0;
      apiPageNumber = 0;
      controllre = PageController(keepPage: true, initialPage: 0);
    }
    time = compRepo?.conpanySwichedAt;
    if (!isLastPage(
        linesList: linesList,
        numOfItemPerPage: numOfItemPerPage,
        viewpageNum: viewpageNum)) return;
    apiPageNumber++;

    var response = await Serviece.getAttandanceDetaisl(
        context, widget.selectedUser.apiKey, apiPageNumber);
    List data = response["EmployeeList"];
    if (data.isNotEmpty) {
      count = AttandanceCountM.fromJson(response["Count"][0]);
      numberOfBills = count!.Leave + count!.Present; //number of items
      linesList.addAll(data.map((e) => AttandanceM.fromJson(e)).toList());
      if (mounted) setState(() {});
    } else {
      // linesList = [];
      if (mounted) setState(() {});
      controllre = PageController(keepPage: true, initialPage: viewpageNum);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
