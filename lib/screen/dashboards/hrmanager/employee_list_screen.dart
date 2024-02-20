import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/EmployeeM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/cahched_img.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;

   CompanyRepository? compRepo;

  List<EmployeeM>? employeeList;

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadEmpoyees();
    user.initData(100);
  }

  double leftHandside = 600;
  double imageSize = 50;
  double rowHeight = 65;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;
    var headders = [
      "       Name",
      "Designation",
      "Department",
      "     Manager"
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      // body: _getBodyWidget(),
      body: employeeList != null
          ? HorizontalDataTable(
        leftHandSideColumnWidth: 200,
        rightHandSideColumnWidth: leftHandside,
        isFixedHeader: true,
        leftHandSideColBackgroundColor: AppColor.cardBackground,

        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        verticalScrollbarStyle: const ScrollbarStyle(
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        leftSideChildren: employeeList
            !.map((e) =>
            SizedBox(
              height: rowHeight,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        title: Text(e.EmpName),
                        leading: SizedBox(
                            height: imageSize,
                            width: imageSize,
                            child: CachedImg(
                              url: e.EmpImage,
                              itemName: e.EmpName,
                              isSmall: true,
                            )),
                      )),
                  Divider(
                    height: 0,
                  )
                ],
              ),
            ))
            .toList(),
        headerWidgets: headders.map((e) {
          return SizedBox(
              width: leftHandside / (headders.length - 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  e,
                  style: textTheme.subtitle2!.copyWith(fontSize: 18),
                ),
              ));
        }).toList(),
        rightSideChildren: employeeList
            !.map((e) =>
            SizedBox(
              height: rowHeight,
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(e.Designation)),
                      Expanded(child: Text(e.Department)),
                      Expanded(child: ListTile(title: Text(e.Manager.isEmpty?"No Name":e.Manager,style: textTheme.bodyText2,),
                        leading: SizedBox(
                            width: imageSize,
                            height: imageSize,
                            child: CachedImg(
                              url: e.ManagerImg,
                              itemName: e.Manager,
                              isSmall: true,
                            )),
                      )),
                    ],
                  ),
                  Divider(
                    height: 0,
                  )
                ],
              ),
            ))
            .toList(),
        itemCount: employeeList!.length,
      )
          : Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }

  Future<void> loadEmpoyees() async {
    employeeList = await Serviece.getEmployeeList(
        context: context, api_key: compRepo!.getSelectedApiKey());
    setState(() {});
  }
}

User user = User();

class User {
  List<UserInfo> userInfo = [];

  void initData(int size) {
    for (int i = 0; i < size; i++) {
      userInfo.add(UserInfo(
          "User_$i", i % 3 == 0, '+001 9999 9999', '2019-01-01', 'N/A'));
    }
  }

  ///
  /// Single sort, sort Name's id
  void sortName(bool isAscending) {
    userInfo.sort((a, b) {
      int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
      int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  ///
  /// sort with Status and Name as the 2nd Sort
  void sortStatus(bool isAscending) {
    userInfo.sort((a, b) {
      if (a.status == b.status) {
        int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
        int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
        return (aId - bId);
      } else if (a.status) {
        return isAscending ? 1 : -1;
      } else {
        return isAscending ? -1 : 1;
      }
    });
  }
}

class UserInfo {
  String name;
  bool status;
  String phone;
  String registerDate;
  String terminationDate;

  UserInfo(this.name, this.status, this.phone, this.registerDate,
      this.terminationDate);
}
