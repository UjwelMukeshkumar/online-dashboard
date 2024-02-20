import 'package:json_annotation/json_annotation.dart';

// part 'StockM.g.dart';

@JsonSerializable()
class StockM {
  num Str_Code;
  String StrName;
  num OrderReceived;
  num OrderGiven;
  num OnHand;
  num NetAvailable;
  num AvgPrice;

  StockM({
  required this.Str_Code,
  required this.StrName,
  required this.OrderReceived,
  required this.OrderGiven,
  required this.OnHand,
  required this.NetAvailable,
  required this.AvgPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "Str_Code": this.Str_Code,
      "StrName": this.StrName,
      "OrderReceived": this.OrderReceived,
      "OrderGiven": this.OrderGiven,
      "OnHand": this.OnHand,
      "NetAvailable": this.NetAvailable,
      "AvgPrice": this.AvgPrice,
    };
  }

  factory StockM.fromJson(Map<String, dynamic> json) {
    return StockM(
      Str_Code: json["Str_Code"],
      StrName: json["StrName"],
      OrderReceived: json["OrderReceived"],
      OrderGiven: json["OrderGiven"],
      OnHand: json["OnHand"],
      NetAvailable: json["NetAvailable"],
      AvgPrice: json["AvgPrice"],
    );
  }
//

/*
  factory StockM.fromJson(Map<String, dynamic> json) => _$StockMFromJson(json);

  Map<String, dynamic> toJson() => _$StockMToJson(this);*/
}
