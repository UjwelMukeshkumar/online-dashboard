import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/model/consise/FreightM.dart';
import 'package:glowrpt/model/consise/SalesHeaderM.dart';
import 'package:glowrpt/pdf/SalesHistory.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/transaction_details.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/flexible_widget.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'item_details_screen.dart';

class SalesDocumentsScreen extends StatefulWidget {
  // LinesBean item;
  String RecNum;
  String Sequence;
  String InitNo;
  // User selectedItem;
  String type;
  int slNo;

  SalesDocumentsScreen({
    required this.type,
    required this.Sequence,
    required this.RecNum,
    required this.InitNo,
    this.slNo = -1,
  });

  @override
  _SalesDocumentsScreenState createState() => _SalesDocumentsScreenState();
}

class _SalesDocumentsScreenState extends State<SalesDocumentsScreen> {
  SalesHeaderM? salesHeader;

  // List<SalesLinesM> salesLines;
  List? salesLines;

  FreightM? freight;

  bool isLoading = false;

  CompanyRepository? compRepo;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  void initState() {
    super.initState();

    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadConsiseReport();
    itemPositionsListener.itemPositions.addListener(() => {});
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${salesHeader?.document == null ? "" : salesHeader?.document?.split("-").first} Document"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          if (salesHeader != null) ...[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionDetails(
                              type: DocType.customer,
                              id: salesHeader!.partyCode,
                              apiKey: compRepo!.getSelectedApiKey(),
                              fromDate: MyKey.displayDateFormat.format(
                                  DateTime.now().subtract(Duration(days: 30))),
                              todate: MyKey.displayDateFormat
                                  .format(DateTime.now()),
                              title: salesHeader!.partyName,
                              RecNum: widget.RecNum,
                              InitNo: widget.InitNo,
                              Sequence: widget.Sequence,
                            )));
              },
              child: Text(
                "${salesHeader!.partyName}",
                style: textTheme.headline6,
              ),
            ),
            Text(
              "(${salesHeader!.partyCode})",
              style: textTheme.caption,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: salesHeader!.document.toString(),
                      style: textTheme.bodyText1!.copyWith(height: 1.5),
                      children: [
                        TextSpan(text: " On ", style: textTheme.caption),
                        TextSpan(text: "${salesHeader!.date}"),
                        TextSpan(text: " For ", style: textTheme.caption),
                        TextSpan(text: "${salesHeader!.total}"),
                        TextSpan(
                            text: " (${salesHeader!.taxAmount} Tax)",
                            style: textTheme.caption),
                        // TextSpan(text: "${String.fromCharCode(0x00A0)}Tax", style: textTheme.caption),
                      ])),
            ),
            Text(
                "${salesHeader!.freightCharge > 0 ? 'Fr-Ch ${salesHeader!.freightCharge}' : ''}"
                "${salesHeader!.discountAmt > 0 ? 'Disc-Amt ${salesHeader!..discountAmt}' : ''}"
                "${salesHeader!.discountPerc > 0 ? 'Disc-Perc ${salesHeader!.discountPerc}%' : ''}"),
          ] else ...[
            if (!isLoading) Center(child: Text("No Records"))
          ],
          Expanded(
              child: salesLines != null
                  ? ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      itemCount: salesLines!.length,
                      itemBuilder: (context, postion) {
                        Map item = salesLines![postion];
                        Map copyOfItem = Map();
                        copyOfItem.addAll(item);
                        return Container(
                          color: widget.slNo - 1 == postion
                              ? Colors.orangeAccent
                              : Colors.transparent,
                          child: ExpansionTile(
                            title: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>SalesHistory(item: item))
                                );
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ItemDetailsScreen(
                                //               itemNo: item["Item_No"],
                                //               api_key:
                                //                   compRepo!.getSelectedApiKey(),
                                //             )));
                              },
                              title: Text("${item["Item Name"]}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Rs ${item["Price"]} - ${item["Discount"]}% (${item["Price"] * (100 - item["Discount"]) / 100})"),
                                  Text(
                                      "${item["Quantity"]} ${item["UOM"].isEmpty ? "Nos" : item["UOM"]}",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              // trailing: Text("(${item["Taxcode"]})"),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("(${item["GP Percent"]})"),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${item["Net Total"]}",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            children: [
                              FlexibleWidget(
                                headderParm: HeadderParm(
                                    paramsFlex: [6, 10],
                                    displayType: DisplayType.gridType),
                                item: copyOfItem
                                  ..remove("Item Name")
                                  ..remove("Item_No")
                                  ..remove("Price")
                                  ..remove("Taxcode"),
                                apiKey: compRepo!.getSelectedApiKey(),
                              )
                            ],
                          ),
                        );
                      })
                  : Center(
                      child: CupertinoActivityIndicator(),
                    )),
        ],
      ),
    );
  }

  Future<void> loadConsiseReport() async {
    isLoading = true;
    var json = await Serviece.getConsise(context, compRepo!.getSelectedApiKey(),
        widget.RecNum, widget.Sequence, widget.InitNo,
        type: widget.type);

    isLoading = false;
    if (json != null) {
      salesHeader = ((json["SalesHeader"] == null ||
              List.from(json["SalesHeader"]).length == 0)
          ? null
          : List<SalesHeaderM>.from(
              json["SalesHeader"].map((x) => SalesHeaderM.fromJson(x))).first);
      /*  salesLines = json["SalesLines"] == null
          ? null
          : List<SalesLinesM>.from(
              json["SalesLines"].map((x) => SalesLinesM.fromJson(x)));*/
      salesLines = json["SalesLines"] ?? [];
      salesLines!
          .map((item) => item["GP Percent"] = "${item["GP Percent"]}%")
          .toList();
      List? freight = json["Freight"] == null
          ? null
          : List<FreightM>.from(
                  json["Freight"].map((x) => FreightM.fromJson(x))) ??
              [];
      if (freight!.length > 0)
        this.freight = freight.first;
      else
        this.freight = FreightM(amount: 0, account: "");
    } else {}
    if (mounted) setState(() {});
    itemScrollController.scrollTo(
        index: (widget.slNo ?? 1) - 1,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutCubic);
  }
}
