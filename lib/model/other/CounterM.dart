import 'package:json_annotation/json_annotation.dart';

// part 'CounterM.g.dart';

@JsonSerializable()
class CounterM {
  num? Cash;
  num? Card;
  num? Bank;
  String? Txt;
  String? Type;
  get amount => Cash ?? Card ?? Bank;

  CounterM({
   this.Cash,
   this.Txt,
   this.Type,
   this.Bank,
   this.Card,
  });

  factory CounterM.fromJson(Map<String, dynamic> json) {
    return CounterM(
      Cash: json["Cash"],
      Card: json["Card"],
      Bank: json["Bank"],
      Txt: json["Txt"],
      Type: json["Type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Cash": this.Cash,
      "Card": this.Card,
      "Bank": this.Bank,
      "Txt": this.Txt,
      "Type": this.Type,
    };
  }
//

  /* factory CounterM.fromJson(Map<String, dynamic> json) =>
      _$CounterMFromJson(json);

  Map<String, dynamic> toJson() => _$CounterMToJson(this);*/
}
