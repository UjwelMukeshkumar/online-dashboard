import 'package:glowrpt/util/MyKey.dart';
import 'package:intl/intl.dart';
 var displayDateFormat = DateFormat("dd/MM/yyyy");
class DateService {
  static String biginingOfThisMonth() {
    var today = DateTime.now();
    return MyKey.displayDateFormat
        .format(today.subtract(Duration(days: (today.day - 1))));
  }
  static List<String> getDefaultDateOfLastMonth(){
    var today = DateTime.now();
    var lastDayOfPreviusMonth= today.subtract(Duration(days: today.day));
    var firstDayOfPreviusMonth= lastDayOfPreviusMonth.subtract(Duration(days: lastDayOfPreviusMonth.day-1));
    return [displayDateFormat.format(firstDayOfPreviusMonth), displayDateFormat.format(lastDayOfPreviusMonth)];
  }

  static List<String> getDefaultDateOfCurrentMonth(){
    return [biginingOfThisMonth(), MyKey.getCurrentDate()];
  }
  static int dayDifference(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (aDate == today) {
      return 0;
    } else if (aDate == yesterday) {
      return -1;
    } else if (aDate == tomorrow) {
      return 1;
    }else{
      return -11111;
    }
  }

  static const Months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  static const  List<DateTypes> dateTypes=[
    DateTypes.today,
    DateTypes.yesterday,
    DateTypes.thisWeek,
    DateTypes.lastWeek,
    DateTypes.thisMonth,
    DateTypes.lastMonth,
    DateTypes.thisYear,
    DateTypes.lastYear,
    DateTypes.dateRange
  ];
  static const List<DateTypes> dateTypesYearBased=[
    DateTypes.today,
    DateTypes.thisWeek,
    DateTypes.thisMonth,
    DateTypes.lastThreeMonth,
    DateTypes.thisYear,
    DateTypes.lastYear,
    DateTypes.dateRange
  ];
  static const List<DateTypes> dateTypesMonthBased=[
    DateTypes.thisMonth,
    DateTypes.lastMonth,
    DateTypes.dateRange
  ];

}

enum DateTypes {
today,
yesterday,
thisWeek,
lastWeek,
thisMonth,
lastMonth,
lastThreeMonth,
thisYear,
lastYear,
selectedDateText,
startDate,
endDate,
dateRange
}