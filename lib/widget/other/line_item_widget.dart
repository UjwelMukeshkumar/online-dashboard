import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/screen/sales_documents_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';

class LineItemWidget extends StatelessWidget {
  const LineItemWidget(
      {Key? key,
      required this.item,
      required this.position,
      required this.selectedItem,
      required this.type,
      required this.excludeGp})
      : super(key: key);

  final LinesBean item;
  final int position;
  final bool excludeGp;
  final User selectedItem;
  final String type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.RecNum != null
          ? () {
              
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalesDocumentsScreen(
                            type: type,
                            RecNum: item.RecNum.toString(),
                            InitNo: item.InitNo.toString(),
                            Sequence: item.Sequence.toString(),
                          )));
            }
          : null,
      child: Container(
        color: position.isEven ? AppColor.background : AppColor.appBackground,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${item.Time}",
                // "${position}",
                textAlign: TextAlign.end,
              ),
              flex: 10,
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(
                "${item.PartyName}",
                overflow: TextOverflow.ellipsis,
              ),
              flex: 20,
            ),
            Expanded(
              child: Text(
                MyKey.currencyFromat(
                  item.NetAmt.toString(),
                  sign: "",
                ),
                textAlign: TextAlign.end,
              ),
              flex: 10,
            ),
            SizedBox(width: 14),
            if (!excludeGp) ...[
              Expanded(
                child: Text(
                    "${MyKey.currencyFromat(item.GPPercent.toString(), sign: "")}%",
                    textAlign: TextAlign.end),
                flex: 10,
              ),
              SizedBox(width: 4),
            ]
          ],
        ),
      ),
    );
  }
}
