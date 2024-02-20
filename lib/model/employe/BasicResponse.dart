// To parse this JSON data, do
//
//     final basicResponse = basicResponseFromJson(jsonString);

import 'dart:convert';

BasicResponse basicResponseFromJson(String str) => BasicResponse.fromJson(json.decode(str));

String basicResponseToJson(BasicResponse data) => json.encode(data.toJson());

class BasicResponse {
  bool error;
  String message;
  dynamic data;

  BasicResponse({
   required this.error,
   required this.message,
   required this.data,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json) => BasicResponse(
    error: json["error"],
    message: json["message"],
    data: json["data"],
  );
  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data,
  };
}

