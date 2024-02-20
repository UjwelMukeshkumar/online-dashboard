import 'dart:convert';
// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:glowrpt/model/employe/LeveTypeM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
// import 'package:glowrpt/widget/employee/KeyValueDate.dart';
import 'package:glowrpt/widget/employee/KeyValueSpinner.dart';
import 'package:glowrpt/widget/employee/KeyValueText.dart';
import 'package:glowrpt/widget/employee/KeyValueTextAria.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RequestLeave extends StatefulWidget {
  bool halfDay = false;
  String dayDiff = "1.0";

  @override
  _RequestLeaveState createState() => _RequestLeaveState();
}

class _RequestLeaveState extends State<RequestLeave> {
  TextEditingController tec_datePickerFrom = TextEditingController();
  TextEditingController tec_datePickerTo = TextEditingController();

  TextEditingController tec_remarks = TextEditingController();
  TextEditingController tec_reason = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var _fromDesignatin;

  // List<Map<String, dynamic>>? _designationMap;
 CompanyRepository? compRepo;

  String? startDate;

  String? endDate;

  String selectedDateText = "";

  List? leveTypes;

  Map? leveType;

  String strLeaveType = "";

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);

    var date = MyKey.displayDateFormat.format(DateTime.now());
    tec_datePickerFrom.text = date;
    tec_datePickerTo.text = date;
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave Request".tr),
      ),
      body: Center(
        child: leveTypes != null
            ? ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 32),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () async {
                                  var sort = DateFormat("MMM dd");

                                  final DateTimeRange? picked =
                                      await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime(1021, 1, 1),
                                    helpText: 'Select a Date or Date-Range',
                                    fieldStartHintText: 'Start Booking date',
                                    fieldEndHintText: 'End Booking date',
                                    lastDate: DateTime(2025, 1, 1),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light(),
                                        child: child!,
                                      );
                                    },
                                  );

                                  if (picked != null) {
                                    startDate = MyKey.displayDateFormat
                                        .format(picked.start);
                                    endDate = MyKey.displayDateFormat
                                        .format(picked.end);
                                    selectedDateText =
                                        "${sort.format(picked.start)} - ${sort.format(picked.end)}";
                                  }
                                  getCalculatedCount();
                                  setState(() {});
                                },
                                child: KeyValueText(
                                  labelText: "Select Date Range".tr,
                                  value: selectedDateText,
                                ),
                              ),
                              KeyValueSpinner(
                                title: "Select Leave Type".tr,
                                modelList: leveTypes!,
                                initModel: leveType,
                                fieldName: "LeaveType".tr,
                                onChanged: (value) {
                                  leveType = value;
                                },
                              ),
                              Stack(
                                alignment: Alignment.topRight,
                                children: <Widget>[
                                  KeyValueText(
                                    labelText: "No Of Days".tr,
                                    value: widget.dayDiff,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text("Half Day".tr),
                                      Switch(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          value: widget.halfDay,
                                          onChanged: (value) {
                                            widget.halfDay = value;
                                            getCalculatedCount();
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                              //Current taken

                              KeyValueTextArea(
                                errorMessage: "Please Enter Reason".tr,
                                label: "Reason".tr,
                                tec: tec_reason,
                                minLine: 2,
                              ),
                              /*   KeyValueTextArea(
                          errorMessage: "Please Enter Remarks",
                          label: "Remarks",
                          tec: tec_remarks,
                          minLine: 2,
                        ),*/
                              Container(
                                width: double.infinity,
                                child: FractionallySizedBox(
                                  alignment: Alignment.bottomRight,
                                  widthFactor: .4,
                                  child: ElevatedButton(
                                    // color: Theme.of(context).colorScheme.background,
                                    // textColor: Colors.white,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        insertLeveRequest();
                                      }
                                    },
                                    child: Text("Save".tr),
                                  ),
                                ),
                              ),
                              TextButton.icon(
                                  onPressed: addNewLeveType,
                                  icon: Icon(Icons.add),
                                  label: Text("Add Leave Type".tr))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : CupertinoActivityIndicator(),
      ),
    );
  }

  Future insertLeveRequest() async {
    var url = "https://login.glowsis.com/hrm/Leaverqst";
    var map = [
      {
        "datefrom": startDate,
        "dateto": endDate,
        "EmployeeID": compRepo!.getSelectedUser().userId,
        "reason": tec_reason.text,
        "api_key": compRepo!.getSelectedApiKey(),
        "Remarks": "",
        "AppName": MyKey.appName,
        "NumberofDays": widget.dayDiff,
        "LeaveType": leveType!["Id"]
      }
    ];

    var params = {"data": json.encode(map)};
    var result = await MyKey.postWithApiKey(url, params, context);
    if (result != null) {
      Toast.show("Success");
      Navigator.of(context).pop();
    }
  }

  getCalculatedCount() {
    try {
      var fromDate = MyKey.displayDateFormat.parse(startDate!);
      var toDate = MyKey.displayDateFormat.parse(endDate!);
      double dayDiff = toDate.difference(fromDate).inDays.toDouble() +
          (widget.halfDay ? 0.5 : 1);
      setState(() {
        widget.dayDiff = dayDiff.toString();
      });
    } catch (e) {
      print(e);
      return "0";
    }
  }

  Future<void> loadData() async {
    leveTypes = await Serviece.leaveLoad(
        api_key: compRepo!.getSelectedApiKey(), context: context);
    if (leveTypes!.length > 0) leveType = leveTypes!.first;
    setState(() {});
  }

  Future<void> addNewLeveType() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (text) {
                    strLeaveType = text;
                  },
                  decoration: InputDecoration(
                      labelText: "Enter Leave Type", border: textFieldBorder),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                if (strLeaveType.isEmpty) {
                  showToast("Enter Leave Type");
                  return;
                }
                showToast("Please wait..");
                var result = await Serviece.createLeveType(
                    api_key: compRepo!.getSelectedApiKey(),
                    context: context,
                    leaveType: strLeaveType);
                if (result != null) {
                  showToast("Leave type added");
                  loadData();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
