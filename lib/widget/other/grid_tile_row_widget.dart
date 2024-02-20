import 'package:flutter/material.dart';
import 'package:glowrpt/util/Constants.dart';

class GridTileRowWidget extends StatelessWidget {
  Widget widget;
  IconData? subIconData;
  Widget? subWidget;
  String title;
  VoidCallback onTap;

  GridTileRowWidget({
   required this.widget,
   required this.title,
   required this.onTap,
    this.subIconData,
    this.subWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                // textAlign: TextAlign,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AppColor.title),
              ),
            ),
            Container(
              margin: EdgeInsets.all(4),
              height: 50,
              width: 30,
              child: Stack(
                children: [
                  Center(
                    child: Container(width: 35, height: 35, child: widget),
                  ),
                  Align(
                      alignment: Alignment(0.5, 0.5),
                      child: subIconData != null
                          ? Icon(subIconData,
                              color: AppColor.notificationBackgroud)
                          : Container(
                              height: 10,
                              width: 10,
                              child: subWidget,
                            )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
