import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glowrpt/appdouble.dart';
import 'package:glowrpt/library/CollectionOperation.dart';
import 'package:glowrpt/model/item/SingleItemM.dart';
import 'package:glowrpt/model/party/SinglePartyDetailsM.dart';
import 'package:glowrpt/model/transaction/DocSaveM.dart';
import 'package:glowrpt/model/transaction/DocumentLoadM.dart';
import 'package:glowrpt/pdf/pdf_view.dart';
import 'package:glowrpt/print/web_view_page.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:printing/printing.dart';
// import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:glowrpt/print/PdfApi.dart';
import 'package:glowrpt/print/PdfServiece.dart';
import 'package:pdf/pdf.dart';
import 'package:toast/toast.dart';
import 'package:glowrpt/library/DateFactory.dart';
import 'package:date_field/date_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import '../../model/DocumentSplitter.dart';
// import '../../model/employe/EmpLoadM.dart';
import '../../model/route/PlannerRouteLoadM.dart';
// import '../../print/web_view_page.dart';

// ignore: must_be_immutable
class InvoiceSubmitScreen extends StatefulWidget {
  // bool isCredit;
  List<SingleItemM>? itemList;
  DocumentLoadM? documentLoadM;
  SinglePartyDetailsM? selectedPary;
  int? formNo;
  RouteDetailsBean? rootDetails;
  int? rootId;
  String? empId;
  bool isDeliveryForm;
  String? savemode;


  InvoiceSubmitScreen({
    this.rootId,
    this.rootDetails,
    this.itemList,
    this.documentLoadM,
    this.selectedPary,
    this.empId,
    this.formNo,
    this.isDeliveryForm = false,
    this.savemode,

  });

  @override
  _InvoiceSubmitScreenState createState() => _InvoiceSubmitScreenState();
}

class _InvoiceSubmitScreenState extends State<InvoiceSubmitScreen> {
  bool interstate = true;

  double? lineTotal;

  var taxLineTotal;

  var tecDiscountTotal = TextEditingController();
  var tecGrossTotal = TextEditingController();
  var tecTaxAmount = TextEditingController();
  var tecNetAmount = TextEditingController();
  var VehicleNo = TextEditingController();

  PartySearchM? selectedEmp;
  double freight = 0;

  double discountPercent = 0.0;

  CompanyRepository? compRepo;

  double? discountAmount;

  double? grossTotal;

  double? netAmount;

  DateTime selectedDate = DateTime.now();

