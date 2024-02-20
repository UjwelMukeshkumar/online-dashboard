// import 'dart:convert';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:glowrpt/library/DateFactory.dart';
import 'package:glowrpt/model/route/EmployeeM.dart';
import 'package:glowrpt/model/route/PlannerRouteLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/route/employee/route_summary_screen.dart';
// import 'package:glowrpt/screen/transaction_details.dart';
import 'package:glowrpt/service/BackgroundLocationServiece.dart';
import 'package:glowrpt/service/FirebaseServiece.dart';
// import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/util/loader_animation.dart';
import 'package:glowrpt/widget/root/activity_item_widget.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toast/toast.dart';

import '../../../model/employe/EmpLoadM.dart';
// import '../../../model/employe/EmployeeM.dart';
import '../../../model/party/PartySearchM.dart';
import '../../../model/route/RouteEndM.dart';
import '../../../model/route/RouteM.dart';
import '../../../service/LocationServiece.dart';
import '../../../util/MyKey.dart';
import '../../create_new_party.dart';
// import '../../transaction/payment_recipt_screen.dart';
// import '../../transaction/sales_invoice_screen.dart';

class EmployeeRoutePlannerReportScreen2a extends StatefulWidget {
  RouteM item;
  EmpLoadM empLoadM;
  // List<RouteM> routesList;

  // int rootId;
  // RouteDetailsBean rootDetails;

  EmployeeRoutePlannerReportScreen2a(
      {required this.item,required this.empLoadM});

  @override
  State<EmployeeRoutePlannerReportScreen2a> createState() =>
      _EmployeeRoutePlannerReportScreen2aState();
}

