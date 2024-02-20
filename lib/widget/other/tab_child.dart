import 'package:flutter/material.dart';

class TabChild extends StatelessWidget {
  // TabController tabController;
  int selectedPosition;
  String title;
  int postion;

  TabChild({required this.selectedPosition, required this.title,
      required this.postion});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(title),
      decoration: BoxDecoration(
          color: selectedPosition == postion
              ? Colors.red.shade50
              : Colors.transparent,
          border: Border.all(
              width: 1,
              color:
              selectedPosition == postion ? Colors.red : Colors.black26),
          borderRadius: BorderRadius.all(Radius.circular(24))),
    );
  }
}
