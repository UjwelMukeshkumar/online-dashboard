// // To parse this JSON data, do
// //
// //     final searchM = searchMFromJson(jsonString);

// import 'dart:convert';

// SearchM searchMFromJson(String str) => SearchM.fromJson(json.decode(str));

// String searchMToJson(SearchM data) => json.encode(data.toJson());

// class SearchM {
//   SearchM(
//       {this.itemNo,
//       this.itemName,
//       this.description,
//       this.barcode,
//       this.hsnCode,
//       this.taxcode,
//       this.itemGroup,
//       this.brand,
//       this.cost,
//       this.mrp,
//       this.lineRemarks,
//       this.uom,
//       this.batchCode,
//       this.expDate,
//       this.supplierName,
//       this.onhand,
//       this.image,
//       this.quantity});

//   String? itemNo;
//   String? itemName;
//   String? description;
//   String? barcode;
//   String? hsnCode;
//   String? taxcode;
//   String? itemGroup;
//   String? brand;
//   double? cost;
//   double? mrp;
//   String? lineRemarks;
//   String? uom;
//   String? batchCode;
//   dynamic expDate;
//   String? supplierName;
//   double? onhand;
//   String? image;
//   double? quantity;

//   factory SearchM.fromJson(Map<String, dynamic> json) => SearchM(
       
//         //     itemNo: json["Item_No"] == null ? null : json["Item_No"],
//         //     itemName: json["Item_Name"] == null ? null : json["Item_Name"],
//         //     description: json["Description"] == null ? null : json["Description"],
//         //     barcode: json["Barcode"] == null ? null : json["Barcode"],
//         //     hsnCode: json["HSNCode"] == null ? null : json["HSNCode"],
//         //     taxcode: json["Taxcode"] == null ? null : json["Taxcode"],
//         //     itemGroup: json["ItemGroup"] == null ? null : json["ItemGroup"],
//         //     brand: json["Brand"] == null ? null : json["Brand"],
//         //     cost: json["Cost"] == null ? null : json["Cost"].toDouble(),
//         //     mrp: json["MRP"] == null ? null : json["MRP"].toDouble(),
//         //     lineRemarks: json["LineRemarks"] == null ? null : json["LineRemarks"],
//         //     uom: json["UOM"] == null ? null : json["UOM"],
//         //     batchCode: json["BatchCode"] == null ? null : json["BatchCode"],
//         //     expDate: json["Exp_Date"],
//         //     supplierName:
//         //         json["SupplierName"] == null ? null : json["SupplierName"],
//         //     onhand: json["Onhand"] == null ? null : json["Onhand"].toDouble(),
//         // quantity: json["quantity"] == null ? 1 : json["quantity"].toDouble(),
//         //     image: json["Image"] == null ? null : json["Image"],
//          itemNo: json["Item_No"]??"",
//         itemName: json["Item_Name"]??"",
//         description: json["Description"]??"",
//         barcode: json["Barcode"]??"",
//         hsnCode: json["HSNCode"]??"",
//         taxcode: json["Taxcode"]??"",
//         itemGroup: json["ItemGroup"]??"",
//         brand: json["Brand"]??"",
//         cost: json["Cost"]?.toDouble(),
//         mrp: json["MRP"]?.toDouble(),
//         lineRemarks: json["LineRemarks"]??"",
//         uom: json["UOM"],
//         batchCode: json["BatchCode"]??"",
//         expDate: json["Exp_Date"]??"",
//         supplierName: json["SupplierName"]??"",
//         onhand: json["Onhand"]?.toDouble(),
//         quantity: json["quantity"]?.toDouble() ?? 1,
//         image: json["Image"]??"",

        
//       );

