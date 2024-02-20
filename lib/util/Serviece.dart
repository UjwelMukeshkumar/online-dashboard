import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glowrpt/library/CollectionOperation.dart';
import 'package:glowrpt/model/attandace/DepartmentAttandance.dart';
import 'package:glowrpt/model/campain/CampaginResponseM.dart';
import 'package:glowrpt/model/campain/CampainItem.dart';
import 'package:glowrpt/model/campain/CampainListItemM.dart';
import 'package:glowrpt/model/campain/CampainM.dart';
import 'package:glowrpt/model/employe/AttandanceListM.dart';
import 'package:glowrpt/model/employe/CountSalaryM.dart';
import 'package:glowrpt/model/employe/EmpLoadM.dart';
import 'package:glowrpt/model/employe/EmployeeM.dart';
import 'package:glowrpt/model/employe/EmployeeMasterM.dart';
import 'package:glowrpt/model/employe/ExpenceTypeM.dart';
import 'package:glowrpt/model/employe/LeveTypeM.dart';
import 'package:glowrpt/model/employe/OrgM.dart';
import 'package:glowrpt/model/employe/PaySlipM.dart';
import 'package:glowrpt/model/employe/PayrollDetailsM.dart';
import 'package:glowrpt/model/employe/RoutPunchLodM.dart';
import 'package:glowrpt/model/hrm/EmpM.dart';
import 'package:glowrpt/model/hrm/RoutPunchM.dart';
import 'package:glowrpt/model/item/InvoiceM.dart';
import 'package:glowrpt/model/item/Lines.dart';
import 'package:glowrpt/model/manager/AccountLoadM.dart';
import 'package:glowrpt/model/manager/AttandanceFindM.dart';
import 'package:glowrpt/model/manager/AtteandanceLoadM.dart';
import 'package:glowrpt/model/manager/NextNumM.dart';
import 'package:glowrpt/model/employe/ReimpurseM.dart';
import 'package:glowrpt/model/item/ItemTopM.dart';
import 'package:glowrpt/model/item/SingleItemM.dart';
import 'package:glowrpt/model/manager/PromotionLoadM.dart';
import 'package:glowrpt/model/manager/RequestsM.dart';
import 'package:glowrpt/model/manager/payroll/PayrollDeatilsM.dart';
import 'package:glowrpt/model/manager/payroll/PayrollLoadM.dart';
import 'package:glowrpt/model/manager/roaster/RoastLoadM.dart';

import 'package:glowrpt/model/other/CounterM.dart';
import 'package:glowrpt/model/other/CustomerWaysReportM.dart';
import 'package:glowrpt/model/other/ExpenceChildM.dart';
import 'package:glowrpt/model/other/ItemDetailsM.dart';
import 'package:glowrpt/model/attandace/AttandanceBranchM.dart';
import 'package:glowrpt/model/attandace/AttandanceEmpM.dart';
import 'package:glowrpt/model/other/BasicResponse.dart';
import 'package:glowrpt/model/other/CccM.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/model/other/FinancialDashBoardM.dart';
import 'package:glowrpt/model/other/LiquidityScoreM.dart';
import 'package:glowrpt/model/other/Price1M.dart';
import 'package:glowrpt/model/other/SearchM.dart';
import 'package:glowrpt/model/attandace/DayAttandanceM.dart';
import 'package:glowrpt/model/attandace/EmpAttandanceM.dart';
import 'package:glowrpt/model/attandace/PunchM.dart';
import 'package:glowrpt/model/consise/ConsiceM.dart';
import 'package:glowrpt/model/item/ItemLoadM.dart';
import 'package:glowrpt/model/item/ItemSaleReportM.dart';
import 'package:glowrpt/model/other/TDetailsM.dart';
import 'package:glowrpt/model/party/DefaultM.dart';
import '../../model/other/DefaultM.dart' as pos;
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/model/party/SinglePartyDetailsM.dart';
import 'package:glowrpt/model/pos/PosGroupM.dart';
import 'package:glowrpt/model/route/RequestDetailsM.dart';
import 'package:glowrpt/model/route/RouteM.dart';
import 'package:glowrpt/model/sale/ItemLstM.dart';
import 'package:glowrpt/model/sale/ItemWithGpM.dart';
import 'package:glowrpt/model/sale/PendingBillsM.dart';
import 'package:glowrpt/model/sale/SalesItemM.dart';
import 'package:glowrpt/model/sale/SlacM.dart';
import 'package:glowrpt/model/sale/SoldItemM.dart';
import 'package:glowrpt/model/sale/StockMoveM.dart';
import 'package:glowrpt/model/transaction/DocumentLoadM.dart';
import 'package:glowrpt/model/transaction/ExpenceLoadM.dart';
import 'package:glowrpt/model/transaction/PartyLoadM.dart';

import 'package:glowrpt/model/trend/CatSecTrendM.dart';
import 'package:glowrpt/model/trend/SalesTrendsM.dart';
import 'package:http/http.dart' as http;

import 'package:toast/toast.dart';

import '../model/DocumentSplitter.dart';
import '../model/campain/CampainHeadderM.dart';
import '../model/employe/EmpPositionM.dart';
import '../model/moving/InventoryM.dart';
import '../model/moving/MovingM.dart';
import '../model/moving/StockinvM.dart';
import '../model/route/PendingNotificationM.dart';
import '../model/route/PlannerRouteLoadM.dart';
import '../model/route/RouteEndM.dart';
import '../model/transaction/CvDetailsM.dart';
import 'MyKey.dart';

String baseUrl = "https://login.glowsis.com";

class Serviece {
  static Future<List<String>> setionChecker(
      BuildContext context, String arryApiKey) async {
    String url = "https://login.glowsis.com/dashboardapp/session?"
        "array_api_keys=$arryApiKey";
    List data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null) {
      return data.map((e) => e["api_key"].toString()).toList();
    }
    return [];
  }

  static Future<BasicResponse> getHomeLoad(BuildContext context,
      String arryApiKey, String fromDate, String todate, String DtRange) async {
    String url = "https://login.glowsis.com/dashboardapp/homeload?"
        "array_api_keys=$arryApiKey"
        "&frmdate=$fromDate"
        "&DtRange=$DtRange"
        "&todate=$todate";
    print("Url $url");
    var response = await http.post(Uri.parse(url), body: Map());
    print("response ${response.body}");
    BasicResponse basicResponse = basicResponseFromJson(response.body);
    return basicResponse;
  }

