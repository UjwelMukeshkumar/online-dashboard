import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:open_file_safe/open_file_safe.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
class PdfApi{
  static Future<File> _saveDocument({ required String name,required Document pdf}) async{
    final bytes =await pdf.save();

    final dir =await getApplicationDocumentsDirectory();
    final file=File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static printPdf(Future<Document> generator) async {
    Document doc=await generator;
    Printing.layoutPdf(onLayout: (format) =>doc.save());
  }

  static sharePdf(Future<Document> generator) async {
    var doc=await generator;
    final bytes =await doc.save();
    Printing.sharePdf(bytes: bytes);
  }

  static openPd(Future<Document> generator,String title) async {
    var doc=await generator;
    var file=await _saveDocument(name: "$title.pdf", pdf: doc);
    OpenFile.open(file.path);
  }
}