import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/model/manager/payroll/PayrollDeatilsM.dart';
import 'package:glowrpt/model/manager/payroll/PayrollInsertM.dart';
import 'package:glowrpt/model/other/BasicResponse.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/hedder_details.dart';
import 'package:glowrpt/screen/hedder_details_paginated.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Serviece.dart';

class MyKey {
  static const baseUrl = 'https://login.glowsis.com/';
  static const user = 'user';
  static const org = 'org';
  static const username = 'username';
  static const password = 'password';
  static const rememberMe = 'rememvberMe';
  static var displayDateFormat = DateFormat("dd/MM/yyyy");
  static var dateMMddYYY = DateFormat("MM/dd/yyyy");
  static var dateWebFormat = DateFormat("yyyy-MM-dd"); //
  static var dateWebFormatT = DateFormat("yyyy-MM-dd'T'HH:mm:ss"); //
  static var pickerDate = DateFormat("yyyy-MM-dd HH:mm"); //
  static String syskey = "sysKey";
  static const passwordUserBase = 'passwordUserBase';
  static const userNameUserBase = 'userNameUserBase';

  static var appName = "EmployeeApp";

  static String getCurrentDate() {
    return displayDateFormat.format(DateTime.now());
  }

  static openDropdown(GlobalKey myKey) {
    GestureDetector? detector;
    //todo pts modify this section
    searchForGestureDetector(BuildContext element) {
      element.visitChildElements((element) {
        if (element.widget != null&&element.widget is GestureDetector) {
          detector = element.widget as GestureDetector;
          // return false;
        } else {
          searchForGestureDetector(element);
          //  return true;
        }
      });
    }

    searchForGestureDetector(myKey.currentContext!);
    assert(detector != null);

    detector!.onTap!();
  }

  static int hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }

  static Future<dynamic> postWithApiKey(
      String url, dynamic params, BuildContext context,
      {dynamic headder}) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: params, headers: headder);
      log("url $url");
      log("params ${json.encode(params)}");
      log("response ${response.body}");
      BasicResponse basicResponse = basicResponseFromJson(response.body);
      // BasicResponse basicResponse = basicResponseFromJson(responses);
      if (!basicResponse.error) {
        return basicResponse.data;
      } else {
        if (basicResponse.message.contains("Session Timed Out")) {
          Toast.show(basicResponse.message);
        } else {
          Toast.show("${basicResponse.message}\n${getUrlReference(url)}");
        }
        return null;
      }
    } catch (error) {
      if (error.toString().contains("SocketException")) {
        Toast.show("Please check your data connection");
        print("error1 $error");
      } else {
        print("error1 ${error.toString()} ${getUrlReference(url)}");
        Toast.show(error.toString() + "\n${getUrlReference(url)}");
      }
    }
    return null;
  }

  static Future<User> getUser() async {
    var preference = await SharedPreferences.getInstance();
    var strUser = preference.getString(user);
    return
        //  strUser == null ? null :
        userFromJson(strUser!);
  }

  static List<String> getDefaultDateListAsToday() {
    var today = DateTime.now();
    return [displayDateFormat.format(today), displayDateFormat.format(today)];
  }

  static Future<String> getApiKey() async {
    var user = await getUser();
    return user == null ? "" : user.apiKey;
  }

  static String getDispayDateFromWb(String string) {
    DateTime dateTime = dateWebFormatT.parse(string);
    return displayDateFormat.format(dateTime);
//   return "Hi";x
  }

  static String currencyFromat(String? amount,
      {String sign = "₹", int decimmalPlace = 2}) {
    try {
      var currencyFormatter =
          NumberFormat.currency(locale: 'HI', decimalDigits: decimmalPlace);
      if (amount == null || amount == "null") {
        return "${currencyFormatter.format(0).replaceAll("INR", sign)}";
      }
      return currencyFormatter
          .format(double.parse(amount.replaceAll(",", "")))
          .replaceAll("INR", sign);
    } catch (e) {
      print("Error Value $amount ${e.toString()}");
      return "";
    }
  }

  static getUrlReference(String url) {
    var split = url.split("?");
    // var part1 = split.first.split("/").last+"?${split.last}";
    var part1 = split.first.split("/").last;
    return part1;
  }
}

const textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black12),
);

bool showTitle(min, double max, sideT, double divisor, double value) {
  // max=max.roundToDouble();
  // return true;
  var noVerticalLines = (max / divisor).toInt();
  var remainder = value % ((noVerticalLines / 5).toInt() * divisor).toInt();
  // print("sideT${sideT}");
  // print("value $value Max $max Devisor $divisor noVerticalLines $noVerticalLines remindr $remainder ");
  return remainder == 0;
}

showToast(String message) {
  Toast.show(message, gravity: Toast.center, duration: Toast.lengthLong);
}

