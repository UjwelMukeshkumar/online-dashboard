import 'package:json_annotation/json_annotation.dart';

// part 'AnalaticsM.g.dart';

@JsonSerializable()
class AnalaticsM {
  String Branch;
  num TotalPayments;
  num Amount;
  num CmpAmnt;
  num AvgAmount;
  num AvgAmountCmp;
  num GP;
  num CmpGP;
  num Org_Id;
  num Total_Estimated_Expense;
  num NetProft;

  AnalaticsM({
  required  this.Branch,
  required  this.TotalPayments,
  required  this.Amount,
  required  this.CmpAmnt,
  required  this.AvgAmount,
  required  this.AvgAmountCmp,
  required  this.GP,
  required  this.Total_Estimated_Expense,
  required  this.CmpGP,
  required  this.Org_Id,
  required  this.NetProft,
  });

  factory AnalaticsM.fromJson(Map<String, dynamic> json) {
    return AnalaticsM(
      Branch: json["Branch"],
      TotalPayments: json["TotalPayments"],
      Amount: json["Amount"],
      CmpAmnt: json["CmpAmnt"],
      AvgAmount: json["AvgAmount"],
      AvgAmountCmp: json["AvgAmountCmp"],
      GP: json["GP"],
      CmpGP: json["CmpGP"],
      Org_Id: json["Org_Id"],
      Total_Estimated_Expense: json["Total_Estimated_Expense"],
      NetProft: json["NetProft"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Branch": this.Branch,
      "TotalPayments": this.TotalPayments,
      "Amount": this.Amount,
      "CmpAmnt": this.CmpAmnt,
      "AvgAmount": this.AvgAmount,
      "AvgAmountCmp": this.AvgAmountCmp,
      "GP": this.GP,
      "CmpGP": this.CmpGP,
      "Org_Id": this.Org_Id,
      "Total_Estimated_Expense": this.Total_Estimated_Expense,
      "NetProft": this.NetProft,
    };
  }
//

  /* factory AnalaticsM.fromJson(Map<String, dynamic> json) =>
      _$AnalaticsMFromJson(json);

  Map<String, dynamic> toJson() => _$AnalaticsMToJson(this);*/
}
