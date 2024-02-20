import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/model/other/TbtlM.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';

class TbtlItemWidget extends StatelessWidget {
  const TbtlItemWidget({
    Key? key,
    required this.item,
   required this.position,
  }) : super(key: key);

  final TbtlM item;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: item.rowColor,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${item.name}",
              textAlign: TextAlign.start,
            ),
            flex: 20,
          ),
          SizedBox(width: 24),
          Expanded(
            child: Visibility(
                visible: item.type != "D",
                child: Text(
                  "${MyKey.currencyFromat(item.amount.toString())}",
                  textAlign: TextAlign.end,
                )),
            flex: 14,
          ),
          Expanded(
            child: Visibility(
              visible: item.type != "D",
              child: Text(
                item.drCr.toString()??"N/A",
                textAlign: TextAlign.end,
              ),
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }
}
