// To parse this JSON data, do
//
//     final transactionHm = transactionHmFromJson(jsonString);

import 'dart:convert';

TransactionHm transactionHmFromJson(String str) =>
    TransactionHm.fromJson(json.decode(str));

String transactionHmToJson(TransactionHm data) => json.encode(data.toJson());

class TransactionHm {
  TransactionHm({
  required this.header,
  required this.total,
  required this.totalBalanceDue,
  required this.dueFor30Days,
  required this.dueFor60Days,
  required this.dueFor90Days,
  required this.dueFor90AboveDays,
  });

  String header;
  double total;
  double totalBalanceDue;
  double dueFor30Days;
  double dueFor60Days;
  double dueFor90Days;
  double dueFor90AboveDays;

  factory TransactionHm.fromJson(Map<String, dynamic> json) => TransactionHm(
        header: json["Header"] == null ? null : json["Header"],
        total: json["Total"] == null ? null : json["Total"].toDouble(),
        totalBalanceDue: json["Total_Balance_Due"] == null
            ? null
            : json["Total_Balance_Due"].toDouble(),
        dueFor30Days:
            json["Due_for_30_Days"] == null ? null : json["Due_for_30_Days"],
        dueFor60Days: json["Due_for_60_Days"] == null
            ? null
            : json["Due_for_60_Days"].toDouble(),
        dueFor90Days:
            json["Due_for_90_Days"] == null ? null : json["Due_for_90_Days"],
        dueFor90AboveDays: json["Due_for_90Above_Days"] == null
            ? null
            : json["Due_for_90Above_Days"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Header": header == null ? null : header,
        "Total": total == null ? null : total,
        "Total_Balance_Due": totalBalanceDue == null ? null : totalBalanceDue,
        "Due_for_30_Days": dueFor30Days == null ? null : dueFor30Days,
        "Due_for_60_Days": dueFor60Days == null ? null : dueFor60Days,
        "Due_for_90_Days": dueFor90Days == null ? null : dueFor90Days,
        "Due_for_90Above_Days":
            dueFor90AboveDays == null ? null : dueFor90AboveDays,
      };
}
