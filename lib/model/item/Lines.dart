import 'package:json_annotation/json_annotation.dart';

//part 'Lines.g.dart';

@JsonSerializable()
class Lines {
  String Transaction;
  String TransactionDate;
  double Quantity;
  double? RunningTotal;
  String StrName;
  String? PartyName;
  String Source_Type;
  int? SI_No;
  double Price;

  Lines({
    required this.Transaction,
    required this.TransactionDate,
    required this.Quantity,
    required this.StrName,
     this.PartyName,
    required this.Price,
    required this.Source_Type,
    this.RunningTotal,
     this.SI_No,
  });

  Map<String, dynamic> toJson() {
    return {
      "Transaction": this.Transaction,
      "Transaction Date": this.TransactionDate,
      "Quantity": this.Quantity,
      "RunningTotal": this.RunningTotal,
      "StrName": this.StrName,
      "PartyName": this.PartyName,
      "Source_Type": this.Source_Type,
      "SI_No": this.SI_No,
      "Price": this.Price,
    };
  }

  factory Lines.fromJson(Map<String, dynamic> json) {
    return Lines(
      Transaction: json["Transaction"],
      TransactionDate: json["Transaction Date"],
      Quantity: json["Quantity"],
       RunningTotal:json["RunningTotal"]??0.0,
      StrName: json["StrName"],
      PartyName: json["PartyName"],
      Source_Type: json["Source_Type"]??""??0,
      SI_No: json["SI_No"],
      Price: json["Price"],
    );
  }
//

/*
  factory Lines.fromJson(Map<String, dynamic> json) => _$LinesFromJson(json);

  Map<String, dynamic> toJson() => _$LinesToJson(this);
*/
}
