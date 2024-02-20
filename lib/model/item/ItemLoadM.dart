import 'dart:convert';

import 'package:glowrpt/model/other/BrandM.dart';
import 'package:glowrpt/model/other/GroupM.dart';
import 'package:glowrpt/model/other/Price1M.dart';
import 'package:glowrpt/model/other/SectionM.dart';
import 'package:glowrpt/model/item/PriceM.dart';
import 'package:glowrpt/model/other/TaxM.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'ItemLoadM.g.dart';

@JsonSerializable()
class ItemLoadM {
  List<TaxM> TaxMaster;
  List<GroupM> ItemGroup;
  List<BrandM> Brand;
  List<SectionM> Section;
  List<PriceM> PriceList;

  ItemLoadM({
  required this.TaxMaster,
  required this.ItemGroup,
  required this.Brand,
  required this.Section,
  required this.PriceList,
  });

  factory ItemLoadM.fromJson(Map<String, dynamic> json) {
    return ItemLoadM(
      TaxMaster:
          List.of(json["TaxMaster"]).map((i) => TaxM.fromJson(i)).toList(),
      ItemGroup:
          List.of(json["ItemGroup"]).map((i) => GroupM.fromJson(i)).toList(),
      Brand: List.of(json["Brand"]).map((i) => BrandM.fromJson(i)).toList(),
      Section:
          List.of(json["Section"]).map((i) => SectionM.fromJson(i)).toList(),
      PriceList:
          List.of(json["PriceList"]).map((i) => PriceM.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TaxMaster": jsonEncode(this.TaxMaster),
      "ItemGroup": jsonEncode(this.ItemGroup),
      "Brand": jsonEncode(this.Brand),
      "Section": jsonEncode(this.Section),
      "PriceList": jsonEncode(this.PriceList),
    };
  }
//

/*
  factory ItemLoadM.fromJson(Map<String, dynamic> json) =>
      _$ItemLoadMFromJson(json);

  Map<String, dynamic> toJson() => _$ItemLoadMToJson(this);
*/
}
