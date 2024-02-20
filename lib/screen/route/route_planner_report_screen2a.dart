import 'dart:async';
import 'dart:convert';

// import 'package:carousel_slider/carousel_slider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:glowrpt/model/employe/RoutPunchLodM.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:glowrpt/model/route/PlannerRouteLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/service/LocationServiece.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/root/activity_item_widget.dart';
import 'package:intl/intl.dart';
// import 'package:map_launcher/map_launcher.dart';
// import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toast/toast.dart';
import '../../model/party/PartySearchM.dart';
import '../../model/route/EmployeeM.dart';
import '../../model/route/RouteM.dart';
import '../../util/Constants.dart';
// import '../../util/DataProvider.dart';
import '../../util/MyKey.dart';
import '../create_new_party.dart';
import 'package:glowrpt/model/route/RouteHeaderM.dart';

// class RoutePlannerReportScreen2a extends StatefulWidget {
// ignore: must_be_immutable
class RoutePlannerReportScreen2a extends StatefulWidget {
  bool isManager;
  RouteM item;
  List<RouteEmployeeM> employeeList;
  List<RouteM>? routesList;

  RoutePlannerReportScreen2a({
    required this.isManager,
    required this.item,
    required this.employeeList,
    this.routesList,
  });

  @override
  State<RoutePlannerReportScreen2a> createState() =>
      _RoutePlannerReportScreen2aState();
}

