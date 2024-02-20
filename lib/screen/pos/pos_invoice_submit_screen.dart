import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:glowrpt/model/item/SingleItemM.dart';
import 'package:glowrpt/model/party/SinglePartyDetailsM.dart';
import 'package:glowrpt/model/transaction/DocSaveM.dart';
import 'package:glowrpt/model/transaction/DocumentLoadM.dart';
import 'package:glowrpt/print/PdfApi.dart';
import 'package:glowrpt/print/PdfServiece.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/pos/PosInvoiceHeadderM.dart';
import 'package:glowrpt/service/CartService.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:pdf/pdf.dart';
import 'PosInvoiceLineM.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PosInvoiceSubmitScreen extends StatefulWidget {
  // bool isCredit;
  List<SingleItemM>? itemList;
  DocumentLoadM? documentLoadM;
  SinglePartyDetailsM? selectedPary;
  int? formNo;

  PosInvoiceSubmitScreen(
      {
      // this.isCredit,
      this.itemList,
      this.documentLoadM,
      this.selectedPary,
      this.formNo});

  @override
  _PosInvoiceSubmitScreenState createState() => _PosInvoiceSubmitScreenState();
}

class _PosInvoiceSubmitScreenState extends State<PosInvoiceSubmitScreen> {
  bool interState = false;

  double? lineTotal;

  var taxLineTotal;

  var tecDiscountTotal = TextEditingController();
  var tecGrossTotal = TextEditingController();
  var tecTaxAmount = TextEditingController();
  var tecNetAmount = TextEditingController();

  double freight = 0;

  double discountPercent = 0.0;

   CompanyRepository? compRepo;

  double? discountAmount;

  double? grossTotal;

  double? netAmount;

  CartService? cart;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    SharedPreferences.getInstance().then((value) {
      cart = CartService(value, compRepo!.getSelectedUser());
    });

