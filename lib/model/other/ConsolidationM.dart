import 'package:json_annotation/json_annotation.dart';

// part 'ConsolidationM.g.dart';

@JsonSerializable()
class ConsolidationM {
  String SalesAmount;
  String TotalGP;
  String SalesAmountCmp;
  String SalesGpcmp;

  ConsolidationM({
   required this.SalesAmount,
   required this.TotalGP,
   required this.SalesAmountCmp,
   required this.SalesGpcmp,
  });

  factory ConsolidationM.fromJson(Map<String, dynamic> json) {
    return ConsolidationM(
      SalesAmount: json["SalesAmount"],
      TotalGP: json["TotalGP"],
      SalesAmountCmp: json["SalesAmountCmp"],
      SalesGpcmp: json["SalesGpcmp"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "SalesAmount": this.SalesAmount,
      "TotalGP": this.TotalGP,
      "SalesAmountCmp": this.SalesAmountCmp,
      "SalesGpcmp": this.SalesGpcmp,
    };
  }
//

  /* factory ConsolidationM.fromJson(Map<String, dynamic> json) => _$ConsolidationMFromJson(json);

  Map<String, dynamic> toJson() => _$ConsolidationMToJson(this);*/
}

/*
	"Consolidation": [{
			"SalesAmount": "350696.44",
			"TotalGP": "31.072",
			"SalesAmountCmp": "-24,654.020",
			"SalesGpcmp": "7.145"
		}]

*/
