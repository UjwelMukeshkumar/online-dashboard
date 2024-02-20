import 'dart:math';

import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/manager/roaster/RoastLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RoasterHrmScreen extends StatefulWidget {
  @override
  _RoasterHrmScreenState createState() => _RoasterHrmScreenState();
}

class _RoasterHrmScreenState extends State<RoasterHrmScreen> {
  CompanyRepository? compRepo;

  List<String>? selectedDateList;

  RoastLoadM? roasterLoad;

  List<Employee_DetailsBean>? employeeDetails;
  List<String> columnData = [];

  List<Shift_RoasterBean>? shiftRoaster;

  List<Shift_DetailsBean>? shiftDetails;
  Map<String, List<Shift_DetailsBean>> roaster = Map();
  var allDepartuments = DepartmentBean(Id: null, Name: "All");
  List<DepartmentBean>? departMents;

  DepartmentBean? selectedDepartment;

  @override
  void initState() {
    super.initState();
    selectedDateList = getEndPointsOfCurrentDate(DateTime.now());
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    selectedDepartment = allDepartuments;
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColor.background,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back)),
                  Expanded(
                    child: DaysSelectorWidget(
                      hideTriling: true,
                      valueChanged: (dateList) {
                        setState(() {
                          selectedDateList = dateList;
                        });
                        selectedDepartment = allDepartuments;
                        loadData();
                      },
                      intialText: "This Month",
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: roasterLoad != null
                  ? ListView(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        departMents != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: DropdownSearch<DepartmentBean>(
                                  popupProps: PopupProps.modalBottomSheet(
                                    showSearchBox: true,
                                    isFilterOnline: true,
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                    labelText: "Departments",
                                  )),
                                  // mode: Mode.BOTTOM_SHEET,
                                  // showSearchBox: true,
                                  selectedItem: selectedDepartment,
                                  items: departMents!,
                                  // label: "Departments",
                                  // isFilteredOnline: true,
                                  onChanged: (departument) {
                                    selectedDepartment = departument;
                                    loadData();
                                  },
                                  validator: (date) =>
                                      date == null ? "Invalid data" : null,
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child:
                              // Text("Testing.....................")
                              Container(
                                  height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          height:
                                              MediaQuery.of(context).size.height,
                                          child: DataTable2(
                                            showBottomBorder: true,
                                            dividerThickness: 0,
                                            horizontalMargin: 0,
                                            minWidth: 1050,
                                            lmRatio: 2,
                                            dataRowHeight: 30,
                                            columnSpacing: 0,
                                            columns: columnData.map((e) {
                                              int index = columnData.indexOf(e);
                                              return DataColumn2(
                                                size: index == 0
                                                    ? ColumnSize.L
                                                    : ColumnSize.S,
                                                label: Center(
                                                  child: Text(e,
                                                      textAlign: TextAlign.center),
                                                ),
                                              );
                                            }).toList(),
                                            rows: roaster.keys
                                                .map(
                                                  (empId) => DataRow2(
                                                      cells: roaster[empId]!
                                                          .map((rosterItem) {
                                                    int index = roaster[empId]!
                                                        .indexOf(rosterItem);
                                                    if (index == 0) {
                                                      return DataCell(Text(
                                                          "${rosterItem.ShiftName}"));
                                                    } else {
                                                      return DataCell(
                                                          PopupMenuButton(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color:
                                                                    Colors.black12),
                                                            color: rosterItem
                                                                        .ShiftColour !=
                                                                    null
                                                                ? Color(int.parse(
                                                                    rosterItem
                                                                        .ShiftColour!))
                                                                : null,
                                                          ),
                                                          width: double.infinity,
                                                          height: double.infinity,
                                                        ),
                                                        padding: EdgeInsets.zero,
                                                        itemBuilder:
                                                            (BuildContext context) {
                                                          return shiftDetails!.map<
                                                                  PopupMenuItem<
                                                                      Shift_DetailsBean>>(
                                                              (shift) {
                                                            return PopupMenuItem<
                                                                Shift_DetailsBean>(
                                                              value: shift,
                                                              child: ListTile(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  shiftAssigned(
                                                                      rosterItem,
                                                                      empId,
                                                                      shift);
                                                                },
                                                                title: Text(shift
                                                                    .ShiftName!),
                                                                subtitle: Text(shift
                                                                        .ShiftValue
                                                                    .toString()),
                                                                leading: Container(
                                                                  height: 30,
                                                                  width: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black12),
                                                                    color: Color(int
                                                                        .parse(shift
                                                                            .ShiftColour!)),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }).toList();
                                                        },
                                                      ));
                                                    }
                                                  }).toList()),
                                                )
                                                .toList(),
                                          )
                              
                                          // DataTable2(
                                          //   showBottomBorder: true,
                                          //   dividerThickness: 0,
                                          //   horizontalMargin: 0,
                                          //   minWidth: 1050,
                                          //   lmRatio: 2,
                                          //   dataRowHeight: 30,
                                          //   columnSpacing: 0,
                                          //   // columns: [
                                          //   //   DataColumn(label: Text('Date')),
                                          //   //   DataColumn(label: Text('Time')),
                                          //   // ],
                                          //   // rows: [
                                          //   //   DataRow(cells: [DataCell(Text('Date1111')),
                                          //   //     DataCell(Text('Time111111'))
                                          //   //   ])
                                          //   // ],
                                          //   columns: columnData.map((e) {
                                          //     int index = columnData.indexOf(e);
                                          //     return DataColumn2(
                                          //       size: index == 0
                                          //           ? ColumnSize.L
                                          //           : ColumnSize.S,
                                          //       label: Center(
                                          //         child:
                                          //             Text(e, textAlign: TextAlign.center),
                                          //       ),
                                          //     );
                                          //   }).toList(),
                                          //   rows: roaster.keys
                                          //       .map(
                                          //         (empId) => DataRow2(
                                          //             cells:
                                          //                 roaster[empId]!.map((rosterItem) {
                                          //           int index =
                                          //               roaster[empId]!.indexOf(rosterItem);
                                          //           // return DataCell(Text("${l?.ShiftName?.characters?.first}"));
                                          //           if (index == 0) {
                                          //             return DataCell(
                                          //                 Text("${rosterItem?.ShiftName}"));
                                          //           } else {
                                          //             return DataCell(PopupMenuButton(
                                          //               child: Container(
                                          //                 decoration: BoxDecoration(
                                          //                   border: Border.all(
                                          //                       width: 1,
                                          //                       color: Colors.black12),
                                          //                   color: rosterItem.ShiftColour !=
                                          //                           null
                                          //                       ? Color(int.parse(rosterItem
                                          //                           .ShiftColour!))
                                          //                       : null,
                                          //                 ),
                                          //                 width: double.infinity,
                                          //                 height: double.infinity,
                                          //                 // child: Text(DateFormat("dd").format(rosterItem.shiftDate)),
                                          //               ),
                                          //               // onSelected: _select,
                                          //               padding: EdgeInsets.zero,
                              
                                          //               itemBuilder:
                                          //                   (BuildContext context) {
                                          //                 return shiftDetails!.map<
                                          //                         PopupMenuItem<
                                          //                             Shift_DetailsBean>>(
                                          //                     (shift) {
                                          //                   return PopupMenuItem<
                                          //                       Shift_DetailsBean>(
                                          //                     value: shift,
                                          //                     child: ListTile(
                                          //                       onTap: () {
                                          //                         Navigator.pop(context);
                                          //                         shiftAssigned(rosterItem,
                                          //                             empId, shift);
                                          //                       },
                                          //                       title:
                                          //                           Text(shift.ShiftName!),
                                          //                       subtitle: Text(shift
                                          //                           .ShiftValue.toString()),
                                          //                       leading: Container(
                                          //                         height: 30,
                                          //                         width: 30,
                                          //                         decoration: BoxDecoration(
                                          //                           border: Border.all(
                                          //                               color:
                                          //                                   Colors.black12),
                                          //                           color: Color(int.parse(
                                          //                               shift
                                          //                                   .ShiftColour!)),
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                   );
                                          //                 }).toList();
                                          //               },
                                          //             ));
                                          //           }
                                          //         }).toList()),
                                          //       )
                                          //       .toList(),
                                          // ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                        )
                      ],
                    )
                  : Center(
                      child: CupertinoActivityIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    roasterLoad = await Serviece.loadRoaster(
        context: context,
        FromDate: selectedDateList?.first.toString() ?? "",
        ToDate: selectedDateList?.last.toString() ?? "",
        api_key: compRepo!.getSelectedApiKey(),
        departmentId: selectedDepartment!.Id.toString());

    // roasterLoad!=null?  employeeDetails = roasterLoad?.Employee_Details:"";
    //  roasterLoad!=null?  shiftRoaster = roasterLoad?.Shift_Roaster:"";
    //   roasterLoad!=null? shiftDetails = roasterLoad?.Shift_Details:"";

    //   roasterLoad!=null? departMents = roasterLoad?.Department:"";
    departMents?.insert(0, allDepartuments);

    columnData.clear();
    roaster = Map();
    columnData.add("Emp Name");
    DateTime startDate = MyKey.displayDateFormat.parse(selectedDateList!.first);
    DateTime lastDate = MyKey.displayDateFormat.parse(selectedDateList!.last);

    int totalDays = lastDate.difference(startDate).inDays;
    // int totalDays = 5;
    //filling colum headder
    List.generate(totalDays, (index) {
      var newDate = startDate.add(Duration(days: index));
      columnData.add(DateFormat("dd\nEEE").format(newDate));
    });

    //filling rows
    employeeDetails?.forEach((employee) {
      var shiftListByEmp =
          shiftRoaster?.where((shiftR) => employee.EmpCode == shiftR.EmpCode);
      List<Shift_DetailsBean> list = [];
      list.add(Shift_DetailsBean(ShiftName: employee.EmpName));
      List.generate(totalDays, (index) {
        var newDate = startDate.add(Duration(days: index));
        var shiftRoasterFount = shiftListByEmp?.firstWhere(
          (shiftByEmp) =>
              MyKey.dateWebFormat
                  .parse(shiftByEmp.DocDate.toString())
                  .difference(newDate)
                  .inDays ==
              0,
          // orElse: () => null
        );
        if (shiftRoasterFount != null) {
          var selectedShiftList = shiftDetails?.where(
              (shift) => shift.ShiftCode == shiftRoasterFount.ShiftCode);
          if (selectedShiftList!.length > 1) {
            print("List has multiple value");
          }
          var selectedShift =
              Shift_DetailsBean.fromJson(selectedShiftList!.first.toJson());
          selectedShift.shiftDate = newDate;
          list.add(selectedShift);
        } else {
          list.add(Shift_DetailsBean(shiftDate: newDate));
        }
      });

      roaster[employee.EmpCode.toString()] = list;
    });

    setState(() {});
  }

  Future<void> shiftAssigned(Shift_DetailsBean rosterItem, String empId,
      Shift_DetailsBean selectedShift) async {
    var response = await Serviece.insertRoaster(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        docDate: MyKey.displayDateFormat.format(rosterItem.shiftDate!),
        shiftCode: selectedShift.ShiftCode.toString(),
        empCode: empId);
    if (response != null) {
      showToast("Updated");
      loadData();
    }
  }
}