    intiliseData();
    // DocSaveM();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 12);
    return Scaffold(
      appBar: AppBar(title: Text("Submit".tr)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Text("Date picker"),9400464645
            TextFormField(
              initialValue: lineTotal!.toStringAsFixed(2),
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Line Total".tr, border: textFieldBorder),
            ),
            sizedBox,
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: tecDiscountTotal,
                    // initialValue: "0",
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Discount Total".tr,
                        border: textFieldBorder),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      initialValue: widget.selectedPary!.Discount.toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Discount %".tr, border: textFieldBorder),
                      onChanged: (text) {
                        discountPercent = double.tryParse(text) ?? 0;
                        calculate();
                      },
                    )),
              ],
            ),
            sizedBox,
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: tecGrossTotal,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Gross Total".tr, border: textFieldBorder),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: tecTaxAmount,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Tax".tr, border: textFieldBorder),
                  ),
                ),
              ],
            ),
            sizedBox,
            TextFormField(
              initialValue: "0",
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Frieght".tr, border: textFieldBorder),
              onChanged: (text) {
                freight = double.tryParse(text) ?? 0;
                calculate();
              },
            ),
            sizedBox,
            TextFormField(
              controller: tecNetAmount,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Net Amount".tr, border: textFieldBorder),
            ),
            sizedBox,
            FlutterSwitch(
              inactiveText: "Intrastate".tr,
              activeText: "Interstate".tr,
              // activeTextColor: Colors.black,
              showOnOff: true,
              padding: 6.0,
              width: 150,
              inactiveColor: Colors.red,
              activeColor: Colors.green,
              value: interState,
              onToggle: (value) {
                setState(() {
                  interState = value;
                });
              },
            ),
            // ElevatedButton(child: Text("Submit"), onPressed: submit),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Cash".tr),
                    onPressed: () => submit(false),
                  ),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        child: Text("Credit".tr),
                        onPressed: () => submit(true)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void intiliseData() {
    lineTotal = widget.itemList!
        .map((e) => e.preTaxPriceTotal)
        .fold(0, (previousValue, element) => previousValue! + element);

    calculate();
  }

  void getFright() {
    /* interstate
        ? widget.documentLoadM.Freight.first.
        : widget.documentLoadM.freight.last; */
  }

  void calculate() {
    taxLineTotal = widget.itemList!
            .map((e) => e.taxAmountTotal)
            .fold(0.0, (previousValue, element) => previousValue + element) *
        (100 - discountPercent) /
        100;
    discountAmount = (lineTotal! * (discountPercent) / 100);
    tecDiscountTotal.text = discountAmount!.toStringAsFixed(2);
    grossTotal = (lineTotal! - discountAmount!);
    tecGrossTotal.text = grossTotal!.toStringAsFixed(2);

    netAmount = (grossTotal! + taxLineTotal + freight);
    tecNetAmount.text = netAmount!.toStringAsFixed(2);
    tecTaxAmount.text = taxLineTotal.toStringAsFixed(2);
  }

  Future<void> submit(bool isCredit) async {
    var user = compRepo!.getSelectedUser();
    var defAccount = widget.documentLoadM!.Default_Account.first;
    var defValues = widget.documentLoadM!.Default_Values.first;
    FreightBean freightM;
    if (interState) {
      freightM = widget.documentLoadM!.Freight.first;
    } else {
      freightM = widget.documentLoadM!.Freight.last;
    }
    var freightDataBean = FreightDataBean(
        AccountCode: freightM.AccountCode,
        AccountName: freightM.AccountName,
        Amount: freight);

    var lines = widget.itemList!.map((e) {
      int position = widget.itemList!.indexOf(e);
      return PosInvoiceLineM(
        Sl_No: (position + 1),
        Item_No: e.Item_No.toString(),
        Item_Name: e.Item_Name.toString(),
        Quantity: e.quantity??0,
        FOC: 0,
        IsInclusive: e.IsInclusive.toString(),
        Price: e.Price??0,
        Discount: e.Discount??0,
        Batch_Code: e.BatchCode.toString(),
        NetTotal: e.preTaxPriceTotal,
        TaxCode: e.TaxCode.toString(),
        TaxRate: e.TaxRate??0,
        Source_Type: "",
        SourceRecNum: 0,
        Source_Line_No: 0,
        SourceSequence: 0,
        SourceInitNo: 0,
        TaxAmount: e.taxAmountTotal,
        LineStatus: "O",
        PriceFC: e.preTaxAmount??0,
      );
    }).toList();
    var headder = PosInvoiceHeadderM(
        Sequence: 0,
        PartyCode: widget.selectedPary!.CVCode,
        Date: MyKey.getCurrentDate(),
        DiscountPerc: discountPercent,
        LineTotal: lineTotal!,
        DiscountAmt: discountAmount!,
        NetAmt: netAmount!,
        Freight_Charge: freight,
        RoundingAmount: 0,
        BankRefNumber: "",
        CardMobileNumber: "",
        CashTendered: 0,
        TenderedBalance: 0,
        TotalTendered: 0,
        TrfsAmount: 0,
        VoucherNumber: "",
        TaxAmount: taxLineTotal,
        Document: widget.formNo!,
        RecNum: 0,
        CardAmount: 0,
        CardNumber: "0",
        CashAmount: isCredit ? 0 : netAmount!, //based on payment type
        InterState: interState ? "Y" : "N");

    Map params = Map();
    params["Db"] = user.db;
    params["server"] = user.server;
    params["LoginID"] = user.loginId;
    params["LoginNo"] = user.loginNo.toString();
    params["headerData"] = json.encode([headder.toJson()]);
    params["lineData"] = json.encode(lines.map((e) => e.toJson()).toList());
    var result =
        await Serviece.insertPosInvoice(context: context, params: params);

    await Printing.layoutPdf(
        format: PdfPageFormat.roll57,
        onLayout: (format) async => await Printing.convertHtml(
              format: format,
              html: '<html><body><p>Hello</p></body></html>',
            ));
/*    await PdfApi.printPdf(PdfService.generatePosPdf(
        user: user,
        posInvoiceHeadderM: headder,
        lines: lines,
        party: widget.selectedPary));*/

    /*  if (result != null) {
      Navigator.pop(context, true);
      Navigator.pop(context, true);
      cart.clearCart();
      Toast.show("Success", context, duration: Toast.LENGTH_LONG);
    }*/
  }
}
