import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/attandace/DayAttandanceM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/other/employee_list_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../ItemLedgerScreen.dart';
import 'attandace_employee_screen.dart';
import 'package:get/get.dart';

class ViewAttendanceWidget extends StatefulWidget {
  @override
  _ViewAttendanceWidgetState createState() => _ViewAttendanceWidgetState();
}

class _ViewAttendanceWidgetState extends State<ViewAttendanceWidget> {
   CompanyRepository? companyRepo;

   List<DayAttandanceM>? attandanceList;

   DateTime? today;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    companyRepo = Provider.of<CompanyRepository>(context, listen: true);
    loadData(getEndPointsOfCurrentDate(DateTime.now()));
    today = DateTime.now();
  }

  // var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2090, 3, 14),
          focusedDay: today!,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
          ),
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              formatButtonShowsNext: false,
              titleTextStyle: TextStyle(fontSize: 15)),
          availableGestures: AvailableGestures.horizontalSwipe,
          selectedDayPredicate: (date) => attandanceList != null
              ? attandanceList!
                      .where(
                          (element) => element.getFormatedDate.day == date.day)
                      .length >
                  0
              : false,
          calendarBuilders:
              CalendarBuilders(selectedBuilder: (context, date1, date2) {
            return Stack(
              children: [
                Center(
                    child: Text(
                  date1.day.toString(),
                )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 108, 144, 208),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "${attandanceList!.firstWhere((element) => element.getFormatedDate.day == date1.day).AttendanceValue}",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.white, fontSize: 9),
                          ),
                        )))
              ],
            );
          }, todayBuilder: (context, date1, date2) {
            return Center(
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.notificationBackgroud),
                    padding: EdgeInsets.all(4),
                    child: Text(
                      date1.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )));
          }),
          onDaySelected: (date, eventList) async {
            var list = await Serviece.attendancerptbyemp(
                api_key: companyRepo!.getSelectedApiKey(),
                date: MyKey.displayDateFormat.format(date));
            // scaffoldKey.currentState.showBottomSheet((context) =>
            showModalBottomSheet(
                // isScrollControlled: true,
                context: context,
                builder: (builder) => EmployeeListWidget(list));
          },
          onPageChanged: (data) {
            today = data;
            loadData(getEndPointsOfCurrentDate(data));
            print("Page changed ${data.toString()}");
          },
        ),
      ),
    );
  }

  Future<void> loadData(List<String> dateList) async {
    attandanceList = await Serviece.attendancerpt(
        context: context,
        api_key: companyRepo!.getSelectedApiKey(),
        fromDate: dateList.first,
        todate: dateList.last);
    if (mounted) setState(() {});
  }
}
