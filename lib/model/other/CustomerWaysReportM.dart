import 'dart:convert';

class CustomerWaysSalesReportM {
  List<Table> table;

  CustomerWaysSalesReportM({
    required this.table,
  });

  factory CustomerWaysSalesReportM.fromRawJson(String str) =>
      CustomerWaysSalesReportM.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerWaysSalesReportM.fromJson(Map<String, dynamic> json) =>
      CustomerWaysSalesReportM(
        table: List<Table>.from(json["Table"].map((x) => Table.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table.map((x) => x.toJson())),
      };
}

class Table {
  String itemNo;
  String itemName;

  Table({
    required this.itemNo,
    required this.itemName,
  });

  factory Table.fromRawJson(String str) => Table.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        itemNo: json["Item_No"],
        itemName: json["Item_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Item_No": itemNo,
        "Item_Name": itemName,
      };
}
