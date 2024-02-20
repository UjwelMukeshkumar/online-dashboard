import 'package:glowrpt/util/MyKey.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'SalesTrendsM.g.dart';

@JsonSerializable()
class SalesTrendsM {
  List<HeaderBean> Header;

  List<TodayBean> Today;
  List<TodayBean> LastWeek;

  List<TodayBean> YesterDay;
  @JsonKey(name: "Last 7 Days")
  List<TodayBean> last7Days;
  @JsonKey(name: "Previous 7 Days")
  List<TodayBean> previus7Days;

  @JsonKey(name: "Last 30 Days")
  List<TodayBean> last30Days;
  @JsonKey(name: "Previous 30 Days")
  List<TodayBean> previus30Days;

  @JsonKey(name: "This Month")
  List<TodayBean> ThisMonth;
  @JsonKey(name: "Previous Month")
  List<TodayBean> PreviousMonth;

  List<TodayBean> get current =>
      Today ?? YesterDay ?? last7Days ?? last30Days ?? ThisMonth;

  factory SalesTrendsM.fromJson(Map<String, dynamic> json) {
    return SalesTrendsM(
      Header:
          json["Header"]==null?[]:List.of(json["Header"])
              .map((i) => HeaderBean.fromJson(i)).toList(),
      Today: json["Today"]==null?[]:List.of(json["Today"])
          .map((i) => TodayBean.fromJson(i)).toList(),
      LastWeek:
          json["LastWeek"]==null?[]:List.of(json["LastWeek"])
              .map((i) => TodayBean.fromJson(i)).toList(),
      YesterDay: json["Last 7 Days"]==null?[]:List.of(json["Last 7 Days"])
          .map((i) => TodayBean.fromJson(i))
          .toList(),
      last7Days: json["Previous 7 Days"]==null?[]:List.of(json["Previous 7 Days"])
          .map((i) => TodayBean.fromJson(i))
          .toList(),
      previus7Days: json["previus7Days"]==null?[]:List.of(json["previus7Days"])
          .map((i) => TodayBean.fromJson(i))
          .toList(),
      last30Days: json["Last 30 Days"]==null?[]:List.of(json["Last 30 Days"])
          .map((i) => TodayBean.fromJson(i))
          .toList(),
      previus30Days: json["Previous 30 Days"]==null?[]:List.of(json["Previous 30 Days"])
          .map((i) => TodayBean.fromJson(i))
          .toList(),
      ThisMonth: json["This Month"]==null?[]:List.of(json["This Month"])
          .map((i) => TodayBean.fromJson(i))
          .toList(),
      PreviousMonth: json["PreviousMonth"]==null?[]:List.of(json["PreviousMonth"])
          .map((i) => TodayBean.fromJson(i))
          .toList(),
      CustomerList: json["CustomerList"]==null?[]:List.of(json["CustomerList"])
          .map((i) => CustomerListBean.fromJson(i))
          .toList(),
    );
  }

  List<TodayBean> get previus =>
      LastWeek ?? previus7Days ?? previus30Days ?? PreviousMonth;

  List<CustomerListBean> CustomerList;

  SalesTrendsM(
      {required this.Header,
      required this.Today,
      required this.LastWeek,
      required this.YesterDay,
      required this.last7Days,
      required this.previus7Days,
      required this.last30Days,
      required this.previus30Days,
      required this.ThisMonth,
      required this.PreviousMonth,
      required this.CustomerList});

// SalesTrendsM({this.Header, this.Today, this.LastWeek, this.CustomerList});

/*
  factory SalesTrendsM.fromJson(Map<String, dynamic> json) =>
      _$SalesTrendsMFromJson(json);

  Map<String, dynamic> toJson() => _$SalesTrendsMToJson(this);
*/
}

@JsonSerializable()
class CustomerListBean {
  num NewCustomer;
  num RepeatCustomer;
  num NewCustomerCmp;
  String NewCustomerCmpTxt;
  num RepeatCustomerCmp;
  String RepeatCustomerTxt;

