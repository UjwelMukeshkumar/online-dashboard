import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
// import 'package:glowrpt/chart/section_category_trends_tab.dart';
// import 'package:glowrpt/model/other/CatM.dart';
import 'package:glowrpt/model/other/CatSectionM.dart';
// import 'package:glowrpt/model/other/HedderParams.dart';
// import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/repo/SettingsManagerRepository.dart';
import 'package:glowrpt/screen/dashboards/sales/fulllist/category_list_screen.dart';
import 'package:glowrpt/screen/dashboards/sales/item_with_gp_screeen.dart';
import 'package:glowrpt/screen/salestrends/section_cat_trends_screen.dart';
import 'package:glowrpt/service/DateService.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/cat_section_item.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

// class CategoryListWidget extends StatefulWidget {
// ignore: must_be_immutable
class CategoryListWidget extends StatefulWidget {
  bool isSale;

  CategoryListWidget(this.isSale);

  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget>
    with AutomaticKeepAliveClientMixin {
   SettingsManagerRepository? settings;
  List<CatSectionM> linesList = [];
   List<String>? dateListLine;

  int viewpageNum = 0;
  int numOfItemPerPage = 5;
  num totalPages = 1;
  int apiPageNumber = 0;
  num numberOfBills = 0;
  var controllre = PageController(keepPage: true, initialPage: 0);

  var dateFormater = DateFormat("dd/MM/yyyy");
  var date = DateTime.now();
   int? time;
   CompanyRepository? compRepo;

  String dateRangeText = "Today";

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    settings = Provider.of<SettingsManagerRepository>(context);
    compRepo = Provider.of<CompanyRepository>(context);
    if (dateListLine == null) dateListLine = MyKey.getDefaultDateListAsToday();
    updateLines();
  }

  @override
  // Widget build(BuildContext context) {
  Widget build(BuildContext context) {
    super.build(context);
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (linesList != null) ...[
        ...[
        DaysSelectorWidget(
          trendTitle: "Category Trends".tr,
          valueChanged: (list) {
            dateListLine = list;
            resetDataWhenDateOrCompanyChange();
            updateLines();
          },
          intialText: dateRangeText,
          controllInitialTextAndDateList: true,
          dateRangeText: (text) {
            dateRangeText = text;
          },
          trendTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SectionCatTrendsScreen(
                          isCategory: true,
                        )));
          },
        ),
        InkWell(
          onTap: openCategoryScren,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text("No of Categories".tr, style: textTheme.overline),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child:
                    Text("${linesList.length}", style: textTheme.subtitle2),
              ),
            ],
          ),
        ),
        if (linesList.isNotEmpty) ...[
          ExpandablePageView(
            controller: controllre,
            // key: key,
            onPageChanged: (pageNumber) {
              setState(() {
                viewpageNum = pageNumber;
              });
              updateLines();
            },

            children: List.generate((numberOfBills / numOfItemPerPage).ceil(),
                (pageIndex) {
              return Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: (linesList.length -
                                  (viewpageNum) * numOfItemPerPage) >=
                              numOfItemPerPage
                          ? numOfItemPerPage
                          : (linesList.length -
                              (viewpageNum) * numOfItemPerPage),
                      itemBuilder: (context, position) {
                        var index =
                            ((viewpageNum) * numOfItemPerPage) + position;
                        var item = linesList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemWithGpScreeen(
                                          item: item,
                                          type: DocType.category,
                                          id: item.id,
                                          dateList: dateListLine,
                                          isSale: widget.isSale,
                                        )));
                          },
                          child: CatSectionItem(
                            position: position,
                            item: item,
                            type: DocType.category,
                            apiKey: compRepo!.getSelectedApiKey(),
                          ),
                        );
                      }),
                  Align(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: previusDay,
                            icon: Icon(
                              Icons.arrow_left,
                              color: AppColor.title,
                            )),
                        Visibility(
                            visible: numberOfBills > 0,
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // controllre?.previousPage(
                                          controllre.previousPage(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeIn);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: 18,
                                        )),
                                    Text(
                                      "${viewpageNum + 1}/${(numberOfBills / numOfItemPerPage).ceil()}",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          // controllre?.nextPage(
                                          controllre.nextPage(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeIn);
                                        },
                                        icon: Icon(Icons.arrow_forward_ios,
                                            size: 18)),
                                  ],
                                )
                              ],
                            )),
                        IconButton(
                            onPressed: nextDay,
                            icon: Icon(
                              Icons.arrow_right,
                              color: AppColor.title,
                            )),
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                ],
              );
            }),
          ),
        ],
      ]
      ],
    );
  }

  void previusDay() {
    var newDate = MyKey.displayDateFormat.format(MyKey.displayDateFormat
        .parse(dateListLine!.first)
        .subtract(Duration(days: 1)));
    dateListLine = [newDate, newDate];

    setCustomDateText();
  }

  void nextDay() {
    var newDate = MyKey.displayDateFormat.format(MyKey.displayDateFormat
        .parse(dateListLine!.first)
        .add(Duration(days: 1)));
    dateListLine = [newDate, newDate];
    setCustomDateText();
  }

  setCustomDateText() {
    int diff = DateService.dayDifference(
        MyKey.displayDateFormat.parse(dateListLine!.first));
    if (diff == 0) {
      dateRangeText = "Today";
    } else if (diff == -1) {
      dateRangeText = "Yesterday";
    } else {
      var date = MyKey.displayDateFormat.parse(dateListLine!.first);
      var sort = DateFormat("dd/MM");
      dateRangeText = "Date Range\n${sort.format(date)} - ${sort.format(date)}";
    }
    resetDataWhenDateOrCompanyChange();
    updateLines();
    setState(() {});
  }

  Future<void> updateLines() async {
    if (time != compRepo!.conpanySwichedAt) {
      resetDataWhenDateOrCompanyChange();
    }
    time = compRepo?.conpanySwichedAt;
    if (!isLastPage(
        linesList: linesList,
        numOfItemPerPage: numOfItemPerPage,
        viewpageNum: viewpageNum)) return;
    apiPageNumber++;
    // docM = null;
    if (dateListLine!.length < 2) return;
    if (settings!.category) {
      var data = await Serviece.getCategory(
          context,
          compRepo!.getSelectedApiKey(),
          dateListLine!.first,
          dateListLine!.last,
          dateRangeText,
          apiPageNumber,
          "",
          endPont: widget.isSale ? "CAT" : "PRCAT");
      var lise = List<CatSectionM>.from(
          data["List"].map((x) => CatSectionM.fromJson(x)));
      totalPages = double.parse(data["PageNo"][0]["PageNo"].toString()).toInt();
      numberOfBills = int.parse(data["PageNo"][0]["Total Item"].toString());
      linesList.addAll(lise);
    }
    if (mounted) setState(() {});
    controllre = PageController(keepPage: true, initialPage: viewpageNum);
  }

  @override
  bool get wantKeepAlive => true;

  void resetDataWhenDateOrCompanyChange() {
    linesList.clear();
    viewpageNum = 0;
    apiPageNumber = 0;
    controllre = PageController(keepPage: true, initialPage: 0);
  }

  void openCategoryScren() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoryListScreen(
                  isSale: widget.isSale,
                  dateListLine: dateListLine,
                )));
  }
}
