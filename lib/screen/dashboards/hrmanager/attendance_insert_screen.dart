import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:glowrpt/model/manager/AttandanceFindM.dart';
import 'package:glowrpt/model/manager/AtteandanceLoadM.dart';
import 'package:glowrpt/model/manager/AttendanceLinesM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/attandance/punch_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
// import 'package:glowrpt/widget/KeyValues.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:glowrpt/model/hrm/AttHeader.dart';
import 'package:get/get.dart';

class AttendanceInsertScreen extends StatefulWidget {
  @override
  State<AttendanceInsertScreen> createState() => _AttendanceInsertScreenState();
}

class _AttendanceInsertScreenState extends State<AttendanceInsertScreen> {
  CompanyRepository? compRepo;

  AtteandanceLoadM? load;

  List<AttandanceFindM>? findList;

  DateTime selectedDate = DateTime.now();

  bool isRequesting = false;

  bool allSelected = false;

  @override
  void initState() {
    super.initState();

    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadAttandanceInsert();
  }

  @override
  Widget build(BuildContext context) {
    // var textTheam = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendance Insert".tr),
        ),
        body: SafeArea(
          child: load != null
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: DateTimeField(
                              decoration:
                                  InputDecoration(labelText: "Select Date".tr),
                              initialValue:
                                  DateTime.now().subtract(Duration(days: 1)),
                              format: MyKey.displayDateFormat,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                              onChanged: (date) {
                                selectedDate = date!;
                                loadAttandanceInsert();
                              },
                            ),
                          ),
                          Expanded(
                              child: CheckboxListTile(
                            title: Text("Select All".tr),
                            value: allSelected,
                            onChanged: (value) {
                              setState(() {
                                findList?.forEach((element) {
                                  element.isSelected = value!;
                                });
                                allSelected = value!;
                              });
                            },
                          ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          // shrinkWrap: true,
                          // physics: ScrollPhysics(),
                          itemCount: findList?.length,
                          itemBuilder: (context, position) {
                            var item = findList?[position];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PunchScreen(
                                              empId: item?.EmployeeID ?? "",
                                              apiKey:
                                                  compRepo!.getSelectedApiKey(),
                                              dateTime: selectedDate,
                                            )));
                              },
                              child: Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                color: AppColor.cardBackground,
                                shadowColor: Color.fromARGB(255, 114, 113, 113),
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    CheckboxListTile(
                                      value: item?.isSelected == true,
                                      onChanged: (value) {
                                        setState(() {
                                          item?.isSelected = value!;
                                        });
                                      },
                                      title: Text(
                                        "${item?.EmpName}",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle:
                                          DropdownButton<AttendanceNameBean>(
                                        isExpanded: true,
                                        underline: Container(),
                                        value: load!.AttendanceName.firstWhere(
                                          (element) =>
                                              element.AttendanceShortName ==
                                              item!.AttendanceShortName,
                                          orElse: () => load!.AttendanceName[0],
                                        ),
                                        items: load?.AttendanceName
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(
                                                      e.AttendanceName
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.6),
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  value: e,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            item?.AttendanceShortName = value!
                                                .AttendanceShortName
                                                .toString();
                                            item?.AttendanceName = value!
                                                .AttendanceName
                                                .toString();
                                            item?.AttendanceValue =
                                                value!.AttendanceValue!;
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Wrap(
                                              children: [
                                                Text("Punch Details".tr,
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        fontSize: 15.0)),
                                                Text(
                                                    "${item?.FirstPunch} ${'to'.tr} ${item?.LastPunch}",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        fontSize: 15.0))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Wrap(
                                              children: [
                                                Text("Late By".tr,
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        fontSize: 14.0)),
                                                //TODO : fixthis
                                                Text("${(int.tryParse(item!.PunchInDeviation.split(" ").first) ?? 0)} Minute".tr,
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        fontSize: 14.0))
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 13)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    FractionallySizedBox(
                      widthFactor: .9,
                      child: ElevatedButton(
                        onPressed: !isRequesting ? sentRequest : null,
                        //TODO : fixthis
                        child: Text(
                            "Sent Request (${findList?.where((element) => element.isSelected == true).length} Nos,"
                            " ${findList?.where((element) => element.isSelected == true).map((e) => e.AttendanceValue).fold(0.0, (previousValue, element) => previousValue + element)} value)"),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 183, 55, 206),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    // SizedBox(height: 16)
                  ],
                )
              : Center(
                  child: CupertinoActivityIndicator(),
                ),
        ));
  }

  Future<void> loadAttandanceInsert() async {
    findList = await Serviece.attandanceFind(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        Date: MyKey.displayDateFormat.format(selectedDate));

    load = await Serviece.attendanceinsertLoad(
        context: context, api_key: compRepo!.getSelectedApiKey());
    setState(() {});
  }

  Future<void> sentRequest() async {
    var selectedList =
        findList?.where((element) => element.isSelected == true).toList();
    if (selectedList!.length < 1) {
      Toast.show("Please Select Employee");
      return;
    }
    if (selectedDate == null) {
      Toast.show("Please Select Date");
      return;
    }
    var details = load?.Defaults.first;
    setState(() {
      isRequesting = true;
    });

    Map params = Map();

    var headder = AttHeader(
      api_key: compRepo!.getSelectedApiKey(),
      Sequence: details!.Sequence.toString(),
      RecNum: details.RecNum.toString(),
      InitNo: "0",
      Remarks: "Attendance",
      DocDate: MyKey.displayDateFormat.format(selectedDate),
    );

    var LineData = selectedList
        .map((e) => AttendanceLinesM(
                InitNo: 0,
                RecNum: details.RecNum,
                Sequence: details.Sequence,
                EmpCode: e.EmpCode,
                AttendanceName: e.AttendanceName,
                AttendanceShortName: e.AttendanceShortName,
                AttendanceValue: e.AttendanceValue,
                EmployeeID: e.EmpCode,
                EmpName: e.EmpName,
                FirstPunch: e.FirstPunch,
                LastPunch: e.LastPunch,
                PunchInDeviation: e.PunchInDeviation,
                PunchOutDeviation: e.PunchInDeviation,
                ShiftBeginTime: e.ShiftBeginTime,
                ShiftEndTime: e.ShiftEndTime,
                isPresent: true)
            .toJson())
        .toList();
    params["Linedata"] = json.encode(LineData);
    params["headerData"] = json.encode([headder.toJson()]);

    print("params ${params}");
    print("params str ${json.encode(params)}");

    var response =
        await Serviece.attendanceInsert(context: context, params: params);
    setState(() {
      isRequesting = false;
    });
    if (response != null) {
      Toast.show("Attendance Uploaded Sucessfully");
    }
  }
}
