import 'package:json_annotation/json_annotation.dart';

// part 'JurnalM.g.dart';

@JsonSerializable()
class JurnalM {
  num LineNum;
  String Code;
  String Name;
  String Internal_Account;
  num Debit;
  num Credit;
  String Remarks;
  String Type;

  JurnalM({
  required this.LineNum,
  required this.Code,
  required this.Name,
  required this.Internal_Account,
  required this.Debit,
  required this.Credit,
  required this.Remarks,
  required this.Type,
  });

  factory JurnalM.fromJson(Map<String, dynamic> json) {
    return JurnalM(
      LineNum: json["LineNum"],
      Code: json["Code"],
      Name: json["Name"],
      Internal_Account: json["Internal_Account"],
      Debit: json["Debit"],
      Credit: json["Credit"],
      Remarks: json["Remarks"],
      Type: json["Type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "LineNum": this.LineNum,
      "Code": this.Code,
      "Name": this.Name,
      "Internal_Account": this.Internal_Account,
      "Debit": this.Debit,
      "Credit": this.Credit,
      "Remarks": this.Remarks,
      "Type": this.Type,
    };
  }
//

  /*factory JurnalM.fromJson(Map<String, dynamic> json) =>
      _$JurnalMFromJson(json);

  Map<String, dynamic> toJson() => _$JurnalMToJson(this);*/
}