getData(int index) {
  var dateTime = DateTime.now();
  switch (index) {
    case 1: //today
      return MyKey.displayDateFormat.format(dateTime);
    case 2: //yesterday
      return MyKey.displayDateFormat
          .format(dateTime.subtract(Duration(days: 1)));
    case 3: //last 7 days
      return MyKey.displayDateFormat
          .format(dateTime.subtract(Duration(days: 7)));
    case 4: //last 30 days
      return MyKey.displayDateFormat
          .format(dateTime.subtract(Duration(days: 30)));
    case 5: //this month
      return MyKey.displayDateFormat
          .format(dateTime.subtract(Duration(days: dateTime.day - 1)));
  }
}

bool isLastPage(
    {required int numOfItemPerPage,
    required int viewpageNum,
    required List linesList}) {
  int requiredItem = numOfItemPerPage * (viewpageNum + 1);
  return linesList.length <= requiredItem;
}

enum JurnalType { PartyToParty, Jurnal }

String priceToString(double number) {
  if (number == null) {
    return "0.0";
  }
  return number.toInt() == number
      ? number.toInt().toString()
      : number.toString();
}

openDatailScreenAny({
  required HeadderParm headderParm,
  required BuildContext context,
  required List<String> dateListLine,
  selectedUserRemoveMe,
  bool showDetails = false,
}) {
  if (headderParm.isPaginated!=null) {
    
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HeadderDetailsPaginated(
                  dateListLine: dateListLine,
                  headderParm: headderParm,
                  showDetails: showDetails,
                )));
  } else {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HeadderDetails(
                  dateListLine: dateListLine,
                  selectedItemRemoveMe: selectedUserRemoveMe,
                  headderParm: headderParm,
                  showDetails: showDetails,
                )));
  }
}

var containerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(6),
    border: Border.all(color: Colors.black26));
var containerMargin = EdgeInsets.all(8);

getTrendText(int position) {
  // return position.toString();
  if (position < 3) {
    return "last week same day";
  }
  if (position == 3) {
    return "previous 7 days";
  }
  if (position == 4) {
    return "previous 30 days";
  } else {
    return "previous month";
  }
}

class DocType {
  static String section = "SC";
  static String category = "G";
  static String customer = "C";
  static String supplier = "S";
  static String sales = "SI";
  static String salseOrder = "SO";
  static String purchase = "PI";
  static String employee = "E";
  static String purchaseOrder = "PO";
  
  static String purchaseReturn = "PR";

}

class DocumentFormId {
  static int Sales = 7;
  static int DeleveryForm = 4811;

  static int Purchase = 8;

  static int SalesReturn = 9;

  static int PurchaseReturn = 10;

  static int SalesOrder = 11;

  static int PurchaseOrder = 12;
  static int Receipt = 17;
  static int Payment = 16;
}

const dropdownPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

List<String> getEndPointsOfCurrentDate(DateTime dateTime) {
  var df = DateFormat("dd/MM/yyyy");
  var biginDAte = DateTime(dateTime.year, dateTime.month, 1);

  var endDate = DateTime(dateTime.year, dateTime.month + 1, 0);
  return [df.format(biginDAte), df.format(endDate)];
}

class Requests {
  static const LeaveRequest = "Leave Request";
  static const TransferRequest = "Transfer Request";
  static const PunchRequest = "Punch Request";
  static const PromotionRequest = "Promotion Request";
  static const ResignationsRequest = "Resignations Request";
  static const Vacancies = "Vacancies";
  static const AttendanceRequest = "Attendance List";
  static const ClimeAndAllowance = "Claim and Allowance";

  static getList() {
    List<String> list = [];
    list.add(LeaveRequest.tr);
    list.add(TransferRequest.tr);
    list.add(PunchRequest.tr);
    list.add(PromotionRequest.tr);
    list.add(ResignationsRequest.tr);
    list.add(AttendanceRequest.tr);
    list.add(ClimeAndAllowance.tr);
    return list;
  }
}

List gstStateList = [
  "JAMMU & KASHMIR",
  "HIMACHAL PRADESH",
  "PUNJAB",
  "CHANDIGARH",
  "UTTARAKHAND",
  "HARYANA",
  "DELHI",
  "RAJASTHAN",
  "UTTAR PRADESH",
  "BIHAR",
  "SIKKIM",
  "ARUNACHAL PRADESH",
  "NAGALAND",
  "MANIPUR",
  "MIZORAM",
  "TRIPURA",
  "MEGHALAYA",
  "ASSAM",
  "WEST BENGAL",
  "JHARKHAND",
  "ODISHA",
  "CHATTISGARH",
  "MADHYA PRADESH",
  "GUJARAT",
  "DADRA & NAGAR HAVELI & DAMAN & DIU (NEWLY MERGED UT)",
  "MAHARASHTRA",
  "ANDHRA PRADESH(BEFORE DIVISION)",
  "KARNATAKA",
  "GOA",
  "LAKSHADWEEP",
  "KERALA",
  "TAMIL NADU",
  "PUDUCHERRY",
  "ANDAMAN & NICOBAR ISLANDS",
  "TELANGANA",
  "ANDHRA PRADESH (NEWLY ADDED)",
  "LADAKH (NEWLY ADDED)"
];

