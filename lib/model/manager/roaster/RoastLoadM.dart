// import 'dart:convert';

// import 'package:json_annotation/json_annotation.dart';

// //part 'RoastLoadM.g.dart';

// @JsonSerializable()
// class RoastLoadM {
//   List<Shift_RoasterBean>? Shift_Roaster;
//   List<Shift_DetailsBean>? Shift_Details;
//   List<Employee_DetailsBean>? Employee_Details;
//   List<DepartmentBean>? Department;
//    List<Table3Bean>? Table3;

//   RoastLoadM({
//    this.Shift_Roaster,
//    this.Shift_Details,
//    this.Employee_Details,
//    this.Table3,
//      this.Department,
//   });

//   factory RoastLoadM.fromJson(Map<String, dynamic> json) {
//     return RoastLoadM(
//       Shift_Roaster: List.of(json["Shift_Roaster"])
//           .map((i) => Shift_RoasterBean.fromJson(i))
//           .toList(),
//       Shift_Details: List.of(json["Shift_Details"])
//           .map((i) => Shift_DetailsBean.fromJson(i))
//           .toList(),
//       Employee_Details: List.of(json["Employee_Details"])
//           .map((i) => Employee_DetailsBean.fromJson(i))
//           .toList(),
//       Department: List.of(json["Department"])
//           .map((i) => DepartmentBean.fromJson(i))
//           .toList(),
//       Table3:
//          List.of(json["Table3"]).map((i) => Table3Bean.fromJson(i)).toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "Shift_Roaster": jsonEncode(this.Shift_Roaster),
//       "Shift_Details": jsonEncode(this.Shift_Details),
//       "Employee_Details": jsonEncode(this.Employee_Details),
//       "Department": jsonEncode(this.Department),
//       // "Table3": jsonEncode(this.Table3),
//     };
//   }
// //

// /*
//   factory RoastLoadM.fromJson(Map<String, dynamic> json) => _$RoastLoadMFromJson(json);

//   Map<String, dynamic> toJson() => _$RoastLoadMToJson(this);
// */
// }

// @JsonSerializable()
// class Table3Bean {
//   String M;
//   String H;
//   String E;
//   num U;

//   Table3Bean({
//     required this.M,
//     required this.H,
//     required this.E,
//     required this.U,
//   });

//   factory Table3Bean.fromJson(Map<String, dynamic> json) {
//     return Table3Bean(
//       M: json["M"],
//       H: json["H"],
//       E: json["E"],
//       U: json["U"],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "M": this.M,
//       "H": this.H,
//       "E": this.E,
//       "U": this.U,
//     };
//   }
// //

// /*
//   factory Table3Bean.fromJson(Map<String, dynamic> json) => _$Table3BeanFromJson(json);

//   Map<String, dynamic> toJson() => _$Table3BeanToJson(this);
// */
// }

// @JsonSerializable()
// class Employee_DetailsBean {
//   String? EmpId;
//   String? EmpCode;
//   String? EmpName;
//   String? Department;
//   String? Designation;

//   Employee_DetailsBean({
//    this.EmpId,
//    this.EmpCode,
//    this.EmpName,
//    this.Department,
//    this.Designation,
//   });

//   factory Employee_DetailsBean.fromJson(Map<String, dynamic> json) {
//     return Employee_DetailsBean(
//       EmpId: json["EmpId"]as String,
//       EmpCode: json["EmpCode"] as String,
//       EmpName: json["EmpName"] as String,
//       Department: json["Department"] as String,
//       Designation: json["Designation"] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "EmpId": this.EmpId,
//       "EmpCode": this.EmpCode,
//       "EmpName": this.EmpName,
//       "Department": this.Department,
//       "Designation": this.Designation,
//     };
//   }
// //

// /*
//   factory Employee_DetailsBean.fromJson(Map<String, dynamic> json) => _$Employee_DetailsBeanFromJson(json);

//   Map<String, dynamic> toJson() => _$Employee_DetailsBeanToJson(this);
// */
// }

// @JsonSerializable()
// class Shift_DetailsBean {
//   num? Org_Id;
//   num? ShiftCode;
//   String? ShiftColour;
//   String? ShiftName;
//   num? ShiftValue;
//   DateTime? shiftDate;

