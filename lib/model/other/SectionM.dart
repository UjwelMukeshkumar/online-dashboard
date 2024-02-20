import 'package:json_annotation/json_annotation.dart';
// part 'SectionM.g.dart';

@JsonSerializable()
class SectionM {
  int Id;
  String Name;
  String Attachment;

  SectionM({
  required  this.Id,
  required  this.Name,
  required  this.Attachment,
  });

  factory SectionM.fromJson(Map<String, dynamic> json) {
    return SectionM(
      Id: json["Id"],
      Name: json["Name"],
      Attachment: json["Attachment"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": this.Id,
      "Name": this.Name,
      "Attachment": this.Attachment,
    };
  }
//

  /*factory SectionM.fromJson(Map<String, dynamic> json) =>
      _$SectionMFromJson(json);

  Map<String, dynamic> toJson() => _$SectionMToJson(this);*/
}
