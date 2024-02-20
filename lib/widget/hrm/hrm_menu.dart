import 'package:flutter/material.dart';
import 'package:glowrpt/screen/dashboards/employee/payroll_list_screen.dart';
import 'package:glowrpt/screen/dashboards/hrmanager/attendance_insert_screen.dart';
import 'package:glowrpt/screen/dashboards/hrmanager/designation_master_screen.dart';
import 'package:glowrpt/screen/dashboards/hrmanager/route_punch_report_screen.dart';
import 'package:glowrpt/screen/dashboards/hrmanager/shift_list_screen.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/other/grid_tile_widget.dart';
import 'package:get/get.dart';

import '../../screen/dashboards/hrmanager/request_list_screen.dart';
import '../request_widget.dart';

class HrmMenu extends StatefulWidget {
  @override
  State<HrmMenu> createState() => _HrmMenuState();
}

class _HrmMenuState extends State<HrmMenu> {
  @override
  Widget build(BuildContext context) {
    var itemList = getWidgetlist();
    return AppCard(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Menu".tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: itemList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, postion) {
                return itemList[postion];
              }),
        ],
      ),
    );
  }

  List<Widget> getWidgetlist() {
    var designationMaster = GridTileWidget(
      title: "Designation Master".tr,
      widget: Icon(Icons.low_priority),
      onTap: openPromotionMaster,
    );

    var attendanceInsert = GridTileWidget(
      title: "Attendance Insert",
      widget: Icon(Icons.list),
      onTap: openAttandanceInsetPage,
    );

    var payRollList = GridTileWidget(
      title: "Pay Roll List",
      widget: Icon(Icons.credit_card),
      onTap: openPayList,
    );

    var shiftMaster = GridTileWidget(
        title: "Shift Master",
        widget: Icon(Icons.work_outline),
        onTap: openShiftMaster);

    var RoutePunch = GridTileWidget(
        title: "Route Punch Report",
        widget: Icon(Icons.route),
        onTap: openRoutePunch);
    return [
      designationMaster,
      attendanceInsert,
      payRollList,
      shiftMaster,
      RoutePunch
    ];
  }

  void openPromotionMaster() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DesignationMasterScreen()));
  }

  void openAttandanceInsetPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AttendanceInsertScreen()));
  }

  void openPayList() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PayrollListScreen(
                  isManager: true,
                )));
  }

  void openShiftMaster() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShiftListScreen()));
  }

  void openRoutePunch() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RoutePunchReportScreen()));
  }
}
