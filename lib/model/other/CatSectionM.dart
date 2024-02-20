import 'package:json_annotation/json_annotation.dart';

// part 'CatSectionM.g.dart';
//category,section,brand,etc..
@JsonSerializable()
class CatSectionM {
  String? Section;
  String? Brand;
  String? ItemGroup;
  num? SalesAmount;
  String? Status;
  num? Quantity;
  num? GrossProfit;
  num? GPPercent;
  num? SalesPercentage;
  num? Percentage_Cmp;
  num? Grp_Id;
  num? BrandId;
  num? Id;

  get title => Section ?? ItemGroup ?? Brand;
  get id => Grp_Id ?? Id ?? BrandId;

  CatSectionM({
    this.Section,
    this.Brand,
    this.ItemGroup,
    this.SalesAmount,
    this.Status,
    this.Quantity,
    this.GrossProfit,
    this.GPPercent,
    this.SalesPercentage,
    this.Percentage_Cmp,
    this.Grp_Id,
    this.BrandId,
    this.Id,
  });

  /*  CatSectionM(
      {this.Section,
      this.SalesAmount,
      this.Status,
      this.Quantity,
      this.GrossProfit,
      this.GPPercent,
      this.SalesPercentage,this.Brand,});*/

  factory CatSectionM.fromJson(Map<String, dynamic> json) {
    return CatSectionM(
      Section: json["Section"],
      Brand: json["Brand"],
      ItemGroup: json["ItemGroup"],
      SalesAmount: json["SalesAmount"],
      Status: json["Status"],
      Quantity: json["Quantity"],
      GrossProfit: json["GrossProfit"],
      GPPercent: json["GPPercent"],
      SalesPercentage: json["SalesPercentage"],
      Percentage_Cmp: json["Percentage_Cmp"],
      Grp_Id: json["Grp_Id"],
      BrandId: json["BrandId"],
      Id: json["Id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Section": this.Section,
      "Brand": this.Brand,
      "ItemGroup": this.ItemGroup,
      "SalesAmount": this.SalesAmount,
      "Status": this.Status,
      "Quantity": this.Quantity,
      "GrossProfit": this.GrossProfit,
      "GPPercent": this.GPPercent,
      "SalesPercentage": this.SalesPercentage,
      "Percentage_Cmp": this.Percentage_Cmp,
      "Grp_Id": this.Grp_Id,
      "BrandId": this.BrandId,
      "Id": this.Id,
    };
  }
//

/*  factory CatSectionM.fromJson(Map<String, dynamic> json) =>
      _$CatSectionMFromJson(json);

  Map<String, dynamic> toJson() => _$CatSectionMToJson(this);*/
}
