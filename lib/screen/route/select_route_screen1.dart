import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/consise/ConsiceM.dart';
import 'package:glowrpt/model/route/EmployeeM.dart';
import 'package:glowrpt/model/route/RouteM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/consise/consice_tab_screen.dart';
import 'package:glowrpt/screen/route/route_map_screen.dart';
import 'package:glowrpt/screen/route/route_planner_report_screen2a.dart';
import 'package:glowrpt/screen/route/route_list_wedget.dart';
import 'package:glowrpt/screen/route/routes_screen_orderable.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/DataProvider.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/root/add_route_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../util/MyKey.dart';
import '../ItemLedgerScreen.dart';

class SelectRouteScreen1 extends StatefulWidget {
  SelectRouteScreen1({Key? key}) : super(key: key);

  @override
  _SelectRouteScreen1State createState() => _SelectRouteScreen1State();
}

class _SelectRouteScreen1State extends State<SelectRouteScreen1>
    with TickerProviderStateMixin {
  List<UserListBean> usersList = [UserListBean(User_Name: "All")]
      .followedBy(DataProvider.users.map((e) => UserListBean(User_Name: e)))
      .toList();
  TabController? tabController;

  CompanyRepository? companyRepo;

  RouteEmployeeM firstEmployee =
      RouteEmployeeM(EmpCode: "0", EmpName: "All", EmpId: "0");
  List<RouteEmployeeM> employeeList = [];

  List<RouteM> routeList = [];
  List<RouteM> routeListInactive = [];

  List<RouteM>? routeFullList;
  List<RouteM>? routeFullListInactive;

  RouteEmployeeM? selectedEmployee;

  RouteEmployeeM? selectedEmployeeForNewRoute;

  @override
  void initState() {
    super.initState();
    selectedEmployee = firstEmployee;
    employeeList.add(firstEmployee);
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    registerTabs();
    loadData(true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .85,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Users and routes"),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TabBar(
                            isScrollable: true,
                            unselectedLabelColor: Colors.black.withOpacity(0.3),
                            labelColor: Colors.red,
                            indicatorColor: Colors.white,
                            controller: tabController,
                            labelPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            tabs: employeeList.map((e) {
                              return TabChild(
                                tabController: tabController!,
                                title: e.EmpName.toString(),
                                postion: employeeList.indexOf(e),
                                color: AppColor.notificationBackgroud,
                              );
                            }).toList()),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.search),
                            ),
                            Visibility(
                              visible: false,
                              maintainInteractivity: true,
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              replacement: Text("Hello"),
                              child: DropdownSearch<RouteEmployeeM>(
                                popupProps: PopupProps.modalBottomSheet(
                                  showSearchBox: true,
                                  // isFilterOnline: true,
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                  labelText: "From Designation",
                                )),
                                // label: "From Designation",
                                // showSearchBox: true,
                                // selectedItem: fromDesignation,
                                items: employeeList,
                                onChanged: (item) {
                                  tabController!.index =
                                      employeeList.indexOf(item!);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (selectedEmployee!.EmpName != "All")
              FloatingActionButton(
                heroTag: "First",
                child: Icon(Icons.map),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RouteMapScreen(
                                selectedEmployee: selectedEmployee!,
                              )));
                },
              ),
            FloatingActionButton(
              heroTag: "Second",
              child: Icon(Icons.add),
              onPressed: () => openAlertBoxAddRoute(companyRepo!),
            ),
          ],
        ),
        body: routeList != null
            ? ListView.builder(
                // shrinkWrap: true,
                itemCount: routeList.length,
                itemBuilder: (context, postion) {
                  var item = routeList[postion];
                  return Card(
                    color: item.inactive == true ? Colors.white70 : null,
                    child: ListTile(
                      onTap: () => openRout(item),
                      title: Text(item.RouteName.toString()),
                      subtitle: isFirstEmployee(selectedEmployee!)
                          ? Text("${employeeList.firstWhere(
                                (element) => element.EmpCode == item.EMPCode,
                                // orElse: () => null,
                              )?.EmpName}")
                          : null,
                      // subtitle: Text(item.EMPCode),
                    ),
                  );
                })
            : CupertinoActivityIndicator(),
      ),
    );
  }

  Future<void> loadData(bool isFirst) async {
    employeeList.clear();
    employeeList.add(firstEmployee);
    routeList.clear();
    var response = await Serviece.getRoutLoad(
        context: context, api_key: companyRepo!.getSelectedApiKey());
    var users = List<RouteEmployeeM>.from(
        response["Employees"].map((e) => RouteEmployeeM.fromJson(e)));
    employeeList.addAll(users);
    routeFullList =
        List<RouteM>.from(response["Routes"].map((e) => RouteM.fromJson(e)));
    routeFullListInactive = List<RouteM>.from(
        response["InactiveRoutes"].map((e) => RouteM.fromJson(e)));
    routeFullList!
        .addAll(routeFullListInactive!.map((e) => e..inactive = true));
    routeListInactive.addAll(routeFullListInactive!);
    if (isFirst) {
      registerTabs();
    }
    filterList();
  }

  Future openAlertBoxAddRoute(CompanyRepository compRepo) {
    var myColor = Colors.red;
    var etcRouteName = TextEditingController();
    var tecCount = TextEditingController();
    var tecFrequency = TextEditingController();
    var tecDate = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: AddRouteWidget(
              selectedEmployee: selectedEmployee!,
              employeeList: employeeList,
              etcRouteName: etcRouteName,
              frequency: tecFrequency,
              tecDate: tecDate,
              tecCount: tecCount,
              onSave: (employeeM) async {
                selectedEmployeeForNewRoute = employeeM;
                if (tecCount.text.isEmpty) {
                  Toast.show("Enter every ${tecFrequency.text} count");
                  return;
                }
                if (!isFirstEmployee(selectedEmployee!)) {
                  selectedEmployeeForNewRoute = selectedEmployee;
                }
                if (selectedEmployeeForNewRoute == null) {
                  Toast.show("Select Employee");
                  return;
                }
                if (etcRouteName.text.isEmpty) {
                  Toast.show("Enter Route Name");
                  return;
                }
                var data = await Serviece.upsertRoute(
                  context: context,
                  api_key: compRepo.getSelectedApiKey(),
                  // routeId:null,
                  routeId: "",
                  EmpCode: selectedEmployeeForNewRoute!.EmpCode.toString(),
                  Frequency: tecFrequency.text,
                  NoOfDays: tecCount.text,
                  routeName: etcRouteName.text,
                  date: tecDate.text,
                );
                if (data != null) {
                  Navigator.pop(context);
                  selectedEmployeeForNewRoute = null;
                  loadData(false);
                }
              },
            ),
            /*  content: Container(
              width: 300.0,
              height: 300,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      )),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Add New",
                        style: textTheme.headline6,
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 8, right: 8, bottom: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropdownSearch<RouteEmployeeM>(
                            mode: Mode.BOTTOM_SHEET,
                          selectedItem: isFirstEmployee(selectedEmployee)?null:selectedEmployee,
                          items: employeeList.sublist(1),
                            label: "Select Employee",
                            isFilteredOnline: true,

                            onChanged: (party) {
                              selectedEmployeeForNewRoute = party;
                            },
                            validator: (date) =>
                            date == null ? "Invalid data" : null,
                          ),
                          space,
                          TextField(
                            controller: etcRouteName,
                            decoration: InputDecoration(
                                labelText: "Route Name", border: textFieldBorder),
                          ),
                          space,

                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: -20,
                      left: 0,
                      right: 0,
                      child: FloatingActionButton(
                        onPressed: () async {
                          print("done");
                          if( !isFirstEmployee(selectedEmployee)){
                            selectedEmployeeForNewRoute=selectedEmployee;
                          }
                          if(selectedEmployeeForNewRoute==null){
                            Toast.show("Select Employee");
                            return;
                          }
                          if(etcRouteName.text.isEmpty){
                            Toast.show("Enter Route Name", context,gravity: Toast.CENTER);
                            return;
                          }
                         var data=await Serviece.upsertRoute(context: context,api_key: compRepo.getSelectedApiKey(),routeId: null,EmpCode: selectedEmployeeForNewRoute.EmpCode,routeName: etcRouteName.text);
                          if(data!=null){
                            Navigator.pop(context);
                            selectedEmployeeForNewRoute=null;
                            loadData(false);
                          }
                        },
                        child: Icon(Icons.done),
                        backgroundColor: Colors.blueAccent,
                      ))
                ],
              ),
            ),*/
          );
        });
  }

  openRout(RouteM item) {
    if (item.inactive == true) {
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RoutePlannerReportScreen2a(
                    isManager: true,
                    item: item,
                    employeeList: employeeList,
                  )));
    }
  }

  void registerTabs() {
    tabController = TabController(
        length: employeeList.length, initialIndex: 0, vsync: this);
    tabController!.addListener(() {
      filterList();
    });
  }

  bool isFirstEmployee(RouteEmployeeM employeeM) {
    return (employeeM.EmpCode == "0" &&
        employeeM.EmpId == "0" &&
        employeeM.EmpName == "All");
  }

  void filterList() {
    selectedEmployee = employeeList[tabController!.index];
    routeList.clear();
    if (tabController!.index == 0) {
      routeList.addAll(routeFullList!);
    } else {
      routeList.addAll(routeFullList!
          .where((element) => element.EMPCode == selectedEmployee!.EmpCode));
    }
    setState(() {});
  }
}
