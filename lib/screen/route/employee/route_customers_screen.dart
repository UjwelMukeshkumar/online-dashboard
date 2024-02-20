import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/model/employe/EmpLoadM.dart';
import 'package:glowrpt/model/location/DistanceM.dart' as dist;
import 'package:glowrpt/model/route/PlannerRouteLoadM.dart';
import 'package:glowrpt/model/route/RouteM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/route/employee/best_route_map_screen.dart';
import 'package:glowrpt/service/LocationServiece.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/util/TravelingSalesManProblem.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RouteCustomersScreen extends StatefulWidget {
  RouteM item;
  EmpLoadM empLoadM;

  RouteCustomersScreen({Key? key, required this.item, required this.empLoadM})
      : super(key: key);

  @override
  State<RouteCustomersScreen> createState() => _RouteCustomersScreenState();
}

class _RouteCustomersScreenState extends State<RouteCustomersScreen> {
  CompanyRepository? companyRepo;

  PlannerRouteLoadM? routeLoad;

  num? totalCustomer;

  num? punchedCustomer;

  List<RouteDetailsBean>? routeDetails;
  bool isSelectedAll = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Customers")),
      body: Column(
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.trailing,
            value: isSelectedAll,
            onChanged: (value) {
              setState(() {
                isSelectedAll = value!;
                // for (var item in routeDetails!) {
                //   // if (item.EMP_LAT_LNG?.isNotEmpty??false) {
                //   //   item.isSelected = value;
                //   // }
                //   item.isSelected = value;
                // }
              });
            },
            title: const Text("Select All"),
          ),
          const Divider(thickness: 2),
          Expanded(
            child: routeDetails != null
                ? ListView.builder(
                    itemCount: routeDetails?.length,
                    // itemCount: routeDetails?.where((element) => element.Location?.isNotEmpty??false).length,
                    itemBuilder: (context, postion) {
                      var item = routeDetails?[postion];
                      return CheckboxListTile(
                        key: Key("${item?.CVCode}"),
                        title: Text("${item?.CVName}"),
                        subtitle: Text("${item?.Location}"),
                        value: item?.isSelected,
                        // onChanged: item!.EMP_LAT_LNG!.isNotEmpty
                        //     ? (value) {
                        //         setState(() {
                        //           item.isSelected = value!;
                        //         });
                        //       }
                        //     : null,
                        onChanged: (value) {
                          setState(() {
                            item?.isSelected = value!;
                               // Check if any item is not selected to uncheck "Select All"
                            isSelectedAll =
                                routeDetails!.every((item) => item.isSelected);
                          });
                        },
                      );
                    })
                : Center(child: CupertinoActivityIndicator()),
          ),

          ElevatedButton(
              onPressed: () async {
                if (routeDetails!.isNotEmpty) {
                  Get.off(() => BestRouteMapScreen(
                        routeDetails: routeDetails!,
                        item: widget.item,
                        empLoadM: widget.empLoadM,
                      ));
                  // Get.to(()=>BestRouteMapScreen(routeDetails: routeDetails,item: widget.item,));
                } else {
                  showToast("Select Route");
                }
              },
              child: Text("Show Best Route")),
          // ElevatedButton(onPressed: () {}, child: Text("Begin Routes"))
        ],
      ),
    );
  }

  Future<void> loadData() async {
    routeLoad = await Serviece.getRoutePlannerReportLoad(
        api_key: companyRepo!.getSelectedApiKey(),
        EmpCode: widget.empLoadM.EmployeeDetails.first.EmpCode,
        context: context,
        routeId: widget.item.RouteID.toString(),
        date: MyKey.getCurrentDate());
    routeDetails = routeLoad!.RouteDetails;
    totalCustomer = routeLoad!.TotalCustomer.first.TotalCustomer;
    punchedCustomer = routeLoad!.TotalPunchCustomer.first.TotalCustomer;
    setState(() {});
  }
}
