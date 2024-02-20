// To parse this JSON data, do
//
//     final empLocation = empLocationFromJson(jsonString);

import 'dart:convert';

EmpLocation empLocationFromJson(String str) =>
    EmpLocation.fromJson(json.decode(str));

String empLocationToJson(EmpLocation data) => json.encode(data.toJson());

class EmpLocation {
  EmpLocation({
   required this.longitude,
   required this.latitude,
   required this.createdDate,
  });

  double longitude;
  double latitude;
  String createdDate;

  factory EmpLocation.fromJson(Map<String, dynamic> json) => EmpLocation(
        longitude:
            json["Longitude"] == null ? null : json["Longitude"].toDouble(),
        latitude: json["Latitude"] == null ? null : json["Latitude"].toDouble(),
        createdDate: json["CreatedDate"] == null ? null : json["CreatedDate"],
      );

  Map<String, dynamic> toJson() => {
        "Longitude": longitude == null ? null : longitude,
        "Latitude": latitude == null ? null : latitude,
        "CreatedDate": createdDate == null ? null : createdDate,
      };
}
