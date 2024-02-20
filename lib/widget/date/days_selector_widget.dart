import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/library/DateFactory.dart';
import 'package:glowrpt/service/DateService.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DaysSelectorWidget extends StatefulWidget {
  ValueChanged<List<String>>? valueChanged;
  ValueChanged<String>? dateRangeText;
  String? intialText;
  String? trendTitle;
  GestureTapCallback? trendTap;
  bool hideTriling;
  List<DateTypes> dateTypes;
  bool controllInitialTextAndDateList;

  DaysSelectorWidget({
 this.valueChanged,
   this.intialText,
   this.trendTitle,
   this.trendTap,
   this.hideTriling = false,
   this.dateRangeText,
   this.dateTypes = DateService.dateTypes,
   this.controllInitialTextAndDateList = false, 
  });

  @override
  _DaysSelectorWidgetState createState() => _DaysSelectorWidgetState();
}

class _DaysSelectorWidgetState extends State<DaysSelectorWidget> {
  var date = DateTime.now();
  var today;
  var yesterday;
  var thisWeek;
  var lastWeek;
  var thisMonth;
  var lastMonth;
  var lastThreeMonth;
  var thisYear;
  var lastYear;
  var dateRange;
  String? selectedDateText;
  String? startDate;
   String? endDate;
  var dateFormater = DateFormat("dd/MM/yyyy");
  var minus = 0;
  @override
  void didUpdateWidget(covariant DaysSelectorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didChangeDependencies");
    if (widget.controllInitialTextAndDateList) {
      selectedDateText = widget.intialText ?? today;
    }
  }

