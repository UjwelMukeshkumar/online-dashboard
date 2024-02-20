import 'package:json_annotation/json_annotation.dart';

//part 'RoutPunchM.g.dart';

@JsonSerializable()
class RoutPunchM {
  String EmpName;
  String PunchIN;
  String PunchinKm;
  String PunchOutTime;
  String PunhOutKM;
  String Type;
  String Dt;
  @JsonKey(name: "TotalKM/Day")
  num TotalKMPerDay;
  String PunchInImage;
  String PunchOutImage;

  RoutPunchM({
   required this.EmpName,
   required this.PunchIN,
   required this.PunchinKm,
   required this.PunchOutTime,
   required this.PunhOutKM,
   required this.Type,
   required this.Dt,
   required this.TotalKMPerDay,
   required this.PunchInImage,
   required this.PunchOutImage,
  });

  factory RoutPunchM.fromJson(Map<String, dynamic> json) {
    return RoutPunchM(
      EmpName: json["EmpName"]??"",
      PunchIN: json["PunchIN"]??"",
      PunchinKm: json["PunchinKm"]??"",
      PunchOutTime: json["PunchOutTime"]??"",
      PunhOutKM: json["PunhOutKM"]??"",
      Type: json["Type"]??"",
      Dt: json["Dt"]??"",
      TotalKMPerDay: json["TotalKM/Day"]??0,
      PunchInImage: json["PunchInImage"]??"",
      PunchOutImage: json["PunchOutImage"]??"",
    );
    //  return RoutPunchM(
    //   EmpName: json["EmpName"] ?? "",
    //   PunchIN: json["PunchIN"] ?? "",
    //   PunchinKm: json["PunchinKm"] ?? "",
    //   PunchOutTime: json["PunchOutTime"] ?? "",
    //   PunhOutKM: json["PunhOutKM"] ?? "",
    //   Type: json["Type"] ?? "",
    //   Dt: json["Dt"] ?? "",
    //   TotalKMPerDay:
    //       json["TotalKM/Day"] ?? 0, // Provide a default value (0 in this case)
    //   PunchInImage: json["PunchInImage"] ?? "",
    //   PunchOutImage: json["PunchOutImage"] ?? "",
    // );
  }

  Map<String, dynamic> toJson() {
    return {
      "EmpName": this.EmpName,
      "PunchIN": this.PunchIN,
      "PunchinKm": this.PunchinKm,
      "PunchOutTime": this.PunchOutTime,
      "PunhOutKM": this.PunhOutKM,
      "Type": this.Type,
      "Dt": this.Dt,
      "TotalKM/Day": this.TotalKMPerDay,
      "PunchInImage": this.PunchInImage,
      "PunchOutImage": this.PunchOutImage,
    };
  }
//

/*
  factory RoutPunchM.fromJson(Map<String, dynamic> json) => _$RoutPunchMFromJson(json);

  Map<String, dynamic> toJson() => _$RoutPunchMToJson(this);
*/
}
