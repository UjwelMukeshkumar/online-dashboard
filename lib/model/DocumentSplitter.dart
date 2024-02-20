

class DocumentSplitter{
  String document;

  DocumentSplitter({required this.document});
  String get sequence=>document.split("/").first;
  String get recNo=>document.split("/").last.split("-").first;
  String get initNumber=>document.split("/").last.split("-").last;

}