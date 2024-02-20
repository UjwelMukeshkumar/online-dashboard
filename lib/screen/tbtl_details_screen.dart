import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/model/other/TbtlM.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:glowrpt/widget/other/line_headder_widget.dart';
import 'package:glowrpt/widget/other/line_item_widget.dart';
import 'package:glowrpt/widget/other/tbtl_item_widget.dart';

import '../model/other/DocM.dart';
import '../model/other/User.dart';

class TbtlDetailsScreen extends StatefulWidget {
  List<String> dateListLine;
  User selectedItem;
  HeadderParm headderParm;

  TbtlDetailsScreen({
    required this.dateListLine,
    required this.selectedItem,
    required this.headderParm,
  });

  @override
  _TbtlDetailsScreenState createState() => _TbtlDetailsScreenState();
}

class _TbtlDetailsScreenState extends State<TbtlDetailsScreen> {
  List<TbtlM> lines = [];
  String query = "";
  bool sortAccending = false;
  List<String> sortBy = ["sdfs"];

   List<TbtlM>? fullList;

  var responseData;

  @override
  void initState() {
    super.initState();
    updateLines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  updateLines();
                },
                intialText: widget.dateListLine[1],
              ),
            ),
            /*Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Search",
                        suffixIcon: Icon(
                          Icons.search,
                          size: 14,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                      ),
                      onChanged: (text) {
                        query = text;
                        filterLines();
                      },
                    ),
                  ),
                ),
              */ /*  Expanded(child: DropdownButton<String>(
                  items: [""],
                ),),*/ /*
                InkWell(
                    onTap: () {
                      sortAccending = !sortAccending;
                      filterLines();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 8,right:12,top: 8,bottom: 8),
                      child: Icon(Icons.sort,color: sortAccending?Colors.green:Colors.black45,),
                    ))
              ],
            ),*/
            if (responseData != null)
              Expanded(
                child: ListView.builder(
                    itemCount: lines.length,
                    itemBuilder: (context, position) {
                      var item = lines[position];
                      return TbtlItemWidget(
                        item: item,
                        position: position,
                      );
                    }),
              )
            else
              Expanded(
                  child: Center(
                child: CupertinoActivityIndicator(),
              ))
          ],
        ),
      ),
    );
  }

  Future<void> updateLines() async {
    if (widget.dateListLine.length < 2) return;
    responseData = await Serviece.getHomedocForHedder( 
      context,
      widget.selectedItem.apiKey,
      widget.dateListLine.first,
      widget.dateListLine.last,
      widget.headderParm.endPont,
      1,
      "",
      type: widget.headderParm.type.toString(),
    );
    if (responseData != null) {
      List lines = responseData["List"];
      fullList = lines.map((e) => TbtlM.fromJson(e)).toList();
    } else {
      responseData = Map();
    }
    filterLines();
  }

  void filterLines() {
    setState(() {
      lines.clear();
      if (query.isNotEmpty) {
        lines.addAll(fullList!.where((element) {
          return element.name.toLowerCase().contains(query);
        }));
      } else {
        lines.addAll(fullList!);
      }
      if (sortAccending) {
        lines.sort((first, second) =>
            first.name.toLowerCase().compareTo(second.name.toLowerCase()));
      }
    });
  }
}
