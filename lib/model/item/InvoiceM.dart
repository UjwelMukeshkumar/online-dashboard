import 'package:json_annotation/json_annotation.dart';

//part 'InvoiceM.g.dart';

@JsonSerializable()
class InvoiceM {
  String Document;
  num SalesAmount;
  num GP;
  num Sequence;

  factory InvoiceM.fromJson(Map<String, dynamic> json) {
    return InvoiceM(
      Document: json["Document"],
      SalesAmount: json["SalesAmount"],
      GP: json["GP"],
      Sequence: json["Sequence"],
      RecNum: json["RecNum"],
      InitNo: json["InitNo"],
      Type: json["Type"],
    );
  }

  num RecNum;
  num InitNo;
  String Type;

  InvoiceM({
   required this.Document,
   required this.SalesAmount,
   required this.GP,
   required this.Sequence,
   required this.RecNum,
   required this.InitNo,
   required this.Type,
  });

/*
  factory InvoiceM.fromJson(Map<String, dynamic> json) => _$InvoiceMFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceMToJson(this);
*/
}
