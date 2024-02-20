import 'package:json_annotation/json_annotation.dart';

//part 'ExpenceTypeM.g.dart';

@JsonSerializable()
class ExpenceTypeM {
  num Code;
  String Name;
  num MonthlyBudget;
  num Branch;

  factory ExpenceTypeM.fromJson(Map<String, dynamic> json) {
    return ExpenceTypeM(
      Code: json["Code"],
      Name: json["Name"],
      MonthlyBudget: json["MonthlyBudget"],
      Branch: json["Branch"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Code": this.Code,
      "Name": this.Name,
      "MonthlyBudget": this.MonthlyBudget,
      "Branch": this.Branch,
    };
  }

  ExpenceTypeM({required this.Code, required this.Name, required this.MonthlyBudget, required this.Branch});

  @override
  String toString() {
    return Name;
  }
}

