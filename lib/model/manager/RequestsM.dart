import 'package:json_annotation/json_annotation.dart';

//part 'RequestsM.g.dart';

@JsonSerializable()
class RequestsM {
  String ApprovalLevel;
  String CreatedDate;
  num? EmployeeId;
  String EmpName;
  String Request;
  num RequestID;
  String RequestType;
  String? ApprovedRemarks;
  String? DateFrom;
  String? DateTo;
  num? Days;
  String? Reason;
  String? Remarks;
  String remarksText;
  String BranchReuest;
  String Img;

  RequestsM(
      {required this.ApprovalLevel,
      required this.CreatedDate,
       this.EmployeeId,
      required this.EmpName,
      required this.Request,
      required this.RequestID,
      required this.RequestType,
       this.ApprovedRemarks,
       this.DateFrom,
       this.DateTo,
       this.Days,
       this.Reason,
       this.Remarks,
      required this.remarksText,
      required this.BranchReuest,
      required this.Img});

  factory RequestsM.fromJson(Map<String, dynamic> json) {
    return RequestsM(
      ApprovalLevel: json["ApprovalLevel"],
      CreatedDate: json["CreatedDate"],
      EmployeeId: json["EmployeeId"],
      EmpName: json["EmpName"],
      Request: json["Request"],
      RequestID: json["RequestID"],
      RequestType: json["RequestType"],
      ApprovedRemarks: json["ApprovedRemarks"],
      DateFrom: json["DateFrom"],
      DateTo: json["DateTo"],
      Days: json["Days"],
      Reason: json["Reason"],
      Remarks: json["Remarks"],
      remarksText: json["remarksText"],
      BranchReuest: json["BranchReuest"],
      Img: json["Img"],
    );
  }
//

  // get getReasonText=>(Reason??"").length>0?Reason:null;

/*
  factory RequestsM.fromJson(Map<String, dynamic> json) =>
      _$RequestsMFromJson(json);

  Map<String, dynamic> toJson() => _$RequestsMToJson(this);
*/
}