//   Shift_DetailsBean({
//     this.Org_Id,
//      this.ShiftCode,
//      this.ShiftColour,
//      this.ShiftName,
//      this.ShiftValue,
//      this.shiftDate,
//   });

//   factory Shift_DetailsBean.fromJson(Map<String, dynamic> json) {
//     return Shift_DetailsBean(
//       Org_Id: json["Org_Id"] as num?,
//       ShiftCode: json["ShiftCode"] as num?,
//       ShiftColour: json["ShiftColour"] as String?,
//       ShiftName: json["ShiftName"] as String?,
//       ShiftValue: json["ShiftValue"] as num?,
//       shiftDate:json["shiftDate"] !=null?DateTime.parse(json["shiftDate"] as String):null,
//     );

 
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "Org_Id": this.Org_Id,
//       "ShiftCode": this.ShiftCode,
//       "ShiftColour": this.ShiftColour,
//       "ShiftName": this.ShiftName,
//       "ShiftValue": this.ShiftValue,
//       "shiftDate": this.shiftDate?.toIso8601String(),
//     };
//   }
// //

// /*
//   factory Shift_DetailsBean.fromJson(Map<String, dynamic> json) => _$Shift_DetailsBeanFromJson(json);

//   Map<String, dynamic> toJson() => _$Shift_DetailsBeanToJson(this);
// */
// }

// @JsonSerializable()
// class Shift_RoasterBean {
//   num? Org_Id;
//   String? DocDate;
//   String? EmpCode;
//   String? ShiftCode;

//   Shift_RoasterBean({
//     this.Org_Id,
//      this.DocDate,
//     this.EmpCode,
//     this.ShiftCode,
//   });

//   factory Shift_RoasterBean.fromJson(Map<String, dynamic> json) {
//     return Shift_RoasterBean(
//       DocDate: json["DocDate"],
//     );
//   }
// //

// /*
//   factory Shift_RoasterBean.fromJson(Map<String, dynamic> json) => _$Shift_RoasterBeanFromJson(json);

//   Map<String, dynamic> toJson() => _$Shift_RoasterBeanToJson(this);
// */
// }

// @JsonSerializable()
// class DepartmentBean {
//   num? Id;
//   String? Name;

//   DepartmentBean({
//      this.Id,
//      this.Name,
//   });

//   factory DepartmentBean.fromJson(Map<String, dynamic> json) {
//     return DepartmentBean(
//       Id: json["Id"],
//       Name: json["Name"],
//     );
//   }

//   /*
//   factory DepartmentBean.fromJson(Map<String, dynamic> json) => _$DepartmentBeanFromJson(json);

//   Map<String, dynamic> toJson() => _$DepartmentBeanToJson(this);
// */

//   @override
//   String toString() {
//     return Name.toString();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "Id": this.Id,
//       "Name": this.Name,
//     };
//   }
// }





