import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/attandace/EmpAttandanceM.dart';
import 'package:glowrpt/model/employe/EmpLoadM.dart';
import 'package:glowrpt/model/employe/activity_screen.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/attandance/attandace_employee_screen.dart';
import 'package:glowrpt/screen/dashboards/employee/ClaimAndAllowance.dart';
import 'package:glowrpt/screen/dashboards/employee/MyRequests.dart';
import 'package:glowrpt/screen/dashboards/employee/RoasterScreen.dart';
import 'package:glowrpt/screen/dashboards/employee/RoutePunchInScreen.dart';
import 'package:glowrpt/screen/dashboards/employee/promotion_request_screen.dart';
import 'package:glowrpt/screen/dashboards/employee/employee_master_screen.dart';
import 'package:glowrpt/screen/dashboards/employee/payroll_list_screen.dart';
import 'package:glowrpt/screen/dashboards/employee/pending_tasks_screen.dart';
import 'package:glowrpt/screen/transaction_details.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/other/caroser_slider_widget.dart';
import 'package:glowrpt/widget/manager/total_branch_details_widget.dart';
import 'package:intl/intl.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';

import '../route/employee/employee_select_route_screen1.dart';
import 'employee/PunchInScreen.dart';
import 'employee/RequestLeave.dart';
import 'employee/reimbursement_screen.dart';
import 'employee/requestlist/MyAttendanceRequests.dart';
import 'package:get/get.dart';

class EmployeeDashBoardWidget extends StatefulWidget {
  @override
  _EmployeeDashBoardWidgetState createState() =>
      _EmployeeDashBoardWidgetState();
}

class _EmployeeDashBoardWidgetState extends State<EmployeeDashBoardWidget> {
  CompanyRepository? compRepo;

