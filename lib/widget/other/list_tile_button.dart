import 'package:flutter/material.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:get/get.dart';

class ListTileButton extends StatelessWidget {
  GestureTapCallback onTap;
  String title;
  IconData icon;
  EdgeInsetsGeometry padding;
  ListTileButton({
 required  this.onTap,
 required  this.title,
 required  this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.backgroundDark),
      child: ListTile(
        // contentPadding: EdgeInsets.zero,
        // dense: true,
        onTap: onTap,
        horizontalTitleGap: 0,
        title: Text(
          title.tr,
          style: TextStyle(color: AppColor.notificationBackgroud),
        ),
        leading: Icon(
          icon,
          color: AppColor.title,
        ),
      ),
    );
  }
}