Future<bool> insertPayRoll({
  required PayrollDeatilsM payrollDetails,
required  BuildContext context,
required  CompanyRepository compRepo,
required  String workingDays,
required  List<String> dateList,
required  int nextNumber,
required  String sequence,
}) async {
  var details = payrollDetails.PayrollDetails.first;
  var payrollInsertM = PayrollInsertM(
    api_key: compRepo.getSelectedApiKey(),
    TotalWorkingDays: workingDays,
    EmployeeCode: details.EmployeeCode,
    FromDate: dateList.first,
    ToDate: dateList.last,
    RecNum: nextNumber.toString(),
    Sequence: sequence,
    Mobile: details.Mobile.toString(),
    Category: details.EmpCategory,
    Department: details.Department,
    Designation: details.Designation,
    JoiningDate: MyKey.getDispayDateFromWb(details.JoiningDate),
    PanCaordNum: details.PancardNum,
    Salary: details.Salary.toString(),
    Nationality: details.Nationality,
    StatutoryCharges: details.StatutoryCharges.toString(),
    TaxNum: details.Taxnum,
    WorkShift: details.WrkShift,
    initNo: "0",
    DocDate: MyKey.getCurrentDate(),
    PermenantAddress: details.PermntAddress,
    SalaryList:
        "${json.encode(payrollDetails.SalaryDetails.map((e) => SalaryListBean(StatutoryCharges: e.StatutoryCharges, Salary: e.Salary, EmployeeCode: e.EmployeeCode, Account: e.Account, BrickCode: e.BrickCode, CtrlAccount: e.CtrlAccount, ReverseChargeAccount: e.ReverseChargeAccount ?? 0).toJson()).toList())}",
  );
  var response = await Serviece.payRollInsert(
      context: context,
      params: {"data": "[${json.encode(payrollInsertM.toJson())}]"});
  return response != null;
}

minimalDecimmal(double value) {
  if (value % 1 == 0) return value.toStringAsFixed(0).toString();
  return value.toString();
}

String responses = """
{
    "data": {
        "PunchDetails": [
            {
                "EmpName": "rishu",
                "PunchIN": "23/11/2022 12:38:11 PM",
                "PunchinKm": "1234",
                "PunchOutTime": "Not entered",
                "PunhOutKM": "Not entered",
                "Type": "Car",
                "Dt": "2022-11-23T00:00:00",
                "TotalKM/Day": 10.00,
                "PunchInImage": "    ",
                "PunchOutImage": null
            },
            {
                "EmpName": "DB Shamsu",
                "PunchIN": "25/11/2022 05:14:34 AM",
                "PunchinKm": "123667",
                "PunchOutTime": "25/11/2022 05:17:59 AM",
                "PunhOutKM": "9087",
                "Type": "Bus",
                "Dt": "2022-11-25T00:00:00",
                "TotalKM/Day": 10.00,
                "PunchInImage": "ADEI",
                "PunchOutImage": "ADEJ"
            },
            {
                "EmpName": "DB Shamsu",
                "PunchIN": "25/11/2022 04:42:35 AM",
                "PunchinKm": "y",
                "PunchOutTime": "25/11/2022 05:17:59 AM",
                "PunhOutKM": "9087",
                "Type": "Bus",
                "Dt": "2022-11-25T00:00:00",
                "TotalKM/Day": 10.00,
                "PunchInImage": "null",
                "PunchOutImage": "ADEJ"
            },
            {
                "EmpName": "DB Shamsu",
                "PunchIN": "17/12/2022 04:56:04 PM",
                "PunchinKm": "100",
                "PunchOutTime": "25/11/2022 05:17:59 AM",
                "PunhOutKM": "9087",
                "Type": "Bus",
                "Dt": "2022-12-17T00:00:00",
                "TotalKM/Day": 10.00,
                "PunchInImage": "ADER",
                "PunchOutImage": "ADEJ"
            },
            {
                "EmpName": "HR SHAMSU",
                "PunchIN": "17/12/2022 05:16:29 PM",
                "PunchinKm": "123",
                "PunchOutTime": "Not entered",
                "PunhOutKM": "Not entered",
                "Type": "Bus",
                "Dt": "2022-12-17T00:00:00",
                "TotalKM/Day": 10.00,
                "PunchInImage": "0000",
                "PunchOutImage": null
            },
            {
                "EmpName": "HR SHAMSU",
                "PunchIN": "17/12/2022 05:17:34 PM",
                "PunchinKm": "23",
                "PunchOutTime": "Not entered",
                "PunhOutKM": "Not entered",
                "Type": "Car",
                "Dt": "2022-12-17T00:00:00",
                "TotalKM/Day": 10.00,
                "PunchInImage": "0000",
                "PunchOutImage": null
            },
            {
                "EmpName": "rishu",
                "PunchIN": "17/01/2023 02:31:03 PM",
                "PunchinKm": "100",
                "PunchOutTime": "Not entered",
                "PunhOutKM": "Not entered",
                "Type": "Bus",
                "Dt": "2023-01-17T00:00:00",
                "TotalKM/Day": 10.00,
                "PunchInImage": "0000",
                "PunchOutImage": null
            }
        ]
    },
    "error": false,
    "message": "OK"
}
""";