class _RoutePlannerReportScreen2aState
    extends State<RoutePlannerReportScreen2a> {
  final PageController controller = PageController();
  RouteEmployeeM? selectedEmployee;

  CompanyRepository? companyRepo;

  PlannerRouteLoadM? routeLoad;

  DateTime selectedDate = DateTime.now();

  DateTime? selectedMMM;

  num totalCustomer = 0;

  num punchedCustomer = 0;

  PartySearchM? selectedParty;

  DateTime? selectedTime;

  CompanyRepository? compRepo;

  List<RouteDetailsBean> filteredRouteDetails = [];

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  StreamSubscription<List<RouteDetailsBean>>? _filteredRouteDetailsSubscription;

  final StreamController<List<RouteDetailsBean>>
      _filteredRouteDetailsController =
      StreamController<List<RouteDetailsBean>>.broadcast();

  @override
  void initState() {
    super.initState();
    selectedEmployee = widget.employeeList.firstWhere(
      (element) => element.EmpCode == widget.item.EMPCode,
      //  orElse: () => null
    );
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();

    // searchFocusNode.addListener(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    _filteredRouteDetailsController.close();
    _filteredRouteDetailsSubscription?.cancel();
    super.dispose();
  }

  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        titleSpacing: 15,
        leadingWidth: 38,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: isSearching
                  ? TextFormField(
                      focusNode: searchFocusNode,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.white70),
                          focusColor: Colors.white70,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70))),
                      onChanged: (value) {
                        isSearching = true;
                        searchController.text = value;
                        getFilteredRouteDetails();
                      },

                      // onFieldSubmitted: (value) => {
                      //   setState(() {
                      //     searchController.text = value;
                      //     isSearching = true;
                      //   }),
                      //   getFilteredRouteDetails(),
                      // },
                    )
                  : Text(
                      "${widget.item.RouteName}",
                      style:
                          textTheme.titleSmall?.copyWith(color: Colors.white70),
                    ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                    if (!isSearching) {
                      searchController.clear();
                      loadData();
                      if (isSearching) {
                        FocusScope.of(context).requestFocus(searchFocusNode);
                      }
                    }
                    if (_filteredRouteDetailsSubscription != null) {
                      _filteredRouteDetailsSubscription?.cancel();
                      _filteredRouteDetailsSubscription =
                          null; // Set to null after canceling
                    }
                  });
                },
                icon: Icon(isSearching ? Icons.close : Icons.search))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool isSuccess = await openAlertBox(companyRepo!);
          if (isSuccess == true) {
            setState(() {});
            print("New route added");
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Container(
            color: Colors.blueAccent,
            child: FractionallySizedBox(
              // color: Colors.blueAccent,
              heightFactor: .25,
              //  MediaQuery.of(context).size.height / 5,
              child: TableCalendar(
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
                    titleTextStyle:
                        // textTheme.caption!.copyWith(color: Colors.white)),
                        textTheme.bodySmall!.copyWith(color: Colors.white)),
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.white)),
                weekendDays: [7],
                onDaySelected: (date, events) {
                  setState(() {
                    selectedDate = date;
                    loadData();
                  });
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 16, bottom: 40, right: 16, top: 100),
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
                isSearching == true
                    ? handleSearchRoutDetails()
                    : handleRoutDetails()
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded handleRoutDetails() {
    return Expanded(
      child: routeLoad?.RouteDetails != null
          ? ListView.separated(
              itemCount: routeLoad!.RouteDetails.length,
              separatorBuilder: (_, __) => Divider(
                    indent: 70,
                    height: 0,
                  ),
              itemBuilder: (context, position) {
                var item = routeLoad?.RouteDetails[position];
                return ActivityItemWidget(
                  isManager: true,
                  item: item!,
                  routeLoad: routeLoad!,
                  Routitem: widget.item,
                  selectedDate: selectedDate,
                  selectedEmployee: selectedEmployee!,
                  onTapItem: () {
                    openAlertBox(companyRepo!, routeDetails: item);
                  },
                  onTapPunch: () {
                    openAlertBox(companyRepo!, routeDetails: item);
                  },
                );
              })
          : CupertinoActivityIndicator(),
    );
  }

  Widget handleSearchRoutDetails() {
    return Expanded(
      child: StreamBuilder<List<RouteDetailsBean>>(
        stream: _filteredRouteDetailsController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<RouteDetailsBean> filteredDetails = snapshot.data;
            return filteredDetails.isEmpty
                ? Center(
                    child: Text("No Data Found"),
                  )
                : ListView.builder(
                    itemCount: filteredDetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      var filterDataItem = filteredDetails[index];
                      return ActivityItemWidget(
                        isManager: true,
                        item: filterDataItem,
                        routeLoad: routeLoad!,
                        Routitem: widget.item,
                        selectedDate: selectedDate,
                        selectedEmployee: selectedEmployee!,
                        onTapItem: () => openAlertBox(companyRepo!,
                            routeDetails: filterDataItem),
                        onTapPunch: () => openAlertBox(companyRepo!,
                            routeDetails: filterDataItem),
                      );
                    });
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.error}"),
            );
          } else {
            return Center(
              child: Text("Searching..."),
            );
          }
        },
      ),
    );
  }

  Future openAlertBox(CompanyRepository compRepo,
      {RouteDetailsBean? routeDetails}) {
    var etcLocation = TextEditingController();
    var etCommants = TextEditingController();
    var timeController = TextEditingController();

    LatLng? position;

    var isAdd = routeDetails == null;
    if (isAdd) {
      timeController.text = DateFormat("HH:mm").format(DateTime.now());
      LocationServiece().getPosition().then((value) {
        position = LatLng(value.latitude, value.longitude);
        LocationServiece().getLocationName(position!).then((locationName) {
          etcLocation.text = locationName;
        });
      });
    } else {
      timeController.text = routeDetails.Time ?? "";
      var split = routeDetails.EMP_LAT_LNG!.split(",");
      position = LatLng(
          double.tryParse(split.first) ?? 0.0, double.tryParse(split.last) ?? 0);
      etcLocation.text = routeDetails.Location.toString();
      selectedParty = PartySearchM(
          CVCode: routeDetails.CVCode, CVName: routeDetails.CVName);
      etCommants.text = routeDetails.Remarks ?? "";
      routeLoad?.RouteDetails.remove(routeDetails);
    }
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          var textTheme = Theme.of(context).textTheme;
          var space = SizedBox(
            height: 12,
          );
          final format = DateFormat("HH:mm");
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              height: 400,
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
                        // style: textTheme.headline6,
                        style: textTheme.titleLarge,
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DropdownSearch<PartySearchM?>(
                                  popupProps: PopupProps.modalBottomSheet(
                                    showSearchBox: true,
                                    isFilterOnline: true,
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                    labelText: "Select Customer",
                                  )),
                                  asyncItems: (text) => Serviece.partySearch(
                                      context: context,
                                      api_key: compRepo.getSelectedApiKey(),
                                      Type: "C",
                                      query: text),

                                  // mode: Mode.BOTTOM_SHEET,
                                  // showSearchBox: true,
                                  // label: "Select Customer",
                                  selectedItem: selectedParty ?? null,
                                  // isFilteredOnline: true,
                                  // onFind: (text) => Serviece.partySearch(
                                  //     context: context,
                                  //     api_key: compRepo.getSelectedApiKey(),
                                  //     Type: "C",
                                  //     query: text),
                                  onChanged: (party) {
                                    selectedParty = party;
                                  },
                                  validator: (date) =>
                                      date == null ? "Invalid data" : null,
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
                                                  //fromRouteReference: "&SalesPerson=${widget.}&RouteId=${widget.item.RouteID}",
                                                )));
                                  },
                                  icon: Icon(Icons.add))
                            ],
                          ),
                          space,
                          TextField(
                            controller: etcLocation,
                            decoration: InputDecoration(
                                labelText: "Location",
                                border: textFieldBorder,
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.pin_drop_outlined),
                                  onPressed: () async {
                                    LocationResult result = await Navigator.of(
                                            context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => PlacePicker(
                                                  Constants.GOOGLE_MAP_API_KEY,
                                                  displayLocation: position,
                                                )));
                                    position = result.latLng;
                                    etcLocation.text = result.locality ??
                                        result.subLocalityLevel1?.name ??
                                        result.subLocalityLevel2?.name ??
                                        "";
                                    print(position);
                                  },
                                )),
                          ),
                          space,
                          TextField(
                            controller: etCommants,
                            decoration: InputDecoration(
                                labelText: "Comments", border: textFieldBorder),
                          ),
                          space,
                          DateTimeField(
                            controller: timeController,
                            decoration: InputDecoration(
                                labelText: "Time", border: textFieldBorder),
                            format: format,
                            initialValue: DateTime.now(),
                            readOnly: true,
                            enabled: false,
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    currentValue ?? DateTime.now()),
                              );
                              return DateTimeField.convert(time);
                            },
                            onChanged: (time) {
                              selectedTime = time;
                              print(DateFormat("HH:mm").format(selectedTime!));
                            },
                          ),
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
                          if (position == null) {
                            Toast.show("Your location not detected");
                            return;
                          }
                          var route = RouteDetailsBean(
                            CVCode: selectedParty?.code,
                            CVName: selectedParty?.name,
                            Remarks: etCommants.text,
                            Date: MyKey.displayDateFormat.format(selectedDate),
                            Location: etcLocation.text,
                            EMP_LAT_LNG:
                                "${position?.latitude},${position?.longitude}",
                            Time: timeController.text,
                            SortOrder: routeLoad!.RouteDetails.length + 1,
                            PunchStatus: "N",
                          );
                          if (routeLoad!.RouteDetails
                                  .where((element) =>
                                      element.CVCode == route.CVCode)
                                  .length >
                              0) {
                            Toast.show("Customer Already Exist");
                            return;
                          }
                          route.activitiList = route.activitiList ?? [];
                          routeLoad?.RouteDetails.add(route);
                          var isSuccess = await updateUser();
                          Navigator.pop(context, isSuccess);
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

  Future updateUser() async {
    Map params = Map();

    var headder = RouteHeader(
      api_key: companyRepo!.getSelectedApiKey(),
      routeId: widget.item.RouteID.toString(),
      EmpCode: selectedEmployee!.EmpCode.toString(),
    );
    // Filter newly added customers
    // var isNew = true;
    // var newCustomers = routeLoad?.RouteDetails
    //     .where((element) => element.isNew ?? false)
    //     .toList();

    // Map newly added customers to JSON
    // var routecv = newCustomers!
    //     .map((e) => RouteDetailsBean(
    //           CVCode: e.CVCode,
    //           CVName: e.CVName,
    //           SortOrder: e.SortOrder,
    //           Date: e.Date,
    //           Time: e.Time,
    //           Remarks: e.Remarks,
    //           Location: e.Location,
    //           EMP_LAT_LNG: e.EMP_LAT_LNG,
    //         ).toJson())
    //     .toList();
    List<RouteDetailsBean>? routecv;

    if (routeLoad != null && routeLoad!.RouteDetails.isNotEmpty) {
      var listLastCustomer = routeLoad?.RouteDetails.last;
      routecv = [
        RouteDetailsBean(
          CVCode: listLastCustomer?.CVCode,
          CVName: listLastCustomer?.CVName,
          SortOrder: listLastCustomer?.SortOrder,
          Date: listLastCustomer?.Date,
          Time: listLastCustomer?.Time,
          Remarks: listLastCustomer?.Remarks,
          Location: listLastCustomer?.Location,
          EMP_LAT_LNG: listLastCustomer?.EMP_LAT_LNG,
        )
      ];
    }
    if (routecv != null) {
      params["LinesData"] = json.encode(routecv);
    }

    params["headerData"] = json.encode([headder.toJson()]);
    // var routecv = routeLoad?.RouteDetails
    //     .map((e) => RouteDetailsBean(
    //           CVCode: e.CVCode,
    //           CVName: e.CVName,
    //           SortOrder: e.SortOrder,
    //           Date: e.Date,
    //           Time: e.Time,
    //           Remarks: e.Remarks,
    //           Location: e.Location,
    //           EMP_LAT_LNG: e.EMP_LAT_LNG,
    //         ).toJson())
    //     .toList();
   
    params["LinesData"] = json.encode(routecv);

    // print("Line Dataaaassssss: ${routecv?.length}");

    // params["headerData"] = json.encode([headder.toJson()]);

    // print("Header Dataaaas: ${headder.toJson()}");

    var response = await Serviece.updateUser(context: context, params: params);
    if (response != null) {
      // Clear the isNew flag for the newly added customers
      // newCustomers.forEach((element) {
      //   element.isNew = false;
      // });

      // widget.onUpdate();
      loadData();
      return true;
    } else {
      return false;
    }
  }

  Future<void> loadData() async {
    if (isSearching && searchController.text.isNotEmpty) {
      filteredRouteDetails = await routeLoad!.RouteDetails
          .where((element) => element.CVName!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    } else {
      routeLoad = await Serviece.getRoutePlannerReportLoad(
          api_key: companyRepo!.getSelectedApiKey(),
          EmpCode: selectedEmployee?.EmpCode ?? "",
          context: context,
          routeId: widget.item.RouteID.toString(),
          date: MyKey.displayDateFormat.format(selectedDate));

      // var filteredRouteDetails = List.from(routeLoad!.RouteDetails);
      routeLoad?.RouteDetails = routeLoad!.RouteDetails.map((e) {
        var list = (routeLoad?.RouteActivity ?? [])
            .where((element) => element.CVCode == e.CVCode)
            .toList();
        // e.activitiList = list ?? [];
        e.activitiList = list;
        print( "eeeeeeeeeeeeeee${e.toString()}");
        return e;
      }).toList();
    }

    totalCustomer = routeLoad?.TotalCustomer.first.TotalCustomer ?? 0;
    punchedCustomer = routeLoad?.TotalPunchCustomer.first.TotalCustomer ?? 0;
    // activities=routeLoad.RouteActivity;
    setState(() {});
  }

  double getValue() {
    if (totalCustomer == 0) {
      return 0;
    } else {
      return punchedCustomer / totalCustomer;
    }
  }

  Stream<List<RouteDetailsBean>> getFilteredRouteDetails() {
    _filteredRouteDetailsSubscription?.cancel(); // Cancel previous subscription

    List<RouteDetailsBean> filteredDetails;
    if (isSearching && searchController.text.isNotEmpty) {
      filteredDetails = routeLoad!.RouteDetails
          .where((element) => element.CVName!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    } else {
      // Handle the case where searchController text is empty
      filteredDetails = List.from(routeLoad!.RouteDetails);
    }

    _filteredRouteDetailsController.add(filteredDetails);

    // Assign the new subscription
    _filteredRouteDetailsSubscription =
        _filteredRouteDetailsController.stream.listen((event) {});

    return _filteredRouteDetailsController.stream;
  }
}
