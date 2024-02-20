import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/CatM.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';

class CategorytemWidget extends StatelessWidget {
  const CategorytemWidget({
    Key? key,
    required this.item,
    required this.position,
  }) : super(key: key);

  final CatM item;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: position.isEven ? AppColor.background : AppColor.appBackground,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${item.itemGroup}",
            ),
            flex: 20,
          ),
          SizedBox(width: 24),
          Expanded(
            child: Text(
              "${item.quantity}",
              textAlign: TextAlign.end,
            ),
            flex: 8,
          ),
          Expanded(
            child: Text(
              MyKey.currencyFromat(item.salesAmount.toString(), sign: ""),
              textAlign: TextAlign.end,
            ),
            flex: 10,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text("${item.gpPercent.toStringAsFixed(0)}%",
                textAlign: TextAlign.end),
            flex: 10,
          ),
          SizedBox(width: 4),
        ],
      ),
    );
  }
}
