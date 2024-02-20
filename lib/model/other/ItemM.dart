import 'package:json_annotation/json_annotation.dart';

// part 'ItemM.g.dart';

@JsonSerializable()
class ItemM {
  String Item_No;
  String Item_Name;
  String Description;
  String HSNCode;
  String Barcode;
  num OnHand;
  num Price;
  num Discount;
  String TaxIsInclusive;
  String Category;
  String? BrandName;
  String Section;
  String Manufacture;
  String TaxCode;
  dynamic Remark;
  num? MRP;
  var Cost;
  String? Image;
  String? ImageUrl1;
  String? ImageUrl2;
  String? ImageUrl3;
  num? SalesPrice;
  var GP;
  num? GroupCode;
  num? BrandCode;
  num? SectionCode;
  num? MRPDiscount;
  String? Supplier;
  String? Type;
  String? Inactive;
  num? CountedQty;

  ItemM({
  required  this.Item_No,
  required  this.Item_Name,
  required  this.Description,
  required  this.HSNCode,
  required  this.Barcode,
  required  this.OnHand,
  required  this.Price,
  required  this.Discount,
  required  this.TaxIsInclusive,
  required  this.Category,
    this.BrandName,
  required  this.Section,
  required  this.Manufacture,
  required  this.TaxCode,
  required  this.Remark,
    this.MRP,
    this.Cost,
    this.Image,
    this.ImageUrl1,
    this.ImageUrl2,
    this.ImageUrl3,
    this.SalesPrice,
    this.GP,
    this.GroupCode,
    this.BrandCode,
    this.SectionCode,
    this.MRPDiscount,
    this.Supplier,
    this.Type,
    this.Inactive,
  required  this.CountedQty,
  });

  factory ItemM.fromJson(Map<String, dynamic> json) {
    return ItemM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Description: json["Description"],
      HSNCode: json["HSNCode"],
      Barcode: json["Barcode"],
      OnHand: json["OnHand"],
      Price: json["Price"],
      Discount: json["Discount"],
      TaxIsInclusive: json["TaxIsInclusive"],
      Category: json["Category"],
      BrandName: json["BrandName"],
      Section: json["Section"],
      Manufacture: json["Manufacture"],
      TaxCode: json["TaxCode"],
      Remark: json["Remark"],
      MRP: json["MRP"],
      Cost: json["Cost"]??0.0,
      Image: json["Image"],
      ImageUrl1: json["ImageUrl1"]??"",
      ImageUrl2: json["ImageUrl2"]??"",
      ImageUrl3: json["ImageUrl3"]??"",
      SalesPrice: json["SalesPrice"]??0,
      GP: json["GP"]??"",
      GroupCode: json["GroupCode"]??0,
      BrandCode: json["BrandCode"],
      SectionCode: json["SectionCode"],
      MRPDiscount: json["MRPDiscount"],
      Supplier: json["Supplier"]??"",
      Type: json["Type"],
      Inactive: json["Inactive"],
      CountedQty: json["CountedQty"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Item_No": this.Item_No,
      "Item_Name": this.Item_Name,
      "Description": this.Description,
      "HSNCode": this.HSNCode,
      "Barcode": this.Barcode,
      "OnHand": this.OnHand,
      "Price": this.Price,
      "Discount": this.Discount,
      "TaxIsInclusive": this.TaxIsInclusive,
      "Category": this.Category,
      "BrandName": this.BrandName,
      "Section": this.Section,
      "Manufacture": this.Manufacture,
      "TaxCode": this.TaxCode,
      "Remark": this.Remark,
      "MRP": this.MRP,
      "Cost": this.Cost,
      "Image": this.Image,
      "ImageUrl1": this.ImageUrl1,
      "ImageUrl2": this.ImageUrl2,
      "ImageUrl3": this.ImageUrl3,
      "SalesPrice": this.SalesPrice,
      "GP": this.GP,
      "GroupCode": this.GroupCode,
      "BrandCode": this.BrandCode,
      "SectionCode": this.SectionCode,
      "MRPDiscount": this.MRPDiscount,
      "Supplier": this.Supplier,
      "Type": this.Type,
      "Inactive": this.Inactive,
      "CountedQty": this.CountedQty,
    };
  }
//

/*  factory ItemM.fromJson(Map<String, dynamic> json) => _$ItemMFromJson(json);

  Map<String, dynamic> toJson() => _$ItemMToJson(this);*/
}
