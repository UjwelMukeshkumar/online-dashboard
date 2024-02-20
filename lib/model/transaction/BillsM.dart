import 'package:glowrpt/util/MyKey.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'BillsM.g.dart';

@JsonSerializable()
class BillsM {
  num SourceNo;
  num SourceInitNo;
  num SourceSequence;
  String SourceType;
  String PostDate;
  num TransAmount;
  num TransBalance;
  String DocRefNo;

  bool isChecked = false;
  String? reciptAmount;
  get documnet => "$SourceType $SourceSequence/$SourceNo-$SourceInitNo";
  get dateText => MyKey.getDispayDateFromWb(PostDate);

  BillsM({
   required this.SourceNo,
   required this.SourceInitNo,
   required this.SourceSequence,
   required this.SourceType,
   required this.PostDate,
   required this.TransAmount,
   required this.TransBalance,
   required this.DocRefNo,
   required this.isChecked,
    this. reciptAmount,
  });

  factory BillsM.fromJson(Map<String, dynamic> json) {
    return BillsM(
      SourceNo: json["SourceNo"],
      SourceInitNo: json["SourceInitNo"],
      SourceSequence: json["SourceSequence"],
      SourceType: json["SourceType"],
      PostDate: json["PostDate"],
      TransAmount: json["TransAmount"],
      TransBalance: json["TransBalance"],
      DocRefNo: json["DocRefNo"],
      isChecked: json["isChecked"]?.toLowerCase() == 'true',
      reciptAmount: json["reciptAmount"],
    );
  }
//

/*
  factory BillsM.fromJson(Map<String, dynamic> json) => _$BillsMFromJson(json);

  Map<String, dynamic> toJson() => _$BillsMToJson(this);
*/
}
