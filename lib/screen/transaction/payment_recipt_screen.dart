import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/model/recipt/BillDataM.dart';
import 'package:glowrpt/model/recipt/ReciptHeadderM.dart';
import 'package:glowrpt/model/transaction/BillsM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/transaction/bill_chooser_screen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/util/loader_animation.dart';
import 'package:glowrpt/widget/date/app_date_widget.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:toast/toast.dart';
import '../../model/route/PlannerRouteLoadM.dart';

class Transaction {
  static String recipt = "IP";
  static String payment = "Op";
}

class PaymentReciptScreen extends StatefulWidget {
  bool isRecipt;
  RouteDetailsBean? rootDetails;
  String? empId;
  int? rootId;

  PaymentReciptScreen({
    required this.isRecipt,
    this.rootDetails,
    this.rootId,
    this.empId,
  });

  factory PaymentReciptScreen.create(bool isRecipt){
    return PaymentReciptScreen(isRecipt: isRecipt);
  }

  @override
  _PaymentReciptScreenState createState() => _PaymentReciptScreenState();
}

enum PayOn { onAccount, chooseBills }

class _PaymentReciptScreenState extends State<PaymentReciptScreen> {
   CompanyRepository? compRepo;

  PartySearchM? party1;
  List<String> transferType = ["Cash", "Card", "Bank", "UPI", "Cheque"];

  // List<String> typeForApi = ["AC", "AB", "AB", "AB"];
  String? mode;

  PartySearchM? account;

  PayOn _payOn = PayOn.onAccount;

  String? selectedDate;
  var tec_amount = TextEditingController();
  var tec_text = TextEditingController();

