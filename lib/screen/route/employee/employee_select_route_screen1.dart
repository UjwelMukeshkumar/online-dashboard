import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glowrpt/model/consise/ConsiceM.dart';
import 'package:glowrpt/model/employe/EmpLoadM.dart';
import 'package:glowrpt/model/route/EmployeeM.dart';
import 'package:glowrpt/model/route/RouteM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/consise/consice_tab_screen.dart';
import 'package:glowrpt/screen/route/employee/route_customers_screen.dart';
import 'package:glowrpt/screen/route/route_planner_report_screen2a.dart';
import 'package:glowrpt/screen/route/route_list_wedget.dart';
import 'package:glowrpt/screen/route/routes_screen_orderable.dart';
import 'package:glowrpt/service/FirebaseServiece.dart';
import 'package:glowrpt/service/LocationServiece.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/DataProvider.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../model/route/PlannerRouteLoadM.dart';
import '../../../util/MyKey.dart';
import 'employee_route_planner_report_screen2a.dart';
import 'package:get/get.dart';

class EmployeeSelectRouteScreen1 extends StatefulWidget {
  EmpLoadM empLoadM;

  // int rootId;
  // RouteDetailsBean rootDetails;

  EmployeeSelectRouteScreen1({
   required this.empLoadM,
  });

  @override
  _EmployeeSelectRouteScreen1State createState() =>
      _EmployeeSelectRouteScreen1State();
}

class _EmployeeSelectRouteScreen1State extends State<EmployeeSelectRouteScreen1>
    with TickerProviderStateMixin {
 /* List<UserListBean> usersList = [UserListBean(User_Name: "All")]
      .followedBy(DataProvider.users.map((e) => UserListBean(User_Name: e)))
      .toList();*/
  TabController? tabController;

  CompanyRepository? companyRepo;

  // EmployeeM firstEmployee = EmployeeM(EmpCode: "0", EmpName: "All", EmpId: "0");
  // List<EmployeeM> employeeList = [];

  List<RouteM> routeList = [];

  List<RouteM>? routeFullList;

  RouteEmployeeM? selectedEmployee;

  RouteEmployeeM? selectedEmployeeForNewRoute;

  List<RouteM>? routeFullListInactive;

  @override
  void initState() {
    super.initState();
    // selectedEmployee = firstEmployee;
    // employeeList.add(firstEmployee);
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users and routes".tr),
      ),
      body: routeList != null
          ? ListView.builder(
              itemCount: routeList.length,
              itemBuilder: (context, postion) {
                var item = routeList[postion];
                return Card(
                  color: item.inactive == true ? Colors.white70 : null,
                  child: ListTile(
                    onTap: () => showPopup(item),
                    title: Text(item.RouteName.toString()),
                    trailing: Text("${item.getText}",style: TextStyle(color: item.getColor)),
                    // subtitle: Text(item.EMPCode),
                  ),
                );
              })
          : CupertinoActivityIndicator(),
    );
  }

  Future<void> loadData() async {
    var response = await Serviece.getRoutLoadByEmployee(
        context: context,
        api_key: companyRepo!.getSelectedApiKey(),
        emp_code: widget.empLoadM.EmployeeDetails[0].EmpCode);

    // employeeList.addAll(users);
    routeFullList =
        List<RouteM>.from(response["Routes"].map((e) => RouteM.fromJson(e)));
    routeFullListInactive = List<RouteM>.from(
        response["InactiveRoutes"].map((e) => RouteM.fromJson(e)));
    routeFullList?.addAll(routeFullListInactive!.map((e) => e..inactive = true));
    routeList.clear();
    routeList.addAll(routeFullList !);
    setState(() {});
  }

  showPopup(RouteM item) async {
    if (item.inactive == true) {
      var requstDetails = await Serviece.employeeRouteRequest(
          context: context,
          api_key: companyRepo!.getSelectedApiKey(),
          emp_code: widget.empLoadM.EmployeeDetails.first.EmpCode,
          RouteId: item.RouteID.toString(),
          RequestType: PushNotificationType.changeRouteActiveState);

      FirebaseServiece.sentPushNotification(
          requestDetailsM: requstDetails,
          title: "Change route status!",
          body:
              "${widget.empLoadM.EmployeeDetails.first.EmpName} wants to make active ${item.RouteName}",
          type: PushNotificationType.changeRouteActiveState);

      if (requstDetails != null) {
        Toast.show('Request Sent');
      }
      return;
    }

   if(!item.isRouteBigin){
     // openRout(item);
    await Get.to(()=>RouteCustomersScreen(item: item,empLoadM: widget.empLoadM,));
    loadData();
 /*    Get.defaultDialog(
       title: 'Are you starting "${item.RouteName}" Route?',
       content: Column(children: [
         ElevatedButton(
             onPressed: () async {
               Position position = await LocationServiece().getPosition();
               String locationName = await LocationServiece()
                   .getLocationName(LatLng(position.latitude, position.longitude));
               await Serviece.routeBeginEnd(
                   apiKey: companyRepo.getSelectedApiKey(),
                   date: MyKey.getCurrentDate(),
                   beginEnd: "B",
                   empCode: companyRepo.getSelectedUser().userCode,
                   latLng: "${position.latitude},${position.longitude}",
                   routeId: item.RouteID.toString(),
                 location: locationName
               );
               Get.back();
               openRout(item);
             },
             child: Text("Yes, Begin Route"))
       ]),
     );*/
   }else{
     openRout(item);
   }
  }

  openRout(RouteM item) async {
   await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmployeeRoutePlannerReportScreen2a(
                  item: item,
                  empLoadM: widget.empLoadM,
                )));
   loadData();
  }
}