  CustomerListBean(
      {required this.NewCustomer,
      required this.RepeatCustomer,
      required this.NewCustomerCmp,
      required this.NewCustomerCmpTxt,
      required this.RepeatCustomerCmp,
      required this.RepeatCustomerTxt});

  factory CustomerListBean.fromJson(Map<String, dynamic> json) {
    return CustomerListBean(
      NewCustomer: json["NewCustomer"],
      RepeatCustomer: json["RepeatCustomer"],
      NewCustomerCmp: json["NewCustomerCmp"],
      NewCustomerCmpTxt: json["NewCustomerCmpTxt"],
      RepeatCustomerCmp: json["RepeatCustomerCmp"],
      RepeatCustomerTxt: json["RepeatCustomerTxt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "NewCustomer": this.NewCustomer,
      "RepeatCustomer": this.RepeatCustomer,
      "NewCustomerCmp": this.NewCustomerCmp,
      "NewCustomerCmpTxt": this.NewCustomerCmpTxt,
      "RepeatCustomerCmp": this.RepeatCustomerCmp,
      "RepeatCustomerTxt": this.RepeatCustomerTxt,
    };
  }
//

/* factory CustomerListBean.fromJson(Map<String, dynamic> json) =>
      _$CustomerListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerListBeanToJson(this);*/
}

@JsonSerializable()
class TodayBean {
  num? LineTotal;
  num? WeekDay;
  dynamic? Time;
  String? Dt;
  String? DateRange;

  DateTime get date => MyKey.dateWebFormat.parse(Dt!);

  TodayBean({ this.LineTotal, this.Time,  this.Dt,  this.WeekDay,  this.DateRange});

  factory TodayBean.fromJson(Map<String, dynamic> json) {
    return TodayBean(
      LineTotal: json["LineTotal"],
      WeekDay: json["WeekDay"],
      Time: json["Time"],
      Dt: json["Dt"],
      DateRange: json["DateRange"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "LineTotal": this.LineTotal,
      "WeekDay": this.WeekDay,
      "Time": this.Time,
      "Dt": this.Dt,
      "DateRange": this.DateRange,
    };
  }
//

/*factory TodayBean.fromJson(Map<String, dynamic> json) =>
      _$TodayBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TodayBeanToJson(this);*/
}

@JsonSerializable()
class HeaderBean {
  num? TotalCollection;
  num? TotalPayments;
  num? AmntComparison;
  String? CmpTxt;
  num? AvgAmount;
  num? AvgAmntComparison;
  String? AvgAmntCmpTxt;

  HeaderBean(
      {
         this.TotalCollection,
 this.TotalPayments,
 this.AmntComparison,
 this.CmpTxt,
 this.AvgAmount,
 this.AvgAmntComparison,
 this.AvgAmntCmpTxt
      });

  factory HeaderBean.fromJson(Map<String, dynamic> json) {
    return HeaderBean(
      TotalCollection: json["TotalCollection"],
      TotalPayments: json["TotalPayments"],
      AmntComparison: json["AmntComparison"],
      CmpTxt: json["CmpTxt"],
      AvgAmount: json["AvgAmount"],
      AvgAmntComparison: json["AvgAmntComparison"],
      AvgAmntCmpTxt: json["AvgAmntCmpTxt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TotalCollection": this.TotalCollection,
      "TotalPayments": this.TotalPayments,
      "AmntComparison": this.AmntComparison,
      "CmpTxt": this.CmpTxt,
      "AvgAmount": this.AvgAmount,
      "AvgAmntComparison": this.AvgAmntComparison,
      "AvgAmntCmpTxt": this.AvgAmntCmpTxt,
    };
  }
//

/*factory HeaderBean.fromJson(Map<String, dynamic> json) =>
      _$HeaderBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HeaderBeanToJson(this);*/
}
