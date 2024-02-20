import 'package:json_annotation/json_annotation.dart';

// part 'DashM.g.dart';

@JsonSerializable()
class DashM {
  String Branch;
  String TotalPayments;
  String Amount;
  String CmpAmnt;
  String AmountCmp;
  String AvgAmount;
  String AvgAmountCmp;
  String GP;
  String CmpGP;
  String Gpcmp;

  String totalPresent;

  String totalAbsent;

  DashM({
   required this.Branch,
   required this.TotalPayments,
   required this.Amount,
   required this.CmpAmnt,
   required this.AvgAmount,
   required this.AvgAmountCmp,
   required this.GP,
   required this.CmpGP,
   required this.totalAbsent,
   required this.totalPresent,
   required this.Gpcmp,
   required this.AmountCmp,
  });

  factory DashM.fromJson(Map<String, dynamic> json) {
    return DashM(
      Branch: json["Branch"]??"",
      TotalPayments: json["TotalPayments"]??"",
      Amount: json["Amount"],
      CmpAmnt: json["CmpAmnt"]??"",
      AmountCmp: json["AmountCmp"],
      AvgAmount: json["AvgAmount"]??"",
      AvgAmountCmp: json["AvgAmountCmp"]??"",
      GP: json["GP"],
      CmpGP: json["CmpGP"]??"",
      Gpcmp: json["Gpcmp"],
      totalPresent: json["Total Present"],
      totalAbsent: json["Total Absent"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Branch": this.Branch,
      "TotalPayments": this.TotalPayments,
      "Amount": this.Amount,
      "CmpAmnt": this.CmpAmnt,
      "AmountCmp": this.AmountCmp,
      "AvgAmount": this.AvgAmount,
      "AvgAmountCmp": this.AvgAmountCmp,
      "GP": this.GP,
      "CmpGP": this.CmpGP,
      "Gpcmp": this.Gpcmp,
      "Total Present": this.totalPresent,
      "Total Absent": this.totalAbsent,
    };
  }
//

  // factory DashM.fromJson(Map<String, dynamic> json) => _$DashMFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$DashMToJson(this);
}
