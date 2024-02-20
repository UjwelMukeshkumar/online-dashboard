

import 'package:glowrpt/callbackinterface.dart';

class Utility {
  static Salesinvoicecallback? salesinvoicecallback;
  static void setSalesPageRefreshCallBack(Salesinvoicecallback? callBack) {
    salesinvoicecallback = callBack;
  }

  static Salesinvoicecallback? getSalesRfreshCallBack() {
    return salesinvoicecallback;
  }
}
