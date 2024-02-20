// To parse this JSON data, do
//
//     final expenceChildM = expenceChildMFromJson(jsonString);

import 'dart:convert';

ExpenceChildM expenceChildMFromJson(String str) =>
    ExpenceChildM.fromJson(json.decode(str));

String expenceChildMToJson(ExpenceChildM data) => json.encode(data.toJson());

class ExpenceChildM {
  ExpenceChildM({
   required this.requestId,
   required this.employeeId,
   required this.empName,
   required this.accountName,
   required this.amount,
   required this.date,
   required this.docImage,
   required this.remarks,
   required this.approvalLevel,
   required this.approvedRemarks,
  });

  int requestId;
  int employeeId;
  String empName;
  String accountName;
  String amount;
  String date;
  String docImage;
  String remarks;
  String approvalLevel;
  String approvedRemarks;

  factory ExpenceChildM.fromJson(Map<String, dynamic> json) => ExpenceChildM(
        requestId: json["RequestID"] == null ? null : json["RequestID"],
        employeeId: json["EmployeeID"] == null ? null : json["EmployeeID"],
        empName: json["EmpName"] == null ? null : json["EmpName"],
        accountName: json["Account_Name"] == null ? null : json["Account_Name"],
        //amount: json["Amount"] == null ? null : json["Amount"].toString(),
        amount:  json["Amount"].toString(),
        date: json["Date"] == null ? null : json["Date"],
        // docImage: json["DocImage"] == null ? null : json["DocImage"].toString(),
        docImage:  json["DocImage"].toString(),
        remarks: json["Remarks"] == null ? null : json["Remarks"],
        approvalLevel:
            json["ApprovalLevel"] == null ? null : json["ApprovalLevel"],
        approvedRemarks:
            json["ApprovedRemarks"] == null ? null : json["ApprovedRemarks"],
      );

  Map<String, dynamic> toJson() => {
        "RequestID": requestId == null ? null : requestId,
        "EmployeeID": employeeId == null ? null : employeeId,
        "EmpName": empName == null ? null : empName,
        "Account_Name": accountName == null ? null : accountName,
        "Amount": amount == null ? null : amount.toString(),
        "Date": date == null ? null : date,
        "DocImage": docImage,
        "Remarks": remarks == null ? null : remarks,
        "ApprovalLevel": approvalLevel == null ? null : approvalLevel,
        "ApprovedRemarks": approvedRemarks == null ? null : approvedRemarks,
      };
}
