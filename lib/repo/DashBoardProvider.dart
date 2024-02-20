import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DashBoardType {
  EmployeeDashboard,
  SalesDashboard,
  PurchaseDashboard,
  AccountsDashboard,
  HRMDashboard,
  MangerDashboard,
  Stakeholder,
  RoutesDashboard
}

String dashBoardKey = "dashBoard";

class DashBoardRepository with ChangeNotifier {
  DashBoardType? _dashBoards;
 late SharedPreferences pref;
  CompanyRepository? comanyRepo;
  DashBoardRepository(this.pref, this.comanyRepo);

  DashBoardType get dashBoards =>
      _dashBoards ??
      DashBoardType.values[pref.get(dashBoardKey) as int? ?? getAvailableDashBoards()];

  set dashBoards(DashBoardType value) {
    pref.setInt(dashBoardKey, value.index);
    _dashBoards = value;
    notifyListeners();
  }

  String getTitle() {
    switch (dashBoards) {
      case DashBoardType.EmployeeDashboard:
        return "Employee Dashboard".tr;
      case DashBoardType.SalesDashboard:
        return "Sales Dashboard".tr;
      case DashBoardType.PurchaseDashboard:
        return "Purchase Dashboard".tr;
      case DashBoardType.AccountsDashboard:
        return "Accounts Dashboard".tr;
      case DashBoardType.HRMDashboard:
        return "HRM Dashboard".tr;
      case DashBoardType.MangerDashboard:
        return "Manager Dashboard".tr;
      case DashBoardType.RoutesDashboard:
        return "Routes Dashboard".tr;
      case DashBoardType.Stakeholder:
        return "Stakeholder Dashboard";
    }
  }

  int getAvailableDashBoards() {
    // int position=-1;
    if (comanyRepo!.hasEmployeeDB()) return 0;
    if (comanyRepo!.hasSalesDB()) return 1;
    if (comanyRepo!.hasPurchaseDB()) return 2;
    if (comanyRepo!.hasAccountDB()) return 3;
    if (comanyRepo!.hasHRMDB()) return 4;
    if (comanyRepo!.hasMangerDB()) return 5;
    if (comanyRepo!.hasRTMDB()) return 6;
    if (comanyRepo!.hasStakeholder()) return 7;
    return 0;
  }
}
