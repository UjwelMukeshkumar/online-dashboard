import 'package:shared_preferences/shared_preferences.dart';

class DefaultQuantity{
  late SharedPreferences _pref;
  String _defaultQuantityKey="defaultQuantityKey";
  String _askForCustomeQunatity="askForCustomeQunatity";



  Future<bool> setQuantity(String quantity) async {
    if(double.tryParse(quantity)==null && quantity.isNotEmpty){
      return false;
    }
    _pref=await SharedPreferences.getInstance();
    return _pref.setString(_defaultQuantityKey,quantity);
  }
  Future<String> getQuantity() async {
    _pref=await SharedPreferences.getInstance();
    return _pref.getString(_defaultQuantityKey)??"1.0";
  }

  Future<bool> setAskForCustomeQuantity(bool ask) async {
    _pref=await SharedPreferences.getInstance();
    return _pref.setBool(_askForCustomeQunatity,ask);
  }

  Future<bool> getAskForCustomeQuantiy() async {
    _pref=await SharedPreferences.getInstance();
    return _pref.getBool(_askForCustomeQunatity)??false;
  }
}