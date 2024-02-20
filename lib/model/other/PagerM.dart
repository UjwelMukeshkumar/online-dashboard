import 'package:json_annotation/json_annotation.dart';

// part 'PagerM.g.dart';

@JsonSerializable()
class PagerM {
  num TotalItems;
  num PageNo;

  PagerM({
   required this.TotalItems,
   required this.PageNo,
  });

  factory PagerM.fromJson(Map<String, dynamic> json) {
    return PagerM(
      TotalItems: json["TotalItems"],
      PageNo: json["PageNo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TotalItems": this.TotalItems,
      "PageNo": this.PageNo,
    };
  }
//

  /* factory PagerM.fromJson(Map<String, dynamic> json) => _$PagerMFromJson(json);

  Map<String, dynamic> toJson() => _$PagerMToJson(this);*/
}
