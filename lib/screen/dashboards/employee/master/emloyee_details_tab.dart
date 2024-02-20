import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/EmployeeMasterM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:get/get.dart';

class EmloyeeDetailsTab extends StatelessWidget {
  EmployeeMasterM employeeMaster;

  EmloyeeDetailsTab({required this.employeeMaster});

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 16);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            initialValue: employeeMaster.EmpDetails.first.EmpName,
            readOnly: true,
            decoration: InputDecoration(
                labelText: "Employee Name".tr, border: textFieldBorder),
          ),
          space,
          TextFormField(
            initialValue: employeeMaster.EmpDetails.first.EmpCode,
            readOnly: true,
            decoration: InputDecoration(
                labelText: "Employee Code".tr, border: textFieldBorder),
          ),
          space,
          TextFormField(
            initialValue: employeeMaster.EmpDetails.first.Mobile,
            readOnly: true,
            decoration: InputDecoration(
                labelText: "Mobile Number".tr, border: textFieldBorder),
          ),
          space,
          TextFormField(
            initialValue: employeeMaster.EmpDetails.first.Email,
            readOnly: true,
            decoration: InputDecoration(
                labelText: "E-Mail".tr, border: textFieldBorder),
          ),
        ],
      ),
    );
  }
}
