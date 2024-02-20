import 'package:json_annotation/json_annotation.dart';

//part 'StockMoveM.g.dart';

@JsonSerializable()
class StockMoveM {
 final String MMonth;
 final String YYear;
 final num Stock;
 final num Debtor;
 late  num Creditor;
 final num Total;

  factory StockMoveM.fromJson(Map<String, dynamic> json) {
    return StockMoveM(
      MMonth: json["MMonth"] as String,
      YYear: json["YYear"] as String,
      Stock: json["Stock"] as num,
      Debtor: json["Debtor"] as num,
      Creditor: json["Creditor"]as num,
      Total: json["Total"] as num,
    );
  }

  StockMoveM({
  required  this.MMonth,
  required  this.YYear,
  required  this.Stock,
  required  this.Debtor,
  required  this.Creditor,
  required  this.Total,
  });

/*
  factory StockMoveM.fromJson(Map<String, dynamic> json) => _$StockMoveMFromJson(json);

  Map<String, dynamic> toJson() => _$StockMoveMToJson(this);
*/
}
