import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:glowrpt/library/CollectionOperation.dart';
import 'package:glowrpt/library/CollectionOperation.dart';
import 'package:glowrpt/model/other/DefaultM.dart';
import 'package:glowrpt/model/other/SearchM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/item/SingleItemM.dart';

class CartService {
  String _cartItems = "cartItems";
  late SharedPreferences _pref;
  late User user;

  Future<bool> addNew({
    SearchM? item,
     SingleItemM? singleItemM,
    double? quntity = 1,
    BuildContext? context,
    DefaultM? defaultM,
    CompanyRepository? compRepo,
  }) async {
    String itemNumber = item?.itemNo ?? singleItemM!.Item_No.toString();
    var itemList = getAll();
    if (itemList.map((e) => e.Item_No).contains(itemNumber)) {
      var index =
          itemList.indexWhere((element) => element.Item_No == itemNumber);

      if (itemList[index].quantity == null) {
        itemList[index].quantity = 1;
      }
      // itemList[index].quantity += quntity as num;
      itemList[index].quantity =
          (itemList[index].quantity ?? 0) + (quntity ?? 0);

      print("Current count ${itemList[index].quantity}");
      saveDataToPref(itemList);
      return false;
    } else {
      // item.quantity=quntity;
      if (singleItemM == null) {
        singleItemM = await Serviece.getPosSingleItemDetails(
          api_key: compRepo!.getSelectedApiKey(),
          cvCode: defaultM!.Details!.tryFirst!.CVCode.toString(),
          context: context as BuildContext,
          itemNumber: itemNumber,
          pricelist: defaultM.Details!.tryFirst!.PriceList.toString(),
          quantiy: item!.quantity,
        );
      }
      itemList.add(singleItemM);
      saveDataToPref(itemList);
      return true;
    }
  }

  void removeItem(SingleItemM item) {
    var itemList = getAll();
    itemList.removeWhere((element) => element.Item_No == item.Item_No);
    saveDataToPref(itemList);
  }

  void saveDataToPref(List<SingleItemM> itemList) {
    _pref.setString("${user.identity}$_cartItems",
        json.encode(itemList.map((e) => e.toJson()).toList()));
  }

  // List<SingleItemM> getAll() {
  //   String strItems = _pref.getString("${user.identity}$_cartItems")as String;
  //   if (strItems == null) {
  //     return [];
  //   } else {
  //     return List<SingleItemM>.from(
  //         json.decode(strItems).map((e) => SingleItemM.fromJson(e)));
  //   }
  // }
  List<SingleItemM> getAll() {
    String? strItems =
        _pref.getString("${user.identity}$_cartItems");
    if (strItems == null) {
      return [];
    } else {
      return List<SingleItemM>.from(
          json.decode(strItems).map((e) => SingleItemM.fromJson(e)));
    }
  }


  void clearCart() {
    _pref.remove("${user.identity}$_cartItems");
  }

  CartService(SharedPreferences value, User user) {
    _pref = value;
    this.user = user;
  }
}
