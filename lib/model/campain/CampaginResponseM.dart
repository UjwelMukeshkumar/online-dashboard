import 'dart:convert';

import 'package:glowrpt/model/campain/CampainItem.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'CampaginResponseM.g.dart';

@JsonSerializable()
class CampaginResponseM {
  List<HeaderBean>? Header;
  List<CampainItem>? LinesDt;
  List<CmpDtBean>? CmpDt;

  CampaginResponseM({
     this.Header,
     this.LinesDt,
     this.CmpDt,
  });

  factory CampaginResponseM.fromJson(Map<String, dynamic> json) {
    return CampaginResponseM(
      Header:
          List.of(json["Header"]).map((i) => HeaderBean.fromJson(i)).toList(),
      LinesDt:
          List.of(json["LinesDt"]).map((i) => CampainItem.fromJson(i)).toList(),
      CmpDt: List.of(json["CmpDt"]).map((i) => CmpDtBean.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Header": jsonEncode(this.Header),
      "LinesDt": jsonEncode(this.LinesDt),
      "CmpDt": jsonEncode(this.CmpDt),
    };
  }
//

/*
  factory CampaginResponseM.fromJson(Map<String, dynamic> json) =>
      _$CampaginResponseMFromJson(json);

  Map<String, dynamic> toJson() => _$CampaginResponseMToJson(this);
*/
}

@JsonSerializable()
class CmpDtBean {
  String? Address;
  String? PrintHeader;
  String? Mobile;
  String? ImageUrl;
  String? EMail;
  String? GSTNo;

  CmpDtBean({
 this.Address,
 this.PrintHeader,
 this.Mobile,
 this.ImageUrl,
 this.EMail,
 this.GSTNo,
  });

  Map<String, dynamic> toJson() {
    return {
      "Address": this.Address,
      "PrintHeader": this.PrintHeader,
      "Mobile": this.Mobile,
      "ImageUrl": this.ImageUrl,
      "EMail": this.EMail,
      "GSTNo": this.GSTNo,
    };
  }

  factory CmpDtBean.fromJson(Map<String, dynamic> json) {
    return CmpDtBean(
      Address: json["Address"],
      PrintHeader: json["PrintHeader"],
      Mobile: json["Mobile"],
      ImageUrl: json["ImageUrl"],
      EMail: json["EMail"],
      GSTNo: json["GSTNo"],
    );
  }
//

  /* factory CmpDtBean.fromJson(Map<String, dynamic> json) =>
      _$CmpDtBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CmpDtBeanToJson(this);
*/
}

/*@JsonSerializable()
class LinesDtBean {
  num Sequence;
  num RecNum;
  num SI_No;
  String Item_No;
  String Item_Name;
  String Barcode;
  num Old_Price;
  num New_Price;
  num Onhand;
  num Discprec;
  num PriceAfterDisc;

  LinesDtBean({this.Sequence, this.RecNum, this.SI_No, this.Item_No, this.Item_Name, this.Barcode, this.Old_Price, this.New_Price, this.Onhand, this.Discprec, this.PriceAfterDisc});

  factory LinesDtBean.fromJson(Map<String, dynamic> json) => _$LinesDtBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LinesDtBeanToJson(this);
}*/

@JsonSerializable()
class HeaderBean {
  num? Sequence;
  num? RecNum;
  String? Date;
  String? Remarks;
  String? FromDate;
  String? ReversalDate;
  num? PriceList;
  String? PriceListName;
  String? DocName;
  String? offer_type;

  HeaderBean({
   this.Sequence,
   this.RecNum,
   this.Date,
   this.Remarks,
   this.FromDate,
   this.ReversalDate,
   this.PriceList,
   this.PriceListName,
   this.DocName,
   this.offer_type,
  });

  Map<String, dynamic> toJson() {
    return {
      "Sequence": this.Sequence,
      "RecNum": this.RecNum,
      "Date": this.Date,
      "Remarks": this.Remarks,
      "FromDate": this.FromDate,
      "ReversalDate": this.ReversalDate,
      "PriceList": this.PriceList,
      "PriceListName": this.PriceListName,
      "DocName": this.DocName,
      "offer_type": this.offer_type,
    };
  }

  factory HeaderBean.fromJson(Map<String, dynamic> json) {
    return HeaderBean(
      Sequence: json["Sequence"],
      RecNum: json["RecNum"],
      Date: json["Date"],
      Remarks: json["Remarks"],
      FromDate: json["FromDate"],
      ReversalDate: json["ReversalDate"],
      PriceList: json["PriceList"],
      PriceListName: json["PriceListName"],
      DocName: json["DocName"],
      offer_type: json["offer_type"],
    );
  }

//

  /*factory HeaderBean.fromJson(Map<String, dynamic> json) =>
      _$HeaderBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HeaderBeanToJson(this);
*/
}
