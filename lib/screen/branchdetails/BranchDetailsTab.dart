import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/library/DateFactory.dart';
import 'package:glowrpt/model/other/AnalaticsM.dart';
import 'package:glowrpt/model/other/ConsolidationM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';

import '../../widget/manager/branch_detail/AnalaticsItem.dart';
import 'package:get/get.dart';

class BranchDetailsTab extends StatefulWidget {
  String fromDate;
  String toDate;
  int position;

  BranchDetailsTab({
    required this.position,
    required this.fromDate,
    required this.toDate,
  });

  @override
  _BranchDetailsTabState createState() => _BranchDetailsTabState();
}

class _BranchDetailsTabState extends State<BranchDetailsTab> {
  List? attandanceList;

  late CompanyRepository companyRepo;

  late ConsolidationM consolidate;

  bool isSale = true;
  List<String> items = ["Sale".tr, "Gp".tr];
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = items.first;
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    if (widget.position == 8) {
      Future.delayed(Duration.zero, () {
        getDateRange();
      });
    } else {
      loadDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    if (attandanceList != null) {
      return ListView(
        children: [
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
                      title: Text("Total".tr),
                      subtitle: Text(
                        MyKey.currencyFromat(consolidate.SalesAmount,
                            decimmalPlace: 0),
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
                      title: Text("Gross Profit".tr),
                      subtitle: Text(
                          "${MyKey.currencyFromat(consolidate.TotalGP.toString(), sign: "", decimmalPlace: 0)}%",
                          style: textTheme.headline6),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                      text: TextSpan(
                          text:
                              "${double.parse((consolidate.SalesAmountCmp ?? "0").replaceAll(",", "")) > 0 ? "Great you have ".tr : "You  ".tr} sold for "
                                  .tr,
                          style: textTheme.caption,
                          children: [
                        TextSpan(
                            text:
                                "${MyKey.currencyFromat(consolidate.SalesAmountCmp.toString() ?? "0", decimmalPlace: 0)} ${double.parse((consolidate?.SalesAmountCmp ?? "0").replaceAll(",", "")) >= 0 ? 'More'.tr : 'Less'.tr}",
                            style: TextStyle(
                                color: double.parse(
                                            (consolidate.SalesAmountCmp ?? "0")
                                                .replaceAll(",", "")) >
                                        0
                                    ? AppColor.notificationBackgroud
                                    : AppColor.red)),
                        TextSpan(
                            text:
                                ", ${MyKey.currencyFromat(consolidate.SalesGpcmp.toString() ?? "0", decimmalPlace: 0, sign: "")}% ${double.parse((consolidate.SalesGpcmp ?? "0").replaceAll(",", "")) >= 0 ? 'More'.tr : 'Less'.tr} ",
                            style: TextStyle(
                                color: double.parse(
                                            (consolidate.SalesGpcmp ?? "0")
                                                .replaceAll(",", "")) >
                                        0
                                    ? AppColor.notificationBackgroud
                                    : AppColor.red)),
                        TextSpan(
                            text: "gross profit compared to same day last week"
                                .tr)
                      ])),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: attandanceList?.length,
                      itemBuilder: (context, postion) {
                        var item = attandanceList?[postion];
                        var analaticsM = AnalaticsM.fromJson(item);
                        return AnalaticsItem(
                          analaticsM,
                          widget.position,
                          companyRepo,
                          consolidate,
                          isSale = selectedItem == items.first,
                          () => loadDetails(),
                        );
                      }),
                ),
                Positioned(
                  top: 0,
                  right: 20,
                  child: RadioGroup<String>.builder(
                    groupValue: selectedItem,
                    direction: Axis.horizontal,
                    onChanged: (value) => setState(() {
                      selectedItem = value ?? "";
                      loadDetails();
                    }),
                    items: items,
                    itemBuilder: (item) => RadioButtonBuilder(item),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
      //       ],
      //         )
      //       ],
      //     ),
      //   ),
      // );
    } else {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
  }

  Future<void> loadDetails() async {
    var response = await Serviece.getBranchBrsg(
        context: context,
        arryApiKey: companyRepo.getAllApiKeys(),
        fromDate: widget.fromDate,
        toDate: widget.toDate,
        DtRange: "${tabs[widget.position - 1]}",
        endPont: "BRSG${selectedItem == items.last ? "/profit" : ""}");
    attandanceList = List.from(response["Details"]);
    consolidate =
        ConsolidationM.fromJson(List.from(response["Consolidation"])[0]);
    setState(() {});
  }
  // Future<void> loadDetails() async {
  //   var response = await Serviece.getBranchBrsg(
  //     context: context,
  //     arryApiKey: companyRepo.getAllApiKeys(),
  //     fromDate: widget.fromDate,
  //     toDate: widget.toDate,
  //     DtRange: "${tabs[widget.position - 1]}",
  //     endPont: "BRSG${selectedItem == items.last ? "/profit" : ""}",
  //   );

  //   if (response != null) {
  //     attandanceList = List.from(response["Details"] ?? []);
  //     if (response["Consolidation"] != null &&
  //         response["Consolidation"].isNotEmpty) {
  //       consolidate =
  //           ConsolidationM.fromJson(List.from(response["Consolidation"]!)[0]);
  //     }
  //     setState(() {});
  //   }
  // }

  Future<void> getDateRange() async {
    print("Screen position ${widget.position}");
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1021, 1, 1),
      helpText: 'Select a Date or Date-Range',
      fieldStartHintText: 'Start Booking date',
      fieldEndHintText: 'End Booking date',
      lastDate: DateTime(2025, 1, 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null) {
      widget.toDate = picked.end.asString;
      widget.fromDate = picked.start.asString;
      loadDetails();
    }
    // widget.toDate = picked!.end.asString;
    // widget.fromDate = picked.start.asString;
    // loadDetails();
  }
}