  bool isLoding = false;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    intiliseData();
    // DocSaveM();
  }

  @override
  Widget build(BuildContext context) {
    print(
     "DOcreffffffff ${widget.rootId.toString()}",
    );
    var sizedBox = SizedBox(height: 12);
    return Scaffold(
      appBar: AppBar(title: Text("Submit")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        // child: Text("Testing.................."),
        child: ListView(
          children: [
            // Text("Date picker"),9400464645
            TextFormField(
              initialValue: lineTotal?.toStringAsFixed(2),
              // initialValue: "2.0",
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Line Total", border: textFieldBorder),
            ),
            sizedBox,
            if (!widget.isDeliveryForm) ...[
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: tecDiscountTotal,
                      // initialValue: "0",
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: "Discount Total", border: textFieldBorder),
                    ),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: widget.selectedPary?.Discount.toString(),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Discount %", border: textFieldBorder),
                        onChanged: (text) {
                          discountPercent = double.tryParse(text) ?? 0.0;
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
                          labelText: "Gross Total", border: textFieldBorder),
                    ),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: tecTaxAmount,
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: "Tax", border: textFieldBorder),
                    ),
                  ),
                ],
              ),
              sizedBox,
              TextFormField(
                initialValue: "0",
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Frieght", border: textFieldBorder),
                onChanged: (text) {
                  freight = double.tryParse(text) ?? 0.0;
                  calculate();
                },
              ),
              sizedBox,
            ],
            TextFormField(
              controller: tecNetAmount,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "Net Amount", border: textFieldBorder),
            ),
            sizedBox,
            DropdownSearch<PartySearchM>(
              popupProps: PopupProps.menu(
                showSearchBox: true,
                isFilterOnline: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                labelText: "Driver",
              )),
              // mode: Mode.MENU,
              selectedItem: selectedEmp,
              // showSearchBox: true,
              // label: "Driver",
              // isFilteredOnline: true,
              asyncItems: (text) => Serviece.partySearch(
                context: context,
                api_key: compRepo!.getSelectedApiKey(),
                Type: "E",
                query: text,
              ),
              // onFind: (text) => Serviece.partySearch(
              //     context: context,
              //     api_key: compRepo.getSelectedApiKey(),
              //     Type: "E", //for Employee
              //     query: text),
              onChanged: (party) {
                selectedEmp = party;
              },
            ),
            sizedBox,
            TextFormField(
              controller: VehicleNo,
              decoration: InputDecoration(
                labelText: "Vehicle Number",
                border: textFieldBorder,
              ),
              autovalidateMode: AutovalidateMode.always,
            ),

            // FlutterSwitch(
            //   inactiveText: "Intrastate",
            //   activeText: "Interstate",
            //   // activeTextColor: Colors.black,
            //   showOnOff: true,
            //   padding: 6.0,
            //   width: 150,
            //   inactiveColor: Colors.red,
            //   activeColor: Colors.green,
            //   value: !interstate,
            //   onToggle: (value) {
            //     setState(() {
            //       interstate = !value;
            //     });
            //   },
            // ),
            // ElevatedButton(child: Text("Submit"), onPressed: submit),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Cash"),
                    onPressed: isLoding ? null : () => submit(false),
                  ),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        child: Text("Credit"),
                        onPressed: isLoding ? null : () => submit(true)),
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
    var comapnyname = user.organisation;
    var defAccount = widget.documentLoadM?.Default_Account.first;
    var defValues = widget.documentLoadM?.Default_Values.first;
    FreightBean? freightM;
    if (interstate) {
      freightM = widget.documentLoadM?.Freight.first;
    } else {
      freightM = widget.documentLoadM?.Freight.last;
    }
    var freightDataBean = FreightDataBean(
        AccountCode: freightM?.AccountCode,
        AccountName: freightM?.AccountName,
        Amount: freight);
    var data = DocSaveM(
        Db: user.db.toString(),
        LoginID: user.loginId.toString(),
        LoginNo: user.loginNo!,
        server: user.server.toString(),
        savemode: widget.savemode?? "",
        //savemode: "SAVE & POST",
        freightData: [freightDataBean],
        headerData: [
          HeaderDataBean(
            Sequence: defValues?.Series_Id,
            PartyCode: widget.selectedPary?.CVCode,
            PartyName: widget.selectedPary?.CVName,
            Date: MyKey.getCurrentDate(),
            ReferenceDate: MyKey.getCurrentDate(),
            DueDate: MyKey.displayDateFormat.format(selectedDate),
            Amount: lineTotal!,
            PriceList: widget.selectedPary?.PriceList,
            Store: defValues?.Store_Code,
            DiscountAmt: discountAmount ?? 0,
            NetAmt: netAmount ?? 0.0,
            Doc_Status: "A",
            GLAccount: widget.selectedPary?.GLAccount.toString(),
            Freight_Charge: freight,
            RoundingAmount: 0,
            RoundingAccount: defValues?.RoundingAccount.toString(),
            TAX1: widget.selectedPary?.TAX1,
            TAX2: widget.selectedPary?.TAX2,
            FormNo: widget.selectedPary?.FormNo,
            Remarks: "",
            DiscountPercHeader: discountPercent,
            SalesPerson: selectedEmp?.EmpID ?? 1,
            // (widget.empId != null
            // ignore: unnecessary_null_comparison
            // (widget.empId != null
            //     ? widget.empId??1
            //     : widget.selectedPary.SalesPerson,
            // DocRefNo: widget.rootId?.toString() ?? "",
           // DocRefNo: widget.rootId.toString(),
           DocRefNo: DateTime.now().millisecondsSinceEpoch.toString(),
            //input value when purchase
            TaxAmount: taxLineTotal,
            Document: widget.formNo,
            //from ticket
            Status: "A",
            //okay
            RecNum: defValues?.RecNum,
            InitNo: 0,
            //always 0 for without edit
            SourceRecNum: defValues?.RecNum,
            SourceSequence: defValues?.Series_Id,
            SourceInitNo: 0,
            TargetInitNo: 0,
            TargetRecNum: defValues?.RecNum,
            TargetSequence: defValues?.Series_Id,
            Attempt: 1,
            KFCGST: 0,
            InterState: "N",
            CardAccount: defAccount?.CardAccount,
            CardAmount: 0,
            CardHolder: 0,
            CardValidDate: MyKey.getCurrentDate(),
            CardNumber: 0,
            CashAccount: defAccount?.CashAccount,
            CashAmount: isCredit ? 0 : netAmount,
            //based on payment type
            ExchangeRate: 1,
            Payment_Id: widget.selectedPary?.PaymentTerms,
            DispatchNo: VehicleNo.text,
          )
        ],
        lineData: widget.itemList!.map((e) {
          int index = widget.itemList!.indexOf(e) + 1;
          return LineDataBean(
              Sl_No: index,
              Item_No: e.Item_No,
              Item_Name: e.Item_Name,
              Barcode: e.Barcode,
              Quantity: e.quantity,
              FOC: 0,
              IsInclusive: e.IsInclusive,
              Price: e.Price,
              Discount: e.Discount,
              BatchCode: e.BatchCode,
              BatchBarcode: "",
              UOM: e.UOM ?? "",
              UOM_quantity: e.UOM_quantity,
              Total: e.priceWithTaxTotal,
              DiscountPercHeader: widget.selectedPary?.Discount,
              DiscAmountHeader: 0,
              NetTotal: e.preTaxPriceTotal,
              Store_Code: defValues?.Store_Code,
              Taxcode: e.TaxCode,
              Tax_Rate: e.TaxRate,
              Cost: 0,
              Open_Qty: e.quantity,
              Source_Type: "",
              SourceRecNum: 0,
              Source_Line_No: 0,
              SourceSequence: 0,
              SourceInitNo: 0,
              TaxAmount: e.taxAmountTotal,
              Onhand: 0,
              LineStatus: "O",
              PreTaxTotal: e.preTaxPriceTotal,
              PriceFC: e.preTaxAmount,
              SellingPrice: 0,
              SellingDis: 0,
              SalesPersonName: "",
              Supplier: e.Supplier,
              LineRemarks: "");
        }).toList());
    print("Json ${data.toFullJson()}");
    setState(() {
      isLoding = true;
    });
    // print("dataaaaaaaaaaa:::$data");
    var result = await Serviece.documentSave(
        context: context, params: data.toStringJson());
    setState(() {
      isLoding = false;
    });
    var head;
    if (data.headerData.first.Document == DocumentFormId.SalesReturn) {
      head = "Sales Return";
    } else if (data.headerData.first.Document ==
        DocumentFormId.PurchaseReturn) {
      head = "Purchase Return";
    } else if (data.headerData.first.Document == DocumentFormId.SalesOrder) {
      head = "Sales Order";
    } else if (data.headerData.first.Document == DocumentFormId.PurchaseOrder) {
      head = "Purchase Order";
    } else if (data.headerData.first.Document == DocumentFormId.Payment) {
      head = "Payment";
    } else if (data.headerData.first.Document == DocumentFormId.Sales) {
      head = "Sales";
    } else if (data.headerData.first.Document == DocumentFormId.Purchase) {
      head = "Purchase";
    } else if (data.headerData.first.Document == DocumentFormId.Receipt) {
      head = "Reciept";
    } else if (data.headerData.first.Document == DocumentFormId.DeleveryForm) {
      head = "Delivery Form";
    }

    if (result != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewPage(
              itemList: widget.itemList!,
              data: data,
              companyName: comapnyname! // Pass the data to the PdfViewPage
              ),
        ),
      );
      //  printDetails(result);
      //WebViewPage();
      //Get.to(PdfViewView(), arguments: data);
