import 'package:flutter/material.dart';
import 'package:glowrpt/model/attandace/AttandanceEmpM.dart';
import 'package:glowrpt/model/attandace/EmpAttandanceM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/attandance/punch_screen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';

class AttandaceEmployeeScreen extends StatefulWidget {
  EmpAttandanceM item;

  AttandaceEmployeeScreen(this.item);

  @override
  _AttandaceEmployeeScreenState createState() =>
      _AttandaceEmployeeScreenState();
}

class _AttandaceEmployeeScreenState extends State<AttandaceEmployeeScreen> {
   CompanyRepository? companyRepo;

   DateTime? today;

   List<AttandanceEmpM>? attandanceList;

  @override
  void initState() {
    
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData(getEndPointsOfCurrentDate(DateTime.now()));
    today = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${'View Attendance'.tr} ${companyRepo!.getSelectedUser().organisation}"),
      ),
      body: ListView(
        children: [
          // ElevatedButton(onPressed: () {}, child: Text("Data")),
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2090, 3, 14),
            focusedDay: today!,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              canMarkersOverflow: true,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              formatButtonShowsNext: false,
            ),
            selectedDayPredicate: (date) => attandanceList != null
                ? attandanceList!
                        .where((element) =>
                            element.getFormatedDate.day == date.day)
                        .length >
                    0
                : false,
            calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date1, date2) {
                  var attendanceValue = attandanceList!
                      .firstWhere(
                          (element) => element.getFormatedDate.day == date1.day)
                      .attendanceValue;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        date1.day.toString(),
                      ),
                      CircularProgressIndicator(
                        value: 1,
                        strokeWidth: 3,
                        color: Colors.green.withOpacity(
                            attendanceValue > 1 ? 1.0 : attendanceValue.toDouble()),
                        backgroundColor: Colors.red,
                      )
                    ],
                  );
                },
                defaultBuilder: (context, date1, date2) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(date1.day.toString()),
                    ),
                todayBuilder: (context, date1, date2) => Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.indigoAccent),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        date1.day.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ))),
            onDaySelected: (date, eventList) async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PunchScreen(
                            empId: widget.item.EmployeeID,
                            apiKey: companyRepo!.getSelectedApiKey(),
                            dateTime: date,
                          )));
            },
            onPageChanged: (data) {
              today = data;
              loadData(getEndPointsOfCurrentDate(data));
              print("Page changed ${data.toString()}");
            },
          ),
          SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 2,
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (attandanceList != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Employee Name :".tr,
                          style: textTheme.subtitle1,
                        ),
                        Text(
                          " ${widget.item.EmployeeName}",
                          style: textTheme.subtitle2,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Leave :".tr,
                          style: textTheme.subtitle1,
                        ),
                        Text(
                          " ${attandanceList?.map((e) => e.attendanceValue).fold(0, (previousValue, element) => previousValue + (1 - element.toInt()))}",
                          style: textTheme.subtitle2,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Present :".tr,
                          style: textTheme.subtitle1,
                        ),
                        Text(
                          " ${attandanceList?.map((e) => e.attendanceValue).fold(0, (previousValue, element) => previousValue + (element.toInt()))}",
                          style: textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> loadData(List<String> dateList) async {
    attandanceList = await Serviece.monthlyAttandanceByEmp(
        context: context,
        api_key: companyRepo!.getSelectedApiKey(),
        fromdate: dateList.first,
        Todate: dateList.last,
        EmpId: widget.item.EmployeeID);
    setState(() {});
  }
}
