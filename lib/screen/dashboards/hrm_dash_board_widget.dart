import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/attandance/view_attendance_widget.dart';
import 'package:glowrpt/screen/dashboards/hrmanager/attendance_insert_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/widget/other/attandance_widget.dart';
import 'package:glowrpt/widget/other/caroser_slider_widget.dart';
// import 'package:glowrpt/widget/other/main_tabs/category_list_widget.dart';
import 'package:glowrpt/widget/other/ledger_buttons.dart';
import 'package:glowrpt/widget/other/list_tile_button.dart';
import 'package:glowrpt/widget/hrm/hrm_menu.dart';
import 'package:glowrpt/widget/manager/total_branch_details_widget.dart';
import 'package:provider/provider.dart';

import 'employee/RoasterScreen.dart';
import 'employee/payroll_list_screen.dart';
import 'hrmanager/designation_master_screen.dart';
import 'hrmanager/employee_list_screen.dart' as emp;
import 'hrmanager/request_list_screen.dart';
import 'hrmanager/roaster_screen_hrm.dart';
import 'hrmanager/select_pay_roll_screen.dart';
import 'hrmanager/shift_list_screen.dart';

class HrmDashBoardWidget extends StatefulWidget {
  HrmDashBoardWidget({Key? key}) : super(key: key);

  @override
  _HrmDashBoardWidgetState createState() => _HrmDashBoardWidgetState();
}

class _HrmDashBoardWidgetState extends State<HrmDashBoardWidget> {
   CompanyRepository? compRepo;

  User? _selectedItem;

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    _selectedItem = compRepo!.getSelectedUser();
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 36);
    return Column(
      children: [
        Visibility(
            visible: true,
            // maintainState: true,
            child: TotalBranchDetailsWidget()),
        ViewAttendanceWidget(),
        HrmMenu(),

        CaroserSliderWidget(),
        RequestListWidget(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
          child: Row(
            children: [
              Expanded(
                child: ListTileButton(
                  title: "Roaster",
                  icon: Icons.local_activity_outlined,
                  onTap: openRoaster,
                ),
              ),
             Expanded(child: ListTileButton(
                 title: "Create Pay Roll",
                 icon: Icons.credit_card,
                 onTap: openPayRollCreate))
            ],
          ),
        ),

        // if (_selectedItem != null) AttandanceWidget(_selectedItem),
        // CategoryListWidget(true)
      ],
    );
  }


  void openPayRollCreate() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectPayRollScreen()));
  }

  void openRoaster() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RoasterHrmScreen()));
  }


  void openRequestListPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RequestListWidget()));
  }



  void openEmployeeList() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => emp.EmployeeListScreen()));
  }


}
