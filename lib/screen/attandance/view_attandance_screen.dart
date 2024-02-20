import 'package:flutter/material.dart';
import 'package:glowrpt/screen/attandance/view_attendance_widget.dart';
import 'package:get/get.dart';

class ViewAttandanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Attendance".tr),
      ),
      body: ViewAttendanceWidget(),
    );
  }
}
