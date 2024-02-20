import 'package:glowrpt/main.dart';

enum DisplayType { rowType, gridType }

enum DataType {
  numberType,
  numberType0,
  percentType,
  percentType0,
  textType,
  textTypeRight,
  numberNonCurrenncy,
  numberNonCurrenncy0,
  raiseFall
}

class HeadderParm {
  String? type;
  String? title;
  List<String>? summationField;
  DisplayType? displayType;
  List<String>? paramsOrder;
  List<int>? paramsFlex;
  List<DataType>? dataType;
  String endPont;
  String? params;
  String tableName;
  bool? isPaginated;
  Map<String, String>? fieldReplacer = Map();
  bool? isDateDipend;
  String? dateRange;

  HeadderParm({
    this.type,
    this.title,
    this.summationField,
    this.params,
    this.tableName = "Header",
    this.endPont = "homedoc",
    this.isPaginated = false,
    this.fieldReplacer,
    this.isDateDipend = true,
    this.dateRange = "",
     this.paramsFlex,
    this.dataType,
    this.displayType,
    this.paramsOrder,
  });
}