  EmpLoadM? empLoadM;
  var controllre = PageController(keepPage: true, initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  var df = DateFormat("dd-MMM yy EEE");

  num precent = 0.0;

  num absent = 0.0;

  num pendingTask = 0;

  num employeeBalnce = 0;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    print("emploadM: ${empLoadM?.PendingTaskCount}");
    print("emploadM: ${empLoadM?.PendingTaskList}");
    var today = DateTime.now();
    var textTheme = Theme.of(context).textTheme;
    var space = SizedBox(
      height: 20,
    );
    return Column(
      children: [
        //only for taking session if failed
        Visibility(
            visible: false,
            maintainState: true,
            child: TotalBranchDetailsWidget()),
        AppCard(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmployeeMasterScreen()));
                },
                title: Text(compRepo!.getSelectedUser().username!),
              ),
              Divider(),
              AspectRatio(
                aspectRatio: 1.8,
                child: Stack(
                  children: [
                    PageView(
                      controller: controllre,
                      children: [
                        InkWell(
                          onTap: openAttandanceCalandar,
                          child: Container(
                            child: Column(
                              children: [
                                space,
                                Text("Attendance".tr),
                                space,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(df.format(today.subtract(
                                        Duration(days: today.day - 1)))),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "to".tr,
                                        style: textTheme.caption,
                                      ),
                                    ),
                                    Text(df.format(today)),
                                  ],
                                ),
                                space,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      width: 150,
                                      child: GridTile(
                                        child: Text(
                                          minimalDecimmal(precent.toDouble())
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: textTheme.headline2!.copyWith(
                                              color: AppColor.barBlue),
                                        ),
                                        footer: Text(
                                          "Present".tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: AppColor.barBlue),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                      width: 150,
                                      child: GridTile(
                                        child: Text(
                                          minimalDecimmal(absent.toDouble()),
                                          textAlign: TextAlign.center,
                                          style: textTheme.headline2!.copyWith(
                                              color: AppColor.negativeRed),
                                        ),
                                        footer: Text(
                                          "Absent".tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: AppColor.negativeRed),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: openEmployeeLedger,
                            child: Column(
                              children: [
                                space,
                                Text("Employee Balance".tr),
                                space,
                                SizedBox(
                                  height: 80,
                                  child: GridTile(
                                    child: Text(
                                      MyKey.currencyFromat(
                                          employeeBalnce.toString(),
                                          decimmalPlace: 0),
                                      textAlign: TextAlign.center,
                                      style: textTheme.headline2!.copyWith(
                                          color: AppColor.negativeRed),
                                    ),
                                    footer: Text(
                                      "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppColor.negativeRed),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: openPendingTasks,
                            child: Column(
                              children: [
                                space,
                                Text("Pending Tasks".tr),
                                space,
                                SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: GridTile(
                                    child: Text(
                                      // pendingTask?.toStringAsFixed(0) ?? "0",
                                      pendingTask.toStringAsFixed(0),
                                      textAlign: TextAlign.center,
                                      style: textTheme.headline2!.copyWith(
                                          color: AppColor.negativeRed),
                                    ),
                                    footer: Text(
                                      "Pending Tasks".tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppColor.negativeRed),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                      onPageChanged: (index) {
                        _currentPageNotifier.value = index;
                      },
                    ),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CirclePageIndicator(
                          itemCount: 3,
                          dotColor: Colors.grey,
                          selectedDotColor: AppColor.title,
                          currentPageNotifier: _currentPageNotifier,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        CaroserSliderWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: GridView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            children: [
              AppGridTile(
                title: "Punch".tr,
                icon: Icons.timer,
                ontap: openPunch,
              ),
              AppGridTile(
                title: "Leave Request".tr,
                icon: Icons.agriculture_sharp,
                ontap: openLeveRequest,
              ),
              // AppGridTile(title: "My Approval",icon: Icons.done_outline_outlined,ontap: openApproval,),
              AppGridTile(
                title: "Claim And Allowance".tr,
                icon: Icons.reset_tv,
                ontap: openClimeAndAlowance,
              ),
              AppGridTile(
                title: "Attendance Log".tr,
                icon: Icons.history,
                ontap: openAttandanceList,
              ),
              AppGridTile(
                title: "Pay Slip".tr,
                icon: Icons.credit_card,
                ontap: openPayList,
              ),
              AppGridTile(
                title: "My Activity".tr,
                icon: Icons.list,
                ontap: openReimbursment,
              ),
              AppGridTile(
                title: "Add Activity".tr,
                icon: Icons.add_business_outlined,
                ontap: openActivityScreen,
              ),
              AppGridTile(
                title: "Roaster".tr,
                icon: Icons.local_activity_outlined,
                ontap: openRoasterScreen,
              ),
              AppGridTile(
                title: "Promotion".tr,
                icon: Icons.volunteer_activism,
                ontap: openPromotionRequest,
              ),
              AppGridTile(
                title: "My Attendance".tr,
                icon: Icons.calendar_today,
                ontap: openAttandanceCalandar,
              ),
              AppGridTile(
                title: "My Routes".tr,
                icon: Icons.route,
                ontap: openRouteScreen,
              ),
              AppGridTile(
                title: "Route Punch".tr,
                icon: Icons.punch_clock_outlined,
                ontap: openRoutePunch,
              ),
            ],
          ),
        ),
        // Divider(),
      ],
    );
  }

  openPunch() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PunchinScreen(empLoadM)));
  }

  openLeveRequest() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RequestLeave()));
  }

  openApproval() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyRequests()));
  }

  void openClimeAndAlowance() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ClaimAndAllowance()));
  }

  void openAttandanceList() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            MyAttendanceRequests(Requests.AttendanceRequest)));
  }

  Future<void> loadData() async {
    empLoadM = await Serviece.getEmpoyeeLoad(
        context: context, api_key: compRepo!.getSelectedApiKey());
    precent = empLoadM!.Attendance.first.Attendance;
    absent = empLoadM!.Attendance.last.Attendance;
    pendingTask = empLoadM!.PendingTaskCount.first.count;
    employeeBalnce = empLoadM!.Attendance[1].Attendance;
    if (mounted) setState(() {});
  }

  void openPendingTasks() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PendingTasksScreen(
                  empLoadM: empLoadM!,
                )));
  }

  void openReimbursment() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReimbursementScreen(
                // empLoadM: empLoadM,
                )));
  }

  void openActivityScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ActivityScreen(
                // empLoadM: empLoadM,
                )));
  }

  void openPayList() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PayrollListScreen(
                  isManager: false,
                )));
  }

  void openRoasterScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RoasterScreen()));
  }

  void openPromotionRequest() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PromotionRequestScreen()));
  }

  void openEmployeeLedger() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactionDetails(
                  type: DocType.employee,
                  id: empLoadM!.EmployeeDetails.first.EmpCode,
                  apiKey: compRepo!.getSelectedUser().apiKey,
                  fromDate: MyKey.getCurrentDate(),
                  todate: MyKey.getCurrentDate(),
                  title: empLoadM!.EmployeeDetails.first.EmpName,

                  // RecNum: item.,
                )));
  }

  void openAttandanceCalandar() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      var employeeDetailsBean = empLoadM?.EmployeeDetails!.first;
      return AttandaceEmployeeScreen(EmpAttandanceM(
        EmployeeID: employeeDetailsBean!.EmpCode,
        EmployeeName: employeeDetailsBean.EmpName,
      ));
    }));
  }

  void openRouteScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EmployeeSelectRouteScreen1(empLoadM: empLoadM!)));
  }

  void openRoutePunch() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RoutePunchinScreen(empLoadM: empLoadM!)));
  }
}

// class AppGridTile extends StatelessWidget {
// ignore: must_be_immutable
class AppGridTile extends StatelessWidget {
  String? title;
  IconData? icon;
  VoidCallback? ontap;

  AppGridTile({this.title, this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridTile(
            child: Icon(
              icon,
              size: 40,
              color: AppColor.title,
            ),
            footer: Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.title),
            ),
          ),
        ),
      ),
    );
  }
}
