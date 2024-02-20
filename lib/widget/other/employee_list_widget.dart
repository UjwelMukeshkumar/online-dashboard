import 'package:flutter/material.dart';
import 'package:glowrpt/model/attandace/EmpAttandanceM.dart';
import 'package:glowrpt/screen/ItemLedgerScreen.dart';
import 'package:glowrpt/screen/attandance/attandace_employee_screen.dart';
import 'package:glowrpt/util/MyKey.dart';

class EmployeeListWidget extends StatefulWidget {
  List<EmpAttandanceM> list;

  EmployeeListWidget(this.list);

  @override
  _EmployeeListWidgetState createState() => _EmployeeListWidgetState();
}

List<String> filters = [
  "All",
  "Overtime",
  "Full Day",
  "Partial attendance",
  "Leave"
];
var tabController;

class _EmployeeListWidgetState extends State<EmployeeListWidget>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  var filteredList = [];

  String querty="";

  @override
  void initState() {
    
    super.initState();
    tabController = TabController(length: filters.length, vsync: this);
    widget.list.sort((fist, second) =>
        ((second.AttendanceValue! - fist.AttendanceValue!) * 100).toInt());
    filterData();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      // height: MediaQuery.of(context).size.height/1.2,
      // color: Colors.red,
      child: Column(
        children: [
          AppBar(
            title: Text("Attendance Details"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TabBar(
                onTap: (index) {
                  selectedIndex = index;
                  filterData();
                },
                isScrollable: true,
                unselectedLabelColor: Colors.black.withOpacity(0.3),
                labelColor: Colors.red,
                indicatorColor: Colors.white,
                controller: tabController,
                labelPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                tabs: filters
                    .map((e) => TabChild(
                          tabController: tabController,
                          title: e,
                          postion: filters.indexOf(e),
                        ))
                    .toList()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TextField(
              decoration:
                  InputDecoration(labelText: "Search", border: textFieldBorder),
              onChanged: (text){
                querty=text;
                filterData();
              },
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, position) {
                    var item = filteredList[position];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AttandaceEmployeeScreen(item)));
                      },
                      subtitle: Text(item.AttendanceName),
                      title: Text(item.EmployeeName),
                      leading: SizedBox(
                        height: 30,
                        width: 30,
                        child: Stack(
                          children: [
                            CircularProgressIndicator(
                              value: item.AttendanceValue,
                              strokeWidth: 6,
                              color: Colors.blue,
                              backgroundColor: Colors.grey.shade200,
                            ),
                            Center(
                              child: Text(
                                item.AttendanceValue.toString(),
                                style: textTheme.caption,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  void filterData() {
    filteredList.clear();
    List<EmpAttandanceM>? tempList;
    // var tempList;
    if (selectedIndex == 0) {
      tempList = widget.list;
    } else if (selectedIndex == 1) {
      tempList = widget.list.where((element) => element.AttendanceValue! > 1).toList();
    } else if (selectedIndex == 2) {
      tempList = widget.list.where((element) => element.AttendanceValue == 1).toList();
    } else if (selectedIndex == 3) {
      tempList = widget.list.where((element) =>
          element.AttendanceValue! < 1 && element.AttendanceValue! > 0).toList();
    } else if (selectedIndex == 4) {
      tempList = widget.list.where((element) => element.AttendanceValue == 0).toList();
    }
    if(querty.isEmpty){
    filteredList.addAll(tempList!);
    }else{
      filteredList.addAll(tempList!.where((element) => element.EmployeeName.toLowerCase().contains(querty.toLowerCase())));
    }
    setState(() {});
  }
}