//       await Printing.layoutPdf(
//         format: PdfPageFormat.roll57.copyWith(
//             marginLeft: 4, marginRight: 4, height: PdfPageFormat.a4.height),
//         //   onLayout: (PdfPageFormat format) async =>
//         // );
//         onLayout: (PdfPageFormat format) async {
//           String itemListHtml = '';

//           for (var item in widget.itemList!) {
//             itemListHtml += '''
//       <tr>
//         <td>${item.Item_Name}<br>${item.priceWithTaxTotal}</td>
//         <td>${item.quantity}</td>
//         <td>Rs ${item.taxAmountTotal}</td>
//       </tr>
//     ''';
//           }

//           return await Printing.convertHtml(format: format, html: '''
//       <html>
//         <head>
//           <title>Invoice</title>
//           <style>
//             table {
//               border-collapse: collapse;
//               width: 100%;
//               margin-bottom: 20px;
//             }
//             table, th, td {
//               border: 1px solid black;
//               padding: 5px;
//               text-align: center;
//             }
//             th {
//               background-color: #ddd;
//             }
//             .red-dot {
//               position: absolute;
//               bottom: 10px;
//               left: 50%;
//               transform: translateX(-50%);
//               height: 10px;
//               width: 10px;
//               border-radius: 50%;
//               background-color: red;
//             }
//           </style>
//         </head>
//         <body>
//           <div>
//             <center><h2>$head</h2></center>
//             <div>
//             <h3>$head <span style="float: right;">Date: ${data.headerData.first.Date}</span></h3>
//             </div>
//             </div>
//             <h3>Bill To: ${data.headerData.first.PartyName}</h3>
//           </div>
//           <table>
//             <thead>
//               <tr>
//                 <th>Item Names<br>price</th>
//                 <th>Qty</th>
//                 <th>Total</th>
//               </tr>
//             </thead>
//             <tbody>
//               $itemListHtml
//             </tbody>
//           </table>
//           <div>
//             <h3>Net Amount:<span style="float: right;">Rs.${data.headerData.first.NetAmt}</span></h3>
//             <h3>Received  :<span style="float: right;">Rs.${data.headerData.first.recceivedAmount}</span></h3>
//              <h3>OldBalance:<span style="float: right;">Rs.${data}</span></h3>
//           <h3>TotalBalance:<span style="float: right;">Rs.${data.lineData.first.Total}</span></h3>
//           </div>
//           <div class="red-dot"></div>
//         </body>
//       </html>
//     ''');
//         },