//   Map<String, dynamic> toJson() => {
//       "Item_No": itemNo == null ? "" : itemNo,
//         "Item_Name": itemName == null ? "" : itemName,
//         "Description": description == null ? "" : description,
//         "Barcode": barcode == null ? "" : barcode,
//         "HSNCode": hsnCode == null ? "" : hsnCode,
//         "Taxcode": taxcode == null ? "" : taxcode,
//         "ItemGroup": itemGroup == null ? "" : itemGroup,
//         "Brand": brand == null ? "" : brand,
//         "Cost": cost == null ? "" : cost,
//         "MRP": mrp == null ? "" : mrp,
//         "LineRemarks": lineRemarks == null ? "" : lineRemarks,
//         "UOM": uom == null ? "" : uom,
//         "BatchCode": batchCode == null ? "" : batchCode,
//         "Exp_Date": expDate,
//         "SupplierName": supplierName == null ? "" : supplierName,
//         "Onhand": onhand == null ? "" : onhand,
//         "quantity": quantity == null ? 1 : quantity,
//         "Image": image == null ? "" : image,
//         // "Item_No": itemNo == null ? null : itemNo,
//         // "Item_Name": itemName == null ? null : itemName,
//         // "Description": description == null ? null : description,
//         // "Barcode": barcode == null ? null : barcode,
//         // "HSNCode": hsnCode == null ? null : hsnCode,
//         // "Taxcode": taxcode == null ? null : taxcode,
//         // "ItemGroup": itemGroup == null ? null : itemGroup,
//         // "Brand": brand == null ? null : brand,
//         // "Cost": cost == null ? null : cost,
//         // "MRP": mrp == null ? null : mrp,
//         // "LineRemarks": lineRemarks == null ? null : lineRemarks,
//         // "UOM": uom == null ? null : uom,
//         // "BatchCode": batchCode == null ? null : batchCode,
//         // "Exp_Date": expDate,
//         // "SupplierName": supplierName == null ? null : supplierName,
//         // "Onhand": onhand == null ? null : onhand,
//         // "quantity": quantity == null ? 1 : quantity,
//         // "Image": image == null ? null : image,
//       };
// }
import 'dart:convert';

SearchM searchMFromJson(String str) => SearchM.fromJson(json.decode(str));

String searchMToJson(SearchM data) => json.encode(data.toJson());

class SearchM {
  SearchM({
    this.itemNo,
    this.itemName,
    this.description,
    this.barcode,
    this.hsnCode,
    this.taxcode,
    this.itemGroup,
    this.brand,
    this.cost,
    this.mrp,
    this.lineRemarks,
    this.uom,
    this.batchCode,
    this.expDate,
    this.supplierName,
    this.onhand,
    this.image,
    this.quantity,
  });

  String? itemNo;
  String? itemName;
  String? description;
  String? barcode;
  String? hsnCode;
  String? taxcode;
  String? itemGroup;
  String? brand;
  double? cost;
  double? mrp;
  String? lineRemarks;
  String? uom;
  String? batchCode;
  dynamic expDate;
  String? supplierName;
  double? onhand;
  String? image;
  double? quantity;

  factory SearchM.fromJson(Map<String, dynamic> json) => SearchM(
        itemNo: json["Item_No"] as String?,
        itemName: json["Item_Name"] as String?,
        description: json["Description"] as String?,
        barcode: json["Barcode"] as String?,
        hsnCode: json["HSNCode"] as String?,
        taxcode: json["Taxcode"] as String?,
        itemGroup: json["ItemGroup"] as String?,
        brand: json["Brand"] as String?,
        cost: (json["Cost"] as num?)?.toDouble(),
        mrp: (json["MRP"] as num?)?.toDouble(),
        lineRemarks: json["LineRemarks"] as String?,
        uom: json["UOM"] as String?,
        batchCode: json["BatchCode"] as String?,
        expDate: json["Exp_Date"],
        supplierName: json["SupplierName"] as String?,
        onhand: (json["Onhand"] as num?)?.toDouble(),
        quantity: (json["quantity"] as num?)?.toDouble() ?? 1,
        image: json["Image"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "Item_No": itemNo,
        "Item_Name": itemName,
        "Description": description,
        "Barcode": barcode,
        "HSNCode": hsnCode,
        "Taxcode": taxcode,
        "ItemGroup": itemGroup,
        "Brand": brand,
        "Cost": cost,
        "MRP": mrp,
        "LineRemarks": lineRemarks,
        "UOM": uom,
        "BatchCode": batchCode,
        "Exp_Date": expDate,
        "SupplierName": supplierName,
        "Onhand": onhand,
        "quantity": quantity,
        "Image": image,
      };
}
