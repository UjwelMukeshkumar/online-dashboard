import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/EmployeeMasterM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:get/get.dart';

class SalaryBricksTab extends StatelessWidget {
  EmployeeMasterM employeeMaster;

  SalaryBricksTab({required this.employeeMaster});

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 16);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (employeeMaster.EmpSalary.length > 0) ...[
            TextFormField(
              initialValue: employeeMaster.EmpSalary.first.BrickCode,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Brick Code".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue: employeeMaster.EmpSalary.first.Account.toString(),
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Account".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue: employeeMaster.EmpSalary.first.Amount.toString(),
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Amount".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue: employeeMaster.EmpSalary.first.Remarks,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Remarks".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue: employeeMaster.EmpSalary.first.Dynamic.toString(),
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Dynamic".tr, border: textFieldBorder),
            ),
          ]
        ],
      ),
    );
  }
}
