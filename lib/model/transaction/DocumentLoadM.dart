import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../pos/AuthM.dart';

//part 'DocumentLoadM.g.dart';

@JsonSerializable()
class DocumentLoadM {
  List<FreightBean> Freight;
  List<Default_ValuesBean> Default_Values;
  List<SeriesBean> Series;
  List<TaxBean> Tax;
  List<PaymentTermsBean> PaymentTerms;
  List<Default_AccountBean> Default_Account;
  List<UOMBean>? UOM;
  List<AuthM> Auth;

  factory DocumentLoadM.fromJson(Map<String, dynamic> json) {
    return DocumentLoadM(
      Freight:
          List.of(json["Freight"]).map((i) => FreightBean.fromJson(i)).toList(),
      Default_Values: List.of(json["Default_Values"])
          .map((i) => Default_ValuesBean.fromJson(i))
          .toList(),
      Series:
          List.of(json["Series"]).map((i) => SeriesBean.fromJson(i)).toList(),
      Tax: List.of(json["Tax"]).map((i) => TaxBean.fromJson(i)).toList(),
      PaymentTerms: List.of(json["PaymentTerms"])
          .map((i) => PaymentTermsBean.fromJson(i))
          .toList(),
      Default_Account: List.of(json["Default_Account"])
          .map((i) => Default_AccountBean.fromJson(i))
          .toList(),
      UOM: List.of(json["UOM"]).map((i) => UOMBean.fromJson(i)).toList(),
      Auth: List.of(json["Auth"]).map((i) => AuthM.fromJson(i)).toList(),
    );
  }

  DocumentLoadM({
    required this.Freight,
    required this.Default_Values,
    required this.Series,
    required this.Tax,
    required this.PaymentTerms,
    required this.Default_Account,
     this.UOM,
    required this.Auth,
  });

  Map<String, dynamic> toJson() {
    return {
      "Freight": jsonEncode(this.Freight),
      "Default_Values": jsonEncode(this.Default_Values),
      "Series": jsonEncode(this.Series),
      "Tax": jsonEncode(this.Tax),
      "PaymentTerms": jsonEncode(this.PaymentTerms),
      "Default_Account": jsonEncode(this.Default_Account),
      "UOM": jsonEncode(this.UOM),
      "Auth": jsonEncode(this.Auth),
    };
  }

/*
  factory DocumentLoadM.fromJson(Map<String, dynamic> json) => _$DocumentLoadMFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentLoadMToJson(this);
*/
}

@JsonSerializable()
class UOMBean {
  String? Code;
  num? UOMQty;

  UOMBean({ this.Code,  this.UOMQty});

  factory UOMBean.fromJson(Map<String, dynamic> json) {
    return UOMBean(
      Code: json["Code"],
      UOMQty: json["UOMQty"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Code": this.Code,
      "UOMQty": this.UOMQty,
    };
  }

  /*
  factory UOMBean.fromJson(Map<String, dynamic> json) => _$UOMBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UOMBeanToJson(this);
*/
  @override
  String toString() {
    return Code.toString();
  }
}

@JsonSerializable()
class Default_AccountBean {
  num CardAccount;
  num CashAccount;

  Default_AccountBean({
    required this.CardAccount,
    required this.CashAccount,
  });

  factory Default_AccountBean.fromJson(Map<String, dynamic> json) {
    return Default_AccountBean(
      CardAccount: json["CardAccount"],
      CashAccount: json["CashAccount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "CardAccount": this.CardAccount,
      "CashAccount": this.CashAccount,
    };
  }
//

/*
  factory Default_AccountBean.fromJson(Map<String, dynamic> json) => _$Default_AccountBeanFromJson(json);

  Map<String, dynamic> toJson() => _$Default_AccountBeanToJson(this);
*/
}

@JsonSerializable()
class PaymentTermsBean {
  num Payment_Id;
  String PaymentCode;
  num Days;

  PaymentTermsBean({
    required this.Payment_Id,
    required this.PaymentCode,
    required this.Days,
  });

  factory PaymentTermsBean.fromJson(Map<String, dynamic> json) {
    return PaymentTermsBean(
      Payment_Id: json["Payment_Id"],
      PaymentCode: json["PaymentCode"],
      Days: json["Days"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Payment_Id": this.Payment_Id,
      "PaymentCode": this.PaymentCode,
      "Days": this.Days,
    };
  }
//

/*
  factory PaymentTermsBean.fromJson(Map<String, dynamic> json) => _$PaymentTermsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTermsBeanToJson(this);
*/
}

@JsonSerializable()
class TaxBean {
  String TaxCode;
  String TaxName;
  num TaxRate;
  num GST_Cess;

  TaxBean({
    required this.TaxCode,
    required this.TaxName,
    required this.TaxRate,
    required this.GST_Cess,
  });

  factory TaxBean.fromJson(Map<String, dynamic> json) {
    return TaxBean(
      TaxCode: json["TaxCode"],
      TaxName: json["TaxName"],
      TaxRate: json["TaxRate"],
      GST_Cess: json["GST_Cess"],
    );
  }
//

/*
  factory TaxBean.fromJson(Map<String, dynamic> json) => _$TaxBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TaxBeanToJson(this);
*/
}

@JsonSerializable()
class SeriesBean {
  num Series_Id;
  String SeriesName;

  SeriesBean({
    required this.Series_Id,
    required this.SeriesName,
  });

  factory SeriesBean.fromJson(Map<String, dynamic> json) {
    return SeriesBean(
      Series_Id: json["Series_Id"],
      SeriesName: json["SeriesName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Series_Id": this.Series_Id,
      "SeriesName": this.SeriesName,
    };
  }
//

/*
  factory SeriesBean.fromJson(Map<String, dynamic> json) => _$SeriesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesBeanToJson(this);
*/
}

@JsonSerializable()
class Default_ValuesBean {
  num Store_Code;
  num RoundingAccount;
  num Series_Id;
  num RecNum;

  Default_ValuesBean({
    required this.Store_Code,
    required this.RoundingAccount,
    required this.Series_Id,
    required this.RecNum,
  });

  factory Default_ValuesBean.fromJson(Map<String, dynamic> json) {
    return Default_ValuesBean(
      Store_Code: json["Store_Code"],
      RoundingAccount: json["RoundingAccount"],
      Series_Id: json["Series_Id"],
      RecNum: json["RecNum"],
    );
  }
//

/*
  factory Default_ValuesBean.fromJson(Map<String, dynamic> json) => _$Default_ValuesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$Default_ValuesBeanToJson(this);
*/
}

@JsonSerializable()
class FreightBean {
  num? Org_Id;
  num? AccountCode;
  String? AccountName;

  FreightBean({
     this.Org_Id,
     this.AccountCode,
     this.AccountName,
  });

  factory FreightBean.fromJson(Map<String, dynamic> json) {
    return FreightBean(
      Org_Id: json["Org_Id"],
      AccountCode: json["AccountCode"],
      AccountName: json["AccountName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Org_Id": this.Org_Id,
      "AccountCode": this.AccountCode,
      "AccountName": this.AccountName,
    };
  }
//

/*
  factory FreightBean.fromJson(Map<String, dynamic> json) => _$FreightBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FreightBeanToJson(this);
*/
}
