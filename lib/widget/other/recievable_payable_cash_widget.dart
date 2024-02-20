import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/PartyLedgerScreen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:provider/provider.dart';

import 'key_val_col.dart';

class RecievablePayableCashWidget extends StatefulWidget {
  @override
  _RecievablePayableCashWidgetState createState() =>
      _RecievablePayableCashWidgetState();
}

class _RecievablePayableCashWidgetState
    extends State<RecievablePayableCashWidget> {
  var recievablePayableCash;

   CompanyRepository? comRepo;


  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    comRepo=Provider.of<CompanyRepository>(context,listen: true);
    updateReceivablePayableCash();
  }
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Container(
        margin: EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (cotext) => PartyLedgerScreen()));
                /* var headderParm = HeadderParm(
                    isPaginated: true,
                    title: "Receivable",
                    type: "Rc",
                    summationField: ["Total_Balance_Due"],
                    displayType: DisplayType.gridType);
                openDatailScreenAny(
                    context: context,
                    dateListLine: widget.dateList,
                    headderParm: headderParm,
                    selectedUser: widget.selectedUser); */
              },
              child: KeyValCol(
                  title: "Receivable",
                  value:
                      "${MyKey.currencyFromat(recievablePayableCash["TotalReceviables"].toString(), decimmalPlace: 0)}"),
            ),
            InkWell(
              onTap: () {
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (cotext) => PartyLedgerScreen(pageIndex: 1,)));

              },
              child: KeyValCol(
                  title: "Payable",
                  value:
                      "${MyKey.currencyFromat(recievablePayableCash["TotalPayables"].toString(), decimmalPlace: 0)}"),
            ),
            InkWell(
                onTap: () => openDetailPage("Cash", "C"),
                child: KeyValCol(
                    title: "Cash",
                    value:
                        "${MyKey.currencyFromat(recievablePayableCash["Cash"].toString(), decimmalPlace: 0)}")),
            InkWell(
                onTap: () => openDetailPage("Bank", "B"),
                child: KeyValCol(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    title: "Bank",
                    value:
                        "${MyKey.currencyFromat(recievablePayableCash["Bank"].toString(), decimmalPlace: 0)}")),
          ],
        ),
      ),
    );
  }
  Future<void> updateReceivablePayableCash() async {
    print("Home doc RPC B called");
    setState(() {
      recievablePayableCash = Map();
    });


    var data = await Serviece.getHomedocForHedder(context, comRepo!.getSelectedApiKey(),
        MyKey.getCurrentDate(), MyKey.getCurrentDate(), "homedoc", 1, "",
        type: "RPC");
    if (data != null) {
      recievablePayableCash = data["Header"][0];
      if (mounted) setState(() {});
    }
  }

  openDetailPage(String title, String type) {
    var headderParm = HeadderParm(
        title: title,
        type: type,
        summationField: ["Balance"],
        displayType: DisplayType.rowType,
        paramsOrder: ["Account", "Balance"],
        dataType: [DataType.textType, DataType.numberType],
        paramsFlex: [3, 2]);
    openDatailScreenAny(
        context: context,
        dateListLine: MyKey.getDefaultDateListAsToday(),
        headderParm: headderParm,
        selectedUserRemoveMe: comRepo!.getSelectedUser());
  }
}
