import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/FinancialDashBoardM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/graph_card_widget.dart';
import 'package:glowrpt/widget/other/graph_row_widget.dart';
import 'package:glowrpt/widget/other/loader_widget.dart';

class DebitCreditAnalisyScreen extends StatefulWidget {
  // DocM docM;
  List<String> dateListLine;
  User selectedItem;

  // String type;
  // String title;

  DebitCreditAnalisyScreen({
  required  this.dateListLine,
  required  this.selectedItem,
  });

  @override
  _DebitCreditAnalisyScreenState createState() =>
      _DebitCreditAnalisyScreenState();
}

class _DebitCreditAnalisyScreenState extends State<DebitCreditAnalisyScreen> {
  FinancialDashBoardM? finacialList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var data =
        finacialList == null ? null : finacialList!.financialDashBoard.first;
    return Scaffold(
      appBar: AppBar(
        title: Text("Debit Credit Analysis"),
      ),
      body: finacialList != null
          ? ListView(
              children: [],
            )
          : LoaderWidget(),
    );
  }

  void loadData() {
    Serviece.geDebitCreditAnalisys(context, widget.selectedItem.apiKey,
            widget.dateListLine.first, widget.dateListLine.last)
        .then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Oops Someting went wrong please retry'),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () {
              loadData();
            },
          ),
        ));
      }
      if (mounted)
        setState(() {
          // finacialList = value;
        });
    });
  }
}
