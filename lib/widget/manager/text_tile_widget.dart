import 'package:flutter/material.dart';
import 'package:glowrpt/util/Constants.dart';

class TextTileWidget extends StatelessWidget {
  VoidCallback ontap;
  String title;
  TextTileWidget({required this.ontap, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.ligtBluePonePe,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(CardProperty.radiuos),
                topRight: Radius.circular(CardProperty.radiuos))),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$title"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
