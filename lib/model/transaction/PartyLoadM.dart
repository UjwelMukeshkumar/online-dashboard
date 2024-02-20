import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'PartyLoadM.g.dart';

@JsonSerializable()
class PartyLoadM {
  List<PricelistBean> pricelist;
  List<StateBean> state;
  List<GroupBean> group;
  List<GsttypeBean> gsttype;

  PartyLoadM(
      {required this.pricelist,
      required this.state,
      required this.group,
      required this.gsttype});

  factory PartyLoadM.fromJson(Map<String, dynamic> json) {
    return PartyLoadM(
      pricelist: List.of(json["pricelist"])
          .map((i) => PricelistBean.fromJson(i))
          .toList(),
      state: List.of(json["state"]).map((i) => StateBean.fromJson(i)).toList(),
      group: List.of(json["group"]).map((i) => GroupBean.fromJson(i)).toList(),
      gsttype:
          List.of(json["gsttype"]).map((i) => GsttypeBean.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pricelist": jsonEncode(this.pricelist),
      "state": jsonEncode(this.state),
      "group": jsonEncode(this.group),
      "gsttype": jsonEncode(this.gsttype),
    };
  }
//

/*
  factory PartyLoadM.fromJson(Map<String, dynamic> json) => _$PartyLoadMFromJson(json);

  Map<String, dynamic> toJson() => _$PartyLoadMToJson(this);
*/
}

@JsonSerializable()
class GsttypeBean {
  String Type;

  GsttypeBean({required this.Type});

  factory GsttypeBean.fromJson(Map<String, dynamic> json) {
    return GsttypeBean(
      Type: json["Type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Type": this.Type,
    };
  }

  /*
  factory GsttypeBean.fromJson(Map<String, dynamic> json) => _$GsttypeBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GsttypeBeanToJson(this);
*/
  @override
  String toString() {
    return Type;
  }
}

@JsonSerializable()
class GroupBean {
  num Grp_Code;
  String Grp_Name;
  String Type;

  GroupBean({
    required this.Grp_Code,
    required this.Grp_Name,
    required this.Type,
  });

  Map<String, dynamic> toJson() {
    return {
      "Grp_Code": this.Grp_Code,
      "Grp_Name": this.Grp_Name,
      "Type": this.Type,
    };
  }

  factory GroupBean.fromJson(Map<String, dynamic> json) {
    return GroupBean(
      Grp_Code: json["Grp_Code"],
      Grp_Name: json["Grp_Name"],
      Type: json["Type"],
    );
  }

  /*
  factory GroupBean.fromJson(Map<String, dynamic> json) => _$GroupBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupBeanToJson(this);
  @override
*/
  String toString() {
    return Grp_Name;
  }
}

@JsonSerializable()
class StateBean {
  num State_Id;
  String State_Name;
  num Country_Id;

  StateBean({
    required this.State_Id,
    required this.State_Name,
    required this.Country_Id,
  });

/*
  factory StateBean.fromJson(Map<String, dynamic> json) => _$StateBeanFromJson(json);

  Map<String, dynamic> toJson() => _$StateBeanToJson(this);
*/
  @override
  String toString() {
    return State_Name;
  }

  Map<String, dynamic> toJson() {
    return {
      'State_Id': this.State_Id,
      'State_Name': this.State_Name,
      'Country_Id': this.Country_Id,
    };
  }

  factory StateBean.fromJson(Map<String, dynamic> map) {
    return StateBean(
      State_Id: map['State_Id'] as num,
      State_Name: map['State_Name'] as String,
      Country_Id: map['Country_Id'] as num,
    );
  }
}

@JsonSerializable()
class PricelistBean {
  num PriceListNo;
  String Name;
  String Inactive;

  PricelistBean({
    required this.PriceListNo,
    required this.Name,
    required this.Inactive,
  });

/*
  factory PricelistBean.fromJson(Map<String, dynamic> json) => _$PricelistBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PricelistBeanToJson(this);
*/

  @override
  String toString() {
    return Name;
  }

  Map<String, dynamic> toJson() {
    return {
      'PriceListNo': this.PriceListNo,
      'Name': this.Name,
      'Inactive': this.Inactive,
    };
  }

  factory PricelistBean.fromJson(Map<String, dynamic> map) {
    return PricelistBean(
      PriceListNo: map['PriceListNo'] as num,
      Name: map['Name'] as String,
      Inactive: map['Inactive'] as String,
    );
  }
}
