import 'package:json_annotation/json_annotation.dart';

//part 'DefaultM.g.dart';

@JsonSerializable()
class DefaultM {
  num CashAccount;
  num CardAccount;
  num BankAccount;
  num ChequeAccount;
  String Cash;
  String Card;
  String Bank;
  String Cheque;

  DefaultM({
   required this.CashAccount,
   required this.CardAccount,
   required this.BankAccount,
   required this.ChequeAccount,
   required this.Cash,
   required this.Card,
   required this.Bank,
   required this.Cheque,
  });

  Map<String, dynamic> toJson() {
    return {
      "CashAccount": this.CashAccount,
      "CardAccount": this.CardAccount,
      "BankAccount": this.BankAccount,
      "ChequeAccount": this.ChequeAccount,
      "Cash": this.Cash,
      "Card": this.Card,
      "Bank": this.Bank,
      "Cheque": this.Cheque,
    };
  }

  factory DefaultM.fromJson(Map<String, dynamic> json) {
    return DefaultM(
      CashAccount: json["CashAccount"],
      CardAccount: json["CardAccount"],
      BankAccount: json["BankAccount"],
      ChequeAccount: json["ChequeAccount"],
      Cash: json["Cash"],
      Card: json["Card"],
      Bank: json["Bank"],
      Cheque: json["Cheque"],
    );
  }

  /*
  factory DefaultM.fromJson(Map<String, dynamic> json) =>
      _$DefaultMFromJson(json);

*/
  // Map<String, dynamic> toJson() => _$DefaultMToJson(this);
}
