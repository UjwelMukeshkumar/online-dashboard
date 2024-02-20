import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/EmployeeMasterM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:get/get.dart';

class PersonalDetailsTab extends StatelessWidget {
  EmployeeMasterM employeeMaster;

  PersonalDetailsTab({required this.employeeMaster});

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 16);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            initialValue: employeeMaster.EmpPersonalDetails.first.EmpName,
            readOnly: true,
            decoration: InputDecoration(
                labelText: "Employee Name".tr, border: textFieldBorder),
          ),
          space,
          TextFormField(
            initialValue:
                employeeMaster.EmpPersonalDetails.first.Balance.toString(),
            readOnly: true,
            decoration: InputDecoration(
                labelText: "Balance".tr, border: textFieldBorder),
          ),
          space,
        ],
      ),
    );
  }
}
