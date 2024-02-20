import 'package:json_annotation/json_annotation.dart';

//part 'CampainListItemM.g.dart';

@JsonSerializable()
class CampainListItemM {
  num? Sequence;
  num? RecNum;
  String? Date;
  String? PriceList;

  factory CampainListItemM.fromJson(Map<String, dynamic> json) {
    return CampainListItemM(
      Sequence: json["Sequence"],
      RecNum: json["RecNum"],
      Date: json["Date"],
      PriceList: json["PriceList"],
      DocName: json["DocName"]??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Sequence": this.Sequence,
      "RecNum": this.RecNum,
      "Date": this.Date,
      "PriceList": this.PriceList,
      "DocName": this.DocName,
    };
  }

  String? DocName;

  CampainListItemM({
   this.Sequence,
   this.RecNum,
   this.Date,
   this.PriceList,
   this.DocName,
  });

  /*factory CampainListItemM.fromJson(Map<String, dynamic> json) => _$CampainListItemMFromJson(json);

  Map<String, dynamic> toJson() => _$CampainListItemMToJson(this);
*/
}
