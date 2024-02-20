import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/DashM.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/attandance/BranchAttandanceScreen.dart';
import 'package:glowrpt/screen/branchdetails/BranchWiseDetailsScreen.dart';
import 'package:glowrpt/screen/loginsignup/auto_login_screen.dart';
import 'package:glowrpt/screen/route/routes_screen_orderable.dart';
import 'package:glowrpt/screen/route/select_route_screen1.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/manager/text_tile_widget.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../print/web_view_page.dart';
import 'package:get/get.dart';

// import 'dart:html' as html;
class TotalBranchDetailsWidget extends StatefulWidget {
  @override
  State<TotalBranchDetailsWidget> createState() =>
      _TotalBranchDetailsWidgetState();
}

class _TotalBranchDetailsWidgetState extends State<TotalBranchDetailsWidget> {
   DashM? data;

   CompanyRepository? companyRep;

   List<String>? dateListHeader;

   String? dtRange;

  @override
  void initState() {
    super.initState();
    companyRep = Provider.of<CompanyRepository>(context, listen: false);
    dateListHeader = MyKey.getDefaultDateListAsToday();
    updateHeadder();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              TextTileWidget(
                title: "Consolidated Attendance from all branches".tr,
                ontap: openAllBranchAttandance,
              ),
              Visibility(
                visible: (double.tryParse(data?.totalPresent ?? "0") ?? 0) > 0,
                maintainAnimation: true,
                maintainState: true,
                child: InkWell(
                  onTap: openAllBranchAttandance,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("Present".tr, style: textTheme.caption),
                                  Text(
                                    (data?.totalPresent ?? "").toString(),
                                    style: textTheme.headline6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Absent".tr,
                                    style: textTheme.caption,
                                  ),
                                  Text((data?.totalAbsent ?? "").toString(),
                                      // "GP ${data?.gp}%",
                                      style: textTheme.headline6),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: DaysSelectorWidget(
                  trendTitle: "",
                  valueChanged: (list) {
                    dateListHeader = list;
                    updateHeadder();
                  },
                  dateRangeText: (text) {
                    dtRange = text;
                  },
                ),
              ),
              TextTileWidget(
                  title: "Consolidated revenue from branches".tr,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BranchWiseDetailsScreen()));
                  }),
              Container(
                padding: EdgeInsets.only(bottom: 16),
                margin: containerMargin,
                decoration: containerDecoration,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: ListTile(
                          title: Text("Total Sales".tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            MyKey.currencyFromat(
                                data?.Amount.toString() ?? "0",
                                decimmalPlace: 2),
                            style: textTheme.headline6,
                          ),
                        )),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.black12,
                        ),
                        Expanded(
                            child: ListTile(
                          title: Text("Gross Profit".tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              "${MyKey.currencyFromat(data?.GP.toString(), sign: "", decimmalPlace: 0)}%",
                              style: textTheme.headline6),
                        )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: RichText(
                          text: TextSpan(
                              text:
                                  "${double.parse((data?.AmountCmp ?? "0").replaceAll(",", "")) > 0 ? "Great you have ".tr : "You".tr} sold for "
                                      .tr,
                              style: textTheme.caption,
                              children: [
                            TextSpan(
                                text:
                                    "${MyKey.currencyFromat(data?.AmountCmp.toString() ?? "0", decimmalPlace: 0)} ${double.parse((data?.AmountCmp ?? "0").replaceAll(",", "")) >= 0 ? 'More'.tr : 'Less'.tr}",
                                style: TextStyle(
                                    color: double.parse((data?.AmountCmp ?? "0")
                                                .replaceAll(",", "")) >
                                            0
                                        ? AppColor.notificationBackgroud
                                        : AppColor.red)),
                            TextSpan(
                                text:
                                    ", ${MyKey.currencyFromat(data?.Gpcmp.toString() ?? "0", decimmalPlace: 0, sign: "")}% ${double.parse((data?.Gpcmp ?? "0").replaceAll(",", "")) >= 0 ? 'More'.tr : 'Less'.tr} ",
                                style: TextStyle(
                                    color: double.parse((data?.Gpcmp ?? "0")
                                                .replaceAll(",", "")) >
                                            0
                                        ? AppColor.notificationBackgroud
                                        : AppColor.red)),
                            TextSpan(
                                text:
                                    "gross profit compared to same day last week"
                                        .tr)
                          ])),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Visibility(
              visible: data == null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(),
              ))
        ],
      ),
    );
  }



  Future<DashM?> updateHeadder() async {
    print("updateHeadder1");
    setState(() {
      data = null;
    });
    if (dateListHeader!.length < 2) return null;

    var basicResponse = await Serviece.getHomeLoad(
      context,
      companyRep!.getAllApiKeys(),
      dateListHeader!.first,
      dateListHeader!.last,
      dtRange.toString(),
    );

    if (!basicResponse.error) {
      data = DashM.fromJson(basicResponse.data[0]);
      setState(() {});
      return data!;
    } else {
      if (basicResponse.message == "Session Timed Out") {
        Toast.show(basicResponse.message);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AutoLoginScreen()));
      } else {
        Toast.show(basicResponse.message + "homeload");
      }
    }

    if (mounted) setState(() {});

    // Handle the case where no valid value can be returned.
    return null;
  }


  // Future<DashM> updateHeadder() async {
  //   print("updateHeadder1");
  //   setState(() {
  //     data = null;
  //   });
  //   if (dateListHeader.length < 2) return null;

  //   var basicResponse = await Serviece.getHomeLoad(
  //       context,
  //       companyRep.getAllApiKeys(),
  //       dateListHeader.first,
  //       dateListHeader.last,
  //       dtRange!);
  //   if (!basicResponse.error) {
  //     data = DashM.fromJson(basicResponse.data[0]);
  //     setState(() {});
  //     return data!;
  //   } else {
  //     if (basicResponse.message == "Session Timed Out") {
  //       Toast.show(basicResponse.message);
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => AutoLoginScreen()));
  //     } else {
  //       Toast.show(basicResponse.message + " homeload");
  //     }
  //   }

  //   if (mounted) setState(() {});
  // }

  void openAllBranchAttandance() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BranchAttandanceScreen(
                  apiKeys: companyRep!.getAllApiKeys(),
                  fromDate: dateListHeader!.first,
                  todate: dateListHeader!.last,
                  headderParm: HeadderParm(
                      displayType: DisplayType.gridType,
                      title: "Attendance Details".tr,
                      endPont: "BRAB",
                      paramsFlex: [1, 2]),
                )));
  }
}
