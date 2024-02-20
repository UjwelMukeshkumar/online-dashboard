import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/EmployeeMasterM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:get/get.dart';

class AccountDetailsTab extends StatelessWidget {
  EmployeeMasterM employeeMaster;

  AccountDetailsTab({required this.employeeMaster});

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 16);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (employeeMaster.EmpAccountDetails.length > 0) ...[
            TextFormField(
              initialValue: employeeMaster.EmpAccountDetails.first.BankName,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Bank Name".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue: employeeMaster.EmpAccountDetails.first.BranchName,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Branch Name".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue:
                  employeeMaster.EmpAccountDetails.first.Accountnumber,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Account Number".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue: employeeMaster.EmpAccountDetails.first.IFSCCode,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "IFSC Code".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue:
                  employeeMaster.EmpAccountDetails.first.AccountHolderName,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Account Holder Name".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue: employeeMaster.EmpAccountDetails.first.GLAccount,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "GL Account".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue:
                  employeeMaster.EmpAccountDetails.first.CommisionAccount,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Commission Account".tr, border: textFieldBorder),
            ),
            space,
            TextFormField(
              initialValue: employeeMaster.EmpAccountDetails.first.LeaveAccount,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Leave Account".tr, border: textFieldBorder),
            ),
          ]
        ],
      ),
    );
  }
}
