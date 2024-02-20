import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'CatSecTrendM.g.dart';

@JsonSerializable()
class CatSecTrendM {
  List<BarDiagramBean>? BarDiagram;
  List<ListBean>? Lists;

  Map<String, dynamic> toJson() {
    return {
      "PageNo": jsonEncode(this.PageNo),
    };
  }

  factory CatSecTrendM.fromJson(Map<String, dynamic> json) {
    return CatSecTrendM(
      // BarDiagram: List.of(json["BarDiagram"])
      //     .map((i) => BarDiagramBean.fromJson(i))
      //     .toList(),
      // Lists: List.of(json["List"]).map((i) => ListBean.fromJson(i)).toList(),
      // PageNo:
      //     List.of(json["PageNo"]).map((i) => PageNoBean.fromJson(i)).toList(),
       BarDiagram: json["BarDiagram"] != null
          ? List.of(json["BarDiagram"])
              .map((i) => BarDiagramBean.fromJson(i))
              .toList()
          : [],
      Lists: json["List"] != null
          ? List.of(json["List"]).map((i) => ListBean.fromJson(i)).toList()
          : [],
      PageNo: json["PageNo"] != null
          ? List.of(json["PageNo"]).map((i) => PageNoBean.fromJson(i)).toList()
          : [],
    );
  }

  List<PageNoBean>? PageNo;

  CatSecTrendM({
     this.BarDiagram,
     this.Lists,
     this.PageNo,
  });

/*
  factory CatSecTrendM.fromJson(Map<String, dynamic> json) =>
      _$CatSecTrendMFromJson(json);

  Map<String, dynamic> toJson() => _$CatSecTrendMToJson(this);
*/
}

@JsonSerializable()
class PageNoBean {
  num? PageNo;

  PageNoBean({ this.PageNo});

  factory PageNoBean.fromJson(Map<String, dynamic> json) {
    return PageNoBean(
      PageNo: json["PageNo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "PageNo": this.PageNo,
    };
  }
//

//

/*
  factory PageNoBean.fromJson(Map<String, dynamic> json) =>
      _$PageNoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PageNoBeanToJson(this);
*/
}

@JsonSerializable()
class ListBean {
  num? Id;
  num? Grp_Id;
  String? Section;
  String? ItemGroup;
  num? SalesPercentage;
  num? SalesAmount;
  num? GPPercent;

  get title => Section ?? ItemGroup;

  get amount =>
      SalesAmount ??
      SalesPercentage; //sales amount first checked but not working

  get id => Id ?? Grp_Id;

  ListBean({
     this.Id,
     this.Section,
     this.SalesPercentage,
     this.SalesAmount,
     this.ItemGroup,
     this.GPPercent,
     this.Grp_Id,
  });

  factory ListBean.fromJson(Map<String, dynamic> json) {
    return ListBean(
      Id: json["Id"],
      Grp_Id: json["Grp_Id"],
      Section: json["Section"],
      ItemGroup: json["ItemGroup"],
      SalesPercentage: json["SalesPercentage"],
      SalesAmount: json["SalesAmount"],
      GPPercent: json["GPPercent"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": this.Id,
      "Grp_Id": this.Grp_Id,
      "Section": this.Section,
      "ItemGroup": this.ItemGroup,
      "SalesPercentage": this.SalesPercentage,
      "SalesAmount": this.SalesAmount,
      "GPPercent": this.GPPercent,
    };
  }
//

  /*factory ListBean.fromJson(Map<String, dynamic> json) =>
      _$ListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ListBeanToJson(this);*/
}

@JsonSerializable()
class BarDiagramBean {
  String? Section;
  num? SalesPercentage;
  String? ItemGroup;
  num? SalesAmount;

  get name => Section ?? ItemGroup;

  get amount => SalesPercentage ?? SalesAmount;

  BarDiagramBean({
   this.Section,
   this.SalesPercentage,
   this.ItemGroup,
   this.SalesAmount,
  });

  factory BarDiagramBean.fromJson(Map<String, dynamic> json) {
    return BarDiagramBean(
      Section: json["Section"],
      SalesPercentage: json["SalesPercentage"],
      ItemGroup: json["ItemGroup"],
      SalesAmount: json["SalesAmount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Section": this.Section,
      "SalesPercentage": this.SalesPercentage,
      "ItemGroup": this.ItemGroup,
      "SalesAmount": this.SalesAmount,
    };
  }
//

  /*factory BarDiagramBean.fromJson(Map<String, dynamic> json) =>
      _$BarDiagramBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BarDiagramBeanToJson(this);*/
}
