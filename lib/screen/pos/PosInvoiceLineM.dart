import 'package:json_annotation/json_annotation.dart';

// part 'PosInvoiceLineM.g.dart';

@JsonSerializable()
class PosInvoiceLineM {
  num Sl_No;
  String Item_No;
  String Item_Name;
  num Quantity;
  num FOC;
  String IsInclusive;
  num Price;
  num PriceFC;
  num Discount;
  String Batch_Code;
  num TaxAmount;
  num NetTotal;
  String TaxCode;
  num TaxRate;
  String Source_Type;
  num Source_Line_No;
  num SourceSequence;
  num SourceRecNum;
  num SourceInitNo;
  String LineStatus;

  PosInvoiceLineM({
  required  this.Sl_No,
  required  this.Item_No,
  required  this.Item_Name,
  required  this.Quantity,
  required  this.FOC,
  required  this.IsInclusive,
  required  this.Price,
  required  this.PriceFC,
  required  this.Discount,
  required  this.Batch_Code,
  required  this.TaxAmount,
  required  this.NetTotal,
  required  this.TaxCode,
  required  this.TaxRate,
  required  this.Source_Type,
  required  this.Source_Line_No,
  required  this.SourceSequence,
  required  this.SourceRecNum,
  required  this.SourceInitNo,
  required  this.LineStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "Sl_No": this.Sl_No,
      "Item_No": this.Item_No,
      "Item_Name": this.Item_Name,
      "Quantity": this.Quantity,
      "FOC": this.FOC,
      "IsInclusive": this.IsInclusive,
      "Price": this.Price,
      "PriceFC": this.PriceFC,
      "Discount": this.Discount,
      "Batch_Code": this.Batch_Code,
      "TaxAmount": this.TaxAmount,
      "NetTotal": this.NetTotal,
      "TaxCode": this.TaxCode,
      "TaxRate": this.TaxRate,
      "Source_Type": this.Source_Type,
      "Source_Line_No": this.Source_Line_No,
      "SourceSequence": this.SourceSequence,
      "SourceRecNum": this.SourceRecNum,
      "SourceInitNo": this.SourceInitNo,
      "LineStatus": this.LineStatus,
    };
  }

  factory PosInvoiceLineM.fromJson(Map<String, dynamic> json) {
    return PosInvoiceLineM(
      Sl_No: json["Sl_No"],
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Quantity: json["Quantity"],
      FOC: json["FOC"],
      IsInclusive: json["IsInclusive"],
      Price: json["Price"],
      PriceFC: json["PriceFC"],
      Discount: json["Discount"],
      Batch_Code: json["Batch_Code"],
      TaxAmount: json["TaxAmount"],
      NetTotal: json["NetTotal"],
      TaxCode: json["TaxCode"],
      TaxRate: json["TaxRate"],
      Source_Type: json["Source_Type"],
      Source_Line_No: json["Source_Line_No"],
      SourceSequence: json["SourceSequence"],
      SourceRecNum: json["SourceRecNum"],
      SourceInitNo: json["SourceInitNo"],
      LineStatus: json["LineStatus"],
    );
  }
//

/* factory PosInvoiceLineM.fromJson(Map<String, dynamic> json) => _$PosInvoiceLineMFromJson(json);

  Map<String, dynamic> toJson() => _$PosInvoiceLineMToJson(this);*/
}
