import 'package:flutter/material.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HeadderCard extends StatelessWidget {
  String title;
  String amount;
  Widget? icon;
  double? percentage;

  HeadderCard({
  required  this.title,
  required  this.amount,
    this.icon,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    if (double.parse(amount.replaceAll(",", "").replaceAll("₹", "")) == 0) {
      return Container();
    }
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //TODO : fixthis
              children: [
                Text("$title"),
                percentage != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "${percentage.toString() ?? 0}%",
                          style: textTheme.caption!.copyWith(
                              color:
                                  percentage! >= 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: 8),
            Text(
              amount,
              style: textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
