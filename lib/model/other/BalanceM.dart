import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// part 'BalanceM.g.dart';

@JsonSerializable()
class BalanceM {
  List<DetailsBean> Details;
  List<DtRangeBean> DtRange;

  BalanceM({
   required this.Details,
   required this.DtRange,
  });

  factory BalanceM.fromJson(Map<String, dynamic> json) {
    return BalanceM(
      Details:
          List.of(json["Details"]).map((i) => DetailsBean.fromJson(i)).toList(),
      DtRange:
          List.of(json["DtRange"]).map((i) => DtRangeBean.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Details": jsonEncode(this.Details),
      "DtRange": jsonEncode(this.DtRange),
    };
  }
//

//

/*  factory BalanceM.fromJson(Map<String, dynamic> json) =>
      _$BalanceMFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceMToJson(this);*/
}

@JsonSerializable()
class DtRangeBean {
  String DateRange;

  DtRangeBean({required this.DateRange});

  factory DtRangeBean.fromJson(Map<String, dynamic> json) {
    return DtRangeBean(
      DateRange: json["DateRange"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "DateRange": this.DateRange,
    };
  }
//

/*  factory DtRangeBean.fromJson(Map<String, dynamic> json) =>
      _$DtRangeBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DtRangeBeanToJson(this);*/
}

@JsonSerializable()
class DetailsBean {
  String Name;
  num Total;
  num Change;

  DetailsBean({required this.Name, required this.Total, required this.Change});

  factory DetailsBean.fromJson(Map<String, dynamic> json) {
    return DetailsBean(
      Name: json["Name"],
      Total: json["Total"],
      Change: json["Change"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Name": this.Name,
      "Total": this.Total,
      "Change": this.Change,
    };
  }
//

/*  factory DetailsBean.fromJson(Map<String, dynamic> json) =>
      _$DetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsBeanToJson(this);*/
}
