// To parse this JSON data, do
//
//     final routeEndM = routeEndMFromJson(jsonString);

import 'dart:convert';

import 'package:glowrpt/library/AppSctring.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

RouteEndM routeEndMFromJson(String str) => RouteEndM.fromJson(json.decode(str));

String routeEndMToJson(RouteEndM data) => json.encode(data.toJson());

class RouteEndM {
  List<RouteDetail> routeDetails;
  List<RouteHistory> routeHistory;

  RouteEndM({
    required this.routeDetails,
    required this.routeHistory,
  });

  factory RouteEndM.fromJson(Map<String, dynamic> json) => RouteEndM(
        routeDetails: List<RouteDetail>.from(
            json["RouteDetails"].map((x) => RouteDetail.fromJson(x))),
        routeHistory: List<RouteHistory>.from(
            json["RouteHistory"].map((x) => RouteHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "RouteDetails": List<dynamic>.from(routeDetails.map((x) => x.toJson())),
        "RouteHistory": List<dynamic>.from(routeHistory.map((x) => x.toJson())),
      };
}

class RouteDetail {
  String routeBeginPlot;
  String beginText;
  String routeEndPlot;
  String endText;
  int kmInstive;

  RouteDetail({
  required this.routeBeginPlot,
  required this.beginText,
  required this.routeEndPlot,
  required this.endText,
  required this.kmInstive,
  });

  factory RouteDetail.fromJson(Map<String, dynamic> json) => RouteDetail(
        routeBeginPlot: json["RouteBeginPlot"],
        beginText: json["BeginText"],
        routeEndPlot: json["RouteEndPlot"],
        endText: json["EndText"],
        kmInstive: json["KMInstive"],
      );

  Map<String, dynamic> toJson() => {
        "RouteBeginPlot": routeBeginPlot,
        "BeginText": beginText,
        "RouteEndPlot": routeEndPlot,
        "EndText": endText,
        "KMInstive": kmInstive,
      };
}

class RouteHistory {
  String? cvCode;
  String cvName;
  String text;
  String empLatLng;

  RouteHistory({
   this.cvCode,
   required this.cvName,
   required this.text,
   required this.empLatLng,
  });

  factory RouteHistory.fromJson(Map<String, dynamic> json) => RouteHistory(
        cvCode: json["CVCode"],
        cvName: json["CVName"],
        text: json["Text"],
        empLatLng: json["EMP_LAT_LNG"],
      );

  Map<String, dynamic> toJson() => {
        "CVCode": cvCode,
        "CVName": cvName,
        "Text": text,
        "EMP_LAT_LNG": empLatLng,
      };
  LatLng toLatLng() {
    return LatLng(empLatLng.split(",").first.toDouble,
        empLatLng.split(",").last.toDouble);
  }
}
