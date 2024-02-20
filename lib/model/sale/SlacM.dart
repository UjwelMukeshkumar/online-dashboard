import 'package:json_annotation/json_annotation.dart';

//part 'SlacM.g.dart';

@JsonSerializable()
class SlacM {
  String Text;
  num Count;

  SlacM({
   required this.Text,
   required this.Count,
  });

  factory SlacM.fromJson(Map<String, dynamic> json) {
    return SlacM(
      Text: json["Text"],
      Count: json["Count"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Text": this.Text,
      "Count": this.Count,
    };
  }
//

/*
  factory SlacM.fromJson(Map<String, dynamic> json) => _$SlacMFromJson(json);

  Map<String, dynamic> toJson() => _$SlacMToJson(this);
*/
}
