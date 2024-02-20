import 'package:json_annotation/json_annotation.dart';

//part 'CampainItem.g.dart';

@JsonSerializable()
class CampainItem {
  String Item_No;
  String Item_Name;
  String Barcode;
  num Onhand;
  num? Price;
  num? MRP;
  num? Old_Price;
  num? SI_No;

  factory CampainItem.fromJson(Map<String, dynamic> json) {
    return CampainItem(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Barcode: json["Barcode"],
      Onhand: json["Onhand"],
      Price: json["Price"]??0,
      MRP: json["MRP"],
      Old_Price: json["Old_Price"],
      SI_No: json["SI_No"],
      Discprec: json["Discprec"],
      New_Price: json["New_Price"],
      PriceAfterDisc: json["PriceAfterDisc"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Item_No": this.Item_No,
      "Item_Name": this.Item_Name,
      "Barcode": this.Barcode,
      "Onhand": this.Onhand,
      "Price": this.Price,
      "MRP": this.MRP,
      "Old_Price": this.Old_Price,
      "SI_No": this.SI_No,
      "Discprec": this.Discprec,
      "New_Price": this.New_Price,
      "PriceAfterDisc": this.PriceAfterDisc,
    };
  }

  var Discprec;
  num? New_Price;
  var PriceAfterDisc;

  CampainItem({
  required this.Item_No,
  required this.Item_Name,
  required this.Barcode,
  required this.Onhand,
   this.Price,
   this.MRP,
   this.Old_Price,
   this.SI_No,
   this.New_Price,
  required this.Discprec,
  required this.PriceAfterDisc
  });

 /* factory CampainItem.fromJson(Map<String, dynamic> json) =>
      _$CampainItemFromJson(json);

  Map<String, dynamic> toJson() => _$CampainItemToJson(this);
*/}
