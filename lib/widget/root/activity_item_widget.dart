
import 'package:flutter/material.dart';

import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/model/route/EmployeeM.dart';
import 'package:glowrpt/model/route/PlannerRouteLoadM.dart';
import 'package:glowrpt/model/route/RouteM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/route/employee/employee_route_planner_report_screen2a.dart';
import 'package:glowrpt/screen/transaction/payment_recipt_screen.dart';
import 'package:glowrpt/screen/transaction/sales_invoice_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';

class ActivityItemWidget extends StatefulWidget {
  bool isManager;
  RouteDetailsBean item;
  RouteM Routitem;
  PlannerRouteLoadM routeLoad;
  RouteEmployeeM selectedEmployee;
  DateTime selectedDate;
  VoidCallback onTapItem;
  VoidCallback onTapPunch;

  ActivityItemWidget({
    required this.isManager,
    required this.item,
    required this.Routitem,
    required this.routeLoad,
    required this.selectedEmployee,
    required this.selectedDate,
    required this.onTapItem,
    required this.onTapPunch,
  });

  @override
  State<ActivityItemWidget> createState() => _ActivityItemWidgetState();
}

class _ActivityItemWidgetState extends State<ActivityItemWidget> {
  late CompanyRepository companyRepo;

  late PartySearchM selectedParty;

  late DateTime selectedTime;

  @override
  void initState() {
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
 

    var textTheme = Theme.of(context).textTheme;
    var isApproved = widget.item.Approved == "Y";
    return Container(
      color: isApproved ? Colors.transparent : AppColor.barBlue,
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  // child: Text("07:30 \nAM"),
                  child: Text(
                    DateFormat("hh:mm \n \a").format(
                        DateFormat("HH:mm").parse(widget.item.Time.toString())),
                    textAlign: TextAlign.center,
                    style: textTheme.caption,
                  ))),
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: widget.onTapItem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.item.CVName}",
                      style: textTheme.bodyMedium,
                    ),
                    Text(
                      widget.item.Location ?? "sdfdsfsdf",
                      style: textTheme.bodySmall,
                    )
                  ],
                ),
              )),
          Expanded(
              child: Row(
            children: [
              InkWell(
                onTap: widget.onTapPunch,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  child: Icon(
                    Icons.circle,
                    color: getColor(widget.item),
                    size: 18,
                  ),
                ),
              ),
              Visibility(
                visible: isApproved,
                child: PopupMenuButton<Menu>(
                    padding: EdgeInsets.zero,
                    // Callback that sets the selected popup menu item.
                    onSelected: (Menu menuItem) {
                      switch (menuItem) {
                        case Menu.Sales:
                        case Menu.SalesReturn:
                        case Menu.SalesOrder:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SalesInVoiceScreen(
                                        title: menuItem.toText,
                                        formId: menuItem.toFormId,
                                        rootDetails: widget.item,
                                        empId: widget.selectedEmployee.EmpId,
                                        rootId:
                                            widget.Routitem.RouteID?.toInt(),
                                      )));
                          break;
                        case Menu.Receipt:
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentReciptScreen(
                                        isRecipt: true,
                                        rootId:
                                            widget.Routitem.RouteID?.toInt(),
                                        rootDetails: widget.item,
                                        empId: widget.selectedEmployee.EmpId,
                                      )));
                          break;
                        case Menu.Payment:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PaymentReciptScreen(
                                        isRecipt: false,
                                        rootId: widget.Routitem.RouteID?.toInt(),
                                        rootDetails: widget.item,
                                        empId: widget.selectedEmployee.EmpId,
                                      )));
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Menu>>[
                          PopupMenuItem<Menu>(
                            value: Menu.Sales,
                            child: Text(Menu.Sales.toText),
                          ),
                          PopupMenuItem<Menu>(
                            value: Menu.SalesReturn,
                            child: Text(Menu.SalesReturn.toText),
                          ),
                          PopupMenuItem<Menu>(
                            value: Menu.SalesOrder,
                            child: Text(Menu.SalesOrder.toText),
                          ),
                          PopupMenuItem<Menu>(
                            value: Menu.Receipt,
                            child: Text(Menu.Receipt.toText),
                          ),
                          PopupMenuItem<Menu>(
                            value: Menu.Payment,
                            child: Text(Menu.Payment.toText),
                          ),
                        ]),
              )
            ],
          ))
        ]),

        
        children: (widget.item.activitiList ?? []).map((e) {
          var isPunch = e.Type == "Punch";
          return Column(
            children: [
              (widget.item.activitiList!.indexOf(e) == 0)
                  ? Divider(
                      thickness: 2,
                      endIndent: 8,
                      indent: 8,
                    )
                  : Container(),
              InkWell(
                onTap: () async {
                  if (isPunch) {
                    var split = e.Loacation?.split(",");
                    final availableMaps = await MapLauncher.installedMaps;
                    await availableMaps.first.showMarker(
                      coords: Coords(
                          double.parse(split!.first), double.parse(split.last)),
                      title: "${e.Remarks}",
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(Icons.access_time, size: 12),
                      ),
                      Text(
                       "${ e.Remarks}",
                        style:
                            TextStyle(color: isPunch ? AppColor.barBlue : null),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
          ;
        }).toList(),
      ),
    );
    ;
  }

  Color getColor(RouteDetailsBean item) {
    switch (item.PunchStatus) {
      case "No Punch":
        return Colors.grey;
        break;
      case "in":
        return Colors.green;
        break;
      case "out":
        return Colors.red;
        break;
      default:
        return Colors.purple;
    }
  }
}
