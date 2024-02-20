import 'package:json_annotation/json_annotation.dart';

//part 'CampainHeadderM.g.dart';

@JsonSerializable()
class CampainHeadderM {
  num? PriceList;
  String fromDate;
  String reversalDate;
  String docName;
  String api_key;
  String offer_type;

  Map<String, dynamic> toJson() {
    return {
      "PriceList": this.PriceList,
      "fromDate": this.fromDate,
      "reversalDate": this.reversalDate,
      "docName": this.docName,
      "api_key": this.api_key,
      "offer_type": this.offer_type,
    };
  }

  factory CampainHeadderM.fromJson(Map<String, dynamic> json) {
    return CampainHeadderM(
      PriceList: json["PriceList"],
      fromDate: json["fromDate"],
      reversalDate: json["reversalDate"],
      docName: json["docName"],
      api_key: json["api_key"],
      offer_type: json["offer_type"],
    );
  }

  CampainHeadderM({
   this.PriceList,
  required this.fromDate,
  required this.reversalDate,
  required this.docName,
  required this.api_key,
  required this.offer_type,
  });

/*
  factory CampainHeadderM.fromJson(Map<String, dynamic> json) => _$CampainHeadderMFromJson(json);

  Map<String, dynamic> toJson() => _$CampainHeadderMToJson(this);
*/
}