  @override
  void initState() {
    super.initState();

    if (date.month <= 3) {
      minus = 1;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    today = "Today".tr + ", ${date.day} ${DateFormat("MMM").format(date)}";
    yesterday =
        "Yesterday, ${date.add(Duration(days: -1)).day} ${DateFormat("MMM").format(date.add(Duration(days: -1)))}";
    thisWeek =
        "This Week, ${date.add(Duration(days: -(date.weekday - 1))).day} - ${date.day} ${DateFormat("MMM").format(date)}";
    lastWeek =
        "Last Week, ${date.add(Duration(days: -(date.weekday - 1) - 7)).day} - ${date.add(Duration(days: -(date.weekday - 1) - 1)).day} ${DateFormat("MMM").format(date.add(Duration(days: -(date.weekday - 2))))}";
    thisMonth = "This Month, ${DateFormat("MMM").format(date)}";
    lastMonth =
        "Last Month, ${DateFormat("MMM").format(DateTime(date.year, date.month - 1, date.day, date.hour, date.minute))}";
    lastThreeMonth =
        "Last Three Month, ${DateFormat("MMM").format(DateTime(date.year, date.month - 3, 1, 0, 0))} - ${DateFormat("MMM").format(DateTime(date.year, date.month - 1, 1, 0, 0))}";
    thisYear =
        "This Year, ${DateFormat("dd MMM yyyy").format(DateTime(DateTime.now().year - (minus), 4, 1))} - ${DateFormat("dd MMM yyyy").format(date)}";
    lastYear =
        "Last Year, ${DateFormat("dd MMM yyyy").format(DateTime(DateTime.now().year - (minus + 1), 4, 1))} - ${DateFormat("dd MMM yyyy").format(DateTime(DateTime.now().year - minus, 3, 31))}";
    selectedDateText = widget.intialText ?? today;
    startDate = dateFormater.format(date);
    endDate = dateFormater.format(date);
    dateRange = "Select Date Range";
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        showBottomDialog(textTheme);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        color: AppColor.background,
        child: Row(
       
          children: [
            Stack(
              children: [
                Icon(CupertinoIcons.calendar_badge_plus, color: AppColor.title),
              ],
            ),
            SizedBox(width: 16),
            Text(selectedDateText?.split(",").first??"",
                style: TextStyle(
                    color: AppColor.title,
                    fontWeight: FontWeight.normal,
                    fontSize: widget.hideTriling ? 12 : 14)),
            if (!widget.hideTriling) ...[
              SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_sharp,
                color: AppColor.title,
              ),
              // Container(),
             
              Expanded(
                child: InkWell(
                  onTap: widget.trendTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          Icon(Icons.bar_chart),
                          /*  Icon(
                            Icons.show_chart,
                            color: AppColor.notificationBackgroud,
                          ), */
                        ],
                      ),
                      SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          widget.trendTitle?.tr??"",
                          style: TextStyle(
                              color: AppColor.notificationBackgroud,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  void showBottomDialog(TextTheme textTheme) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          // height: 200,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Select date range",
                style: textTheme.headline6,
              ),
              SizedBox(height: 12),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.dateTypes.contains(DateTypes.today))
                    ListTile(
                      title: Text(today),
                      onTap: () {
                        selectedDateText = today;
                        startDate = dateFormater.format(date);
                        endDate = dateFormater.format(date);
                        Navigator.pop(context);
                        if (widget.dateRangeText != null)
                          widget
                              .dateRangeText!(selectedDateText!.split(",").first);
                        widget.valueChanged!(
                            [startDate!, selectedDateText!, endDate!]);
                        setState(() {});
                      },
                    ),
                  if (widget.dateTypes.contains(DateTypes.yesterday))
                    ListTile(
                      title: Text(yesterday),
                      onTap: () {
                        selectedDateText = yesterday;
                        startDate =
                            dateFormater.format(date.add(Duration(days: -1)));
                        endDate =
                            dateFormater.format(date.add(Duration(days: -1)));
                        Navigator.pop(context);
                        if (widget.dateRangeText != null)
                          widget
                              .dateRangeText!(selectedDateText!.split(",").first);
                        widget.valueChanged!(
                            [startDate!, selectedDateText!, endDate!]);
                        setState(() {});
                      },
                    ),
                  if (widget.dateTypes.contains(DateTypes.thisWeek))
                    ListTile(
                      title: Text(thisWeek), //monday to the same date
                      onTap: () {
                        selectedDateText = thisWeek;
                        startDate = dateFormater.format(
                            date.add(Duration(days: -(date.weekday - 1))));
                        endDate = dateFormater.format(date);
                        Navigator.pop(context);
                        if (widget.dateRangeText != null)
                          widget
                              .dateRangeText!(selectedDateText!.split(",").first);
                        widget.valueChanged!(
                            [startDate!, selectedDateText!, endDate!]);
                        setState(() {});
                      },
                    ),
                  if (widget.dateTypes.contains(DateTypes.lastWeek))
                    ListTile(
                      title: Text(lastWeek),
                      onTap: () {
                        selectedDateText = lastWeek;
                        startDate = dateFormater.format(
                            date.add(Duration(days: -(date.weekday - 1) - 7)));
                        endDate = dateFormater.format(
                            date.add(Duration(days: -(date.weekday - 1) - 1)));
                        Navigator.pop(context);
                        if (widget.dateRangeText != null)
                          widget
                              .dateRangeText!(selectedDateText!.split(",").first);
                        widget.valueChanged!(
                            [startDate!, selectedDateText!, endDate!]);
                        setState(() {});
                      },
                    ),
                  if (widget.dateTypes.contains(DateTypes.thisMonth))
                    ListTile(
                      title: Text(thisMonth),
                      onTap: () {
                        selectedDateText = thisMonth;
                        startDate = date.getFirstDayOfThisMonth.asString;
                        endDate = date.getLastDayOfThisMonth.asString;
                        Navigator.pop(context);
                        if (widget.dateRangeText != null)
                          widget
                              .dateRangeText!(selectedDateText!.split(",").first);
                        widget.valueChanged!(
                            [startDate!, selectedDateText!, endDate!]);
                        setState(() {});
                      },
                    ),
                  if (widget.dateTypes.contains(DateTypes.lastThreeMonth))
                    ListTile(
                      title: Text(lastThreeMonth),
                      onTap: () {
                        selectedDateText = lastWeek;
                        startDate = dateFormater.format(
                            DateTime(date.year, date.month - 3, 1, 0, 0));
                        endDate = dateFormater.format(
                            DateTime(date.year, date.month - 1, 1, 0, 0));
                        Navigator.pop(context);
                        if (widget.dateRangeText != null)
                          widget
                              .dateRangeText!(selectedDateText!.split(",").first);
                        widget.valueChanged!(
                            [startDate!, selectedDateText!, endDate!]);
                        setState(() {});
                      },
                    ),
                  if (widget.dateTypes.contains(DateTypes.lastMonth))
                    ListTile(
                      title: Text(lastMonth),
                      onTap: () {
                        selectedDateText = lastMonth;
                        startDate = dateFormater.format(DateTime(date.year,
                            date.month - 1, 1, date.hour, date.minute));
                        endDate = dateFormater.format(DateTime(
                            date.year, date.month, 0, date.hour, date.minute));
                        Navigator.pop(context);
                        if (widget.dateRangeText != null)
                          widget
                              .dateRangeText!(selectedDateText!.split(",").first);
                        widget.valueChanged!(
                            [startDate!, selectedDateText!, endDate!]);
                        setState(() {});
                      },
                    ),
                  if (widget.dateTypes.contains(DateTypes.thisYear))
                    ListTile(
                      title: Text(thisYear),
                      onTap: () {
                        selectedDateText = thisYear;
                        startDate = dateFormater.format(
                            DateTime(DateTime.now().year - (minus), 4, 1));
                        endDate = dateFormater.format(date);
                        Navigator.pop(context);
                        if (widget.dateRangeText != null)
                          widget
                              .dateRangeText!(selectedDateText!.split(",").first);
                        widget.valueChanged!(
                            [startDate!, selectedDateText!, endDate!]);
                        setState(() {});
                      },
                    ),
                  if (widget.dateTypes.contains(DateTypes.lastYear))
                    ListTile(
                      title: Text(lastYear),
                      onTap: () {
                        selectedDateText = lastYear;
                        startDate = dateFormater.format(
                            DateTime(DateTime.now().year - (minus + 1), 4, 1));
                        endDate = dateFormater.format(
                            DateTime(DateTime.now().year - minus, 3, 31));
                        Navigator.pop(context);
                        if (widget.dateRangeText != null)
                          widget
                              .dateRangeText!(selectedDateText!.split(",").first);
                        widget.valueChanged!(
                            [startDate!, selectedDateText!, endDate!]);
                        setState(() {});
                      },
                    ),
                  if (widget.dateTypes.contains(DateTypes.dateRange))
                    ListTile(
                      title: Text(dateRange),
                      onTap: () async {
                        var sort = DateFormat("dd/MM");
                        Navigator.pop(context);
                        final DateTimeRange? picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(1021, 1, 1),
                          helpText: 'Select a Date or Date-Range',
                          fieldStartHintText: 'Start Booking date',
                          fieldEndHintText: 'End Booking date',
                          lastDate: DateTime(2025, 1, 1),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light(),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          startDate = dateFormater.format(picked.start);
                          endDate = dateFormater.format(picked.end);
                          selectedDateText =
                              "Date Range\n${sort.format(picked.start)} - ${sort.format(picked.end)}";
                        }
                        if (widget.dateRangeText != null)
                          widget
                              .dateRangeText!(selectedDateText!.split(",").first);
                        widget.valueChanged!(
                            [startDate!, selectedDateText!, endDate!]);
                        setState(() {});
                      },
                    ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
