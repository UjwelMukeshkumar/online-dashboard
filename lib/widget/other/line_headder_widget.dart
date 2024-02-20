import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/screen/cash_flow_details.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/other/key_val_col.dart';
import 'package:get/get.dart';

class LineHeadderWidget extends StatelessWidget {
  DocM docM;
  GestureTapCallback? onTap;

  LineHeadderWidget(this.docM, {this.onTap});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    HeaderBean? headder =
        (docM?.Header?.length ?? 0) > 0 ? docM?.Header?.first : null;
    return ExpansionTile(
      leading: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No of Bills".tr, style: textTheme.overline),
            SizedBox(height: 4),
            Text("${headder?.BillNo ?? "0"}", style: textTheme.subtitle2)
          ],
        ),
      ),
      title: KeyValCol(
        title: "Total".tr,
        value:
            MyKey.currencyFromat(headder?.Amount?.toString(), decimmalPlace: 2),
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
      children: headder != null
          ? [
              ExpItem(
                  title: "Gross Profit".tr,
                  value:
                      "${MyKey.currencyFromat(headder.TotalGrossProfit.toString(), decimmalPlace: 2)}"),
              ExpItem(
                  title: "GP Percent".tr,
                  value:
                      "${MyKey.currencyFromat(headder.GP.toString(), sign: "", decimmalPlace: 0)} %"),
              ExpItem(
                  title: "Total Credit".tr,
                  value:
                      "${MyKey.currencyFromat(headder.TotalCredit.toString(), decimmalPlace: 2)}"),
              ExpItem(
                  title: "Tax Amount".tr,
                  value:
                      "${MyKey.currencyFromat(headder.TaxAmount.toString(), decimmalPlace: 2)}"),
              ExpItem(
                  title: "Rounding Amount".tr,
                  value:
                      "${MyKey.currencyFromat(headder.RoundingAmount.toString(), decimmalPlace: 2)}"),
              ExpItem(
                  title: "Sales".tr,
                  value:
                      "${MyKey.currencyFromat(headder.Sales.toString(), decimmalPlace: 2)}"),
              ExpItem(
                  title: "Sales Return".tr,
                  value:
                      "${MyKey.currencyFromat(headder.SalesReturn.toString(), decimmalPlace: 2)}"),
              ExpItem(
                  title: "Average Basket Value".tr,
                  value:
                      "${MyKey.currencyFromat(headder.AverageBaskutValue.toString(), decimmalPlace: 2)}"),
              ExpItem(
                  title: "Total Receipt".tr,
                  value:
                      "${MyKey.currencyFromat(headder.TotalReceipt.toString(), decimmalPlace: 2)}"),
              SizedBox(height: 10)
            ]
          : [],
    );
  }
}
// "Bill No": 229,

class ExpItem extends StatelessWidget {
  String title;
  String value;

  ExpItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme.overline),
          Text(value, style: textTheme.subtitle2)
        ],
      ),
    );
  }
}
