import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/EmployeeMasterM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:get/get.dart';

class StatutoryChargesTab extends StatelessWidget {
  EmployeeMasterM employeeMaster;

  StatutoryChargesTab({required this.employeeMaster});

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 16);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (employeeMaster.EmpSalaryTax.length > 0) ...[
            TextFormField(
              initialValue: employeeMaster.EmpSalaryTax.first.TaxCode,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "TaxCode".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue: employeeMaster.EmpSalaryTax.first.Amount.toString(),
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Amount".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue: employeeMaster.EmpSalaryTax.first.Remarks,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Remarks".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue:
                  employeeMaster.EmpSalaryTax.first.Dynamic.toString(),
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
