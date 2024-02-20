import 'package:flutter/material.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:glowrpt/model/sale/SoldItemM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/cahched_img.dart';
import 'package:provider/provider.dart';

class SoldItemListScreen extends StatefulWidget {
  String? title;
  String? type;
  String? fromDate;
  String? todate;

  SoldItemListScreen({this.title, this.type, this.fromDate, this.todate});

  @override
  State<SoldItemListScreen> createState() => _SoldItemListScreenState();
}

class _SoldItemListScreenState extends State<SoldItemListScreen> {
  CompanyRepository? compRepo;

  TextTheme? textTheme;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.title}"),
        ),
        body: PagewiseListView<SoldItemM?>(
          pageSize: 20,
          noItemsFoundBuilder: (_) => Text("No Details Found"),
          pageFuture: (pageIndex) => Serviece.getSoldItemList(
              context: context,
              api_key: compRepo!.getSelectedApiKey(),
              pageNo: pageIndex! + 1,
              fromdate: widget.fromDate.toString(),
              todate: widget.todate.toString(),
              type: widget.type!),
          itemBuilder: (context, item, position) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          item!.Item_Name.toString(),
                          style: textTheme?.subtitle1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              children: [
                                Text(
                                  "Sold At",
                                  style: textTheme?.caption,
                                ),
                                // Text(
                                //   MyKey.currencyFromat(item.Price.toString(),
                                //           decimmalPlace: 0) +
                                //       " ${item.Discount != 0 ? '(${item.Discount.toStringAsFixed(1)})' : ""}",
                                //   style: textTheme?.headline6,
                                // ),
                                   Text(
                                  "${MyKey.currencyFromat(item.Price.toString(),
                                   decimmalPlace: 0)} ${item.Discount != 0 ? '(${item.Discount?.toStringAsFixed(1)})' : ""}",
                                  style: textTheme?.headline6,
                                ),
                                Divider(
                                  endIndent: 50,
                                ),
                                Text(
                                    "With ${item.Discount?.toStringAsFixed(0)}% Discount")
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          )),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.black12,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    item.GP!.toInt() < 0
                                        ? "Gross Loss"
                                        : "Gross Profit",
                                    style: textTheme!.caption?.copyWith(
                                        color: item.GP!.toInt() < 0
                                            ? AppColor.negativeRed
                                            : AppColor.positiveGreen)),
                                            // Text(item.GP.toInt()!=0?"${item.GP.toInt().abs()}%":"N/A"),
                                Text("${item.GP?.toInt().abs()}%",
                                    style: textTheme?.headline6),
                                Divider(
                                  endIndent: 50,
                                ),
                                Text(
                                    "At Cost ${MyKey.currencyFromat(item.Cost.toString())}")
                              ],
                            ),
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                            text: TextSpan(
                                text:
                                    "Sold to ${item.PartyName} with bill number. ",
                                style: textTheme?.caption,
                                children: [
                              TextSpan(
                                text: "${item.BillNo}",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ".")
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
