import 'package:flutter/material.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:get/get.dart';

class GridTileWidget extends StatelessWidget {
  Widget widget;
  IconData? subIconData;
  Widget? subWidget;
  String title;
  VoidCallback onTap;

  GridTileWidget({
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(4),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.background),
              child: Stack(
                children: [
                  Center(
                    child: Container(width: 35, height: 35, child: widget),
                  ),
                  Align(
                      alignment: Alignment(1.3, 1.3),
                      child: subIconData != null
                          ? Icon(subIconData,
                              color: AppColor.notificationBackgroud)
                          : Container(
                              height: 25,
                              width: 25,
                              child: subWidget,
                            )),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              title.tr,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColor.title),
            )
          ],
        ),
      ),
    );
  }
}
