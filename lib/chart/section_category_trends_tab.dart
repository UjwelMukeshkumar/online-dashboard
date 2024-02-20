import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/chart/cat_section_chart.dart';
import 'package:glowrpt/model/trend/CatSecTrendM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SectionCategoryTrendsTab extends StatefulWidget {
  bool isCategory;
  String urlPart;
  int index;
  bool isSale;

  SectionCategoryTrendsTab(this.urlPart, this.index, this.isSale,
      {this.isCategory=false});

  @override
  _SectionCategoryTrendsTabState createState() =>
      _SectionCategoryTrendsTabState();
}

class _SectionCategoryTrendsTabState extends State<SectionCategoryTrendsTab> {
   CompanyRepository? companyRepo;

  CatSecTrendM? catSectionM;

  @override
  void initState() {

    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    // return Center(child: Text("Under Progress"),);
    return catSectionM != null
        ? Container(
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    "Top 10 ${widget.isCategory ? "Category".tr : "Section".tr}",
                    style: textTheme.headline6,
                  ),
                ),
                CatSectionChart(
                  catSectionM,
                ),
                ListTile(
                  title: Text(
                    "All ${widget.isCategory ? "Category".tr : "Section".tr}",
                    style: textTheme.headline6,
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: catSectionM?.Lists?.length,
                    itemBuilder: (context, position) {
                      var item = catSectionM?.Lists?[position];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Card(
                          margin: EdgeInsets.all(8),
                          // color: AppColor.background,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    item?.title,
                                    style: textTheme.subtitle1,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: ListTile(
                                      title: Text(
                                        "Total Sales".tr,
                                        style: textTheme.caption,
                                      ),
                                      subtitle: Text(
                                        MyKey.currencyFromat(
                                            item?.amount.toString(),
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
                                      title: Text("Gross Profit".tr,
                                          style: textTheme.caption),
                                      subtitle: Text(
                                          "${item?.GPPercent?.toInt()}%",
                                          style: textTheme.headline6),
                                    )),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: RichText(
                                      text: TextSpan(
                                          text:
                                              "${item?.title} has contributed ",
                                          style: textTheme.caption,
                                          children: [
                                        TextSpan(
                                          text:
                                              "${item?.SalesPercentage?.toInt()}% ",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: "of total sale")
                                      ])),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          )
        : Center(
            child: CupertinoActivityIndicator(),
          );
  }

  // Future<void> loadData() async {
  //   var date2 = getData(widget.index);
  //   print("Date 2 $date2");
  //   //return;
  //   catSectionM = await Serviece.SalseSectionTrend(
  //       context: context,
  //       api_key: companyRepo!.getSelectedApiKey(),
  //       endPoint: widget.isCategory ? "CATT" : "SCT",
  //       fromDate: date2,
  //       urlEndPart: widget.urlPart);

  //   if (mounted) setState(() {});
  // }
  Future<void> loadData() async {
    var date2 = getData(widget.index);
    print("Date 2: $date2");

    // Check for null or zero value in date2
    if (date2 == null || date2 == 0) {
      print("Error: Date 2 is null or zero.");
      return;
    }

    catSectionM = await Serviece.SalseSectionTrend(
        context: context,
        api_key: companyRepo!.getSelectedApiKey(),
        endPoint: widget.isCategory ? "CATT" : "SCT",
        fromDate: date2,
        urlEndPart: widget.urlPart);

    if (mounted) setState(() {});
  }
}
