import 'package:json_annotation/json_annotation.dart';

//part 'StockinvM.g.dart';

@JsonSerializable()
class StockinvM {
  String Text;
  num value;

  StockinvM({
    required this.Text,
    required this.value,
  });

  factory StockinvM.fromJson(Map<String, dynamic> json) {
    return StockinvM(
      Text: json["Text"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Text": this.Text,
      "value": this.value,
    };
  }
//

/*
  factory StockinvM.fromJson(Map<String, dynamic> json) => _$StockinvMFromJson(json);

  Map<String, dynamic> toJson() => _$StockinvMToJson(this);
*/
}
