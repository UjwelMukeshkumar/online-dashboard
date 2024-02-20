import 'package:json_annotation/json_annotation.dart';
// part 'BrandM.g.dart';

@JsonSerializable()
class BrandM {
  int Id;
  String Name;
  String Attachment;

  BrandM({
   required this.Id,
   required this.Name,
   required this.Attachment,
  });

  factory BrandM.fromJson(Map<String, dynamic> json) {
    return BrandM(
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
/*
  factory BrandM.fromJson(Map<String, dynamic> json) => _$BrandMFromJson(json);

  Map<String, dynamic> toJson() => _$BrandMToJson(this);*/
}
