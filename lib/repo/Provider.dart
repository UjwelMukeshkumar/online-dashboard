import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/other/User.dart';

class CompanyRepository with ChangeNotifier {
  SharedPreferences? pref;
  int? conpanySwichedAt;
  String keySelectedUser = "selected user";

  CompanyRepository();

  updatePreference(SharedPreferences preferences) {
    pref = preferences;
  }

  updateTime() {
    conpanySwichedAt = DateTime.now().millisecond;
  }

  refresh() {
    updateTime();
    notifyListeners();
  }

  void logout() {
    // this._selectedUser = null;
    pref!.remove("User");
    updateTime();
    notifyListeners();
  }

  // User _selectedUser;

  void updateSelectedUser(User user) {
    // this._selectedUser = user;
    pref!.setString(keySelectedUser, user.toJsonString());
    updateTime();
    notifyListeners();
  }

  User getSelectedUser() =>
      // this._selectedUser ??
      userFromPreference() ?? getAllUser().first;

  String getSelectedApiKey() => getSelectedUser().apiKey;

  String getAllApiKeys() => getAllUser().map((e) => e.apiKey).join(",");

  void updateUser(User user) {
    pref?.setString("User", user.toJsonString());
    updateTime();
    notifyListeners();
  }

  List<User> getAllUser() {
    String? strUser = pref?.getString("User");
    if (strUser != null) {
      var user = User.fromJson(json.decode(strUser));
      List users = json.decode(user.UserBranches!);
      return [user].followedBy(users.map((e) {
        String data = e["api_key"];
        List parts = data.split("@");
        return User(
            apiKey: "${parts[0]}@${parts[1]}@${parts[2]}@${parts[3]}",
            username: parts[4],
            userCode: parts[5],
            organisation: parts[6]);
      })).toList();
    } else {
      return [];
    }
  }

  User? getPrimaryUser() {
    String? strUser = pref?.getString("User");
    if (strUser != null) {
      return User.fromJson(json.decode(strUser));
    }
    return null;
  }

  User? getUserByOrgName(String orgName) {
    return getAllUser().firstWhereOrNull((element) =>
        element.organisation?.toLowerCase().trim() ==
        orgName.toLowerCase().trim());
  }

  User? getUserByOrgId(int orgId) {
    return getAllUser().firstWhereOrNull((element) => element.orgId == orgId);
  }

  bool hasMangerDB() => getPrimaryUser()?.MangerDB == "Y";
  bool hasSalesDB() => getPrimaryUser()?.SalesDB == "Y";
  bool hasAccountDB() => getPrimaryUser()?.AccountDB == "Y";
  bool hasEmployeeDB() => getPrimaryUser()?.EmployeeDB == "Y";
  bool hasPurchaseDB() => getPrimaryUser()?.PurchaseDB == "Y";
  bool hasHRMDB() => getPrimaryUser()?.HRMDB == "Y";
  bool hasRTMDB() => getPrimaryUser()?.RTMDB == "Y";
  bool hasStakeholder() => getPrimaryUser()?.STKDB == "Y";

  String? getSyskey() {
    return pref!.getString(MyKey.syskey);
  }

  User? userFromPreference() {
    var strUser = pref?.getString(keySelectedUser);
    if (strUser == null) return null;
    var userFromPref = userFromJson(strUser);
    return getAllUser().firstWhereOrNull(
        (element) => element.identity == userFromPref.identity);
  }
}
