import 'package:json_annotation/json_annotation.dart';

//part 'LeveTypeM.g.dart';

@JsonSerializable()
class LeveTypeM {
  num Id;
  String LeaveType;

  factory LeveTypeM.fromJson(Map<String, dynamic> json) {
    return LeveTypeM(
      Id: json["Id"],
      LeaveType: json["LeaveType"],
    );
  }

  LeveTypeM({required this.Id, required this.LeaveType});

/*
  factory LeveTypeM.fromJson(Map<String, dynamic> json) => _$LeveTypeMFromJson(json);

  Map<String, dynamic> toJson() => _$LeveTypeMToJson(this);
*/
}

