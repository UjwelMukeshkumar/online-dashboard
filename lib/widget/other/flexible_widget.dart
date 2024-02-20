import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/screen/item_details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'headder_item_widget.dart';

class FlexibleWidget extends StatelessWidget {
  Map item;
  HeadderParm headderParm;
  int? position;
  String? apiKey;

  FlexibleWidget({
  required this.item,
  required this.headderParm,
   this.position,
   this.apiKey,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var keys = item.keys
        .where((element) =>
            item[element].toString().isNotEmpty &&
            (double.tryParse(item[element].toString()) ?? -1) != 0)
        .toList();
    if (headderParm.displayType == DisplayType.rowType) {
      return HedderItemWidget(
        headderParm: headderParm,
        position: position!,
        item: item,
      );
    }
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: keys.map((e) {
            int position = keys.indexOf(e);
            return InkWell(
              onTap: e == "MobileNo"
                  ? () {
                      _launch('tel:${item[e].toString().trim()}');
                    }
                  : null,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e,
                              style: textTheme.subtitle2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            flex: headderParm.paramsFlex == null
                                ? 2
                                : headderParm.paramsFlex!.first,
                          ),
                          Text(
                            " :  ",
                            style: textTheme.headline6,
                          ),
                          Expanded(
                            child: Text(item[e].toString(),
                                style: textTheme.subtitle1),
                            flex: headderParm.paramsFlex == null
                                ? 7
                                : headderParm.paramsFlex!.last,
                          )
                        ],
                      ),
                    ),
                    if (keys.last != e) ...[
                      Divider(
                        height: 0,
                      )
                    ]
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

_launch(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print("Not supported");
  }
}
