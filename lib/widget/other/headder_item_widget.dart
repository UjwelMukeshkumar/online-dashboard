import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';

class HedderItemWidget extends StatelessWidget {
  int position;
  HeadderParm headderParm;
  Map item;
  bool isGrand;

  HedderItemWidget({
  required this.position,
  required this.headderParm,
  required this.item,
    this.isGrand = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: position.isOdd ? AppColor.background : AppColor.appBackground,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
          children: headderParm.paramsOrder!.map((e) {
        int col = headderParm.paramsOrder!.indexOf(e);
        var dataType = headderParm.dataType![col];
        bool rightAlign = (dataType == DataType.numberType ||
            dataType == DataType.percentType ||
            dataType == DataType.percentType0 ||
            dataType == DataType.numberType0 ||
            dataType == DataType.numberNonCurrenncy ||
            dataType == DataType.textTypeRight ||
            dataType == DataType.numberNonCurrenncy0);
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: dataType == DataType.raiseFall
                ? getRaiseFallWidget(item[e])
                : Text(
                    "${getValue(dataType, item[e])}",overflow: TextOverflow.ellipsis,
                    textAlign: rightAlign ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                        fontWeight:
                            isGrand ? FontWeight.bold : FontWeight.normal),
                  ),
          ),
          flex: headderParm.paramsFlex![col],
        );
      }).toList()),
    );
  }

  getValue(DataType dataType, var data) {
    if (data == null) {
      data = 0.0;
    }
    if (dataType == DataType.textType || dataType == DataType.textTypeRight) {
      return data;
    } else if (dataType == DataType.numberType) {
      return MyKey.currencyFromat(data.toString());
    } else if (dataType == DataType.numberType0) {
      return MyKey.currencyFromat(data.toString(), decimmalPlace: 0);
    } else if (dataType == DataType.numberNonCurrenncy) {
      return data.toStringAsFixed(2);
    } else if (dataType == DataType.numberNonCurrenncy0) {
      return data.toStringAsFixed(0);
    } else if (dataType == DataType.percentType) {
      return MyKey.currencyFromat(data.toString(), sign: "") + "%";
    } else if (dataType == DataType.percentType0) {
      return data.toStringAsFixed(0) + "%";
    }
  }

  Widget getRaiseFallWidget(String e) {
    if (e == "rise") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Icon(
          Icons.thumb_up_alt_outlined,
          color: Colors.green,
          size: 14,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Icon(
          Icons.thumb_down_alt_outlined,
          color: Colors.red,
          size: 14,
        ),
      );
    }
  }
}
