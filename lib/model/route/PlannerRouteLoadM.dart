// import 'dart:convert';

// import 'package:glowrpt/library/AppSctring.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:json_annotation/json_annotation.dart';

// //part 'PlannerRouteLoadM.g.dart';

// @JsonSerializable()
// class PlannerRouteLoadM {
//   List<RouteDetailsBean> RouteDetails;
//   List<TotalCustomerBean> TotalCustomer;
//   List<TotalPunchCustomerBean> TotalPunchCustomer;
//   List<RouteActivityBean>? RouteActivity;

//   PlannerRouteLoadM({
//     required this.RouteDetails,
//     required this.TotalCustomer,
//     required this.TotalPunchCustomer,
//     this.RouteActivity = const [],
//   });

//   factory PlannerRouteLoadM.fromJson(Map<String, dynamic> json) {
//     return PlannerRouteLoadM(
//       RouteDetails: List.of(json["RouteDetails"])
//           .map((i) => RouteDetailsBean.fromJson(i))
//           .toList(),
//       TotalCustomer: List.of(json["TotalCustomer"])
//           .map((i) => TotalCustomerBean.fromJson(i))
//           .toList(),
//       TotalPunchCustomer: List.of(json["TotalPunchCustomer"])
//           .map((i) => TotalPunchCustomerBean.fromJson(i))
//           .toList(),
//       RouteActivity: List.of(json["RouteActivity"])
//           .map((i) => RouteActivityBean.fromJson(i))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "RouteDetails": jsonEncode(this.RouteDetails),
//       "TotalCustomer": jsonEncode(this.TotalCustomer),
//       "TotalPunchCustomer": jsonEncode(this.TotalPunchCustomer),
//       "RouteActivity": jsonEncode(this.RouteActivity),
//     };
//   }

// //

// /*
//   factory PlannerRouteLoadM.fromJson(Map<String, dynamic> json) => _$PlannerRouteLoadMFromJson(json);

//   Map<String, dynamic> toJson() => _$PlannerRouteLoadMToJson(this);
// */
// }

// @JsonSerializable()
// class RouteActivityBean {
//   String CVCode;

//   Map<String, dynamic> toJson() {
//     return {
//       "CVCode": this.CVCode,
//       "CVName": this.CVName,
//       "Remarks": this.Remarks,
//       "Loacation": this.Loacation,
//       "Type": this.Type,
//     };
//   }

//   String CVName;
//   String Remarks;
//   String Loacation;
//   String Type;

//   RouteActivityBean({
//     required this.CVCode,
//     required this.CVName,
//     required this.Remarks,
//     required this.Loacation,
//     required this.Type,
//   });

//   factory RouteActivityBean.fromJson(Map<String, dynamic> json) {
//     return RouteActivityBean(
//       CVCode: json["CVCode"],
//       CVName: json["CVName"],
//       Remarks: json["Remarks"],
//       Loacation: json["Loacation"],
//       Type: json["Type"],
//     );
//   }
// //

// /*
//   factory RouteActivityBean.fromJson(Map<String, dynamic> json) => _$RouteActivityBeanFromJson(json);

//   Map<String, dynamic> toJson() => _$RouteActivityBeanToJson(this);

//   factory RouteActivityBean.fromJson(Map<String, dynamic> json) {
// */
// //
// }

// @JsonSerializable()
// class TotalPunchCustomerBean {
//   num TotalCustomer;

//   TotalPunchCustomerBean({required this.TotalCustomer});

//   factory TotalPunchCustomerBean.fromJson(Map<String, dynamic> json) {
//     return TotalPunchCustomerBean(
//       TotalCustomer: json["TotalCustomer"],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "TotalCustomer": this.TotalCustomer,
//     };
//   }
// //

// /*
//   factory TotalPunchCustomerBean.fromJson(Map<String, dynamic> json) => _$TotalPunchCustomerBeanFromJson(json);

//   Map<String, dynamic> toJson() => _$TotalPunchCustomerBeanToJson(this);
// */
// }

// @JsonSerializable()
// class TotalCustomerBean {
//   num TotalCustomer;

//   TotalCustomerBean({required this.TotalCustomer});

