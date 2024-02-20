import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/sales_documents_screen.dart';
import 'package:glowrpt/screen/transaction_details.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class DocApprovePaginated extends StatefulWidget {
  String DocType;
  String title;

  DocApprovePaginated({
    required this.DocType,
    required this.title,
  });

  @override
  _DocApprovePaginatedState createState() => _DocApprovePaginatedState();
}

class _DocApprovePaginatedState extends State<DocApprovePaginated> {
  Map? dataSet;

  List heaDerList = [];
  bool hasMoreData = true;
  int pageNo = 0;

  String query = "";

  Map? totalMap;
  int? time;
  CompanyRepository? compRepo;

  // List<String> dateList;
  int viewpageNum = 0;
  int numOfItemPerPage = 2;

  List linesList = [];

  num totalPages = 1;

  int apiPageNumber = 0;

  num numberOfBills = 0;

  var controllre = PageController(keepPage: true, initialPage: 0);
  List<String>? dateListLine;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    compRepo = Provider.of<CompanyRepository>(context);
    if (dateListLine == null) dateListLine = MyKey.getDefaultDateListAsToday();
    updateLines();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title.tr,
                  style: textTheme.subtitle1,
                ),
              )),

// Container(
//             width: double.infinity,
//             child: DaysSelectorWidget(
//               valueChanged: (list) {
//                 if (dateListLine != null && dateListLine!.length > 1) {
//                   dateListLine = list;
//                   linesList.clear();
//                   pageNo = 0;
//                   apiPageNumber = 0;
//                   hasMoreData = true;
//                   updateLines();
//                 } else {
//                   // Handle the case where dateListLine is null or has fewer than 2 elements.
//                   // You may show an error message or take appropriate action.
//                 }
//               },
//               initialText: dateListLine != null && dateListLine!.length > 1
//                   ? dateListLine![1]
//                   : '', // Provide a default value if dateListLine is null or insufficient.
//             ),
//           ),

          // dateListLine!=null? 
          Container(
                  width: double.infinity,
                  child: DaysSelectorWidget(
                    valueChanged: (list) {
                      dateListLine = list;
                      linesList.clear();
                      pageNo = 0;
                      apiPageNumber = 0;
                      hasMoreData = true;
                      updateLines();
                    },
                     intialText: dateListLine![1],
                    // intialText: dateListLine != null && dateListLine!.length > 1
                    //     ? dateListLine![1]
                    //     : '',
                  )
                ),
          Text(widget.DocType),
          if ((numberOfBills / numOfItemPerPage).ceil() > 0) ...[
            ExpandablePageView(
              controller: controllre,
              // key: key,
              onPageChanged: (pageNumber) {
                setState(() {
                  viewpageNum = pageNumber;
                });
                updateLines();
              },
              children: List.generate(
                (numberOfBills / numOfItemPerPage).ceil(),
                (pageIndex) {
                  // return Text("Hello");
                  return ListView.builder(
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
                        Map item = linesList[index];
                        String document = item["DM"];
                        String sequence = document.split("/").first;
                        String recNumber =
                            (document.split("/").last).split("-").first;
                        String inItNumber =
                            (document.split("/").last).split("-").last;
                        if (linesList[index]["hide"] == true) {
                          return Container();
                        }
                        return Card(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        item["DM"],
                                        style: textTheme.subtitle2,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SalesDocumentsScreen(
                                                      Sequence: sequence,
                                                      InitNo: inItNumber,
                                                      RecNum: recNumber,
                                                      type: item["ST"],
                                                    )));
                                      },
                                    ),
                                    Text(
                                        "${MyKey.currencyFromat(item["AM"].toString())}")
                                  ],
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Remark".tr,
                                      contentPadding: EdgeInsets.zero),
                                  onChanged: (text) {
                                    linesList[index]["remark"] = text;
                                  },
                                ),
                                // SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        child: Text(
                                          item["PN"],
                                          style: textTheme.subtitle1,
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TransactionDetails(
                                                        type: widget.DocType ==
                                                                DocType.sales
                                                            ? DocType.customer
                                                            : DocType.supplier,
                                                        id: item["PC"],
                                                        apiKey: compRepo!
                                                            .getSelectedApiKey(),
                                                        fromDate:
                                                            dateListLine!.first,
                                                        todate:
                                                            dateListLine!.last,
                                                        title: widget.title,
                                                        // RecNum: item.,
                                                      )));
                                        },
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          approve(
                                              inItNumber: inItNumber,
                                              position: index,
                                              recNumber: recNumber,
                                              sequence: sequence,
                                              remarks: linesList[index]
                                                  ["remark"]??"",
                                              isApprove: false);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Reject".tr,
                                              style: textTheme.button!
                                                  .copyWith(color: Colors.red)),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          approve(
                                              inItNumber: inItNumber,
                                              position: index,
                                              recNumber: recNumber,
                                              sequence: sequence,
                                              remarks: linesList[position]
                                                  ["remark"]??"",
                                              isApprove: true);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Approve".tr,
                                              style: textTheme.button!.copyWith(
                                                  color: Colors.green)),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            Align(
              child: Row(
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
                mainAxisSize: MainAxisSize.min,
              ),
              alignment: Alignment.bottomCenter,
            ),
          ]

          // if (totalMap != null) ...[getFooterWidget(textTheme)]
        ],
      ),
    );
  }

  Future updateLines() async {
    if (time != compRepo?.conpanySwichedAt) {
      linesList.clear();
      viewpageNum = 0;
      apiPageNumber = 0;
      controllre = PageController(keepPage: true, initialPage: 0);
    }
    time = compRepo?.conpanySwichedAt;
    if (!isLastPage(
        linesList: linesList,
        numOfItemPerPage: numOfItemPerPage,
        viewpageNum: viewpageNum)) return;
    apiPageNumber++;
    var response = await Serviece.getDocumentList(
      context: context,
      api_key: compRepo!.getSelectedApiKey(),
      fromDate: dateListLine!.first,
      toDate: dateListLine!.last,
      DBType: widget.DocType,
      pageNo: apiPageNumber.toString(),
      query: "",
    );
    if (response != null) {
      totalPages =
          double.parse(response["PageNo"][0]["PageNo"].toString()).toInt();
      numberOfBills = int.parse(response["PageNo"][0]["TotalItem"].toString());
      List list = response["List"];
      linesList.addAll(list);
      if (mounted) setState(() {});
    } else {
      linesList = [];
      if (mounted) setState(() {});
      controllre = PageController(keepPage: true, initialPage: viewpageNum);
    }
  }

  Future<void> approve({
    required String sequence,
    required String inItNumber,
    required String recNumber,
    required int position,
     String? remarks,
    required bool isApprove,
  }) async {
    if (!isApprove && (remarks!.isEmpty)) {
      Toast.show("Enter Remark");
      return;
    }

    Toast.show(isApprove ? "Approving..." : "Rejecting..");
    // return;
    var response = await Serviece.approveDocument(
        context: context,
        DBType: widget.DocType,
        api_key: compRepo!.getSelectedApiKey(),
        initno: inItNumber,
        Sequence: sequence,
        RecNo: recNumber,
        isApproved: isApprove,
        remark: remarks!);
    if (response != null) {
      linesList[position]["hide"] = true;
      setState(() {});
      /* linesList.clear();
      viewpageNum = 0;
      apiPageNumber = 0;
      controllre = PageController(keepPage: true, initialPage: 0);
      updateLines();*/
    }
  }
}