/*  Sales = SI
  Sales Return = SR
  Sales Order = SO
  Purchase = PI
  Purchase Return = PR
  Purchase Order = PO
  POS = SP
  Pos Return = RP
  POS Order = PS
  Receipt = IP
  Payment = OP*/

  static Future<DocM> getHomedoc(BuildContext context, String apiKey,
      String fromDate, String todate, int pageNo, String query,
      {String type = "SL",
      String endPont = "homedoc",
      String? Orderby,
      String? Sortyby,
      String IsPageing = "Y",
      int? PageSize}) async {
    String url = "https://login.glowsis.com/dashboardapp/$endPont?"
        "api_key=$apiKey"
        "&frmdate=$fromDate"
        "&todate=$todate"
        "&type=$type"
        "&PageNum=$pageNo&SearchTxt=$query&IsPageing=$IsPageing&PageSize=$PageSize&Orderby=$Orderby&Sortyby=$Sortyby";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null)
      return DocM.fromJson(data);
    else
      return DocM(
        Lines: [],
      );
  }

  static Future<dynamic> getHomedocForHedder(
    BuildContext context,
    String apiKey,
    String fromDate,
    String todate,
    String endPoint,
    int pageNo,
    String query, {
    String type = "SL",
    String? params,
    String IsPageing = "Y",
    String? details,
  }) async {
    String url = "https://login.glowsis.com/dashboardapp/$endPoint?"
        "api_key=$apiKey"
        "&frmdate=$fromDate"
        "&todate=$todate"
        "&type=$type"
        "&PageNum=$pageNo&SearchTxt=$query&IsPageing=$IsPageing&Details=${details ?? ""}${params ?? ""}";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null)
      return data;
    else
      return data;
  }

  static Future<dynamic> getWhatChangedSince(BuildContext context,
      String apiKey, String dateRange, String fromDate, String toDate) async {
    String url = "https://login.glowsis.com/dashboardapp/WCS?"
        "api_key=$apiKey"
        "&DateRange=$dateRange&frmdate=$fromDate&todate=$toDate";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null)
      return data;
    else
      return null;
  }

  static Future<dynamic> getConsise(BuildContext context, String apiKey,
      String RecNum, String Sequene, String InitNo,
      {String type = "SL"}) async {
    String url = "https://login.glowsis.com/reports/sales/concise?"
        "api_key=$apiKey"
        "&RecNum=$RecNum"
        "&Sequence=$Sequene"
        "&InitNo=$InitNo"
        "&type=$type";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null)
      return data;
    else
      return data;
  }

  static Future<LiquidityScoreM?> getLiquidityScore(BuildContext context,
      String apiKey, String fromDate, String todate) async {
    String url = "https://login.glowsis.com/dashboardapp/LS?"
        "api_key=$apiKey"
        "&frmdate=$fromDate"
        "&todate=$todate";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null)
      return LiquidityScoreM.fromJson(data);
    else
      return null;
  }

  static Future<FinancialDashBoardM?> geFinancialDashBoard(BuildContext context,
      String apiKey, String fromDate, String todate) async {
    String url = "https://login.glowsis.com/dashboardapp/FDB?"
        "api_key=$apiKey"
        "&frmdate=$fromDate"
        "&todate=$todate";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null)
      return FinancialDashBoardM.fromJson(data);
    else
      return null;
  }

  static Future<LiquidityScoreM?> geDebitCreditAnalisys(BuildContext context,
      String apiKey, String fromDate, String todate) async {
    String url = "https://login.glowsis.com/dashboardapp/DCA?"
        "api_key=$apiKey"
        "&frmdate=$fromDate"
        "&todate=$todate";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null)
      return LiquidityScoreM.fromJson(data);
    else
      return null;
  }

  static Future<LiquidityScoreM?> geProfitRation(BuildContext context,
      String apiKey, String fromDate, String todate) async {
    String url = "https://login.glowsis.com/dashboardapp/PR?"
        "api_key=$apiKey"
        "&frmdate=$fromDate"
        "&todate=$todate";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null)
      return LiquidityScoreM.fromJson(data);
    else
      return null;
  }

  static Future<CccM?> geCashConvertionCycle(BuildContext context,
      String apiKey, String fromDate, String todate) async {
    String url = "https://login.glowsis.com/dashboardapp/CCC?"
        "api_key=$apiKey"
        "&frmdate=$fromDate"
        "&todate=$todate";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null)
      return CccM.fromJson(data);
    else
      return null;
  }

  static Future<dynamic> getCategory(
      BuildContext context,
      String apiKey,
      String fromDate,
      String todate,
      String dateRange,
      int pageNo,
      String query,
      {String endPont = "CAT",
      String IsPageing = "Y"}) async {
    String url = "https://login.glowsis.com/dashboardapp/$endPont?"
        "api_key=$apiKey"
        "&frmdate=$fromDate"
        "&todate=$todate&DateRange=$dateRange&PageNum=$pageNo&SearchTxt=$query&IsPageing=$IsPageing";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    return data;
  }

  Future<List<SearchM>> itemSearch({
    required BuildContext context,
    required String apiKey,
    required String query,
    required String type,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/Itemserach?api_key=$apiKey&Value=$query&PageSize=10&Type=${type ?? ""}";
    print(url);
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    List dataList = data["List"];
    List<SearchM> map =
        dataList.map<SearchM>((e) => SearchM.fromJson(e)).toList();
    return map;
  }

  static Future<ItemDetailsM> getItemDetails(
      BuildContext context, String api_key, String itemNo) async {
    String url =
        "https://login.glowsis.com/dashboard/getitemdetails?api_key=$api_key&Item_No=$itemNo";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    return ItemDetailsM.fromJson(data);
  }

  static Future<ItemDetailsM?> getItemDetailslByBarCode(
      BuildContext context, String api_key, String barCode) async {
    String url =
        "https://login.glowsis.com/rtm/itemsearch?api_key=$api_key&Barcode=$barCode&Type=B";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null) {
      return ItemDetailsM.fromJson(data);
    }
    return null;
  }

  static Future<dynamic> updatePriceDetails(
      BuildContext context,
      String api_key,
      String itemNo,
      String priceListNo,
      String price,
      String discount,
      String isInclusive) async {
    String url =
        "https://login.glowsis.com/stocktaking/updateprice?api_key=$api_key&Item_No=$itemNo&priceListNo=$priceListNo&price=$price&discount=$discount&isinclusive=$isInclusive";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> updateItemCount({
    required BuildContext context,
    required String api_key,
    required String itemNo,
    required String remark,
    required String CountedQty,
  }) async {
    String url =
        "https://login.glowsis.com/rtm/updatestock?api_key=$api_key&Item_No=$itemNo&Remark=$remark&Count=$CountedQty";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> getAttandanceDetaisl(
      BuildContext context, String api_key, num pageNum) async {
    String url =
        "https://login.glowsis.com/hrm/OndutyRegister?api_key=$api_key&PageNum=$pageNum";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return response;
  }

  static Future<dynamic> getPartyLedger(
    BuildContext context,
    String api_key,
    String type,
    String fromDate,
    String toDate,
    int pageNo,
    String query,
  ) async {
    String url =
        "https://login.glowsis.com/dashboardapp/GeneralLedger/load?api_key=$api_key&type=$type&FromDate=$fromDate&ToDate=$toDate&PageNumber=$pageNo&Value=$query";
    // String url = "https://login.glowsis.com/dashboardapp/homedoc?api_key=$api_key&frmdate=11/07/2020&todate=11/07/2022&type=C&PageNum=11200&SearchTxt=";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> getItemLedger({
    required BuildContext context,
    required String api_key,
    required String type,
    required String fromDate,
    required String toDate,
    required String pageNo,
    required String value,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/ItemLeadger?api_key=$api_key&type=$type&FromDate=$fromDate&ToDate=$toDate&PageNumber=$pageNo&Value=$value";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> getInventoryPostList({
    required BuildContext context,
    required String api_key,
    required String fromDate,
    required String toDate,
    required String itemNo,
    required String storeCode,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/InventoryPostList?api_key=$api_key&FromDate=$fromDate&ToDate=$toDate&ItemNo=$itemNo&StrCode=$storeCode";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  //item
  static Future<List<Lines>> getInventoryOpeningBalance({
    required BuildContext context,
    required String api_key,
    required String fromDate,
    required String itemNo,
    String? category,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/InventoryPostList/opening?api_key=$api_key&ItemNo=$itemNo&FromDate=$fromDate&PageNumber=1&StrCode&TransType=${(category == "Future Transactions") ? "FT" : "OP"}";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return List<Lines>.from(response["Lines"].map((e) => Lines.fromJson(e)));
  }

  static Future<List<Price1M>> getPriceList(
      BuildContext context, String api_key, String itemNo) async {
    String url =
        "https://login.glowsis.com/stocktaking/pricedetailsDashBoard?api_key=$api_key&Item_No=$itemNo";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    List data = response["PriceDetails"];
    return data.map((e) => Price1M.fromJson(e)).toList();
  }

  static Future createNewParty({
    required BuildContext context,
    required bool isUpdate,
    required String api_key,
    required String CVCode,
    required String Type,
    required String CVName,
    required String CVGroup,
    required String GSTNo,
    required String MobileNo,
    required String Email,
    required String priceList,
    required String Address,
    required String PinCode,
    required String State,
    required String GSTType,
    required String fromRouteReference,
  }) async {
    //String url = "https://login.glowsis.com/dashboardapp/NewParty?api_key=$api_key&CVName=$cvName&MobileNo=$mobileNumber&Email=$email&Type=$type";
    String url =
        "https://login.glowsis.com/dashboardapp/${isUpdate ? "CVUpdate" : "NewParty"}?api_key=$api_key"
        "&CVCode=$CVCode"
        "&Type=$Type"
        "&CVName=$CVName"
        "&CVGroup=$CVGroup"
        "&GSTNo=$GSTNo"
        "&MobileNo=$MobileNo"
        "&Email=$Email"
        "&priceList=$priceList"
        "&Address=$Address"
        "&PinCode=$PinCode"
        "&State=$State"
        "&GSTType=$GSTType"
        "$fromRouteReference";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return response;
  }

  static Future<CvDetailsM> getCvDetails({
    required BuildContext context,
    required String api_key,
    required String cvCode,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/CVFind?api_key=$api_key&CVCode=$cvCode";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return CvDetailsM.fromJson(response["CVDetails"][0]);
  }

  static Future<dynamic> getTrasaction(
      BuildContext context,
      String api_key,
      String code,
      String fromdate,
      String todate,
      String type,
      String PageNumber) async {
    String url =
        "https://login.glowsis.com/dashboardapp/GeneralLedger/execute?api_key=$api_key&Code=$code&FromDate=$fromdate&ToDate=$todate&Type=$type&PageNumber=$PageNumber";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

//party
  static Future<List<TDetailsM>> getOpeningBalanceDetails({
    required BuildContext context,
    required String api_key,
    required String code,
    required String fromdate,
    required String type,
    required String category,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/Opening?api_key=$api_key&Code=$code&FromDate=$fromdate&Type=$type&PageNumber=1&TransType=${(category == "Future Transactions") ? "FT" : "OP"}";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List list = response["Details"];
    return list.map((e) => TDetailsM.fromJson(e)).toList();
  }

  static Future<dynamic> addMoreCompany({
    required BuildContext context,
    required String api_key,
    required String OrgName,
    required String branchOrg,
    required String branchUser,
    required String branchPwd,
  }) async {
    String url =
        "https://login.glowsis.com/user/addbranch?api_key=$api_key&OrgName=$OrgName&branchOrg=$branchOrg&branchUser=$branchUser&branchPwd=$branchPwd";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> updatItemdetails({
    required BuildContext context,
    required String api_key,
    required String ItemNo,
    required String Group,
    required String Brand,
    required String Section,
    required String TaxCode,
    required String HsnCode,
    required String Supplier,
    required String Inactive,
    required String Type,
    required String MrpDiscount,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/ItemUpdate?api_key=$api_key"
        "&ItemNo=$ItemNo"
        "&Group=$Group"
        "&Brand=$Brand"
        "&Section=$Section"
        "&TaxCode=$TaxCode"
        "&HsnCode=$HsnCode"
        "&Supplier=$Supplier"
        "&Inactive=$Inactive"
        "&Type=$Type"
        "&MrpDiscount=$MrpDiscount";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> addStore({
    required BuildContext context,
    required String api_key,
    required String StroreName,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/StoreInsert?api_key=$api_key&StrName=$StroreName";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<List<DayAttandanceM>> attendancerpt({
    required BuildContext context,
    required String api_key,
    required String fromDate,
    required String todate,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/attendancerpt?api_key=$api_key&from_date=$fromDate&to_date=$todate&AppName=HRManager";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    List list = response["Details"];
    return list.map((e) => DayAttandanceM.fromJson(e)).toList();
  }

  static Future<List<EmpAttandanceM>> attendancerptbyemp({
    BuildContext? context,
    required String api_key,
    required String date,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/attendancerptbyemp?api_key=$api_key&date=$date&AppName=HRManager";
    var response = await MyKey.postWithApiKey(url, Map(), context!);
    List list = response["Details"];
    return list.map((e) => EmpAttandanceM.fromJson(e)).toList();
  }

  static Future<List<AttandanceEmpM>> monthlyAttandanceByEmp({
    required BuildContext context,
    required String api_key,
    required String fromdate,
    required String Todate,
    required String EmpId,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/attendanceEmp?api_key=$api_key&fromdate=$fromdate&Todate=$Todate&EmpId=$EmpId";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    List list = response["Details"];
    return list.map((e) => AttandanceEmpM.fromJson(e)).toList();
  }

  // https://login.glowsis.com/hrm/attendancerptbyemp?
  // https://login.glowsis.com/hrm/attendancerpt?
  // https://login.glowsis.com/hrm/attendancerptbyperiod?api_key=myapiKey&from_date=MyfromDate&to_date=myTodate
  // static Future<SalesTrendsM> salesTrends({
  //   required BuildContext context,
  //   required String api_key,
  //   required String date,
  //   required String urlEndPart,
  //   String endPoint = "SLT",
  //   required String categoryId,
  // }) async {
  //   String url =
  //       "https://login.glowsis.com/dashboardapp/$endPoint?api_key=$api_key&fromdate=$date$urlEndPart&ItemGroup=${categoryId ?? ""}";
  //   var response = await MyKey.postWithApiKey(url, Map(), context);
  //   return SalesTrendsM.fromJson(response);
  // }
  static Future<SalesTrendsM> salesTrends({
    required BuildContext context,
    required String api_key,
    required String date,
    required String urlEndPart,
    String endPoint = "SLT",
    required String categoryId,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/$endPoint?api_key=$api_key&fromdate=$date$urlEndPart&ItemGroup=${categoryId ?? ""}";

    // Make the API call and get the response
    var response = await MyKey.postWithApiKey(url, Map(), context);

    // Check if the response is not null and is a Map<String, dynamic>
    if (response != null && response is Map<String, dynamic>) {
      // Convert the response to SalesTrendsM
      return SalesTrendsM.fromJson(response);
    } else {
      // If the response is null or not a Map<String, dynamic>, handle it accordingly
      throw Exception("Invalid response format");
    }
  }

  static Future<List<AttandanceBranchM>> getAttandaceByBranch(
      BuildContext context,
      String arryApiKey,
      String fromDate,
      String toDate) async {
    String url = "https://login.glowsis.com/dashboardapp/BRAB?"
        "array_api_keys=$arryApiKey&frmdate=$fromDate&todate=$toDate";
    List data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null) {
      return data.map((e) => AttandanceBranchM.fromJson(e)).toList();
    }
    return [];
  }

  static Future<dynamic> getBranchBrsg({
    required BuildContext context,
    required String arryApiKey,
    required String fromDate,
    required String toDate,
    required String DtRange,
    required String endPont,
  }) async {
    String url = "https://login.glowsis.com/dashboardapp/$endPont?"
        "array_api_keys=$arryApiKey&frmdate=$fromDate&todate=$toDate&DtRange=$DtRange";
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    String strResonse = """
    {
		"Details": [{
			"Branch": "EDU CLT",
			"Org_Id": 1120,
			"TotalPayments": 169,
			"Amount": 350696.44,
			"CmpAmnt": -24654.02,
			"YestedaySales": 375350.46,
			"AvgAmount": 2075.0,
			"AvgAmountCmp": -159.0,
			"GP": 31.07,
			"CmpGP": 7.14,
			"TodayGPAmount": 108967.77,
			"YesyerdayGPAmount": 89810.47
		}],
		"Consolidation": [{
			"SalesAmount": "350696.44",
			"TotalGP": "31.072",
			"SalesAmountCmp": "-24,654.020",
			"SalesGpcmp": "7.145"
		}]
	}
    """;
    // data=json.decode(strResonse);
    if (data != null) {
      return data;
    }
    return null;
  }

  static Future<PunchM?> getPunchDetails({
    required BuildContext context,
    required String api_key,
    required String Date,
    required String EmpId,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/punchingrpt?api_key=$api_key&Date=$Date&EmpId=$EmpId";
    var data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null) {
      return PunchM.fromJson(data);
    }
    return null;
  }

  static Future<ConsiceM?> getConciseRport({
    required BuildContext context,
    required String api_key,
    required String userId,
    required String frmdate,
    required String todate,
    required String dtRange,
  }) async {
    String url = "https://login.glowsis.com/dashboardapp/CNR?"
        "api_key=$api_key&userId=$userId&frmdate=$frmdate&todate=$todate&DtRange=$dtRange";
    var data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null) {
      return ConsiceM.fromJson(data);
    }
    return null;
  }

  static Future<ItemLoadM?> itemLoad(
      {required BuildContext context, required String api_key}) async {
    String url = "https://login.glowsis.com/Mobileapp/ItemsLoad?"
        "api_key=$api_key";
    var data = await MyKey.postWithApiKey(url, Map(), context);
    if (data != null) {
      return ItemLoadM.fromJson(data);
    }
    return null;
  }

  static addProduct({
    required BuildContext context,
    required String api_key,
    required String ItemName,
    required String Bracode,
    required String HSNCode,
    required String TaxCode,
    required String ItemGroup,
    required String Brand,
    required String Section,
    String Image = "",
    String Image1 = "",
    String Image2 = "",
    String Image3 = "",
    required String MRP,
    required String MRPDisc,
    required String PriceDt,
    String Update = "N",
    required String Inactive,
  }) async {
    String url =
        "https://login.glowsis.com/Mobileapp/ItemInsert?api_key=$api_key"
        "&ItemName=$ItemName"
        "&Bracode=$Bracode"
        "&HSNCode=$HSNCode"
        "&TaxCode=$TaxCode"
        "&ItemGroup=$ItemGroup"
        "&Brand=$Brand"
        "&Section=$Section"
        "&Image=$Image"
        "&Image1=$Image1"
        "&Image2=$Image2"
        "&Image3=$Image3"
        "&MRP=$MRP"
        "&MRPDisc=$MRPDisc"
        "&Update=$Update" //Y OR N
        "&PriceDt=$PriceDt"
        "&Inactive=$Inactive";
    var data = await MyKey.postWithApiKey(url, Map(), context);
    return data;
  }

  static Future<dynamic> signup({
    required BuildContext context,
    required String Organisation,
    required String Mobile,
    required String Email,
    required String Address,
    required String UserCode,
    required String PassWord,
    required bool isConnectWithExistingCompany,
  }) async {
    String ip = await getIp();
    String url = "https://login.glowsis.com/Mobileapp/createcompany?"
        "Organisation=$Organisation"
        "&Mobile=$Mobile"
        "&Email=$Email"
        "&Address=$Address"
        "&UserCode=$UserCode"
        "&PassWord=$PassWord"
        "&connect_to_exists=${isConnectWithExistingCompany ? "Y" : "N"}&create_new_org=${isConnectWithExistingCompany ? "N" : "Y"}&DeviceIp=$ip";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> signupOtpSent({
    required BuildContext context,
    required String Mobile,
  }) async {
    String url =
        "$baseUrl/Mobileapp/OTP?ValidationKey=$Mobile&MobileOrEmail=M&Level=1";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> signupOtpVerify({
    required BuildContext context,
    required String Mobile,
    required String Otp,
    required String OtpId,
  }) async {
    String url =
        "$baseUrl/Mobileapp/OTP?ValidationKey=$Mobile&MobileOrEmail=M&OTP=$Otp&OTPId=$OtpId&Level=2";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> getDocumentType({
    required BuildContext context,
    required String api_key,
    required String DBType,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/DBT?api_key=$api_key&DBType=$DBType";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> getDocumentList({
    required BuildContext context,
    required String api_key,
    required String DBType,
    required String fromDate,
    required String toDate,
    required String pageNo,
    required String query,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/apd?api_key=$api_key&DocType=$DBType&frmdate=$fromDate&todate=$toDate&PageNumber=$pageNo&Searchtxt=$query";
    print("Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx $url");
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> approveDocument({
    required BuildContext context,
    required String api_key,
    required String DBType,
    required String Sequence,
    required String RecNo,
    required String initno,
    required bool isApproved,
    required String remark,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/update?api_key=$api_key&DocType=$DBType&Sequence=$Sequence&RecNo=$RecNo&initno=$initno&Approvred=${isApproved ? "Y" : "N"}&Remarks=$remark";

    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<List<PartySearchM>> partySearch({
    required BuildContext context,
    required String api_key,
    required String Type,
    required String query,
  }) async {
    String url =
        "$baseUrl/Mobileapp/CMS?api_key=$api_key&type=$Type&SearchTxt=$query";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    List list = response["Details"];
    print("length ${list.first.toString()}");
    return list.map((e) => PartySearchM.fromJson(e)).toList();
  }

  static Future<PartySearchM?> partySearchMode({
    BuildContext? context,
    String? api_key,
    String? Type,
    String? mode,
  }) async {
    try {
      String url =
          "$baseUrl/Mobileapp/CMS?api_key=$api_key&type=$Type&SearchTxt=";
      var response = await MyKey.postWithApiKey(url, Map(), context!);

      if (response.containsKey("DefaultAccount") &&
          response["DefaultAccount"].isNotEmpty) {
        List list = response["DefaultAccount"];
        var defaultM = DefaultM.fromJson(list.first);

        switch (mode) {
          case "Cash":
            return PartySearchM(
                CVCode: defaultM.CashAccount.toString(), Name: defaultM.Cash);
          case "Card":
            return PartySearchM(
                CVCode: defaultM.CardAccount.toString(), Name: defaultM.Card);
          case "Bank":
          case "UPI":
            return PartySearchM(
                CVCode: defaultM.BankAccount.toString(), Name: defaultM.Bank);
          case "Cheque":
            return PartySearchM(
                CVCode: defaultM.ChequeAccount.toString(),
                Name: defaultM.Cheque);
          default:
            // Handle unsupported 'mode' here or return a default value.
            break;
        }
      }

      // Handle cases where 'DefaultAccount' is empty or 'mode' is unsupported.
      return null;
    } catch (e) {
      // Handle exceptions (e.g., network errors) here.
      return null;
    }
  }

  // static Future<PartySearchM> partySearchMode({
  //   BuildContext? context,
  //   String? api_key,
  //   String? Type,
  //   String? mode,
  // }) async {
  //   String url =
  //       "$baseUrl/Mobileapp/CMS?api_key=$api_key&type=$Type&SearchTxt=";
  //   var response = await MyKey.postWithApiKey(url, Map(), context!);
  //   List list = response["DefaultAccount"];
  //   var defaultM = DefaultM.fromJson(list.first);
  //   if (mode == "Cash") {
  //     return PartySearchM(
  //         CVCode: defaultM.CashAccount.toString(), Name: defaultM.Cash);
  //   } else if (mode == "Card") {
  //     return PartySearchM(
  //         CVCode: defaultM.CardAccount.toString(), Name: defaultM.Card);
  //   } else if (mode == "Bank") {
  //     return PartySearchM(
  //         CVCode: defaultM.BankAccount.toString(), Name: defaultM.Bank);
  //   } else if (mode == "UPI") {
  //     return PartySearchM(
  //         CVCode: defaultM.BankAccount.toString(), Name: defaultM.Bank);
  //   } else if (mode == "Cheque") {
  //     return PartySearchM(
  //         CVCode: defaultM.ChequeAccount.toString(), Name: defaultM.Cheque);
  //   }

  //   // ChequeAccount
  // }

  static Future<dynamic> insertJurnal({
    required BuildContext context,
    required String api_key,
    required String date,
    required String remark,
    String? dat,
  }) async {
    String url =
        "https://login.glowsis.com/Mobileapp/PTP?api_key=$api_key&Date=$date&Narration=$remark&JournalData=$dat";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return response;
  }

  static Future<String> getIp() async {
    var response = await http.get(Uri.parse("https://Api.ipify.org"));
    print(response.body);
    return response.body;
  }

  static Future<List<CounterM>> CounterClosing(
      {required BuildContext context,
      required String api_key,
      required String fromdate,
      required String today,
      required String type,
      required String userId}) async {
    String url =
        "https://login.glowsis.com/dashboardapp/CounterClosing/?api_key=$api_key&frmdate=$fromdate&ToDate=$today&Type=$type&UserId=$userId";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    List list = response["Details"];
    print("length ${list.first.toString()}");
    return list.map((e) => CounterM.fromJson(e)).toList();
  }

  static Future<CatSecTrendM> SalseSectionTrend(
      {BuildContext? context,
      required String api_key,
      required String fromDate,
      String? todate,
      required String urlEndPart,
      required String endPoint}) async {
    String url =
        "https://login.glowsis.com/dashboardapp/$endPoint?api_key=$api_key&$urlEndPart&frmdate=$fromDate&todate=${MyKey.getCurrentDate()}";
    // var response = await MyKey.postWithApiKey(url, Map(), context!);
    var response = await MyKey.postWithApiKey(url, {}, context!);

    return CatSecTrendM.fromJson(response ?? {});
  }

  static Future<dynamic> insertRecipt({
    required BuildContext context,
    required Map params,
  }) async {
    String url = "https://login.glowsis.com/Mobileapp/receiptsave";
    var response = await MyKey.postWithApiKey(url, params, context);
    return response;
  }

  //Op/IP
  static Future getBills(
      {required BuildContext context,
      required String api_key,
      required String Code,
      required String DocType,
      required String pageNumber}) async {
    String url =
        "https://login.glowsis.com/Mobileapp/GetPB?api_key=$api_key&Code=$Code&DocType=$DocType&PageNumber=$pageNumber";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return response;
  }

  static Future<List<String>> getNotification(
      {required BuildContext context, required String apiKey}) async {
    String url = "https://login.glowsis.com/dashboardapp/NTL?api_key=$apiKey";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return List<String>.from(
        response["List"].map((x) => x["Content"].toString()));
  }

  static Future<dynamic> getItemSalesReport(BuildContext context, String apiKey,
      String fromDate, String toDate, int pageNumber, bool isSale,
      {String IsPageing = "Y", pageSize = 20}) async {
    String url =
        "https://login.glowsis.com/dashboardapp/${isSale ? "ISR" : "IPR"}?api_key=$apiKey&frmdate=$fromDate&todate=$toDate&PageNumber=$pageNumber&IsPageing=$IsPageing&PageSize=$pageSize";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return response;
  }

  static Future<dynamic> getItemSalesTrend(
      {required BuildContext context,
      required String apiKey,
      required String fromDate,
      required String toDate,
      required int pageNumber,
      required bool isSale}) async {
    String url =
        "https://login.glowsis.com/dashboardapp/${isSale ? "ISTR" : "IPTR"}?api_key=$apiKey&frmdate=$fromDate&todate=$toDate&PageNumber=$pageNumber";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return response;
  }

  static Future<DocumentLoadM> getDocumentLoad(
      {required BuildContext context, required String apiKey}) async {
    String url =
        "https://login.glowsis.com/Mobileapp/docload?api_key=$apiKey&&frmid=7";
    print("Url $url");
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return DocumentLoadM.fromJson(response);
  }

  static Future<SinglePartyDetailsM> getSinglePartyDetails({
    required BuildContext context,
    required String apiKey,
    required String cvCode,
  }) async {
    String url =
        "https://login.glowsis.com/Mobileapp/getcv?api_key=$apiKey&CVCode=$cvCode";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return SinglePartyDetailsM.fromJson(response["Details"][0]);
  }

  static Future<SingleItemM> getSingleItemDetails(
      {required BuildContext context,
      required String apiKey,
      required String cvCode,
      required String document,
      required String itemNumber,
      required String pricelist}) async {
    String url =
        "https://login.glowsis.com/Sales/GetSingleItem?api_key=$apiKey&CVCode=$cvCode&Document=$document&itemNo=$itemNumber&PriceList=$pricelist&storeID=1&Batch&UOM";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return SingleItemM.fromJson(response[0]["Details"][0]);
  }

  static Future documentSave(
      {required BuildContext context, required Map params}) async {
    String url = "https://login.glowsis.com/windowsoff/docsave2";

    var response = await MyKey.postWithApiKey(url, params, context);
    //  print("paramssssssssssss::::$params");
    //  print("urllllllllllllllll::::$url");
    return response;
  }

  static Future<EmpLoadM> getEmpoyeeLoad({
    required BuildContext context,
    required String api_key,
  }) async {
    String url = "https://login.glowsis.com/hrm/empload?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return EmpLoadM.fromJson(response);
  }

  static Future<EmployeeMasterM> getEmployeeMaster({
    required BuildContext context,
    required String api_key,
  }) async {
    String url = "https://login.glowsis.com/hrm/EmpFind?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return EmployeeMasterM.fromJson(response);
  }

  static Future<ReimpurseM> getReimbursment({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com//hrm/empreimbursement?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return ReimpurseM.fromJson(response);
  }

  static Future insertActivity({
    required BuildContext context,
    required String api_key,
    required String where,
    required String when,
    required String from,
    required String to,
    required String strWith,
    required String expences,
    required String what,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/empactivity?api_key=$api_key&fromplace=$where&Date=$when&StrtTime=$from&EndTime=$to&Toplace=&Location=$where&with=$strWith&Expenses=$expences&Activity=$what";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future createLeveType({
    required BuildContext context,
    required String api_key,
    required String leaveType,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Lvtype?api_key=$api_key&Name=$leaveType";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List> leaveLoad({
    required BuildContext context,
    required String api_key,
  }) async {
    String url = "https://login.glowsis.com/hrm/leaveLoad?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List types = response["LeaveType"];
    return types;
  }

  static Future topsellingPurchasingItems({
    required BuildContext context,
    required String api_key,
    required String fromdate,
    required String todate,
    required bool isSale,
    int? pageNo,
    int? GrpId,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/${isSale ? "TSVS" : "TSVP"}?api_key=$api_key&frmdate=$fromdate&todate=$todate&PageNum=$pageNo&SerachTxt&GrpId=$GrpId";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List> soldCount({
    required BuildContext context,
    required String api_key,
    required String fromdate,
    required String todate,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/SLAC?api_key=$api_key&frmdate=$fromdate&todate=$todate";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List list = response["count"];
    return list;
  }

  static Future getLsvCount({
    required BuildContext context,
    required String api_key,
    required String fromdate,
    required String todate,
    required String SplitType,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/SVS?&api_key=$api_key&SplitType=$SplitType";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future getLsvList({
    required BuildContext context,
    required String api_key,
    required String fromdate,
    required String todate,
    required int pageNo,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/LSVList?api_key=$api_key&frmdate=$fromdate&todate=$todate&PageNum=$pageNo&SerachTxt";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List<SlacM>> getSlacCount({
    required BuildContext context,
    required String api_key,
    required String fromdate,
    required String todate,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/SLAC?api_key=$api_key&frmdate=$fromdate&todate=$todate";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List list = response["count"];
    return list.map((e) => SlacM.fromJson(e)).toList();
  }

  static Future<AccountLoadM> getAccountLoad({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/accload?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return AccountLoadM.fromJson(response);
  }

  static Future<NextNumM> getNextNum({
    required BuildContext context,
    required String api_key,
    required String code,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/acc/nextnum?api_key=$api_key&Code=$code";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return NextNumM.fromJson(response);
  }

  static Future accountInsert({
    required BuildContext context,
    required String api_key,
    required String code,
    required String name,
    required String clasification,
    required String parent,
    required String drawer,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/acc/insert?api_key=$api_key&Code=$code&Name=$name&Classification=$clasification&Parent=$parent&Drawer=$drawer";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List<SoldItemM>> getSoldItemList({
    required BuildContext context,
    required String api_key,
    required String fromdate,
    required String todate,
    required String type,
    required int pageNo,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/SAL?api_key=$api_key&frmdate=$fromdate&todate=$todate&PageNum=$pageNo&SerachTxt&Type=$type";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List list = response["List"];
    return list.map((e) => SoldItemM.fromJson(e)).toList();
  }

  static Future<ExpenceLoadM> expenceLoad({
    required BuildContext context,
    required String api_key,
    required String type,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/ExpLoad?api_key=$api_key&SerachTxt&AccType=$type";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return ExpenceLoadM.fromJson(response);
  }

  static Future expenceInsert({
    required BuildContext context,
    required String api_key,
    required String date,
    required String account,
    required String partyCode,
    required String partyName,
    required String refNo,
    required String refDate,
    required String netAmount,
    required String expence,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/ExpInsert?api_key=$api_key&Date=$date&Account=$account&PartyCode=$partyCode&PartyName=$partyName&RefNo=$refNo&RefDate=$refDate&NetAmnt=$netAmount&Expenses=$expence";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List<PaySlipM>> getPayroll(
      //M for manager ,E for employee
      {
    required BuildContext context,
    required String api_key,
    required String fromdate,
    required String todate,
    required String type,
  }) async {
    String url =
        "https://login.glowsis.com/dashboard/PayrollList?api_key=$api_key&FromDate=$fromdate&ToDate=$todate&DashBoardType=$type";
    // String url ="https://login.glowsis.com/dashboard/PayrollList?api_key=glowsis.database.windows.net@HiveZ8@7RB87X9CBYDYQ7PEYKIRLX93WV43KNK9MQGM7NEKXHKRMGFUBZ@82181@i6Osu614XjSn3Tg4IIkFxapcSBSkKnzdNdr3373vgigdm94sXYD6lPTDQWpmZtkyDrkN968ooc59Bc=&FromDate=01/05/2019&ToDate=30/06/2019&DashBoardType=E";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List list = response["List"];
    return list.map((e) => PaySlipM.fromJson(e)).toList();
  }

  static Future<PayrollDetailsM> getPayrollByemployee({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    required String EmpCode,
  }) async {
    String url =
        "https://login.glowsis.com/DashBoard/payrollemp?api_key=$api_key&FromDate=$FromDate&ToDate=$ToDate&EmpCode=$EmpCode";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return PayrollDetailsM.fromJson(response);
  }

  static Future<PayrollDetailsM> getPayrollDetails({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    required String EmpCode,
    required String PayNo,
  }) async {
    String url =
        "https://login.glowsis.com/DashBoard/payroll/details?api_key=$api_key&FromDate=$FromDate&ToDate=$ToDate&EmpCode=$EmpCode&PayNo=$PayNo";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return PayrollDetailsM.fromJson(response);
  }

  static Future<PayrollLoadM> payRollLoad({
    required BuildContext context,
    required String api_key,
    required String TotalWorkingDays,
    required String FromDate,
    required String ToDate,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Payrollload?api_key=$api_key&TotalWorkingDays=$TotalWorkingDays&FromDate=$FromDate&ToDate=$ToDate";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return PayrollLoadM.fromJson(response);
  }

  static Future<PayrollDetailsM> payRollDetails({
    required BuildContext context,
    required String api_key,
    required String TotalWorkingDays,
    required String FromDate,
    required String ToDate,
    required String EmployeeCode,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Payrollloaddetails?api_key=$api_key&FromDate=$FromDate&ToDate=$ToDate&TotalWorkingDays=$TotalWorkingDays&EmployeeCode=$EmployeeCode";
    var response = await MyKey.postWithApiKey(url, {}, context);
    var payrollDetailsM = PayrollDetailsM.fromJson(response);
    if (payrollDetailsM.SalaryBricks == null) {
      payrollDetailsM.SalaryBricks = [];
    }
    return payrollDetailsM;
  }

  static Future<PayrollDeatilsM> payRollFullDetails({
    required BuildContext context,
    required String api_key,
    required String TotalWorkingDays,
    required String FromDate,
    required String ToDate,
    required String EmployeeCode,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Payrollloaddetails?api_key=$api_key&FromDate=$FromDate&ToDate=$ToDate&TotalWorkingDays=$TotalWorkingDays&EmployeeCode=$EmployeeCode";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return PayrollDeatilsM.fromJson(response);
  }

  static Future<int> getSequence({
    required BuildContext context,
    required String api_key,
    required String form_id,
    required String Series_Id,
  }) async {
    String url =
        "https://login.glowsis.com/accounts/sales/select_sequenceNo?api_key=$api_key&form_id=$form_id&Series_Id=$Series_Id";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response["SequenceNo"][0]["RecNum"];
  }

  static Future payRollInsert({
    required BuildContext context,
    required Map params,
  }) async {
    String url = "https://login.glowsis.com/hrm/payrollinsert";
    var response = await MyKey.postWithApiKey(url, params, context);
    return response;
  }

  // static Future<RoastLoadM> loadRoaster({
  //   required BuildContext context,
  //   required String api_key,
  //   required String FromDate,
  //   required String ToDate,
  //   required String departmentId,
  // }) async {
  //   String url =
  //       "https://login.glowsis.com/hrm/ShiftRoster01FindAll?api_key=$api_key&FromDate=$FromDate&ToDate=$ToDate&AppName=HRManagerAPP${departmentId != null ? "&Department=$departmentId" : ""}";
  //   var response = await MyKey.postWithApiKey(url, {}, context);
  //   var roastLoadM;
  //   try {
  //     roastLoadM = RoastLoadM.fromJson(response);
  //   } catch (e) {
  //     Toast.show(e.toString());
  //     print(" RoasterLoadM:${e.toString()}");
  //   }
  //   return roastLoadM;
  // }
  //////////////////////////////////////////////////////////////////
  static Future<RoastLoadM> loadRoaster({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    required String departmentId,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/ShiftRoster01FindAll?api_key=$api_key&FromDate=$FromDate&ToDate=$ToDate&AppName=HRManagerAPP${departmentId != null ? "&Department=$departmentId" : ""}";
    var response = await MyKey.postWithApiKey(url, {}, context);
    RoastLoadM roastLoadM;
    try {
      if (response != null) {
        roastLoadM = RoastLoadM.fromJson(response);
      } else {
        // Handle the case where response is null
        throw Exception("Response is null");
      }
    } catch (e) {
      Toast.show(e.toString());
      print("RoasterLoadM: ${e.toString()}");
      // You can choose to return a default value or rethrow the exception here
      throw e;
    }
    return roastLoadM;
  }

  static Future insertRoaster({
    required BuildContext context,
    required String api_key,
    required String docDate,
    required String empCode,
    required String shiftCode,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/shiftrosterinsertupdate?api_key=$api_key&DocDate=$docDate&EmpCode=$empCode&ShiftCode=$shiftCode";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List<ExpenceTypeM>> getExpenceList({
    required BuildContext context,
    required String api_key,
  }) async {
    String url = "https://login.glowsis.com/hrm/ListOfExpense?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List list = response['List_Of_Expense'];
    return list.map((e) => ExpenceTypeM.fromJson(e)).toList();
  }

  static Future<List<ItemWithGpM>> catItems({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    required String pageNo,
    required int id,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/CAT/items?api_key=$api_key&frmdate=$FromDate&todate=$ToDate&PageNum=$pageNo&GrpId=$id";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List list = response['List'];
    return list.map((e) => ItemWithGpM.fromJson(e)).toList();
  }

  static Future<List<ItemWithGpM>> secItems({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    required String pageNo,
    required int id,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/SEC/items?api_key=$api_key&frmdate=$FromDate&todate=$ToDate&PageNum=$pageNo&Id=$id";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List list = response['List'];
    return list.map((e) => ItemWithGpM.fromJson(e)).toList();
  }

  static Future<List<ItemWithGpM>> catItemsPr({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    required String pageNo,
    required int id,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/CAT/itemsPR?api_key=$api_key&frmdate=$FromDate&todate=$ToDate&PageNum=$pageNo&GrpId=$id";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List list = response['List'];
    return list.map((e) => ItemWithGpM.fromJson(e)).toList();
  }

  static Future<List<ItemWithGpM>> secItemsPr({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    required String pageNo,
    required int id,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/SEC/itemsPR?api_key=$api_key&frmdate=$FromDate&todate=$ToDate&PageNum=$pageNo&Id=$id";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List list = response['List'];
    return list.map((e) => ItemWithGpM.fromJson(e)).toList();
  }

  static Future insertPromotion({
    required BuildContext context,
    required String api_key,
    required String name,
    required String id,
    required String subpromotions,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/promotionmaster/insert?api_key=$api_key&Id=$id&Name=$name&subpromotions=$subpromotions";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<PromotionLoadM> promotionLoad({
    required BuildContext context,
    required String api_key,
    required String type, //M for manager, E for employee
  }) async {
    String url =
        "https://login.glowsis.com/hrm/promotionload?api_key=$api_key&DashBoardType=$type";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return PromotionLoadM.fromJson(response);
  }

  static Future promotionRequest({
    required BuildContext context,
    required String api_key,
    required String fromDeig,
    required String toDesig,
    required String remarks,
    required String date,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/request/promotioninsert?api_key=$api_key&fromdesignation=$fromDeig&todesignation=$toDesig&remarks=$remarks&Date=$date";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List<RequestsM>> getRequestList({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/DashBoard/requestlist?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<RequestsM>.from(
        response["Requests"].map((e) => RequestsM.fromJson(e)));
  }

  static Future<RequestsM> getRequestListDetails({
    required BuildContext context,
    required String api_key,
    required String RequestType,
    required String RequestId,
  }) async {
    String url =
        "https://login.glowsis.com/DashBoard/requestlist/id?api_key=$api_key&RequestType=$RequestType&RequestId=$RequestId";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<RequestsM>.from(
        response["Requests"].map((e) => RequestsM.fromJson(e))).first;
  }

  // static Future approveReject({
  //   required BuildContext context,
  //   required String api_key,
  //   required String RequestType,
  //   required String Approved,
  //   required String remarks,
  //   required String RequestId,
  //   required String Branchrequest,
  //   required String OrgId,
  // }) async {
  //   String url =
  //       "https://login.glowsis.com/DashBoard/requestapprove?api_key=$api_key&RequestType=$RequestType&Approved=$Approved&ApprovedRemarks=$remarks&RequestId=$RequestId&Branchrequest=$Branchrequest&OrgId=$OrgId";
  //   var response = await MyKey.postWithApiKey(url, {}, context);
  //   return response;
  // }

  static Future<List<PendingBillsM>> getPendingBills({
    required BuildContext context,
    required String api_key,
    required String code,
    required String pageNo,
  }) async {
    String url =
        "https://login.glowsis.com/DashBoard/pendinglist?api_key=$api_key&Code=$code&PageNum=$pageNo&DBType=M";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<PendingBillsM>.from(
        response["PendingBills"].map((e) => PendingBillsM.fromJson(e)));
  }

  static Future<AtteandanceLoadM> attendanceinsertLoad({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/AttendanceFirstLoad?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return AtteandanceLoadM.fromJson(response);
  }

  static Future<List<AttandanceFindM>> attandanceFind({
    required BuildContext context,
    required String api_key,
    required String Date,
  }) async {
    // String url = "https://login.glowsis.com/hrm/AttendanceFinddetails?api_key=$api_key&DocID=92";
    String url =
        "https://login.glowsis.com/hrm/ViewAttendance?api_key=$api_key&Date=$Date";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<AttandanceFindM>.from(
        response["Details"].map((e) => AttandanceFindM.fromJson(e)));
  }

  static Future<dynamic> attendanceInsert({
    required BuildContext context,
    required Map params,
  }) async {
    String url = "https://login.glowsis.com/hrm/Attendanceinsert";
    var response = await MyKey.postWithApiKey(url, params, context);
    return response;
  }

  static Future<dynamic> insertFcmToken({
    required BuildContext context,
    required String api_key,
    required String token,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/TokenInsert?api_key=$api_key&DeviceToken=$token";
    print("url:$url");
    dynamic response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List<AttandanceListM>> getAttandanceList({
    required BuildContext context,
    required String api_key,
    final String? FromDate,
    final String? ToDate,
  }) async {
    String url =
        "https://login.glowsis.com/DashBoard/attendance/list?api_key=$api_key&FromDate=$FromDate&ToDate=$ToDate";
    // url="https://login.glowsis.com/DashBoard/attendance/list?api_key=glowsis.database.windows.net@HiveZ8@KRZK6XWDOXKW2JQTVLLYHL2IS76WT3TEJ2QUX6I8X5ICF98S8T@82597@3GViNZ2HxlAWGZTRU7JYObwWjnsYgChLCj7g3rlX9Qy7BWi3PJOIVoRaVr3373LbvrzgDgGIySwmQs=&FromDate=01/10/2021&ToDate=30/10/2021";
    var response = await MyKey.postWithApiKey(url, {}, context);

    return List<AttandanceListM>.from(
        response["Attendance"].map((e) => AttandanceListM.fromJson(e)));
  }

  static Future approveRequest({
    required BuildContext context,
    required String api_key,
    required String PassKey,
    required String requestId,
    required String org_id,
    required String type,
  }) async {
    String url =
        "https://login.glowsis.com/dashboard/auth/statusupdate?api_key=$api_key&RequestId=$requestId&PassKey=$PassKey&OrgId=$org_id&type=$type";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List<PosGroupM>> getPosItemGroup({
    required BuildContext context,
    required String api_key,
    required String pageNo,
    required String query,
  }) async {
    String url =
        "https://login.glowsis.com/POS/grplist?api_key=$api_key&PageNum=$pageNo&SerachTxt=$query";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<PosGroupM>.from(
        response["grplist"].map((e) => PosGroupM.fromJson(e)));
  }

  static Future<List<SearchM>> getPosItem({
    required BuildContext context,
    required String api_key,
    required String query,
    required String groupid,
    required String pageNo,
  }) async {
    String url =
        "https://login.glowsis.com/POS/items/grpid?api_key=$api_key&PageNum=$pageNo&SerachTxt=$query&GrpId=$groupid";
    print(url);
    dynamic data = await MyKey.postWithApiKey(url, Map(), context);
    List dataList = data["ItemList"];
    List<SearchM> map =
        dataList.map<SearchM>((e) => SearchM.fromJson(e)).toList();
    return map;
  }

  static Future<List<PartySearchM>> posPartySearch({
    required BuildContext context,
    required String api_key,
    required String query,
  }) async {
    String url =
        "https://login.glowsis.com/POS/CVSearch?api_key=$api_key&SearchTxt=$query";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    List list = response["CVList"];
    print("length ${list.first.toString()}");
    return list.map((e) => PartySearchM.fromJson(e)).toList();
  }

  static Future<SinglePartyDetailsM> getPosCvSinglePartyDetails({
    required BuildContext context,
    required String api_key,
    required String cvCode,
  }) async {
    String url =
        "https://login.glowsis.com/POS/getcv?api_key=$api_key&CVCode=$cvCode";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return SinglePartyDetailsM.fromJson(response["Details"][0]);
  }

  static Future<SingleItemM> getPosSingleItemDetails({
    required BuildContext context,
    required String api_key,
    required String cvCode,
    String? document,
    required String itemNumber,
    required String pricelist,
    double? quantiy,
  }) async {
    String url =
        "https://login.glowsis.com/POS/GetSingleItem?api_key=$api_key&CVCode=$cvCode&Document=$document&itemNo=$itemNumber&PriceList=$itemNumber";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    var singleItemM = SingleItemM.fromJson(response[0]["Details"][0]);
    singleItemM.quantity = quantiy;
    return singleItemM;
  }

  static Future insertPosInvoice({
    required BuildContext context,
    required Map params,
  }) async {
    String url = "https://login.glowsis.com/windowsoff/possave";
    var response = await MyKey.postWithApiKey(url, params, context);
    return response;
  }

  // static Future<PartyLoadM> getPartyLoad({
  //   required BuildContext context,
  //   required String api_key,
  // }) async {
  //   String url =
  //       "https://login.glowsis.com/dashboardapp/dashcvload?api_key=$api_key";
  //   var response = await MyKey.postWithApiKey(url, Map(), context);
  //   return PartyLoadM.fromJson(response);
  // }
  static Future<PartyLoadM> getPartyLoad({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/dashcvload?api_key=$api_key";

    // Fetch the response
    var response = await MyKey.postWithApiKey(url, Map(), context);

    // Check if the response is not null
    if (response != null) {
      // Parse the response into PartyLoadM
      return PartyLoadM.fromJson(response);
    } else {
      // Return an empty PartyLoadM or handle the null case accordingly
      return PartyLoadM(
          group: [],
          gsttype: [],
          pricelist: [],
          state: []); // You may need to adjust this based on PartyLoadM constructor
    }
  }

  static Future<List<EmployeeM>> getEmployeeList({
    required BuildContext context,
    required String api_key,
  }) async {
    String url = "https://login.glowsis.com/hrm/Empdetails?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return List<EmployeeM>.from(
        response["EmpDetails"].map((e) => EmployeeM.fromJson(e)));
  }

  static Future<CountSalaryM> getCountSalary({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/Dashboard/Employee/countsalary?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return List<CountSalaryM>.from(
        response["empcountsalary"].map((e) => CountSalaryM.fromJson(e))).first;
  }

  static Future<List<OrgM>> getConnectedCompanies({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/DashBoard/connetedcmp?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    print(" ORG_list response:$response");
    return List<OrgM>.from(response["Org_List"].map((e) => OrgM.fromJson(e)));
  }

  static Future punchRequestInsert({
    required BuildContext context,
    required String api_key,
    required String In_Out,
    required String HomeCmp,
    required String Org_Id,
    required String EmpCode,
    required String EmpName,
    required String doImageID,
    required String PUType,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/punchrequestinsert?api_key=$api_key&In_Out=$In_Out&HomeCmp=$HomeCmp&Org_Id=$Org_Id&EmpCode=$EmpCode&EmpName=$EmpName&DocImage=$doImageID&PUType=$PUType";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return response;
  }

  static Future<List<StockMoveM>> getStockMovementReport({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/stockmovement/report?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return List<StockMoveM>.from(
        response["stockmovement"].map((e) => StockMoveM.fromJson(e)));
  }

  static Future<List<ItemLstM>> getListDetails({
    required BuildContext context,
    required String api_key,
    required String PageNumber,
    required String type,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/SVL?api_key=$api_key&Type=$type&SearchTxt&PageNumber=$PageNumber";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return List<ItemLstM>.from(
        response["details"].map((e) => ItemLstM.fromJson(e)));
  }

  static Future connectWithExistingCompany({
    required BuildContext context,
    required String Organisation,
    required String Mobile,
    required String Email,
    required String Address,
    required String UserCode,
    required String PassWord,
  }) async {
    String url =
        "https://login.glowsis.com/dashboard/createuser?Organisation=$Organisation&Mobile=$Mobile&Email=$Email&Address=$Address&UserCode=$UserCode&PassWord=$PassWord";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return response;
  }

  static Future<List<String>> getFcmTokens({
    required BuildContext context,
    required String Organisation,
  }) async {
    String url =
        "https://login.glowsis.com/dashboard/getdeviceid?Organisation=$Organisation";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return List<String>.from(response["DeviceId"].map((e) => e["DeviceId"]));
  }

  static Future<http.Response> sentPushNotification({
    required String to,
    required String userName,
    required String request_id,
    required String key1,
    required String key2,
    required String key3,
  }) async {
    String url = "https://fcm.googleapis.com/fcm/send";
    var headers = {
      'Authorization':
          'key=AAAANGLrneQ:APA91bFQ9Va1mdw34xT7VEMaaoLzW-YiWUHFA-WO4fs0-f5op7hxrL69hAOJaFi9FS5g_2PeGMoFsI_SUOrJ0kErNF6H5RgTQoz88Qj1yCKaRObZusvMjGRu0JRofKwlk8GeiRgrIOGG',
      'Content-Type': 'application/json'
    };
    var response = await http.post(Uri.parse(url),
        headers: headers,
        body: json.encode({
          "to": "$to",
          "notification": {
            "body": "Requested By $userName",
            "title": "Approve New User request"
          },
          "data": {
            "type": "User Creation",
            "request_id": "$request_id",
            "key_1": "$key1",
            "key_2": "$key2",
            "key_3": "$key3",
          }
        }));
    return response;
  }

  static Future<List<EmpM>> getEmployeeAbsentList({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/Dashboard/employeeleave/statuslist?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return List<EmpM>.from(
        response["empleavestatuslist"].map((e) => EmpM.fromJson(e)));
  }

  static Future acceptLoginRequest({
    required BuildContext context,
    required String api_key,
    required String orgId,
    required String userCode,
    required String requestId,
    required bool isApproved,
  }) async {
    String url =
        "https://login.glowsis.com/Login/auth/statusupdate?api_key=$api_key&RequestId=$requestId&Organisation=$orgId&UserCode=$userCode&Approved=${isApproved ? "Y" : "N"}";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return response;
  }

  static Future<List<Shift_DetailsBean>> getShiftList({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Shift01Findlist?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, Map(), context);
    return List<Shift_DetailsBean>.from(
        response["Table"].map((e) => Shift_DetailsBean.fromJson(e)));
  }

  static Future insertShift({
    required BuildContext context,
    required String api_key,
    required String shiftName,
    required String shiftCode,
    required String shiftValue,
    required String shiftColor,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Shift01InsertUpdate?api_key=$api_key&ShiftCode=$shiftCode&ShiftColour=$shiftColor&ShiftValue=$shiftValue&ShiftName=$shiftName";
    return await MyKey.postWithApiKey(url, Map(), context);
  }

  static Future<dynamic> getParyGroups({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    required String CVtype,
    required bool isGroup,
    required int apiPageNumber,
    String IsPageing = "Y",
    int PageSize = 20,
    String Orderby = "",
    String Sortyby = "",
    String query = "",
    String CVGroup = "",
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/${isGroup ? "cvgroup" : "cv"}/details?api_key=$api_key&frmdate=$FromDate&todate=$ToDate&PageNum=$apiPageNumber&IsPageing=$IsPageing&PageSize=$PageSize&CVtype=$CVtype&CVGroup=$CVGroup&Orderby=$Orderby&Sortyby=$Sortyby&SearchTxt=$query";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<dynamic> getBarandDetails({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    String? CVtype,
    required String dateRangeText,
    bool? isGroup,
    int? apiPageNumber,
    String IsPageing = "Y",
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/brand/details?api_key=$api_key&frmdate=$FromDate&todate=$ToDate&DateRange=$dateRangeText&PageNum=$apiPageNumber&IsPageing=$IsPageing&PageSize=20";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<dynamic> getTaxcodeDetails({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    String? CVtype,
    required String dateRangeText,
    String IsPageing = "Y",
    bool? isGroup,
    int? apiPageNumber,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/taxcode/details?api_key=$api_key&frmdate=$FromDate&todate=$ToDate&DateRange=$dateRangeText&PageNum=$apiPageNumber&PageSize=20&IsPageing=$IsPageing";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List<InvoiceM>> getCustomerInvoiceDetails({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    required String partyCode,
    String? dateRangeText,
    required bool isSupplier,
    required int apiPageNumber,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/${isSupplier ? "items" : "customer"}/details?api_key=$api_key&frmdate=$FromDate&todate=$ToDate&${isSupplier ? "ItemNo" : "PartyCode"}=$partyCode&PageNum=$apiPageNumber&PageSize=20";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<InvoiceM>.from(
        response["List"].map((e) => InvoiceM.fromJson(e)));
  }

  static Future<List<SalesItemM>> getSalesItemBySupplier({
    required BuildContext context,
    required String api_key,
    required String FromDate,
    required String ToDate,
    required String partyCode,
    String? dateRangeText,
    bool? isSupplier,
    required int apiPageNumber,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/ISR?api_key=$api_key&frmdate=$FromDate&todate=$ToDate&PageNumber=$apiPageNumber&PageSize=20&Supplier=$partyCode";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<SalesItemM>.from(
        response["List"].map((e) => SalesItemM.fromJson(e)));
  }

  static Future<List<DepartmentAttandance>> getDepartmentWiseAttandance({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/DashBoard/dptleaverpt?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<DepartmentAttandance>.from(
        response["List"].map((e) => DepartmentAttandance.fromJson(e)));
  }

  static Future getRoutLoad({
    required BuildContext context,
    required String api_key,
  }) async {
    String url = "https://login.glowsis.com/hrm/rptload?api_key=$api_key";
    return await MyKey.postWithApiKey(url, {}, context);
  }

  static Future getRoutLoadByEmployee({
    required BuildContext context,
    required String api_key,
    required String emp_code,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/roue/employee?api_key=$api_key&EmpCode=$emp_code";
    return await MyKey.postWithApiKey(url, {}, context);
  }

  static Future<RequestDetailsM> employeeRouteRequest({
    required BuildContext context,
    required String api_key,
    required String emp_code,
    required String RouteId,
    String? CVCode,
    String? CVName,
    required String RequestType,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Planner/routerequest?api_key=$api_key&RouteId=$RouteId&EmpCode=$emp_code&CVCode=$CVCode&CVName=$CVName&RequestType=$RequestType";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return RequestDetailsM.fromJson(response);
  }

  static Future changeUserRequestStatus({
    required BuildContext context,
    required String api_key,
    required String RequestId,
    required String RequestType,
    required String Status,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Planner/requestupdate?api_key=$api_key&RequestId=$RequestId&Status=$Status&RequestType=$RequestType";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List<PendingNotificationM>> getAllPendingNotification({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Planner/requestlist?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    List<PendingNotificationM>.from(response["RequestList"].map(
      (e) => PendingNotificationM.fromJson(e),
    ));
    return [];
  }

  static Future<List<RouteM>> getRoutByEmbloyee(
      //no need to use filter can be done from local
      {
    required BuildContext context,
    required String api_key,
    required String EmpCode,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/roue/employee?api_key=$api_key&EmpCode=$EmpCode";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<RouteM>.from(response["Routes"].map((e) => RouteM.fromJson(e)));
  }

  static Future<PlannerRouteLoadM> getRoutePlannerReportLoad(
      //no need to use filter can be done from local
      {
    required BuildContext context,
    required String api_key,
    required String EmpCode,
    required String date,
    required String routeId,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Planner/rptload?api_key=$api_key&RouteId=$routeId&EmpCode=$EmpCode&Date=$date";
    // String url = "https://login.glowsis.com/hrm/Planner/rptload?api_key=$api_key&RouteId=4&EmpCode=12541&Date=21/04/2022";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return PlannerRouteLoadM.fromJson(response);
  }

  static Future updateUser(
      //no need to use filter can be done from local
      {
    required BuildContext context,
    required Map params,
  }) async {
    String url = "https://login.glowsis.com/hrm/routeplanemp/insert";
    var response = await MyKey.postWithApiKey(url, params, context);
    return response;
  }

  static Future updatePunchStatus(
      //no need to use filter can be done from local
      {
    required BuildContext context,
    required String api_key,
    required String EmpCode,
    required String routeId,
    required String Location,
    required String LAT_LNG,
    required String CVCode,
    String punchStatus = "Y",
    required String date,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Planner/Punch?api_key=$api_key&RouteId=$routeId&EmpCode=$EmpCode&Date=$date&PunchStatus=$punchStatus&Location=$Location&LAT_LNG=$LAT_LNG&CVCode=$CVCode";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<String?> getCriptString({
    required BuildContext context,
    required String api_key,
    String? Document,
    String? Sequence,
    String? RecNum,
    String? InitNo,
    String? DocumentNumber,
    required String fullDocument,
  }) async {
    if (fullDocument != null) {
      var documentSplit = DocumentSplitter(document: fullDocument);
      Document = documentSplit.document;
      Sequence = documentSplit.sequence;
      RecNum = documentSplit.recNo;
      InitNo = documentSplit.initNumber;
    }

    String url =
        "https://login.glowsis.com/dashboardapp/document/crypt?api_key=$api_key&Document=$DocumentNumber&Sequence=$Sequence&RecNum=$RecNum&InitNo=$InitNo";
    var response = await MyKey.postWithApiKey(url, {}, context);
    if (response != null)
      return response["DocDetails"][0]["CryptString"];
    else
      return null;
  }

  static Future upsertRoute(
      //no need to use filter can be done from local
      {
    required BuildContext context,
    required String api_key,
    required String EmpCode,
    required String Frequency,
    required String NoOfDays,
    required String routeId,
    required String routeName,
    required String date,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/route/insertupdate?api_key=$api_key&RouteId=$routeId&EmpCode=$EmpCode&RouteName=$routeName&Frequency=$Frequency&NoOfDays=$NoOfDays&StartingDate=$date";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<List<InventoryM>> getInventoryByProduct(
      //no need to use filter can be done from local
      {
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/inventory/product?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<InventoryM>.from(
        response["List"].map((e) => InventoryM.fromJson(e)));
  }

  static Future<List<InventoryM>> getInventoryByBrand(
      //no need to use filter can be done from local
      {
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/inventory/brand?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<InventoryM>.from(
        response["List"].map((e) => InventoryM.fromJson(e)));
  }

  static Future<List<StockinvM>> getStockinv(
      //no need to use filter can be done from local
      {
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/stockinv?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<StockinvM>.from(
        response["List"].map((e) => StockinvM.fromJson(e)));
  }

  static Future<List<MovingM>> getFastMoving(
      //no need to use filter can be done from local
      {
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/inventory/fastmoving?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<MovingM>.from(response["List"].map((e) => MovingM.fromJson(e)));
  }

  static Future<List<MovingM>> getSlowMoving(
      //no need to use filter can be done from local
      {
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/inventory/slowmoving?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<MovingM>.from(response["List"].map((e) => MovingM.fromJson(e)));
  }

  static Future<pos.DefaultM> getDefault({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/Mobileapp/default?api_key=$api_key&Document=7";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return pos.DefaultM.fromJson(response);
  }

  static Future setEstExpense({
    required BuildContext context,
    required String api_key,
    required String amount,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/update/estexpamnt?api_key=$api_key&Amount=$amount";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  static Future<String> loadImage({
    required BuildContext context,
    required int orgId,
    required String imageCode,
  }) async {
    Map params = {"org_id": orgId.toString(), "imgCode": imageCode};
    String url = "https://login.glowsis.com/hrm/fileimageselect";
    var response = await MyKey.postWithApiKey(url, params, context);
    if (response == null) {
      throw Exception("Failed to load Image");
    }
    return response;
  }

  /////////////////////////////////////////
  // static Future<String> loadImage({
  //   required BuildContext context,
  //   required int orgId,
  //   required String imageCode,
  // }) async {
  //   Map params = {"org_id": orgId.toString(), "imgCode": imageCode};
  //   String url = "https://login.glowsis.com/hrm/fileimageselect";
  //   var response = await MyKey.postWithApiKey(url, params, context);

  //   if (response == null) {
  //     throw Exception("Failed to load image");
  //   }

  //   return response;
  // }

  static Future<RoutPunchLodM> routePunchKmLoad({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/Planner/kmload?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return RoutPunchLodM.fromJson(response);
  }

  static Future routePunch({
    required BuildContext context,
    required String api_key,
    required String inOut,
    required String EmpCode,
    required String EmpName,
    required String DocImage,
    required String Type,
    required String KM,
    required String Remarks,
    required String PUType,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/punchrequestinsert?api_key=$api_key&In_Out=$inOut&HomeCmp=Y&Org_Id&EmpCode=$EmpCode&EmpName=$EmpName&DocImage=$DocImage&Type=$Type&KM=$KM&Remarks=$Remarks&PUType=$PUType";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response;
  }

  /* Get Stock value */
  static Future<num> StockValue({
    required BuildContext context,
    required String api_key,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/stkvalue?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return response["StockValue"][0]["StockValue"];
  }

  static Future<List<RoutPunchM>> getRoutePunchReport({
    required BuildContext context,
    required String api_key,
    required String fromDate,
    required String toDate,
  }) async {
    // String url = "https://login.glowsis.com/hrm/Planner/rptpunch?api_key=$api_key&FromDate=$fromDate&ToDate=$toDate";
    String url =
        "https://login.glowsis.com/hrm/Planner/rptpunch?api_key=$api_key&FromDate=$fromDate&ToDate=$toDate";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<RoutPunchM>.from(
        response["PunchDetails"].map((e) => RoutPunchM.fromJson(e)));
  }

  // static Future<CampainM> getCampainLoad({
  //   required BuildContext context,
  //   required String api_key,
  // }) async {
  //   String url = "https://login.glowsis.com/campaign/pageload?api_key=$api_key";
  //   var response = await MyKey.postWithApiKey(url, {}, context);
  //   return CampainM.fromJson(response);
  // }

  static Future<Object> getCampainLoad({
    required BuildContext context,
    required String api_key,
  }) async {
    try {
      String url =
          "https://login.glowsis.com/campaign/pageload?api_key=$api_key";
      var response = await MyKey.postWithApiKey(url, {}, context);
      if (response != null && response is Map<String, dynamic>) {
        return CampainM.fromJson(response);
      } else {
        return {};
      }
    } catch (err) {
      print("Error os getCampain Load :$err");
      return {};
    }
  }

  static Future<List<CampainItem>> getCamapinItemDetails({
    required BuildContext context,
    required String api_key,
    required String pricelist,
    required String searchValue,
  }) async {
    String url =
        "https://login.glowsis.com/campaign/itemdetail?api_key=$api_key&PriceList=$pricelist&searchvalue=$searchValue";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return List<CampainItem>.from(
        response["ItemDetails"].map((e) => CampainItem.fromJson(e)));
  }

  static Future<dynamic> insertCampain({
    required BuildContext context,
    required String api_key,
    required CampainHeadderM headder,
    required List<CampainItem> itemList,
  }) async {
    Map<String, dynamic> data = {
      "data": [headder],
      "itms": itemList
    };
    String url = "https://login.glowsis.com/campaign/insert";
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'ARRAffinity=2b61cec408d874c576472ee16343ea5413e09acae6c0285fbe59824567b6c09b; ARRAffinitySameSite=2b61cec408d874c576472ee16343ea5413e09acae6c0285fbe59824567b6c09b'
    };
    var response = await MyKey.postWithApiKey(url, json.encode(data), context,
        headder: headers);
    return response;
  }

  // static Future<List<CampainListItemM>> getCampaginList({
  //   required BuildContext context,
  //   required String api_key,
  // }) async {
  //   String url = "https://login.glowsis.com/campaign/findlist?api_key=$api_key";
  //   var response = await MyKey.postWithApiKey(url, {}, context);
  //   return List<CampainListItemM>.from(
  //       response["DocList"].map((e) => CampainListItemM.fromJson(e)).toList());
  // }

  static Future<List<CampainListItemM>> getCampaginList({
    required BuildContext context,
    required String api_key,
  }) async {
    String url = "https://login.glowsis.com/campaign/findlist?api_key=$api_key";
    var response = await MyKey.postWithApiKey(url, {}, context);

    if (response != null && response.containsKey("DocList")) {
      return List<CampainListItemM>.from(
        (response["DocList"] as List<dynamic>?)
                ?.map((e) => CampainListItemM.fromJson(e))
                .toList() ??
            [],
      );
    } else {
      return [];
    }
  }

  static Future<CampaginResponseM> getCampainDetails({
    required BuildContext context,
    required String api_key,
    required String Sequence,
    required String RecNum,
  }) async {
    String url =
        "https://login.glowsis.com/campaign/find?api_key=$api_key&Sequence=$Sequence&RecNum=$RecNum";
    var response = await MyKey.postWithApiKey(url, {}, context);
    return CampaginResponseM.fromJson(response);
  }

  static Future insertNewLocation({
    // BuildContext context,
    required String api_key,
    required double lat,
    required double lan,
    required double accuracy,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/EmpLocationInsert?api_key=$api_key&lat=$lat&lan=$lan&accuracy=$accuracy";
    print("Url $url}");
    try {
      var response = await http.get(Uri.parse(url));
      print("response ${response.body}");
    } catch (e) {
      print("Error $e");
    }
  }

  static Future<List<EmpPositionM>> getRoutes({
    required BuildContext context,
    required String api_key,
    required String fromdate,
    required String Todate,
    required String EmpCode,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/EmpLocationFind?api_key=$api_key&fromdate=$fromdate&Todate=$Todate&EmpCode=$EmpCode";
    var response = await MyKey.postWithApiKey(url, {}, context);

    return List<EmpPositionM>.from(
        response["Details"].map((e) => EmpPositionM.fromJson(e)));
  }

  static Future<RouteEndM> routeBeginEnd({
    required String apiKey,
    required String routeId,
    required String empCode,
    required String latLng,
    required String date,
    required String beginEnd,
    required String location,
  }) async {
    String url =
        "https://login.glowsis.com/hrm/routeplan/BeginEnd/?api_key=$apiKey&RouteId=$routeId&EmpCode=$empCode&LAT_LAN=$latLng&Date=$date&Begin_End=$beginEnd&Location=$location";
    var response = await MyKey.postWithApiKey(url, {}, Get.context!);
    return RouteEndM.fromJson(response);
  }

  //for customerways sales report
  static Future<CustomerWaysSalesReportM> getCustomerwaysReport({
    required BuildContext context,
    required String apiKey,
    required String cvCode,
  }) async {
    String url =
        "https://login.glowsis.com/dashboardapp/cvsalesreport?api_key=$apiKey&CVCode=$cvCode";
    dynamic response = await MyKey.postWithApiKey(url, Map(), context);

    if (response != null && response["Table"] != null) {
      return CustomerWaysSalesReportM.fromJson(response);
    } else {
      // Handle the error or return a default value
      return CustomerWaysSalesReportM(table: []);
    }
  }
}