//   factory TotalCustomerBean.fromJson(Map<String, dynamic> json) {
//     return TotalCustomerBean(
//       TotalCustomer: json["TotalCustomer"],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "TotalCustomer": this.TotalCustomer,
//     };
//   }
// //

// /*
//   factory TotalCustomerBean.fromJson(Map<String, dynamic> json) => _$TotalCustomerBeanFromJson(json);

//   Map<String, dynamic> toJson() => _$TotalCustomerBeanToJson(this);
// */
// }

// @JsonSerializable()
// class RouteDetailsBean {
//   String? CVCode;
//   String CVName;
//   String Location;
//   String? Time;
//   String? PunchStatus;
//   String? Date;
//   String? Remarks;
//   num? SortOrder;
//   String? EMP_LAT_LNG;
//   String? EMP_Location;
//   String? Approved;
//   List<RouteActivityBean> ?activitiList;
//   get getIsPunched => PunchStatus == "Y";
//   bool isSelected = false;
//   LatLng get toLatLng => LatLng(EMP_LAT_LNG!.split(",").first.toDouble,
//       EMP_LAT_LNG!.split(",").last.toDouble);

//   RouteDetailsBean({
//    this.CVCode,
//   required this.CVName,
//   required this.Location,
//    this.Time,
//    this.PunchStatus,
//    this.Date,
//    this.Remarks,
//    this.SortOrder,
//   required this.EMP_LAT_LNG,
//    this.EMP_Location,
//    this.Approved,
//    this.activitiList,
//   });

//   @override
//   String toString() {
//     return "$CVName $CVCode $Location $Remarks";
//   }

//   factory RouteDetailsBean.fromJson(Map<String, dynamic> json) {
//     return RouteDetailsBean(
//       CVCode: json["CVCode"],
//       CVName: json["CVName"],
//       Location: json["Location"],
//       Time: json["Time"],
//       PunchStatus: json["PunchStatus"],
//       Date: json["Date"],
//       Remarks: json["Remarks"],
//       SortOrder: json["SortOrder"],
//       EMP_LAT_LNG: json["EMP_LAT_LNG"],
//       EMP_Location: json["EMP_Location"],
//       Approved: json["Approved"],
//       activitiList: json["activitiList"] != null
//           ? List<Map<String, dynamic>>.from(json[
//                   "activitiList"]) // Ensure it is a List<Map<String, dynamic>>
//               .map((i) => RouteActivityBean.fromJson(i))
//               .toList()
//           : [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "CVCode": this.CVCode,
//       "CVName": this.CVName,
//       "Location": this.Location,
//       "Time": this.Time,
//       "PunchStatus": this.PunchStatus,
//       "Date": this.Date,
//       "Remarks": this.Remarks,
//       "SortOrder": this.SortOrder,
//       "EMP_LAT_LNG": this.EMP_LAT_LNG,
//       "EMP_Location": this.EMP_Location,
//       "Approved": this.Approved,
//       "activitiList": jsonEncode(this.activitiList),
//     };
//   }

// //

// //

// /*
//   factory RouteDetailsBean.fromJson(Map<String, dynamic> json) => _$RouteDetailsBeanFromJson(json);

//   Map<String, dynamic> toJson() => _$RouteDetailsBeanToJson(this);
// */
// }



////////////////////
import 'dart:convert';

import 'package:glowrpt/library/AppSctring.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PlannerRouteLoadM {
  List<RouteDetailsBean> RouteDetails;
  List<TotalCustomerBean> TotalCustomer;
  List<TotalPunchCustomerBean> TotalPunchCustomer;
  List<RouteActivityBean>? RouteActivity;

  PlannerRouteLoadM({
    required this.RouteDetails,
    required this.TotalCustomer,
    required this.TotalPunchCustomer,
    this.RouteActivity,
  });

  factory PlannerRouteLoadM.fromJson(Map<String, dynamic> json) {
    return PlannerRouteLoadM(
      RouteDetails: (json["RouteDetails"] as List)
          .map((i) => RouteDetailsBean.fromJson(i))
          .toList(),
      TotalCustomer: (json["TotalCustomer"] as List)
          .map((i) => TotalCustomerBean.fromJson(i))
          .toList(),
      TotalPunchCustomer: (json["TotalPunchCustomer"] as List)
          .map((i) => TotalPunchCustomerBean.fromJson(i))
          .toList(),
      RouteActivity: (json["RouteActivity"] as List)
          .map((i) => RouteActivityBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "RouteDetails": jsonEncode(this.RouteDetails),
      "TotalCustomer": jsonEncode(this.TotalCustomer),
      "TotalPunchCustomer": jsonEncode(this.TotalPunchCustomer),
      "RouteActivity": jsonEncode(this.RouteActivity),
    };
  }
}

