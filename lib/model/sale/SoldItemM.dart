import 'package:json_annotation/json_annotation.dart';

//part 'SoldItemM.g.dart';

@JsonSerializable()
class SoldItemM {
  String? PartyName;
  String? Item_No;
  String? Item_Name;
  String? BillNo;
  num? Price;
  String? Barcode;
  num? Discount;
  num? GP;
  num? Cost;

  factory SoldItemM.fromJson(Map<String, dynamic> json) {
    return SoldItemM(
      PartyName: json["PartyName"],
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      BillNo: json["BillNo"],
      Price: json["Price"],
      Barcode: json["Barcode"],
      Discount: json["Discount"],
      GP: json["GP"],
      Cost: json["Cost"],
    );
  }

  SoldItemM({
    this.PartyName,
    this.Item_No,
    this.Item_Name,
    this.Price,
    this.Barcode,
    this.Discount,
    this.BillNo,
    this.GP,
    this.Cost,
  });

/*
  factory SoldItemM.fromJson(Map<String, dynamic> json) => _$SoldItemMFromJson(json);

  Map<String, dynamic> toJson() => _$SoldItemMToJson(this);
*/
}
