// import 'package:flutter/material.dart';

import 'package:glowrpt/model/other/TDetailsM.dart';
import 'package:glowrpt/model/other/THeadderM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/model/party/SinglePartyDetailsM.dart';
import 'package:glowrpt/screen/pos/PosInvoiceHeadderM.dart';
import 'package:glowrpt/screen/pos/PosInvoiceLineM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfService {
  static Future<Document> generatePosPdf({
    required PosInvoiceHeadderM posInvoiceHeadderM,
    required List<PosInvoiceLineM> lines,
    required User user,
    required SinglePartyDetailsM party,
  }) async {
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final font2 = await PdfGoogleFonts.sansitaBold();
    var myStyle = TextStyle(font: font, fontSize: 26);
    var styleBold = TextStyle(font: font2, fontSize: 26);
    final pdf = Document();
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Column(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(user.organisation!, style: styleBold),
                Text("Email: ${user.companyEmail}", style: myStyle),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(party.CVName, style: myStyle),
                Text("On", style: myStyle),
                Text(posInvoiceHeadderM.Date, style: styleBold),
              ],
            ),
            SizedBox(height: 30),
            Text("Hello"),
          ]); // Center
        }));
    return pdf;
  }

  static Future<Document> generateTransactionPdf({
   required THeadderM headderM,
   required TDetailsM detailsM,
   required User user,
  }) async {
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final font2 = await PdfGoogleFonts.sansitaBold();
    var myStyle = TextStyle(font: font, fontSize: 26);
    var styleBold = TextStyle(font: font2, fontSize: 26);
    final pdf = Document();
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Column(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(user.organisation!, style: styleBold),
                Text("Email: ${user.companyEmail}", style: myStyle),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(headderM.name, style: myStyle),
                Text("On", style: myStyle),
                Text(detailsM.date, style: styleBold),
              ],
            ),
            SizedBox(height: 30),
            Text(detailsM.Document, style: myStyle),
            Text(detailsM.category, style: styleBold),
            Text(detailsM.Source_Type, style: myStyle),
            Text(MyKey.currencyFromat(detailsM.balance.toString()),
                style: myStyle),
          ]); // Center
        }));
    return pdf;
  }
}
