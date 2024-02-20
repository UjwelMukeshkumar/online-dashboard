// To parse this JSON data, do
//
//     final snapPointM = snapPointMFromJson(jsonString);

import 'dart:convert';

import 'package:place_picker/place_picker.dart';

SnapPointM snapPointMFromJson(String str) =>
    SnapPointM.fromJson(json.decode(str));

String snapPointMToJson(SnapPointM data) => json.encode(data.toJson());

class SnapPointM {
  Location location;
  int originalIndex;
  String placeId;

  SnapPointM({
    required this.location,
    required this.originalIndex,
    required this.placeId,
  });

  factory SnapPointM.fromJson(Map<String, dynamic> json) => SnapPointM(
        location: Location.fromJson(json["location"]),
        originalIndex: json["originalIndex"],
        placeId: json["placeId"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "originalIndex": originalIndex,
        "placeId": placeId,
      };

  LatLng toLatLng() {
    return LatLng(location.latitude, location.longitude);
  }
}

class Location {
  double latitude;
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
