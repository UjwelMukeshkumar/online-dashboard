import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/library/NumberOperation.dart';
import 'package:toast/toast.dart';

import '../../../model/other/AnalaticsM.dart';
import '../../../model/other/ConsolidationM.dart';
import '../../../model/other/User.dart';
import '../../../repo/Provider.dart';
import '../../../screen/salestrends/sales_trends_screen.dart';
import '../../../util/Constants.dart';
import '../../../util/MyKey.dart';
import '../../../util/Serviece.dart';

class AnalaticsItem extends StatefulWidget {
  AnalaticsM analaticsM;
  ConsolidationM consolidationM;
  int position;
  bool isSale;
  CompanyRepository companyRepo;
  VoidCallback onUpdate;

  AnalaticsItem(
      this.analaticsM, this.position, this.companyRepo, this.consolidationM,this.isSale,this.onUpdate);

  @override
  State<AnalaticsItem> createState() => _AnalaticsItemState();
}

class _AnalaticsItemState extends State<AnalaticsItem> {
  var etcEstimatedExpense = TextEditingController();
   User? selectedUser  ;
  @override
  void initState() {

    selectedUser  = widget.companyRepo.getUserByOrgName(widget.analaticsM.Branch)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var divider = Divider(
      height: 1,
      endIndent: 16,
      indent: 16,
    );
    return InkWell(
      onTap: () {
        
        //userByOrgId.organisation=analaticsM.Branch;
        print("Selected User ${selectedUser!.toJson()}");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SalesTrendsScreen(
            isSale: true,
            selectedComp: selectedUser!,
          );
        }));
      },
      child: Card(
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "${widget.analaticsM.Branch} ",
                          style: textTheme.subtitle1,
                        ),
                        Text(
                          " ${(widget.analaticsM.Amount / double.parse(widget.consolidationM.SalesAmount) * 100).toSafeInt}%",
                          style: textTheme.caption!.copyWith(color: Colors.blue),
                        )
                      ],
                    ),
                  )),
              Container(
                padding: EdgeInsets.only(bottom: 16),
                margin: containerMargin,
                decoration: containerDecoration,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.analaticsM.Amount > 0) ...[
                      Row(
                        children: [
                          Expanded(
                              child: ListTile(
                            title: Text(widget.isSale?"Total Collection":"Total GP"),
                            subtitle: Text(
                              MyKey.currencyFromat(
                                  widget.analaticsM.Amount.toString() ?? "0",
                                  decimmalPlace: 0),
                              style: textTheme.headline6,
                            ),
                          )),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.black12,
                          ),
                          Expanded(
                              child: ListTile(
                            title: Text("No Of Bills"),
                            subtitle: Text(
                                widget.analaticsM.TotalPayments?.toString() ??
                                    "",
                                style: textTheme.headline6),
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                            text: TextSpan(
                                text: widget.analaticsM.CmpAmnt > 0
                                    ? "Great you ${widget.isSale?"collected":"received"} "
                                    : "You ${widget.isSale?"collected":"received"} ",
                                style: textTheme.caption,
                                children: [
                              TextSpan(
                                  text:
                                      "${MyKey.currencyFromat(widget.analaticsM.CmpAmnt?.abs()?.toString() ?? "0", decimmalPlace: 0)} ${widget.analaticsM.CmpAmnt >= 0 ? 'More' : 'Less'}",
                                  style: TextStyle(
                                      color: widget.analaticsM.CmpAmnt > 0
                                          ? AppColor.notificationBackgroud
                                          : AppColor.red)),
                              TextSpan(
                                  text:
                                      " compared to ${getTrendText(widget.position)}")
                            ])),
                      ),
                      divider,
                      Row(
                        children: [
                          Expanded(
                              child: ListTile(
                            subtitle: Text(
                              "Avg. Amount per.Payment",
                              style: textTheme.caption,
                            ),
                            title: Text(
                              MyKey.currencyFromat(
                                  widget.analaticsM?.AvgAmount?.toString() ??
                                      "0",
                                  decimmalPlace: 0),
                              style: textTheme.headline6!.copyWith(
                                  color: AppColor.title.withOpacity(.6)),
                            ),
                          )),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.black12,
                          ),
                          Expanded(
                              child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                  style: textTheme.caption!
                                      .copyWith(color: Colors.black87),
                                  children: [
                                    TextSpan(
                                        text:
                                            "${MyKey.currencyFromat(widget.analaticsM?.AvgAmountCmp?.abs().toString() ?? "0", decimmalPlace: 0)} ${(widget.analaticsM?.AvgAmountCmp ?? 0) >= 0 ? "More" : "Less"} ",
                                        style: TextStyle(
                                            color: (widget.analaticsM
                                                            ?.AvgAmountCmp ??
                                                        0) >=
                                                    0
                                                ? AppColor.notificationBackgroud
                                                : AppColor.red)),
                                    TextSpan(
                                        text:
                                            " compared to ${getTrendText(widget.position)}")
                                  ]),
                            ),
                          )),
                        ],
                      ),
                      divider,
                      Row(
                        children: [
                          Expanded(
                              child: ListTile(
                            subtitle: Text(
                              "GP",
                              style: textTheme.caption,
                            ),
                            title: Text(
                              MyKey.currencyFromat(
                                  widget.analaticsM?.GP?.toString() ?? "0",
                                  decimmalPlace: 0,
                                  sign: ""),
                              style: textTheme.headline6!.copyWith(
                                  color: AppColor.title.withOpacity(.6)),
                            ),
                          )),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.black12,
                          ),
                          Expanded(
                              child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                  style: textTheme.caption!
                                      .copyWith(color: Colors.black87),
                                  children: [
                                    TextSpan(
                                        text:
                                            "${MyKey.currencyFromat(widget.analaticsM?.CmpGP?.abs().toString() ?? "0", decimmalPlace: 0, sign: "")} ${(widget.analaticsM?.CmpGP ?? 0) >= 0 ? "More" : "Less"} ",
                                        style: TextStyle(
                                            color: (widget.analaticsM?.CmpGP ??
                                                        0) >=
                                                    0
                                                ? AppColor.notificationBackgroud
                                                : AppColor.red)),
                                    TextSpan(
                                        text:
                                            " compared to ${getTrendText(widget.position)}")
                                  ]),
                            ),
                          )),
                        ],
                      ),
                      divider,
                      Row(
                        children: [
                          Expanded(
                              child: ListTile(
                            onTap: () async {
                              etcEstimatedExpense.text =
                                  widget.analaticsM?.Total_Estimated_Expense?.toString() ??
                                      "0";
                              bool? isUpdated = await showDialog<bool>(
                                  context: (context),
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Update Expense"),
                                      content: TextField(
                                        controller: etcEstimatedExpense,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: textFieldBorder,
                                            labelText:
                                                "Enter Estimated Expense"),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Toast.show("Please Wait..");
                                            var response =
                                                await Serviece.setEstExpense(
                                                    context: context,
                                                    api_key:selectedUser!.apiKey,
                                                    amount: etcEstimatedExpense.text);
                                            if (response != null) {
                                              Toast.show("Updated");
                                              Navigator.pop(context, true);
                                            }
                                          },
                                          child: Text("Update"),
                                        ),
                                      ],
                                    );
                                  });
                              if (isUpdated == true) {
                                widget.onUpdate();
                              }
                            },
                            title: Text(
                              MyKey.currencyFromat(
                                  widget.analaticsM?.Total_Estimated_Expense
                                          ?.toString() ??
                                      "0",
                                  decimmalPlace: 0,
                                  sign: ""),
                              style: textTheme.headline6!.copyWith(
                                  color: AppColor.title.withOpacity(.6)),
                            ),
                            subtitle: Text(
                              "Estimated Expense",
                              style: textTheme.caption,
                            ),
                          )),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.black12,
                          ),
                          Expanded(
                              child: ListTile(
                            title: Text(MyKey.currencyFromat(
                                "${widget.analaticsM.NetProft}")),
                            subtitle: Text("Est.Netprofit"),
                          )),
                        ],
                      )
                    ] else ...[
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "No Transactions during the selected period",
                          style: textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ))
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
