import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'AccountLoadM.g.dart';

@JsonSerializable()
class AccountLoadM {
  List<ParentListBean> ParentList;
  List<DrawerBean> Drawer;
  List<ClassificationBean> Classification;

  AccountLoadM({required this.ParentList, required this.Drawer, required this.Classification});

  factory AccountLoadM.fromJson(Map<String, dynamic> json) {
    return AccountLoadM(
      ParentList: List.of(json["ParentList"])
          .map((i) => ParentListBean.fromJson(i))
          .toList(),
      Drawer:
          List.of(json["Drawer"]).map((i) => DrawerBean.fromJson(i)).toList(),
      Classification: List.of(json["Classification"])
          .map((i) => ClassificationBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ParentList": jsonEncode(this.ParentList),
      "Drawer": jsonEncode(this.Drawer),
      "Classification": jsonEncode(this.Classification),
    };
  }
//

/*
  factory AccountLoadM.fromJson(Map<String, dynamic> json) => _$AccountLoadMFromJson(json);

  Map<String, dynamic> toJson() => _$AccountLoadMToJson(this);
*/
}

@JsonSerializable()
class ClassificationBean {
  String ValueMember;
  String DisplayMember;
  String Drawer;

  ClassificationBean({required this.ValueMember, required this.DisplayMember, required this.Drawer});

  factory ClassificationBean.fromJson(Map<String, dynamic> json) {
    return ClassificationBean(
      ValueMember: json["ValueMember"],
      DisplayMember: json["DisplayMember"],
      Drawer: json["Drawer"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Drawer": this.Drawer,
    };
  }

  /*
  factory ClassificationBean.fromJson(Map<String, dynamic> json) => _$ClassificationBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ClassificationBeanToJson(this);
*/
  @override
  String toString() {
    return DisplayMember;
  }
}

@JsonSerializable()
class DrawerBean {
  num ValueMember;
  String DisplayMember;

  DrawerBean({required this.ValueMember, required this.DisplayMember});

  factory DrawerBean.fromJson(Map<String, dynamic> json) {
    return DrawerBean(
      ValueMember: json["ValueMember"],
      DisplayMember: json["DisplayMember"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ValueMember": this.ValueMember,
      "DisplayMember": this.DisplayMember,
    };
  }

  /*
  factory DrawerBean.fromJson(Map<String, dynamic> json) => _$DrawerBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DrawerBeanToJson(this);
*/

  @override
  String toString() {
    return DisplayMember;
  }
}

@JsonSerializable()
class ParentListBean {
  num Code;
  String Name;
  String Drawer;

  ParentListBean({required this.Code, required this.Name, required this.Drawer});

  factory ParentListBean.fromJson(Map<String, dynamic> json) {
    return ParentListBean(
      Code: (json["Code"]),
      Name: json["Name"],
      Drawer: json["Drawer"],
    );
  }

  /*
  factory ParentListBean.fromJson(Map<String, dynamic> json) => _$ParentListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ParentListBeanToJson(this);
*/

  @override
  String toString() {
    return Name;
  }
}
