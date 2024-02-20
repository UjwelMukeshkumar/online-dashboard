import 'package:get/get.dart';
extension AppDouble on double{
  // get toCurrency=>"Re ${toStringAsFixed(2)}";
  // get toCurrency=>"Re ${toStringAsPrecision(2)}";
  get toCurrency=>"Rs ${toPrecision(2)}";
  get toCurrency0=>"Rs ${toInt()}";
  get toRound=>"${toPrecision(2)}";
}