class _EmployeeRoutePlannerReportScreen2aState
    extends State<EmployeeRoutePlannerReportScreen2a> {
  final PageController controller = PageController();

  // EmployeeM selectedEmployee;

  CompanyRepository? companyRepo;

  PlannerRouteLoadM? routeLoad;

  DateTime selectedDate = DateTime.now();

  DateTime? selectedMMM;

  num totalCustomer = 0;

  num punchedCustomer = 0;

  PartySearchM? selectedParty;

  DateTime? selectedTime;
  var etcCustomerName = TextEditingController();
  var etcCode = TextEditingController();
  var timeController = TextEditingController();

  String? _selectedMenu;

  bool showProgress = false;

  List<RouteDetailsBean> routeDetailsList = [];

  String searchValue = "";
  bool isLoading = false;
  BackgroundLocationServiece? backgroundLocation;
  @override
  void initState() {
    super.initState();

    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    backgroundLocation = Provider.of<BackgroundLocationServiece>(context);
    backgroundLocation!.getTrackingStatus();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: EasySearchBar(
          backgroundColor: Colors.blueAccent,
          titleTextStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("${widget.item.RouteName}"),
          onSearch: (value) {
            searchValue = value;
            filter(searchValue);
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            heroTag: "first",
            onPressed: ()  {
            endRoute();
            },
            label: Text("End Route"),

            backgroundColor: Colors.blueAccent,
          ),
          FloatingActionButton(
            heroTag: "second",
            onPressed: () async {
              await openAlertBox(companyRepo!);
              setState(() {});
              print("New route added");
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blueAccent,
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: isLoading
          ? LoadingAnimation()
          : Stack(
              children: [
                Container(
                  color: Colors.blueAccent,
                  height: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    children: [
                      TableCalendar(
                        firstDay: DateTime(2000),
                        lastDay: DateTime(3000),
                        focusedDay: selectedDate,
                        selectedDayPredicate: (day) {
                          return isSameDay(selectedDate, day);
                        },
                        onPageChanged: (date) {
                          selectedMMM = date;
                        },
                        headerVisible: true,
                        calendarFormat: CalendarFormat.week,
                        availableGestures: AvailableGestures.all,
                        headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            headerPadding: EdgeInsets.only(left: 16, bottom: 8),
                            // headerMargin: EdgeInsets.zero,
                            rightChevronVisible: false,
                            leftChevronVisible: false,
                            titleTextStyle: textTheme.caption!
                                .copyWith(color: Colors.white)),
                        daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(color: Colors.white)),
                        weekendDays: [7],
                        onDaySelected: (date, events) {
                          setState(() {
                            selectedDate = date;
                            loadData();
                          });
                        },
                      )
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(
                      left: 16, bottom: 40, right: 16, top: 100),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Today Plan"),
                                Text("$punchedCustomer/$totalCustomer"),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            LinearProgressIndicator(value: getValue()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: routeDetailsList != null
                            ? ListView.separated(
                                itemCount: routeDetailsList.length,
                                separatorBuilder: (_, __) => Divider(
                                      indent: 70,
                                      height: 0,
                                    ),
                                itemBuilder: (context, position) {
                                  var item = routeDetailsList[position];
                                  var isApproved = item.Approved == "Y";
                                  return ActivityItemWidget(
                                    isManager: true,
                                    item: item,
                                    routeLoad: routeLoad!,
                                    Routitem: widget.item,
                                    selectedDate: selectedDate,
                                    selectedEmployee: RouteEmployeeM.fromJson(
                                        widget.empLoadM.EmployeeDetails.first
                                            .toJson()),
                                    onTapItem: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateNewParty(
                                                      code: item.CVCode!,
                                                    )));
                                      });
                                    },
                                    onTapPunch: () {
                                      setState(() {
                                        if (isApproved) {
                                          if (item.PunchStatus == "No Punch") {
                                            item.PunchStatus = "in";
                                          } else if (item.PunchStatus == "in") {
                                            item.PunchStatus = "out";
                                          } else if (item.PunchStatus ==
                                              "out") {
                                            item.PunchStatus = "in";
                                          }
                                          updatePunchStatus(item);
                                        } else {
                                          Toast.show(
                                              "Punch Not allowed for this item",
                                          );
                                        }
                                      });
                                    },
                                  );
                                })
                            : CupertinoActivityIndicator(),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Visibility(
                      visible: showProgress,
                      child: CupertinoActivityIndicator(
                        radius: 50,
                      )),
                )
              ],
            ),
    );
  }

  Future openAlertBox(CompanyRepository compRepo) {
    timeController.text = DateFormat("HH:mm").format(DateTime.now());

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          var textTheme = Theme.of(context).textTheme;
          var space = SizedBox(
            height: 12,
          );
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
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
                        "Add New Customer",
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
                          space,
                          space,
                          space,
                          Row(
                            children: [
                              Expanded(
                                child: DropdownSearch<PartySearchM>(
                                   popupProps: PopupProps.bottomSheet(
                                    showSearchBox: true,
                                    isFilterOnline: true,
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                    labelText: "Party",
                                  )),
                                   asyncItems: (text) => Serviece.partySearch(
                                      context: context,
                                      api_key: compRepo.getSelectedApiKey(),
                                      Type: "C",
                                      query: text),
                                  // mode: Mode.BOTTOM_SHEET,
                                  //autoFocusSearchBox: true,
                                  // showSearchBox: true,
                                  // label: "Party",
                                  // isFilteredOnline: true,
                                  // onFind: (text) => Serviece.partySearch(
                                  //     context: context,
                                  //     api_key: compRepo.getSelectedApiKey(),
                                  //     Type: "C",
                                  //     query: text),
                                  onChanged: (party) {
                                    selectedParty = party;
                                    etcCode.text = party!.CVCode.toString();
                                  },
                                  // onChanged: (party) => getSinglePartyDetails(party),
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    var isCreated = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateNewParty(
                                                  type: "C",
                                                  title: "Create New Customer",
                                                  fromRouteReference:
                                                      "&SalesPerson=${widget.empLoadM.EmployeeDetails.first.EmpID}&RouteId=${widget.item.RouteID}",
                                                )));
                                  },
                                  icon: Icon(Icons.add))
                            ],
                          ),
                          /* TextField(
                            controller: etcCustomerName,
                            decoration: InputDecoration(
                                labelText: "Customer Name",
                                border: textFieldBorder),
                          ),*/
                          space,
                          TextField(
                            readOnly: false,
                            controller: etcCode,
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: "Customer Code",
                                border: textFieldBorder),
                          ),
                          space,
                        ],
                      ),
                    ),
                  ),
                  isLoading
                      ? LoadingAnimation()
                      : Positioned(
                          bottom: -20,
                          left: 0,
                          right: 0,
                          child: FloatingActionButton(
                            onPressed: () async {
                              // if (etcCustomerName.text.isEmpty) {
                              //   Toast.show("Enter Customer Name", context,
                              //       gravity: Toast.CENTER);
                              //   return;
                              // }
                              if (etcCode.text.isEmpty) {
                                Toast.show("Enter Customer Code");
                                return;
                              }

                              await addCustomerRequest();
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.done),
                            backgroundColor: Colors.blueAccent,
                          ))
                ],
              ),
            ),
          );
        });
  }

  Future<void> loadData() async {
    routeLoad = await Serviece.getRoutePlannerReportLoad(
        api_key: companyRepo!.getSelectedApiKey(),
        EmpCode: widget.empLoadM.EmployeeDetails.first.EmpCode,
        context: context,
        routeId: widget.item.RouteID.toString(),
        date: MyKey.displayDateFormat.format(selectedDate));
    totalCustomer = routeLoad?.TotalCustomer.first.TotalCustomer??0;
    punchedCustomer = routeLoad!.TotalPunchCustomer.first.TotalCustomer;
    routeLoad?.RouteDetails = routeLoad!.RouteDetails.map((e) {
      // routeDetailsList = routeLoad.RouteDetails.map((e) {
      var list = (routeLoad?.RouteActivity ?? [])
          .where((element) => element.CVCode == e.CVCode)
          .toList();
      e.activitiList = list ?? [];
      return e;
    }).toList();

    showProgress = false;
    filter(searchValue);
  }

  filter(String query) {
    routeDetailsList.clear();
    if (query.isEmpty) {
      routeDetailsList.addAll(routeLoad!.RouteDetails);
    }else{
      routeDetailsList = routeLoad!.RouteDetails
          .where((element) =>
              element.toString().toLowerCase().contains(query) ?? false)
          .toList();
    }
  
    setState(() {});
  }

  double getValue() {
    if (totalCustomer == 0) {
      return 0;
    } else {
      return punchedCustomer / totalCustomer;
    }
  }

  Future<void> addCustomerRequest() async {
    setState(() {
      isLoading = true;
    });
    var requstDetails = await Serviece.employeeRouteRequest(
        context: context,
        api_key: companyRepo!.getSelectedApiKey(),
        emp_code: widget.empLoadM.EmployeeDetails.first.EmpCode,
        RouteId: widget.item.RouteID.toString(),
        CVName: selectedParty!.name,
        CVCode: etcCode.text,
        RequestType: PushNotificationType.addNewCustomer);
    FirebaseServiece.sentPushNotification(
        requestDetailsM: requstDetails,
        title: "Add New Customer Request!",
        body:
            "${widget.empLoadM.EmployeeDetails.first.EmpName} wants to add ${selectedParty!.name}",
        type: PushNotificationType.addNewCustomer);
    if (requstDetails != null) {
      isLoading = false;
      Toast.show('Added' );
      loadData();
    }
  }

  Future<void> updatePunchStatus(RouteDetailsBean item) async {
    showProgress = true;
    setState(() {});
    Position position = await LocationServiece().getPosition();
    String locationName = await LocationServiece()
        .getLocationName(LatLng(position.latitude, position.longitude));
    if (position == null) {
      Toast.show("Location Not detected");
      loadData();
      return;
    }
    var response = await Serviece.updatePunchStatus(
        context: context,
        api_key: companyRepo!.getSelectedApiKey(),
        EmpCode: widget.empLoadM.EmployeeDetails.first.EmpCode,
        routeId: widget.item.RouteID.toString(),
        LAT_LNG: "${position.latitude},${position.longitude}",
        Location: locationName,
        CVCode: item.CVCode!,
        date: MyKey.displayDateFormat.format(selectedDate),
        punchStatus: item.PunchStatus!);
    loadData();
    if (response != null) {
      Toast.show("Status Updated");
    }
  }

  Future<void> endRoute() async {
    Position position = await LocationServiece().getPosition();
    String locationName = await LocationServiece()
        .getLocationName(LatLng(position.latitude, position.longitude));
    RouteEndM routeEndM=  await Serviece.routeBeginEnd(
        apiKey: companyRepo!.getSelectedApiKey(),
        date: MyKey.getCurrentDate(),
        beginEnd: "E",
        empCode: companyRepo!.getSelectedUser().userCode!,
        latLng: "${position.latitude},${position.longitude}",
        routeId: widget.item.RouteID.toString(),
        location: locationName
    );
    backgroundLocation!.stopTracking();
    Get.off(RouteSummaryScreen(routeEndM: routeEndM,));
  }

}

enum Menu { Sales, SalesReturn, SalesOrder, Receipt, Payment }

extension MenuText on Menu {
  String get toText {
    switch (this) {
      case Menu.Sales:
        return "Sales";
        // break;
      case Menu.SalesReturn:
        return "Sales Return";
        // break;
      case Menu.SalesOrder:
        return "Sales Order";
        // break;
      case Menu.Receipt:
        return "Receipt";
        // break;
      case Menu.Payment:
        return "Payment";
        // break;
    }
  }

  int get toFormId {
    switch (this) {
      case Menu.Sales:
        return DocumentFormId.Sales;
        // break;
      case Menu.SalesReturn:
        return DocumentFormId.SalesReturn;
        // ;
        // break;
      case Menu.SalesOrder:
        return DocumentFormId.SalesOrder;
        // ;
        // break;
      case Menu.Receipt:
        return DocumentFormId.Receipt;
        // ;
        // break;
      case Menu.Payment:
        return DocumentFormId.Payment;
        // ;
        // break;
    }
  }
}
