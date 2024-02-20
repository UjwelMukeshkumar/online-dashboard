// To parse this JSON data, do
//
//     final itemDetailsM = itemDetailsMFromJson(jsonString);

import 'dart:convert';

import 'package:glowrpt/model/other/BrandM.dart';
import 'package:glowrpt/model/other/GroupM.dart';
import 'package:glowrpt/model/other/Price1M.dart';
import 'package:glowrpt/model/other/SectionM.dart';
import 'package:glowrpt/model/other/SupplierM.dart';
import 'package:glowrpt/model/other/TaxM.dart';
import 'package:glowrpt/screen/StockM.dart';

import 'ItemM.dart';
import 'TypeM.dart';
import 'package:json_annotation/json_annotation.dart';
// part 'ItemDetailsM.g.dart';

// ItemDetailsM itemDetailsMFromJson(String str) => ItemDetailsM.fromJson(json.decode(str));

// String itemDetailsMToJson(ItemDetailsM data) => json.encode(data.toJson());
@JsonSerializable()
class ItemDetailsM {
  ItemDetailsM({
    this.ItemDetails,
    this.property,
    this.Section,
    this.Brand,
    this.Tax,
    this.Stock,
    this.ItemGroup,
    this.Supplier,
    this.Type,
  });

  List<ItemM>? ItemDetails;
  List<SectionM>? Section;
  List<BrandM>? Brand;
  List<TaxM>? Tax;
  List<GroupM>? ItemGroup;
  List<StockM>? Stock;
  List<String>? property;
  List<SupplierM>? Supplier;
  List<TypeM>? Type;
  /* factory ItemDetailsM.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsMFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsMToJson(this);*/
  factory ItemDetailsM.fromJson(Map<String, dynamic> json) => ItemDetailsM(
        ItemDetails: json["ItemDetails"] == null
            ? []
            : List<ItemM>.from(
                json["ItemDetails"].map((x) => ItemM.fromJson(x))),
        Section: json["Section"] == null
            ? []
            : List<SectionM>.from(
                json["Section"].map((x) => SectionM.fromJson(x))),
        Brand: json["Brand"] == null
            ? []
            : List<BrandM>.from(json["Brand"].map((x) => BrandM.fromJson(x))),
        Tax: json["Tax"] == null
            ? []
            : List<TaxM>.from(json["Tax"].map((x) => TaxM.fromJson(x))),
        ItemGroup: json["ItemGroup"] == null
            ? []
            : List<GroupM>.from(
                json["ItemGroup"].map((x) => GroupM.fromJson(x))),
        Stock: json["Stock"] == null
            ? []
            : List<StockM>.from(json["Stock"].map((x) => StockM.fromJson(x))),
        Supplier: json["Supplier"] == null
            ? []
            : List<SupplierM>.from(
                json["Supplier"].map((x) => SupplierM.fromJson(x))),
        Type: json["Type"] == null
            ? []
            : List<TypeM>.from(json["Type"].map((x) => TypeM.fromJson(x))),
      );
}