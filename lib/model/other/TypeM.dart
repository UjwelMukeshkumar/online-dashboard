import 'package:json_annotation/json_annotation.dart';

// part 'TypeM.g.dart';

@JsonSerializable()
class TypeM {
  String TypeId;
  String TypeName;

  TypeM({
  required  this.TypeId,
  required  this.TypeName,
  });

  factory TypeM.fromJson(Map<String, dynamic> json) {
    return TypeM(
      TypeId: json["TypeId"],
      TypeName: json["TypeName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TypeId": this.TypeId,
      "TypeName": this.TypeName,
    };
  }
//

  /* factory TypeM.fromJson(Map<String, dynamic> json) => _$TypeMFromJson(json);

  Map<String, dynamic> toJson() => _$TypeMToJson(this);*/
}