import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RoastLoadM {
  List<Shift_RoasterBean>? Shift_Roaster;
  List<Shift_DetailsBean>? Shift_Details;
  List<Employee_DetailsBean>? Employee_Details;
  List<DepartmentBean>? Department;
  List<Table3Bean>? Table3;

  RoastLoadM({
    this.Shift_Roaster,
    this.Shift_Details,
    this.Employee_Details,
    this.Department,
    this.Table3,
  });

  factory RoastLoadM.fromJson(Map<String, dynamic> json) {
    return RoastLoadM(
      Shift_Roaster: (json['Shift_Roaster'] as List<dynamic>?)
          ?.map((i) => Shift_RoasterBean.fromJson(i as Map<String, dynamic>))
          .toList(),
      Shift_Details: (json['Shift_Details'] as List<dynamic>?)
          ?.map((i) => Shift_DetailsBean.fromJson(i as Map<String, dynamic>))
          .toList(),
      Employee_Details: (json['Employee_Details'] as List<dynamic>?)
          ?.map((i) => Employee_DetailsBean.fromJson(i as Map<String, dynamic>))
          .toList(),
      Department: (json['Department'] as List<dynamic>?)
          ?.map((i) => DepartmentBean.fromJson(i as Map<String, dynamic>))
          .toList(),
      Table3: json['Table3']!=null? (json['Table3'] as List<dynamic>?)
          ?.map((i) => Table3Bean.fromJson(i as Map<String, dynamic>))
          .toList():[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Shift_Roaster': jsonEncode(Shift_Roaster),
      'Shift_Details': jsonEncode(Shift_Details),
      'Employee_Details': jsonEncode(Employee_Details),
      'Department': jsonEncode(Department),
      'Table3': jsonEncode(Table3),
    };
  }
}

@JsonSerializable()
class Table3Bean {
  String? M;
  String? H;
  String? E;
  num? U;

  Table3Bean({
     this.M,
     this.H,
     this.E,
     this.U,
  });

  factory Table3Bean.fromJson(Map<String, dynamic> json) {
    return Table3Bean(
      M: json['M'] ,
      H: json['H'] ,
      E: json['E'] ,
      U: json['U'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'M': M,
      'H': H,
      'E': E,
      'U': U,
    };
  }
}

@JsonSerializable()
class Employee_DetailsBean {
  String? EmpId;
  String? EmpCode;
  String? EmpName;
  String? Department;
  String? Designation;

  Employee_DetailsBean({
    this.EmpId,
    this.EmpCode,
    this.EmpName,
    this.Department,
    this.Designation,
  });

  factory Employee_DetailsBean.fromJson(Map<String, dynamic> json) {
    return Employee_DetailsBean(
      EmpId: json['EmpId'] ,
      EmpCode: json['EmpCode'] ,
      EmpName: json['EmpName'] ,
      Department: json['Department'] ,
      Designation: json['Designation'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EmpId': EmpId,
      'EmpCode': EmpCode,
      'EmpName': EmpName,
      'Department': Department,
      'Designation': Designation,
    };
  }
}

@JsonSerializable()
class Shift_DetailsBean {
  num? Org_Id;
  num? ShiftCode;
  String? ShiftColour;
  String? ShiftName;
  num? ShiftValue;
  DateTime? shiftDate;

  Shift_DetailsBean({
    this.Org_Id,
    this.ShiftCode,
    this.ShiftColour,
    this.ShiftName,
    this.ShiftValue,
    this.shiftDate,
  });

  factory Shift_DetailsBean.fromJson(Map<String, dynamic> json) {
    return Shift_DetailsBean(
      Org_Id: json['Org_Id'] != null ? (json['Org_Id'] as num) : 0,
      ShiftCode: json['ShiftCode'] != null ? (num.parse(json['ShiftCode'])) : 0,
      ShiftValue: json['ShiftValue'] != null ? (json['ShiftValue'] as num) : 0,

      // Org_Id: json['Org_Id']??0 ,
      // ShiftCode: json['ShiftCode']??0 ,
      ShiftColour: json['ShiftColour']??"" ,
      ShiftName: json['ShiftName']??"" ,
      // ShiftValue: json['ShiftValue']??0 ,
      shiftDate: json['shiftDate'] != null
          ? DateTime.parse(json['shiftDate'] )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Org_Id': Org_Id,
      'ShiftCode': ShiftCode,
      'ShiftColour': ShiftColour,
      'ShiftName': ShiftName,
      'ShiftValue': ShiftValue,
      'shiftDate': shiftDate?.toIso8601String(),
    };
  }
}

@JsonSerializable()
class Shift_RoasterBean {
  num? Org_Id;
  String? DocDate;
  String? EmpCode;
  String? ShiftCode;

  Shift_RoasterBean({
    this.Org_Id,
    this.DocDate,
    this.EmpCode,
    this.ShiftCode,
  });

  factory Shift_RoasterBean.fromJson(Map<String, dynamic> json) {
    return Shift_RoasterBean(
      DocDate: json['DocDate'] as String,
    );
  }
}

@JsonSerializable()
class DepartmentBean {
  num? Id;
  String? Name;

  DepartmentBean({
    this.Id,
    this.Name,
  });

  factory DepartmentBean.fromJson(Map<String, dynamic> json) {
    return DepartmentBean(
      Id: json['Id'] ,
      Name: json['Name'] ,
    );
  }

  @override
  String toString() {
    return Name.toString();
  }
}

