import 'dart:ui';

class Constants {
  static String TABLE_NAME = "User";
  static String COLUMN_identity = "identity";
  static String COLUMN_api_key = "api_key";

  // static String GOOGLE_MAP_API_KEY="AIzaSyDYXVADat0SYf22g4-eUjtKpWidTozxzC0";
  static String GOOGLE_MAP_API_KEY = "AIzaSyClqBNJ2uahJQwyOwxxCKkgdbT4Rh2b_uY";
}

class Sort {
  static String Default = "Default";
  static String Ascending = "Ascending";
  static String Descending = "Descending";
  static String DESC = "DESC";
  static String ASCE = "ASC";

  static String getSortApiTag(String text) {
    if (text == Ascending) {
      return ASCE;
    } else if (text == Descending) {
      return DESC;
    } else {
      return "";
    }
  }

  static List<String> all = [Default, Ascending, Descending];
}

String getCvType({required bool isGroups,required bool isSupplier}) {
  if (isGroups) {
    return isSupplier ? "VG" : "CG";
  } else {
    return isSupplier ? "S" : "C";
  }
}

List<String> tabs = [
  "Today",
  "Yesterday",
  "Last 7 day",
  "Last 30 days",
  "This Month",
  "Last 3 Month",
  "This Year",
  "Last Year",
  "Custom"
];

class CardProperty {
  static double radiuos = 6;
  static Color color = Color(-1122315);
  static double elivation = 5;
}

class AppColor {
  static Color title = Color(0xff303B5A);

  // static Color title=Color(0xffee780a);
  static Color notificationBackgroud = Color.fromARGB(255, 20, 89, 106);
  static Color background = Color(0xffEBF3FE);
  static Color cardBackground = Color(0xfff5f7fa);
  static Color backgroundDark = Color(0xffe3f8fe);
  static Color backgroundSemiDark = Color(0x44e3f8fe);
  static Color appBackground = Color(0xfffefefe);

  // static Color chartBacground=Color(0xffF8F8F8);
  static Color chartBacground = Color(0xffeeeeee);
  static Color warning = Color(0xffcd271d);
  static Color greenDark = Color(0xff558000);
  static Color green = Color(0xffa6c41d);
  static Color greenLigt = Color(0xffcee47d);

  static Color redDark = Color(0xff7b2b64);
  static Color red = Color(0xffcc3a65);
  static Color redLigt = Color(0xfff16b5e);

  static Color red30 = Color(0xff50023e);
  static Color red60 = Color(0xff7b2b64);
  static Color red90 = Color(0xfff56b5c);
  static Color red91 = Color(0xffff9484);
  static Color barBlueDark = Color(0xff009bfa);
  static Color barBlue = Color(0xff73bdf5);
  static Color barBlueLigt = Color(0xff9bbad5);
  static Color positiveGreen = Color(0xff44a281);
  static Color negativeRed = Color(0xffd0755a);
  static Color vyaparIcon = Color(0xff6397b7);
  static Color phonePeColor = Color(0xff531893);
  static Color ligtBluePonePe = Color(0xffE1E9FD);

  static Color barColor = Color(0xff00abae);
}
