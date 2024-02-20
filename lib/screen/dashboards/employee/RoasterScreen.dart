import 'package:flutter/material.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:get/get.dart';

class RoasterScreen extends StatefulWidget {
  @override
  _RoasterScreenState createState() => _RoasterScreenState();
}

class _RoasterScreenState extends State<RoasterScreen> {
  // CalendarController _calendarController;
  Map<DateTime, List> events = Map();
  var ApiKey = "";
  var summaryBiulder = "";
  var selectedDay = "";
  DateTime today = DateTime.now();

   CompanyRepository? compRepo;

  List<String> eventDateList = [];
  @override
  void initState() {

    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    // _calendarController = CalendarController();
    getRoaster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Roaster".tr),
      ),
      body: Stack(
//          mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment(0, -0.9),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              focusedDay: today,
              lastDay: DateTime.utc(2090, 3, 14),
              // calendarController: _calendarController,
              holidayPredicate: (date) =>
                  eventDateList.contains(MyKey.dateWebFormat.format(date)),
              calendarStyle: CalendarStyle(outsideDaysVisible: false),
              headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  formatButtonShowsNext: false,
                  titleCentered: true),

              calendarBuilders: CalendarBuilders(
                holidayBuilder: (context, date, evnt) {
                  var modifiedDate =
                      DateTime(date.year, date.month, date.day, 0, 0, 0, 0);
                  var event = events[modifiedDate.toLocal()];
                  return Center(
                    child: CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 3.0,
                      percent: 1,
                      center: new Text("${date.day}"),
                      progressColor: Color(int.parse(event![0])),
                    ),
                  );
                },
              ),
              onPageChanged: (date) {
                today = date;
                // print(_calendarController.toString());
                getRoaster();
              },
              onDaySelected: (date, eventList) {
                var modifiedDate =
                    DateTime(date.year, date.month, date.day, 0, 0, 0, 0);
                var event = events[modifiedDate.toLocal()];
                if (event == null) {
                  setState(() {
                    selectedDay = "";
                  });
                  return;
                }
                StringBuffer buffer = StringBuffer();
                buffer.write("${'Shift Name'.tr} : ${event[1]}\n");
                buffer.write("${'Shift Value'.tr} : ${event[2]}\n");
                buffer.write("${'Shift Code'.tr} : ${event[3]}\n");
                setState(() {
                  selectedDay = buffer.toString();
                });
              },
            ),
          ),
          Align(
              alignment: Alignment(0, 0.5),
              child: Text(
                summaryBiulder,
                textAlign: TextAlign.center,
              )),
          Align(
              alignment: Alignment(0, 0.8),
              child: Text(
                selectedDay,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }

  Future getRoaster() async {
    var url = MyKey.baseUrl + "/hrm/ShiftRoster01FindAll";
    var dates = getEndPointsOfCurrentDate(today);
    Map params = {
      "api_key": compRepo!.getSelectedApiKey(),
      "FromDate": dates.first,
      "ToDate": dates.last,
      "AppName": MyKey.appName
    };
    var result = await MyKey.postWithApiKey(url, params, context);
    if (result != null) {
      List roasterDetails = result["Shift_Roaster"];
      List shiftDatails = result["Shift_Details"];
      StringBuffer summary = StringBuffer();
      Map<String, double> shiftMap = Map();

      roasterDetails.forEach((roster) {
        var key = MyKey.dateWebFormat.parse(roster["DocDate"]);
        List list = [];
        var shift = shiftDatails
            .firstWhere((shift) => shift["ShiftCode"] == roster["ShiftCode"]);
        var shiftName = shift["ShiftName"];
        shiftMap[shiftName] =
            (shiftMap[shiftName] == null ? 0.0 : shiftMap[shiftName])! +
                shift["ShiftValue"];
        list.add(shift["ShiftColour"]);
        list.add(shiftName);
        list.add(shift["ShiftValue"]);
        list.add(shift["ShiftCode"]);

        events[key] = list;
      });
      eventDateList =
          events.keys.map((e) => MyKey.dateWebFormat.format(e)).toList();

      summary.write("${'Total Working Days'.tr} : ${roasterDetails.length}\n\n");

      shiftMap.forEach((name, val) {
        summary.write("${name} : $val\n");
      });

      summaryBiulder = summary.toString();
      setState(() {});
    }
  }
}
