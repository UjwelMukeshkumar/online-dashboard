import 'package:glowrpt/util/MyKey.dart';
import 'package:intl/intl.dart';

var dateFormater = DateFormat("dd/MM/yyyy");
var toDisplayDateTimeFormater = DateFormat("dd/MM/yyyy HH:mm");
extension DateModify on DateTime {
  String get asString=>dateFormater.format(this);
  DateTime get getLastDayOfThisMonth => _getLastDayOfThisMonth(this);
  DateTime get getFirstDayOfThisMonth => _getFirstDayOfThisMonth(this);
  DateTime get getLast3MonthFirstDay => _getLast3MonthFirstDay(this);
  DateTime get getLastDayOfPreviousMonth => _getLastDayOfPreviousMonth(this);
  DateTime get getThisYearFirstDay => _getThisYearFirstDay(this);
  DateTime get getLastYearFirstDay => _getLastYearFirstDay(this);
  DateTime get getLastYearLastDay => _getLastYearLastDay(this);

  String get toDisplayDate=>MyKey.displayDateFormat.format(this);

  String get toDisplayDateTime=>toDisplayDateTimeFormater.format(this);
  String get toPickerDisplayDate=>MyKey.pickerDate.format(this);
  String get toDisplayWebDate=>MyKey.dateWebFormat.format(this);
  Duration get toDuration=>this.difference(DateTime.now());




  DateTime _getLastDayOfThisMonth(DateTime dateTime) {
    return DateTime(year, month + 1, 0);
  }

  DateTime _getFirstDayOfThisMonth(DateTime dateTime) {
   return dateTime.subtract(Duration(days: dateTime.day - 1));
  }

  DateTime _getLast3MonthFirstDay(DateTime dateTime) {
   var dateTime = DateTime(year, month - 3, 1);
   print("getLast3MonthFirstDay ${dateTime.asString}");
   return dateTime;
  }

  DateTime _getLastDayOfPreviousMonth(DateTime dateTime) {
   var dateTime = DateTime(year, month, 0);
   print("_getLastDayOfPreviousMonth ${dateTime.asString}");
   return dateTime;
  }

  DateTime _getThisYearFirstDay(DateTime dateTime) {
    var dateTime = DateTime(year, 1, 1);
    print("getThisYearFirstDay ${dateTime.asString}");
    return dateTime;
  }

  DateTime _getLastYearFirstDay(DateTime dateTime) {
    var dateTime = DateTime(year-1, 1, 1);
    print("getLastYearFirstDay ${dateTime.asString}");
    return dateTime;
  }

  DateTime _getLastYearLastDay(DateTime dateTime) {
    var dateTime = DateTime(year, 1, 0);
    print("getLastYearLastDay ${dateTime.asString}");
    return dateTime;
  }


}
