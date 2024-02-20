// To parse this JSON data, do
//
//     final empPositionM = empPositionMFromJson(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class EmpPositionM {
  double lat;
  double lan;
  num accuracy;
  String createdDate;

  EmpPositionM({
   required this.lat,
   required this.lan,
   required this.accuracy,
   required this.createdDate,
  });

  factory EmpPositionM.fromRawJson(String str) => EmpPositionM.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmpPositionM.fromJson(Map<String, dynamic> json) => EmpPositionM(
    lat: json["LAT"]?.toDouble(),
    lan: json["LAN"]?.toDouble(),
    accuracy: json["Accuracy"],
    createdDate: json["CreatedDate"],
  );

  Map<String, dynamic> toJson() => {
    "LAT": lat,
    "LAN": lan,
    "Accuracy": accuracy,
    "CreatedDate": createdDate,
  };
  LatLng toLatLng(){
   return LatLng(lat, lan);
  }
}