// //           onLayout: (format) async =>
// //               await Printing.convertHtml(format: format, html: '''<html>
// // <head>
// // 	<title>Invoice</title>
// // 	<style>
// // 		table {
// // 			border-collapse: collapse;
// // 			width: 100%;
// // 			margin-bottom: 20px;
// // 		}
// // 		table, th, td {
// // 			border: 1px solid black;
// // 			padding: 5px;
// // 			text-align: center;
// // 		}
// // 		th {
// // 			background-color: #ddd;
// // 		}
// // 		.red-dot {
// // 			position: absolute;
// // 			bottom: 10px;
// // 			left: 50%;
// // 			transform: translateX(-50%);
// // 			height: 10px;
// // 			width: 10px;
// // 			border-radius: 50%;
// // 			background-color: red;
// // 		}
// // 	</style>
// // </head>
// // <body>
// // 	<div>
// //     <h1>$head</h1>
// // 		<h2>$head No: </h2>
// // 		<h3>Date: ${data.headerData.first.Date}</h3>
// // 		<h3>Bill To: ${data.headerData.first.PartyName}</h3>
// // 	</div>
// // 	<table>
// // 		<thead>
// // 			<tr>
// // 				<th>Item Names<br>price</th>
// // 				<th>Qty</th>
// // 				<th>Tax</th>
// // 			</tr>
// // 		</thead>
// // 		<tbody>
// // 			<tr>
// // 				<td>${data.lineData.first.Item_Name}<br>${data.headerData.first.Amount}</td>
// // 				<td>${data.lineData.first.Quantity}</td>
// // 				<td>Rs ${data.lineData.first.Total}</td>
// // 			</tr>
// // 		</tbody>
// // 	</table>
// // 	<div>
// // 		<h3>Net Amount: Rs ${data.headerData.first.NetAmt}</h3>

// // 		<h3>Received: Rs ${data.headerData.first.recceivedAmount}</h3>
// // 		<h3> Total  Balance: Rs ${data.lineData.first.Total}</h3>
// // 	</div>
// // 	<div class="red-dot"></div>
// // </body>

// //             </html>''')
//       );
      Navigator.pop(context);
      Navigator.pop(context);

      // DocPrint(result["DocDetails"][0]["DocumentNo"],
      //     result["DocDetails"][0]["Document"]);
      Toast.show("Success");
    }

    Future<void> printDetails() async {
      String? criptString = await Serviece.getCriptString(
          context: context,
          api_key: compRepo!.getSelectedApiKey(),
          fullDocument: result["DocDetails"][0]["Document"],
          DocumentNumber: result["DocDetails"][0]["DocumentNo"].toString());
      var docSplitter =
          DocumentSplitter(document: result["DocDetails"][0]["Document"]);
      String printUrl =
          "https://print.glowsis.com/p?t=${result["DocDetails"][0]["DocumentNo"]}-${compRepo?.getSelectedUser().orgId}-$criptString";
      final Uri _url = Uri.parse(printUrl);
      launchUrl(_url, mode: LaunchMode.externalApplication);
    }

    DocPrint(String DocumentNo, String Document) async {
      Future<void> printDetails() async {
        String? criptString = await Serviece.getCriptString(
            context: context,
            api_key: compRepo!.getSelectedApiKey(),
            fullDocument: Document,
            DocumentNumber: DocumentNo);
        var docSplitter = DocumentSplitter(document: Document);
        String printUrl =
            "https://print.glowsis.com/p?t=${Document}-${compRepo?.getSelectedUser().orgId}-$criptString";
        final Uri _url = Uri.parse(printUrl);
        launchUrl(_url, mode: LaunchMode.externalApplication);
      }
    }
  }

  Future<void> printDetails(result) async {
    var docSplitter =
        DocumentSplitter(document: result["DocDetails"][0]["Document"]);
    String? criptString = await Serviece.getCriptString(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        fullDocument: result["DocDetails"][0]["Document"],
        DocumentNumber: result["DocDetails"][0]["DocumentNo"].toString());

    String printUrl =
        "https://print.glowsis.com/p?t=${result["DocDetails"][0]["DocumentNo"]}-${compRepo?.getSelectedUser().orgId}-$criptString";
    print("printing Url ${printUrl}");
    // return;
    final Uri _url = Uri.parse(printUrl);
    launchUrl(_url, mode: LaunchMode.externalApplication);
  }
}
