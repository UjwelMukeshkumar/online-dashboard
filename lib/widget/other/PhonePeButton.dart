import 'package:flutter/material.dart';
import 'package:glowrpt/util/Constants.dart';

class GridTilePhonePeWidget extends StatelessWidget {
  Widget widget;
  IconData subIconData;
  Widget subWidget;
  String title;
  VoidCallback onTap;
  double height = 50;
  GridTilePhonePeWidget({
  required  this.widget,
  required  this.title,
  required  this.onTap,
  required  this.subIconData,
  required  this.subWidget,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(4),
                height: height,
                width: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height / 2.5),
                    color: AppColor.phonePeColor),
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
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AppColor.title),
              )
            ],
          ),
        ),
      ),
    );
  }
}
