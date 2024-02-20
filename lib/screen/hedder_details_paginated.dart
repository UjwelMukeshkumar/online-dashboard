import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/other/flexible_widget.dart';
import 'package:glowrpt/widget/other/headder_item_widget.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import '../model/other/User.dart';
import 'package:get/get.dart';

class HeadderDetailsPaginated extends StatefulWidget {
  List<String> dateListLine;
  User? selectedUserRemoveMe;
  HeadderParm headderParm;
  bool showDetails;

  HeadderDetailsPaginated({
    required this.dateListLine,
   this.selectedUserRemoveMe,
    required this.headderParm,
    this.showDetails = false,
  });

  @override
  _HeadderDetailsPaginatedState createState() =>
      _HeadderDetailsPaginatedState();
}

class _HeadderDetailsPaginatedState extends State<HeadderDetailsPaginated> {
  Map? dataSet;

  List heaDerList = [];
  bool hasMoreData = true;
  int pageNo = 0;

  String query = "";

  Map? totalMap;

  CompanyRepository? companyRepo;

  @override
  void initState() {
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.chartBacground,
      appBar: AppBar(
        title: Text("${widget.headderParm.title}"),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: DaysSelectorWidget(
                valueChanged: (list) {
                  widget.dateListLine = list;
                  heaDerList.clear();
                  pageNo = 0;
                  hasMoreData = true;
                  setState(() {});
                },
                intialText: widget.dateListLine[1],
              ),
            ),
            Container(
              height: 40,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search".tr,
                  suffixIcon: Icon(
                    Icons.search,
                    size: 14,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                ),
                onSubmitted: (text) async {
                  print("One submit");
                  query = text.toLowerCase();
                  pageNo = 0;
                  heaDerList.clear();
                  hasMoreData = true;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: LoadMore(
                isFinish: !hasMoreData,
                onLoadMore: () async {
                  pageNo++;
                  var bool = await updateLines();
                  return bool;
                },
                textBuilder: (statue) {
                  if (statue == LoadMoreStatus.loading) {
                    return "Please wait";
                  } else if (statue == LoadMoreStatus.nomore) {
                    return "No More items";
                  } else if (statue == LoadMoreStatus.fail) {
                    return "Failed";
                  } else if (statue == LoadMoreStatus.idle) {
                    return "Ideal";
                  }
                  return "";
                },
                child: ListView.builder(
                    itemCount: heaDerList.length,
                    itemBuilder: (context, position) {
                      Map item = heaDerList[position];
                      return FlexibleWidget(
                        item: item,
                        headderParm: widget.headderParm,
                        position: position,
                      );
                    }),
              ),
            ),
            if (totalMap != null) ...[getFooterWidget(textTheme)]
          ],
        ),
      ),
    );
  }

  Future<bool> updateLines() async {
    dataSet = await Serviece.getHomedocForHedder(
      context,
      companyRepo!.getSelectedApiKey(),
      widget.dateListLine.first,
      widget.dateListLine.last,
      widget.headderParm.endPont,
      pageNo,
      query,
      params: widget.headderParm.params,
      type: widget.headderParm.type.toString(),
      // details: widget.showDetails ? "Y" : null,
      details: widget.showDetails ? "Y" : "",
    );
    if (dataSet != null) {
      List dataList = dataSet?[widget.headderParm.tableName];
      try {
        totalMap = dataSet?["Total"][0];
      } catch (e) {
        // totalMap=0;
        print(e);
      }

      hasMoreData = dataList.length > 0;
      heaDerList.addAll(dataList);
    }
    setState(() {});
    return hasMoreData;
  }

  getValue(int position, var key, List<String> summationField) {
    bool toCalculate = widget.headderParm.summationField!.contains(key);
    if (position == 0) {
      return "Total";
    } else if (toCalculate) {
      return heaDerList
          .map((h) => h[key])
          .fold(0.0, (value, element) => value + element);
    } else {
      return "";
    }
  }

  getFooterWidget(TextTheme textTheme) {
    if (widget.headderParm.displayType == DisplayType.rowType) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: HedderItemWidget(
            headderParm: widget.headderParm,
            position: 0,
            isGrand: true,
            item: totalMap!.map((key, value) {
              return MapEntry(value,
                  getValue(key, value, widget.headderParm.summationField!));
            }),
          ),
        ),
      );
    } else {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: totalMap!.keys
                .map((e) =>
                    // int position=widget.summationFileld.indexOf(e);
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            "$e",
                            style: textTheme.subtitle1,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              /* MyKey.currencyFromat(heaDerList
                                  .map((h) => h[e])
                                  .fold(0, (value, element) => value + element)
                                  .toString())*/
                              "${MyKey.currencyFromat(totalMap![e].toString(), decimmalPlace: 0)}",
                              style: textTheme.headline6,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        )
                      ],
                    ))
                .toList(),
          ),
        ),
      );
    }
  }
}