@JsonSerializable()
class RouteActivityBean {
  String? CVCode;
  String? CVName;
  String? Remarks;
  String? Loacation;
  String? Type;

  RouteActivityBean({
 this.CVCode,
 this.CVName,
 this.Remarks,
 this.Loacation,
 this.Type,
  });

  factory RouteActivityBean.fromJson(Map<String, dynamic> json) {
    return RouteActivityBean(
      CVCode: json["CVCode"],
      CVName: json["CVName"],
      Remarks: json["Remarks"],
      Loacation: json["Loacation"],
      Type: json["Type"],
    );
  }
}

@JsonSerializable()
class TotalPunchCustomerBean {
  num TotalCustomer;

  TotalPunchCustomerBean({required this.TotalCustomer});

  factory TotalPunchCustomerBean.fromJson(Map<String, dynamic> json) {
    return TotalPunchCustomerBean(
      TotalCustomer: json["TotalCustomer"],
    );
  }
}

@JsonSerializable()
class TotalCustomerBean {
  num? TotalCustomer;

  TotalCustomerBean({ this.TotalCustomer});

  factory TotalCustomerBean.fromJson(Map<String, dynamic> json) {
    return TotalCustomerBean(
      TotalCustomer: json["TotalCustomer"],
    );
  }
}

@JsonSerializable()
class RouteDetailsBean {
  String? CVCode;
  String? CVName;
  String? Location;
  String? Time;
  String? PunchStatus;
  String? Date;
  String? Remarks;
  num? SortOrder;
  String? EMP_LAT_LNG;
  String? EMP_Location;
  String? Approved;
  List<RouteActivityBean>? activitiList;
  bool get getIsPunched => PunchStatus == "Y";
  bool isSelected = false;
  LatLng get toLatLng => LatLng(EMP_LAT_LNG?.split(",").first.toDouble,
      EMP_LAT_LNG?.split(",").last.toDouble);

  RouteDetailsBean({
    this.CVCode,
     this.CVName,
     this.Location,
    this.Time,
    this.PunchStatus,
    this.Date,
    this.Remarks,
    this.SortOrder,
     this.EMP_LAT_LNG,
    this.EMP_Location,
    this.Approved,
    this.activitiList,
  });

  @override
  String toString() {
    return "$CVName $CVCode $Location $Remarks";
  }

  factory RouteDetailsBean.fromJson(Map<String, dynamic> json) {
    return RouteDetailsBean(
      CVCode: json["CVCode"],
      CVName: json["CVName"],
      Location: json["Location"],
      Time: json["Time"],
      PunchStatus: json["PunchStatus"],
      Date: json["Date"],
      Remarks: json["Remarks"],
      SortOrder: json["SortOrder"],
      EMP_LAT_LNG: json["EMP_LAT_LNG"],
      EMP_Location: json["EMP_Location"],
      Approved: json["Approved"],
      activitiList: (json["activitiList"] as List?)
          ?.map((i) => RouteActivityBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "CVCode": this.CVCode,
      "CVName": this.CVName,
      "Location": this.Location,
      "Time": this.Time,
      "PunchStatus": this.PunchStatus,
      "Date": this.Date,
      "Remarks": this.Remarks,
      "SortOrder": this.SortOrder,
      "EMP_LAT_LNG": this.EMP_LAT_LNG,
      "EMP_Location": this.EMP_Location,
      "Approved": this.Approved,
      "activitiList": jsonEncode(this.activitiList),
    };
  }
}