  List<BillsM>? list;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedDate = MyKey.getCurrentDate();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    if (widget.rootDetails != null) {
      party1 = PartySearchM(
          CVCode: widget.rootDetails?.CVCode,
          CVName: widget.rootDetails?.CVName);
    };
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var space = SizedBox(height: 12);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isRecipt ? "Receipt" : "Payment"),
      ),
      body: isLoading
          ? LoadingAnimation()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        AppDateWidget(
                          onDateSelected: (date) {
                            selectedDate = date;
                          },
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Party Balance ",
                              style: textTheme.bodySmall,
                            ),
                            Text(
                              "${MyKey.currencyFromat((party1?.Balance ?? 0).toString())}",
                              style: TextStyle(color: Colors.amberAccent),
                            ),
                          ],
                        ),
                        DropdownSearch<PartySearchM>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            isFilterOnline: true,
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelText: "Party *",
                          )),
                          asyncItems: (text) => Serviece.partySearch(
                            context: context,
                            api_key: compRepo!.getSelectedApiKey(),
                            Type: "All",
                            query: text,
                          ),
                          // mode: Mode.MENU,
                          selectedItem: party1,
                          onChanged: (party) {
                            setState(() {
                              party1 = party;
                            });
                          },
                        ),
                        space,
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            isFilterOnline: true,
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelText: "Mode",
                          )),
                          // mode: Mode.MENU,
                          items: transferType,
                          //autoFocusSearchBox: true,
                          // label: "Mode",
                          onChanged: (party) async {
                            setState(() {
                              mode = party;
                            });
                            account = await Serviece.partySearchMode(
                                context: context,
                                api_key: compRepo!.getSelectedApiKey(),
                                Type: mode == "Cash" ? "AC" : "AB",
                                mode: mode);
                            setState(() {});
                          },
                        ),
                        space,
                        DropdownSearch<PartySearchM>(
                          popupProps: PopupProps.menu(
                            searchFieldProps: TextFieldProps(autofocus: true),
                            showSearchBox: true,
                            isFilterOnline: true,
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelText: "Account",
                          )),
                           asyncItems: (text) => Serviece.partySearch(
                              context: context,
                              api_key: compRepo!.getSelectedApiKey(),
                              Type: mode == "Cash" ? "AC" : "AB",
                              // Type: mode=="Cash"?"AC":"AB",
                              query: text,),
                          selectedItem: account,
                          onChanged: (party) {
                            setState(() {
                              account = party;
                            });
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: RadioListTile(
                              title: Text("On Account"),
                              value: PayOn.onAccount,
                              onChanged: (value) {
                                setState(() {
                                  _payOn = value!;
                                });
                              },
                              groupValue: _payOn,
                            )),
                            Expanded(
                                child: RadioListTile(
                              title: Text("Choose Bills"),
                              value: PayOn.chooseBills,
                              onChanged: (value) {
                                setState(() {
                                  _payOn = value!;
                                });
                              },
                              groupValue: _payOn,
                            )),
                          ],
                        ),
                        Visibility(
                            visible: _payOn == PayOn.chooseBills,
                            child: TextButton(
                              child: Text((list == null || list!.isNotEmpty)
                                  ? "Choose bills"
                                  : "Edit Bills"),
                              onPressed: () async {
                                if (party1 == null) {
                                  Toast.show("Select Party");
                                  return;
                                }
                                list = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BillChooserScreen(
                                              party: party1!,
                                              billType: widget.isRecipt
                                                  ? Transaction.recipt
                                                  : Transaction.payment,
                                            )));
                                tec_amount.text = list!
                                    .map((e) =>
                                        double.tryParse(e.reciptAmount.toString()) ?? 0.0)
                                    .fold(
                                        0.0,
                                        (previousValue, element) =>
                                            previousValue + element)
                                    .toString();
                                setState(() {});
                              },
                            )),
                        space,
                        TextFormField(
                          controller: tec_amount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Amount", border: textFieldBorder),
                        ),
                        space,
                        TextFormField(
                          controller: tec_text,
                          decoration: InputDecoration(
                              labelText: "Remarks", border: textFieldBorder),
                        ),
                        if (list != null) ...[
                          space,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Selected Bills",
                              style: textTheme.subtitle2,
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: list?.length,
                              itemBuilder: (context, index) {
                                var item = list?[index];
                                return Card(
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Text(item?.documnet),
                                        Text(
                                            "Amount :${MyKey.currencyFromat(item?.TransAmount.toString())}"),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(item?.dateText),
                                        Text(
                                            "Balance :${MyKey.currencyFromat(item?.TransBalance.toString())}"),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                  ),
                                );
                              })
                        ]
                      ],
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ElevatedButton(
                        onPressed: saveData, child: Text("Save")),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> saveData() async {
    Map params = Map();
    if (party1 == null) {
      Toast.show("Select Party");
      return;
    }
    if (mode == null) {
      Toast.show("Select Mode of payment");
      return;
    }
    if (account == null) {
      Toast.show("Select Account");
      return;
    }
    if (tec_amount.text.isEmpty) {
      Toast.show("Enter Amount");
      return;
    }

    var headder = ReciptHeadderM(
      PartyCode: party1!.code,
      PartyType: party1!.Type == null ? "C" : party1!.Type!,
      api_key: compRepo!.getSelectedApiKey(),
      CashAmount: 0,
      CreditAmount: 0,
      CardName: "",
      Date: selectedDate!,
      Remarks: tec_text.text,
      // SalesPerson: widget.empId != null ? widget.empId :
      // party1.code,
      DocRefNo: widget.rootId?.toString() ?? "",
      CardNum: 0,
      CheckAmount: 0,
      ChequeDueDate: "",
      ChequeNum: 0,
      TrsfrAmount: 0,
      TrsfrRef: "",
      IsPaymentOnAccount: "${_payOn == PayOn.onAccount ? "Y" : "N"}",
      PaymentOnAccount: 0,
      BankAccount: 0,
      CardAccount: 0,
      CashAccount: 0,
      ChequeAccount: 0,
      DiscountAmount: 0,
      AfterDiscount: 0,
      Document: widget.isRecipt ? 17 : 16,
      TotalBillAmount: double.parse(tec_amount.text),
    );

    if (mode == "Cash") {
      headder.CashAmount = double.parse(tec_amount.text);
      headder.CashAccount = int.parse(account!.code);
    } else if (mode == "Card") {
      headder.CardName = "";
      headder.CardNum = 0;
      headder.TrsfrAmount = double.parse(tec_amount.text);
      headder.CardAccount = int.parse(account?.code);
    } else if (mode == "Bank") {
      headder.TrsfrAmount = double.parse(tec_amount.text);
      headder.BankAccount = int.parse(account?.code);
    } else if (mode == "UPI") {
      headder.TrsfrAmount = double.parse(tec_amount.text);
      headder.BankAccount = int.parse(account?.code);
    } else if (mode == "Cheque") {
      headder.CheckAmount = double.parse(tec_amount.text);
      headder.ChequeAccount = int.parse(account?.code);
    }

    headder.RecTotal = headder.CashAmount +
        headder.CreditAmount +
        headder.TrsfrAmount +
        headder.CheckAmount;

    headder.PaymentOnAccount =
        _payOn == PayOn.onAccount ? headder.RecTotal! : 0;

    if (_payOn == PayOn.chooseBills) {
      headder.RecTotal = double.parse(tec_amount.text);
      var billDataList = list!
          .map((e) => BillDataM(
                  LineEntry: list!.indexOf(e) + 1,
                  LineSequence: e.SourceSequence,
                  LineRecNum: e.SourceNo,
                  BillDate: e.dateText,
                  LineInitNum: e.SourceInitNo,
                  CollectedSum: double.tryParse(e.reciptAmount.toString()) ?? 0,
                  RecTotal: e.TransAmount,
                  Balance: e.TransAmount,
                  InvCategory: e.SourceType,
                  InvEntry: 1)
              .toJson())
          .toList();
      params["billdata"] = json.encode(billDataList);
    } else {
      params["billdata"] = "[]";
    }
    params["accountdata"] = "[]";
    params["headerData"] = json.encode([headder.toJson()]);
    print("params $params");
    print("params str ${json.encode(params)}");
    setState(() {
      isLoading = true;
    });

    var response =
        await Serviece.insertRecipt(context: context, params: params);
    setState(() {
      isLoading = false;
    });
    if (response != null) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: new Text(
              'Saved Sucessfully ${response["DocDetails"][0]["Document"]}'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: new Text('Close'),
            ),
          ],
        ),
      );
      Navigator.pop(context);
    }
  }
}
