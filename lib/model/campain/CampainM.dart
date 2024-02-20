import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'CampainM.g.dart';

@JsonSerializable()
class CampainM {
  List<NextNumBean> NextNum;
  List<UserDefaultBean> UserDefault;
  List<StoreBean> Store;
  List<PriceListBean> PriceList;
  List<AccessListBean> AccessList;

  CampainM({
    required this.NextNum,
    required this.UserDefault,
    required this.Store,
    required this.PriceList,
    required this.AccessList,
  });

  factory CampainM.fromJson(Map<String, dynamic> json) {
    return CampainM(
      UserDefault: List.of(json["UserDefault"])
          .map((i) => UserDefaultBean.fromJson(i))
          .toList(), NextNum: [], Store: [], PriceList: [], AccessList: [], //this line i added
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "NextNum": jsonEncode(this.NextNum),
      "UserDefault": jsonEncode(this.UserDefault),
      "Store": jsonEncode(this.Store),
      "PriceList": jsonEncode(this.PriceList),
      "AccessList": jsonEncode(this.AccessList),
    };
  }
//

/*
  factory CampainM.fromJson(Map<String, dynamic> json) => _$CampainMFromJson(json);

  Map<String, dynamic> toJson() => _$CampainMToJson(this);
*/
}

@JsonSerializable()
class AccessListBean {
  String ViewPermission;
  String AddPermission;
  String EditPermission;
  String CancelPermission;
  String PrintPermission;
  String FindPermission;

  AccessListBean({
    required this.ViewPermission,
    required this.AddPermission,
    required this.EditPermission,
    required this.CancelPermission,
    required this.PrintPermission,
    required this.FindPermission,
  });

/*
  factory AccessListBean.fromJson(Map<String, dynamic> json) => _$AccessListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AccessListBeanToJson(this);
*/
}

@JsonSerializable()
class PriceListBean {
  num PriceList;
  String PriceListName;

  PriceListBean({
    required this.PriceList,
    required this.PriceListName,
  });

  Map<String, dynamic> toJson() {
    return {
      "PriceList": this.PriceList,
      "PriceListName": this.PriceListName,
    };
  }

  factory PriceListBean.fromJson(Map<String, dynamic> json) {
    return PriceListBean(
      PriceList: json["PriceList"],
      PriceListName: json["PriceListName"],
    );
  }

  /*
  factory PriceListBean.fromJson(Map<String, dynamic> json) => _$PriceListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PriceListBeanToJson(this);
*/
  @override
  String toString() {
    // TODO: implement toString
    return PriceListName;
  }
}

@JsonSerializable()
class StoreBean {
  num Store_Code;
  String StrName;

  Map<String, dynamic> toJson() {
    return {
      "Store_Code": this.Store_Code,
      "StrName": this.StrName,
    };
  }

  factory StoreBean.fromJson(Map<String, dynamic> json) {
    return StoreBean(
      Store_Code: json["Store_Code"],
      StrName: json["StrName"],
    );
  }

  StoreBean({
    required this.Store_Code,
    required this.StrName,
  });

  /*factory StoreBean.fromJson(Map<String, dynamic> json) => _$StoreBeanFromJson(json);

  Map<String, dynamic> toJson() => _$StoreBeanToJson(this);
*/
}

@JsonSerializable()
class UserDefaultBean {
  num Store_Code;
  num Series_Id;
  num PriceList;
  String SeriesName;

  UserDefaultBean({
    required this.Store_Code,
    required this.Series_Id,
    required this.PriceList,
    required this.SeriesName,
  });

  factory UserDefaultBean.fromJson(Map<String, dynamic> json) {
    return UserDefaultBean(
      Store_Code: json["Store_Code"],
      Series_Id: json["Series_Id"],
      PriceList: json["PriceList"],
      SeriesName: json["SeriesName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Store_Code": this.Store_Code,
      "Series_Id": this.Series_Id,
      "PriceList": this.PriceList,
      "SeriesName": this.SeriesName,
    };
  }
//

  /*factory UserDefaultBean.fromJson(Map<String, dynamic> json) => _$UserDefaultBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserDefaultBeanToJson(this);
*/
}

@JsonSerializable()
class NextNumBean {
  num RecNum;

  Map<String, dynamic> toJson() {
    return {
      "RecNum": this.RecNum,
    };
  }

  NextNumBean({
    required this.RecNum,
  });

  factory NextNumBean.fromJson(Map<String, dynamic> json) {
    return NextNumBean(
      RecNum: json["RecNum"],
    );
  }
//

/*
  factory NextNumBean.fromJson(Map<String, dynamic> json) => _$NextNumBeanFromJson(json);

  Map<String, dynamic> toJson() => _$NextNumBeanToJson(this);
*/
}
