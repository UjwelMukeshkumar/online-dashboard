import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/model/item/SingleItemM.dart';
import 'package:glowrpt/model/transaction/DocSaveM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:http/http.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfViewPage extends StatelessWidget {
  final List<SingleItemM> itemList;
  final DocSaveM data;
  final String companyName;

  PdfViewPage({
    required this.itemList,
    required this.data,
    // String? comapnyname,
    required this.companyName,
  });
  var head;
  @override
  Widget build(BuildContext context) {
    print("Company Name is $companyName");
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
    // ... existing code ...
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        pageFormats: {
          "A4": PdfPageFormat.a4.copyWith(
              marginLeft: 4, marginRight: 4, height: PdfPageFormat.a4.height),
          "roll80": PdfPageFormat.roll80.copyWith(
              marginLeft: 4, marginRight: 4, height: PdfPageFormat.a4.height),
          "roll57": PdfPageFormat.roll57.copyWith(
              marginLeft: 4, marginRight: 4, height: PdfPageFormat.a4.height),
        },
        build: (format) async {
          final pdf = await _generatePdfContent(format);
          return pdf.save();
        },
        actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }

  void _showPrintedToast(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File('$appDocPath/document.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  // Future<pw.Document> _generatePdfContent(PdfPageFormat pageFormat) async {
  //   final pdf = pw.Document();

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: pageFormat,
  //       build: (context) {
  //         return pw.Column(

  //             // crossAxisAlignment: pw.CrossAxisAlignment
  //             //     .start, // Align children to the start (left side)
  //             children: [
  //               pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.Text(
  //                         head,
  //                         style: pw.TextStyle(
  //                           fontSize: 16,
  //                           fontWeight: pw.FontWeight.bold,
  //                         ),
  //                       ),
  //                       pw.SizedBox(
  //                         height: 10,
  //                       ),
  //                       pw.Text(
  //                         '$head No: ${data.headerData.first.RecNum}',
  //                         style: pw.TextStyle(fontSize: 10),
  //                       ),
  //                       pw.SizedBox(
  //                         height: 10,
  //                       ),
  //                       pw.Text(
  //                         'Company Name: $companyName',
  //                         style: pw.TextStyle(fontSize: 10),
  //                       ),
  //                       pw.SizedBox(
  //                         height: 10,
  //                       ),
  //                       pw.Text(
  //                         'Bill To: ${data.headerData.first.PartyName}',
  //                         style: pw.TextStyle(fontSize: 10),
  //                       ),
  //                     ],
  //                   ),
  //                   pw.Text(
  //                     'Date: ${data.headerData.first.Date}',
  //                     style: pw.TextStyle(fontSize: 10),
  //                   ),
  //                 ],
  //               ),
  //               // Add other details as needed

  //               pw.Table.fromTextArray(
  //                 context: context,
  //                 headerAlignment: pw.Alignment.center,
  //                 cellAlignment: pw.Alignment.center,
  //                 cellStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
  //                 headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
  //                 headers: ['Item Names\nprice', 'Qty', 'Total'],
  //                 data: itemList
  //                     .map((item) => [
  //                           item.Item_Name,
  //                           item.quantity,
  //                           'Rs ${data.lineData.first.Total}'
  //                         ])
  //                     .toList(),
  //               ),

  //               pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   pw.Text(
  //                     'Net Amount: ',
  //                     style: pw.TextStyle(fontSize: 10),
  //                   ),
  //                   pw.Text(
  //                     'Rs ${data.headerData.first.NetAmt}',
  //                     style: pw.TextStyle(fontSize: 10),
  //                   ),
  //                 ],
  //               ),
  //               pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   pw.Text(
  //                     'Recieved Amount: ',
  //                     style: pw.TextStyle(fontSize: 10),
  //                   ),
  //                   pw.Text(
  //                     'Rs ${data.headerData.first.recceivedAmount}',
  //                     style: pw.TextStyle(fontSize: 10),
  //                   ),
  //                 ],
  //               ),
  //               pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   pw.Text(
  //                     'Total Balance: ',
  //                     style: pw.TextStyle(fontSize: 10),
  //                   ),
  //                   pw.Text(
  //                     'Rs ${data.lineData.first.Total}',
  //                     style: pw.TextStyle(fontSize: 10),
  //                   ),
  //                 ],
  //               )
  //             ]);
  //       },
  //     ),
  //   );

  //   return pdf;
  // }

  Future<pw.Document> _generatePdfContent(PdfPageFormat pageFormat) async {
    List<String> salesOrdertableHeaders = [
      'Item Name',
      'Price',
      'Qty',
      'Total'
    ];

    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: pageFormat,
      build: (context) {
        return [
          ///Header
          pw.Column(children: [
            pw.SizedBox(height: 4),
            pw.Text(head),
            pw.SizedBox(height: 4),
            pw.Text(companyName),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('$head No: ${data.headerData.first.RecNum}'),
                  pw.Text('Date: ${data.headerData.first.Date}'),
                ]),
          ]),
          pw.Text('Bill To: ${data.headerData.first.PartyName}'),

          ///Table
          pw.Table.fromTextArray(
            context: context,
            headerAlignment: pw.Alignment.center,
            cellAlignment: pw.Alignment.center,
            cellStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
            headers: ['Item Names\nprice', 'Qty', 'Total'],
            data: itemList
                .map((item) => [
                      '${item.Item_Name}\nRs ${item.Price}',
                      item.quantity,
                      'Rs ${data.lineData.first.Total}'
                    ])
                .toList(),
          ),

          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Net Amount: ',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Rs ${data.headerData.first.NetAmt}',
                style: pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Recieved Amount: ',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Rs ${data.headerData.first.recceivedAmount}',
                style: pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Total Balance: ',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Rs ${data.lineData.first.Total}',
                style: pw.TextStyle(fontSize: 10),
              ),
            ],
          )
        ];
      },
    ));
    return pdf;
  }
}
