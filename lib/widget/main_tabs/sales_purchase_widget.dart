// import 'package:carousel_pro/carousel_pro.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/sales/fulllist/sales_list_screen.dart';
import 'package:glowrpt/screen/salestrends/sales_trends_screen.dart';
import 'package:glowrpt/service/DateService.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/other/line_headder_widget.dart';
import 'package:glowrpt/widget/other/line_item_widget.dart';
// import 'package:glowrpt/widget/other/size_reporting_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SalesPurchaseWidget extends StatefulWidget {
  bool isSale;

  SalesPurchaseWidget(this.isSale);

  @override
  _SalesPurchaseWidgetState createState() => _SalesPurchaseWidgetState();
}

class _SalesPurchaseWidgetState extends State<SalesPurchaseWidget>
    with AutomaticKeepAliveClientMixin {
  bool isExpandFirstTable = false;
  DocM? docM;

  CompanyRepository? compRepo;

  List<String>? dateListLine;

  int viewpageNum = 0;
  int numOfItemPerPage = 5;

  List<LinesBean> linesList = [];

  num totalPages = 1;

  int apiPageNumber = 0;

  num numberOfBills = 0;
  var controllre = PageController(keepPage: true, initialPage: 0);

  int? time;

  var dateRangeText;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    compRepo = Provider.of<CompanyRepository>(context);
    if (dateListLine == null) dateListLine = MyKey.getDefaultDateListAsToday();
    updateLines();
  }

  @override
  Widget build(BuildContext context) {
    // print("sales list line :$linesList");
    super.build(context);
    // print("Loading Data ${docM?.Lines != null} bills ${(numberOfBills??0) > 0} ");
    return SingleChildScrollView(
      child: Column(
        children: [
          DaysSelectorWidget(
            trendTitle: widget.isSale ? "Sales Trends" : "Purchase Trends",
            valueChanged: (list) {
              dateListLine = list;
              resetDataWhenDateOrCompanyChange();
              updateLines();
            },
            trendTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalesTrendsScreen(
                            isSale: widget.isSale,
                            selectedComp: compRepo!.getSelectedUser(),
                          )));
            },
            dateRangeText: (text) {
              dateRangeText = text;
            },
            intialText: dateRangeText,
            controllInitialTextAndDateList: true,
          ),
          docM!=null?
          LineHeadderWidget(
            docM!,
            onTap: openListScreen,
          ):CupertinoActivityIndicator(),
          if (numberOfBills > 0) ...[
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
                return ListView.builder(
                
                
                  
                   shrinkWrap: true,
                   physics: ScrollPhysics(),
                   itemCount: (linesList.length -
                               (viewpageNum) * numOfItemPerPage) >=
                           numOfItemPerPage
                       ? numOfItemPerPage
                       : (linesList.length - (viewpageNum) * numOfItemPerPage),
                   itemBuilder: (context, position) {
                     var index = ((viewpageNum) * numOfItemPerPage) + position;
                     var item = linesList[index];
                     return LineItemWidget(
                       item: item,
                       position: position,
                       excludeGp: false,
                       selectedItem: compRepo!.getSelectedUser(),
                       //type: widget.isSale ? "SI" : "PI", //todo change type
                       type: item.Type,
                     );
                   },
                 );
              }),
            ),
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
          ]
        ],
      ),
    );
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
    docM = null;
    if (dateListLine!.length < 2) return;

    // Fetch data from the service
    docM = await Serviece.getHomedoc(context, compRepo!.getSelectedApiKey(),
        dateListLine!.first, dateListLine!.last, apiPageNumber, "",
        endPont: widget.isSale ? "homedoc" : "prdoc", PageSize: 100);

    // Check if docM is not null and Header is not empty
    if (docM != null && docM!.Header != null && docM!.Header!.isNotEmpty) {
      totalPages = docM!.Header!.first.PageNo;
      numberOfBills = docM!.Header!.first.BillNo;
    } else {
      // Handle the case where docM, Header, or first is null
      // You might want to log a message or handle this situation accordingly
      print("Error: Missing data in docM or Header");
      return;
    }

    linesList.addAll(docM!.Lines);
    if (mounted) setState(() {});
    controllre = PageController(keepPage: true, initialPage: viewpageNum);
  }

  // Future<void> updateLines() async {
  //   if (time != compRepo?.conpanySwichedAt) {
  //     resetDataWhenDateOrCompanyChange();
  //   }
  //   time = compRepo?.conpanySwichedAt;
  //   if (!isLastPage(
  //       linesList: linesList,
  //       numOfItemPerPage: numOfItemPerPage,
  //       viewpageNum: viewpageNum)) return;
  //   apiPageNumber++;
  //   docM = null;
  //   if (dateListLine!.length < 2) return;
  //   docM = await Serviece.getHomedoc(context, compRepo!.getSelectedApiKey(),
  //       dateListLine!.first, dateListLine!.last, apiPageNumber, "",
  //       endPont: widget.isSale ? "homedoc" : "prdoc", PageSize: 100);
  //   totalPages = docM!.Header!.first.PageNo;
  //   numberOfBills = docM!.Header!.first.BillNo;
  //   linesList.addAll(docM!.Lines);
  //   if (mounted) setState(() {});
  //   controllre = PageController(keepPage: true, initialPage: viewpageNum);
  // }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void resetDataWhenDateOrCompanyChange() {
    linesList.clear();
    viewpageNum = 0;
    apiPageNumber = 0;
    controllre = PageController(keepPage: true, initialPage: 0);
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

  void openListScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SalesListScreen(
                  isSale: widget.isSale,
                  dateListLine: dateListLine,
                )));
  }
}
