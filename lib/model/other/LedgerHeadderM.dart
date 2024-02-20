import 'package:json_annotation/json_annotation.dart';

// part 'LedgerHeadderM.g.dart';

@JsonSerializable()
class LedgerHeadderM {
  num TotalReceviables;
  num TotalPayables;
  num Sales;
  num Purchase;
  num Receipt;
  num? Payment;
  num? Salescomparison;
  num Purchasecomparison;
  num Receiptcomparison;
  num? Paymentcomparison;

  LedgerHeadderM({
    required this.TotalReceviables,
    required this.TotalPayables,
    required this.Sales,
    required this.Purchase,
    required this.Receipt,
     this.Payment,
     this.Salescomparison,
    required this.Purchasecomparison,
    required this.Receiptcomparison,
     this.Paymentcomparison,
  });

  factory LedgerHeadderM.fromJson(Map<String, dynamic> json) {
    return LedgerHeadderM(
      TotalReceviables: json["TotalReceviables"],
      TotalPayables: json["TotalPayables"],
      Sales: json["Sales"],
      Purchase: json["Purchase"],
      Receipt: json["Receipt"],
      Payment: json["Payment"],
      Salescomparison: json["Salescomparison"],
      Purchasecomparison: json["Purchasecomparison"],
      Receiptcomparison: json["Receiptcomparison"],
      Paymentcomparison: json["Paymentcomparison"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TotalReceviables": this.TotalReceviables,
      "TotalPayables": this.TotalPayables,
      "Sales": this.Sales,
      "Purchase": this.Purchase,
      "Receipt": this.Receipt,
      "Payment": this.Payment,
      "Salescomparison": this.Salescomparison,
      "Purchasecomparison": this.Purchasecomparison,
      "Receiptcomparison": this.Receiptcomparison,
      "Paymentcomparison": this.Paymentcomparison,
    };
  }
//

  /* factory LedgerHeadderM.fromJson(Map<String, dynamic> json) =>
      _$LedgerHeadderMFromJson(json);

  Map<String, dynamic> toJson() => _$LedgerHeadderMToJson(this);*/
}
