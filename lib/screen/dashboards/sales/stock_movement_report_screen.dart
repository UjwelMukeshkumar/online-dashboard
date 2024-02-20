import 'package:flutter/material.dart';
import 'package:glowrpt/chart/stock_movement_report_chart.dart';
import 'package:get/get.dart';

class StockMovementReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Movement Report".tr),
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: StockMovementReportChart()),
      ),
    );
  }
}
