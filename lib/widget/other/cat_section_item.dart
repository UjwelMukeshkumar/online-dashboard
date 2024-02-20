import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/CatSectionM.dart';
import 'package:glowrpt/screen/dashboards/sales/item_with_gp_screeen.dart';
import 'package:glowrpt/screen/item_list_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';

class CatSectionItem extends StatelessWidget {
  int position;
  CatSectionM item;
  String type;
  String apiKey;

  CatSectionItem({
   required this.position,
   required this.item,
   required this.type,
   required this.apiKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: position.isOdd ? AppColor.background : AppColor.appBackground,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Expanded(
                flex: 10,
                child: RichText(
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 2),
                      text: item.title,
                      children: [
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(2, -8),
                            child: Text(
                              "${item.Percentage_Cmp ?? 0}%",
                              //superscript is usually smaller in size
                              textScaleFactor: 0.7,
                              /*     style: TextStyle(
                                  color: item.Percentage_Cmp > 0
                                      ? Colors.green
                                      : Colors.red,
                                  height: 2),*/
                            ),
                          ),
                        )
                      ]),
                )),
            Expanded(
              child: Text(
                MyKey.currencyFromat(item.SalesAmount.toString(),
                    decimmalPlace: 0),
                textAlign: TextAlign.end,
              ),
              flex: 5,
            ),
            Expanded(
              child: Text(
                "${item.GPPercent}%",
                textAlign: TextAlign.end,
              ),
              flex: 3,
            )
          ],
        ));
  }
}
