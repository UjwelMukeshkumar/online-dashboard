import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/EmployeeMasterM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/employee/master/account_details_tab.dart';
import 'package:glowrpt/screen/dashboards/employee/master/company_allowance_tab.dart';
import 'package:glowrpt/screen/dashboards/employee/master/emloyee_details_tab.dart';
import 'package:glowrpt/screen/dashboards/employee/master/experience_tab.dart';
import 'package:glowrpt/screen/dashboards/employee/master/general_details_tab.dart';
import 'package:glowrpt/screen/dashboards/employee/master/personal_details_tab.dart';
import 'package:glowrpt/screen/dashboards/employee/master/qualification_tab.dart';
import 'package:glowrpt/screen/dashboards/employee/master/salary_bricks_tab.dart';
import 'package:glowrpt/screen/dashboards/employee/master/statutory_charges_tab.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class EmployeeMasterScreen extends StatefulWidget {
  @override
  _EmployeeMasterScreenState createState() => _EmployeeMasterScreenState();
}

class _EmployeeMasterScreenState extends State<
    EmployeeMasterScreen> /*with SingleTickerProviderStateMixin*/ {
   CompanyRepository? compRepo;

  EmployeeMasterM? employeeMaster;
  var tabController;

  @override
  void initState() {

    super.initState();
    // tabController = TabController(length: tabs.length, vsync: this);
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadEmployeeMaster();
  }

  List<String> tabs = [
    "Employee Details".tr,
    "Personal Details".tr,
    "Employee Qualification".tr,
    "Employee Experience".tr,
    "General Details".tr,
    "Account Details".tr,
    "Salary Bricks".tr,
    "Statutory Charges".tr,
    "Company Allowance".tr
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employee Master".tr),
          /* bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),*/
        ),
        body: employeeMaster != null
            ? ListView(
                children: [
                  ExpansionTile(
                    title: Text("Employee Details".tr),
                    children: [
                      EmloyeeDetailsTab(
                        employeeMaster: employeeMaster!,
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text("Personal Details".tr),
                    children: [
                      PersonalDetailsTab(
                        employeeMaster: employeeMaster!,
                      )
                    ],
                  ),
                  // ExpansionTile(title: Text("Qualification"),children: [QualificationTab(employeeMaster: employeeMaster,)],),
                  // ExpansionTile(title: Text("Experience"),children: [ExperienceTab(employeeMaster: employeeMaster,)],),
                  // ExpansionTile(title: Text("General Details"),children: [GeneralDetailsTab(employeeMaster: employeeMaster,)],),
                  ExpansionTile(
                    title: Text("Account Details".tr),
                    children: [
                      AccountDetailsTab(
                        employeeMaster: employeeMaster!,
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text("Salary Bricks".tr),
                    children: [
                      SalaryBricksTab(
                        employeeMaster: employeeMaster!,
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text("Statutory Charges".tr),
                    children: [
                      StatutoryChargesTab(
                        employeeMaster: employeeMaster!,
                      )
                    ],
                  ),
                ],
              )
            : Center(child: CupertinoActivityIndicator()));
  }

  Future<void> loadEmployeeMaster() async {
    employeeMaster = await Serviece.getEmployeeMaster(
        context: context, api_key: compRepo!.getSelectedApiKey());
    if (mounted) setState(() {});
  }
}
