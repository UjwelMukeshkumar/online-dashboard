import 'package:flutter/material.dart';
import 'package:glowrpt/screen/dashboards/employee/requestlist/ClaimeAndAllowance.dart';
import 'package:glowrpt/screen/dashboards/employee/requestlist/MyAttendanceRequests.dart';
import 'package:glowrpt/screen/dashboards/employee/requestlist/MyLeaveRequests.dart';
import 'package:glowrpt/screen/dashboards/employee/requestlist/MyPromotionRequests.dart';
import 'package:glowrpt/screen/dashboards/employee/requestlist/MyPunchRequests.dart';
import 'package:glowrpt/screen/dashboards/employee/requestlist/MyResignationRequests.dart';
import 'package:glowrpt/screen/dashboards/employee/requestlist/MyTransferRequests.dart';
import 'package:glowrpt/screen/dashboards/employee/requestlist/MyVacancies.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/employee/MenuItem.dart';

import 'package:toast/toast.dart';
import 'package:get/get.dart';

class MyRequests extends StatefulWidget {
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  var requestListType = Requests.getList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Requests".tr),
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return MyMenuItem(
              title: requestListType[index],
              onTap: () {
                openRequest(requestListType[index]);
              },
            );
          },
          itemCount: requestListType.length,
        ),
      ),
    );
  }

  void openRequest(String elementAt) {
    switch (elementAt) {
      case Requests.LeaveRequest:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyLeaveRequests(elementAt)));
        break;
      case Requests.TransferRequest:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyTransferRequests(elementAt)));
        break;
      case Requests.PunchRequest:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyPunchRequests(elementAt)));
        break;
      case Requests.PromotionRequest:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyPromotionRequests(elementAt)));
        break;
      case Requests.ResignationsRequest:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                MyResignationRequests(elementAt)));
        break;
      case Requests.Vacancies:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyVacancies(elementAt)));
        break;
      case Requests.AttendanceRequest:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                MyAttendanceRequests(elementAt)));
        break;
      case Requests.ClimeAndAllowance:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ClaimAndAllowance(elementAt)));
        break;

      default:

        showToast("Under Progress".tr);
        break;
    }
  }
}
