import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/other/line_headder_widget.dart';
import 'package:glowrpt/widget/other/line_item_widget.dart';
import 'package:loadmore/loadmore.dart';

import '../model/other/DocM.dart';
import '../model/other/User.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatefulWidget {
  List<String> dateListLine;
  User selectedItem;
  String type;
  String title;

  DetailsScreen({
    required this.dateListLine,
    required this.selectedItem,
    required this.title,
    this.type = "SL",
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String query = "";
  bool sortAccending = false;
  List<String> sortBy = ["sdfs"];
  int pageNo = 0;

  List<HeaderBean>? headder;

  List<LinesBean> itemList = [];

  bool hasMoreData = true;

  DocM? docM;

  List<LinesBean> sortedItemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
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
                  itemList.clear();
                  pageNo = 0;
                  hasMoreData = true;
                  setState(() {});
                },
                intialText: widget.dateListLine[1],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
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
                        itemList.clear();
                        hasMoreData = true;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                /*  Expanded(child: DropdownButton<String>(
                  items: [""],
                ),),*/
                InkWell(
                    onTap: () {
                      sortAccending = !sortAccending;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 8, right: 12, top: 8, bottom: 8),
                      child: Icon(
                        Icons.sort,
                        color: sortAccending ? Colors.green : Colors.black45,
                      ),
                    ))
              ],
            ),
            if(docM!=null)
            LineHeadderWidget(docM!),
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
                    itemCount: itemList.length,
                    itemBuilder: (context, position) {
                      var item;
                      if (sortAccending) {
                        item = sortedItemList[position];
                      } else {
                        item = itemList[position];
                      }
                      return LineItemWidget(
                        item: item,
                        position: position,
                        excludeGp: widget.title == "Purchase Order",
                        selectedItem: widget.selectedItem,
                        type: widget.type,
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> updateLines() async {
    // if (widget.dateListLine.length < 2) return;
    docM = await Serviece.getHomedoc(context, widget.selectedItem.apiKey,
        widget.dateListLine.first, widget.dateListLine.last, pageNo, query,
        type: widget.type);
    headder = docM!.Header;
    if (docM!.Lines.length > 0) {
      itemList.addAll(docM!.Lines);
    } else {
      hasMoreData = false;
    }
    sortedItemList.clear();
    sortedItemList.addAll(itemList);
    sortedItemList.sort((a, b) =>
        a.PartyName.toLowerCase().compareTo(b.PartyName.toLowerCase()));
    setState(() {});
    return true;
  }
}
