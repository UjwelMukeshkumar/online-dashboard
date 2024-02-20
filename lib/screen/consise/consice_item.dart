import 'package:flutter/material.dart';
import 'package:glowrpt/model/consise/ConsiceM.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:get/get.dart';

class ConsiceItem extends StatelessWidget {
  DocumetListBean item;

  ConsiceItem(this.item);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    if (item.Amount == 0) {
      return Container();
    }
    return Card(
      color: Color(0xfff9fff9),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(item.Document),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 16),
              margin: containerMargin,
              decoration: containerDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: ListTile(
                        title: Text("Total ${item.Document}".tr),
                        subtitle: Text(
                          MyKey.currencyFromat(item.Amount.toString() ?? "0",
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
                        title: Text("No. Of ${item.Document}".tr),
                        subtitle: Text(item.NoOfBills?.toString() ?? "",
                            style: textTheme.headline6),
                      )),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: containerMargin,
              decoration: containerDecoration,
              child: Row(
                children: [
                  Expanded(
                      child: ListTile(
                    title: RichText(
                      text: TextSpan(
                          text: "You ${getText()} ".tr,
                          style:
                              textTheme.caption!.copyWith(color: Colors.black87),
                          children: [
                            TextSpan(
                                text:
                                    "${MyKey.currencyFromat(item?.CmpAmount?.abs().toString() ?? "0", decimmalPlace: 0)} ${(item?.CmpAmount ?? 0) >= 0 ? "More" : "Less"} ",
                                style: TextStyle(
                                    color: (item?.CmpAmount ?? 0) >= 0
                                        ? AppColor.notificationBackgroud
                                        : AppColor.red)),
                            TextSpan(
                                text: "compared to last month same day.".tr)
                          ]),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getText() {
    if (["SP", "SI", "Cr"].contains(item.DocType)) {
      return "have sold".tr;
    }
    if (["PI"].contains(item.DocType)) {
      return "have purchased".tr;
    }
    if (["RP", "PR"].contains(item.DocType)) {
      return "have returned".tr;
    }
    if (["SR"].contains(item.DocType)) {
      return "got returns of".tr;
    }
    if (["PO", "SO", ""].contains(item.DocType)) {
      return "have ordered".tr;
    } else
      return "Sold".tr;
  }
}
