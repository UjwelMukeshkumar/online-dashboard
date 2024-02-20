import 'package:json_annotation/json_annotation.dart';

//part 'PartyGroupM.g.dart';

@JsonSerializable()
class PartyGroupM {
  String PartyCode;
  String PartyName;
  num No_Of_Bills;
  num? Quantity;
  num Id;
  String Name;
  String Taxcode;
  num Amount;
  num SalesAmount;
  num GPPercent;

  get getTitle => Name ?? PartyName ?? Taxcode;
  get getId => Id ?? PartyCode;
  get getAmount => Amount ?? SalesAmount;
  get getNumberOfBills => No_Of_Bills ?? Quantity;

  String getLast() {
    if (getNumberOfBills == null) {
      return GPPercent.toString() + "%";
    } else {
      return getNumberOfBills.toString();
    }
  }

/*  factory PartyGroupM.fromJson(Map<String, dynamic> json) {
    return PartyGroupM(
      PartyName: json["PartyName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "PartyName": this.PartyName,
    };
  }*/

  PartyGroupM({
    required this.PartyCode,
    required this.PartyName,
    required this.No_Of_Bills,
    required this.Id,
    required this.Name,
    required this.Amount,
    required this.GPPercent,
    required this.Taxcode,
    this.Quantity,
    required this.SalesAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'PartyCode': this.PartyCode,
      'PartyName': this.PartyName,
      'No_Of_Bills': this.No_Of_Bills,
      'Quantity': this.Quantity,
      'Id': this.Id,
      'Name': this.Name,
      'Taxcode': this.Taxcode,
      'Amount': this.Amount,
      'SalesAmount': this.SalesAmount,
      'GPPercent': this.GPPercent,
    };
  }

  factory PartyGroupM.fromJson(Map<String, dynamic> map) {
    return PartyGroupM(
      PartyCode: map['PartyCode'] ?? "",
      PartyName: map['PartyName'] ?? "",
      No_Of_Bills: map['No_Of_Bills'] ?? 0,
      Quantity: map['Quantity'] ?? 0,
      Id: map['Id'] ?? 0,
      Name: map['Name'] ?? "",
      Taxcode: map['Taxcode'] ?? "",
      Amount: map['Amount'] ?? 0,
      SalesAmount: map['SalesAmount'] ?? 0,
      GPPercent: map['GPPercent'] ?? 0,
    );
  }
/*
  factory PartyGroupM.fromJson(Map<String, dynamic> json) => _$PartyGroupMFromJson(json);

  Map<String, dynamic> toJson() => _$PartyGroupMToJson(this);
*/
}
