import 'package:json_annotation/json_annotation.dart';

//part 'AttandanceCountM.g.dart';

@JsonSerializable()
class AttandanceCountM {
  num Present;
  num Leave;
  num Roster;

  AttandanceCountM({required this.Present, required this.Leave, required this.Roster});

  factory AttandanceCountM.fromJson(Map<String, dynamic> json) {
    return AttandanceCountM(
      Present: json["Present"],
      Leave:json["Leave"],
      Roster:json["Roster"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Present": this.Present,
      "Leave": this.Leave,
      "Roster": this.Roster,
    };
  }
//

/*
  factory AttandanceCountM.fromJson(Map<String, dynamic> json) =>
      _$AttandanceCountMFromJson(json);

  Map<String, dynamic> toJson() => _$AttandanceCountMToJson(this);
*/
}
