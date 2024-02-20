import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/party/PartyGroupM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/repo/SettingsManagerRepository.dart';
import 'package:glowrpt/screen/dashboards/sales/fulllist/tax_list_screen.dart';
import 'package:glowrpt/service/DateService.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/other/party_group_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// class TaxcodeListWidget extends StatefulWidget {
// ignore: must_be_immutable
class TaxcodeListWidget extends StatefulWidget {
  bool isSale;

  TaxcodeListWidget(this.isSale);

  @override
  _TaxcodeListWidgetState createState() => _TaxcodeListWidgetState();
}

class _TaxcodeListWidgetState extends State<TaxcodeListWidget>
    with AutomaticKeepAliveClientMixin {
   SettingsManagerRepository? settings;
  List linesList = [];
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
          // trendTitle: "Category Trends",
          valueChanged: (list) {
            dateListLine = list;
            resetDataWhenDateOrCompanyChange();
            updateLines();
          },
          dateRangeText: (text) {
            dateRangeText = text;
          },
          intialText: dateRangeText,
          controllInitialTextAndDateList: true,
          trendTap: () {
          /*  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SectionCatTrendsScreen(
                          isCategory: true,
                        )));*/
          },
        ),
        InkWell(
          onTap: openTaxScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text("No of Tax Code", style: textTheme.overline),
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
                           /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemWithGpScreeen(
                                          item: item,
                                          type: DocType.category,
                                          id: item.id,
                                          dateList: dateListLine,
                                          isSale: widget.isSale,
                                        )));*/
                          },
                            child: PartyGroupItem(
                              position: position,
                              item: PartyGroupM.fromJson(item),
                              // type: DocType.section,
                              apiKey: compRepo!.getSelectedApiKey(),
                            )
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
                                              duration: Duration(milliseconds: 300),
                                              curve: Curves.easeIn);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: 18,
                                        )),
                                    Text(
                                      "${viewpageNum + 1}/${(numberOfBills / numOfItemPerPage).ceil()}",
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          // controllre?.nextPage(
                                          controllre.nextPage(
                                              duration: Duration(milliseconds: 300),
                                              curve: Curves.easeIn);
                                        },
                                        icon: Icon(Icons.arrow_forward_ios, size: 18)),
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
    if (time != compRepo?.conpanySwichedAt) {
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
      var data = await Serviece.getTaxcodeDetails(
        context: context,
        api_key:  compRepo!.getSelectedApiKey(),
        FromDate:  dateListLine!.first,
        ToDate:  dateListLine!.last,
        dateRangeText:  dateRangeText,
        apiPageNumber:  apiPageNumber,);
     List list=data["List"];
      totalPages = double.parse(data["PageNo"][0]["PageNo"].toString());
      numberOfBills = int.parse(data["PageNo"][0]["Total Item"].toString());
      linesList.addAll(list);
    }
    if (mounted) setState(() {});
    controllre = PageController(keepPage: true, initialPage: viewpageNum);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void resetDataWhenDateOrCompanyChange() {
    linesList.clear();
    viewpageNum = 0;
    apiPageNumber = 0;
    controllre = PageController(keepPage: true, initialPage: 0);
  }

  void openTaxScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TaxListScreen(isSale: widget.isSale,dateListLine: dateListLine,dateRangeText: dateRangeText,)));
  }
}
