import 'package:json_annotation/json_annotation.dart';

//part 'BillDataM.g.dart';

@JsonSerializable()
class BillDataM {
  num LineEntry;
  num LineSequence;
  num LineRecNum;
  num LineInitNum;
  String BillDate;
  num RecTotal;
  num CollectedSum;
  num Balance;
  String InvCategory;
  num InvEntry;

  BillDataM({
    required this.LineEntry,
    required this.LineSequence,
    required this.LineRecNum,
    required this.LineInitNum,
    required this.BillDate,
    required this.RecTotal,
    required this.CollectedSum,
    required this.Balance,
    required this.InvCategory,
    required this.InvEntry,
  });

  factory BillDataM.fromJson(Map<String, dynamic> json) {
    return BillDataM(
      LineEntry: json["LineEntry"],
      LineSequence: json["LineSequence"],
      LineRecNum: json["LineRecNum"],
      LineInitNum: json["LineInitNum"],
      BillDate: json["BillDate"],
      RecTotal: json["RecTotal"],
      CollectedSum: json["CollectedSum"],
      Balance: json["Balance"],
      InvCategory: json["InvCategory"],
      InvEntry: json["InvEntry"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "LineEntry": this.LineEntry,
      "LineSequence": this.LineSequence,
      "LineRecNum": this.LineRecNum,
      "LineInitNum": this.LineInitNum,
      "BillDate": this.BillDate,
      "RecTotal": this.RecTotal,
      "CollectedSum": this.CollectedSum,
      "Balance": this.Balance,
      "InvCategory": this.InvCategory,
      "InvEntry": this.InvEntry,
    };
  }

//

/*
  factory BillDataM.fromJson(Map<String, dynamic> json) =>
      _$BillDataMFromJson(json);

  Map<String, dynamic> toJson() => _$BillDataMToJson(this);
*/
}
