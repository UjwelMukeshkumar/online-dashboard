import 'package:json_annotation/json_annotation.dart';

//part 'SingleItemM.g.dart';

@JsonSerializable()
class SingleItemM {
  String? Item_No;
  String? Item_Name;
  String? Barcode;
  String? HSNCode;
  num? Store_Code;
  num? Onhand;
  num? Price;
  num? Discount;
  String? BatchCode;
  String? TaxCode;
  num? TaxRate;
  String? IsInclusive;
  String? FormId;
  String? UOM;
  num? UOM_quantity;
  String? LineRemarks;
  num? MRP;
  num? PurchasePrice;

  factory SingleItemM.fromJson(Map<String, dynamic> json) {
    return SingleItemM(
      Item_No: json["Item_No"],
      Item_Name: json["Item_Name"],
      Barcode: json["Barcode"],
      HSNCode: json["HSNCode"],
      Store_Code: json["Store_Code"],
      Onhand: json["Onhand"],
      Price: json["Price"],
      Discount: json["Discount"],
      BatchCode: json["BatchCode"],
      TaxCode: json["TaxCode"],
      TaxRate: json["TaxRate"],
      IsInclusive: json["IsInclusive"],
      FormId: json["FormId"],
      UOM: json["UOM"],
      UOM_quantity: json["UOM_quantity"],
      LineRemarks: json["LineRemarks"],
      MRP: json["MRP"],
      PurchasePrice: json["PurchasePrice"],
      Cost: json["Cost"],
      SellingPrice: json["SellingPrice"],
      SellingDis: json["SellingDis"],
      Supplier: json["Supplier"],
      Type: json["Type"],
      GSTCess: json["GSTCess"],
      quantity: json["quantity"] ?? 0,
      /*quntityManuallyChanged:
          json["quntityManuallyChanged"],
      UOMManuallyChanged: json["UOMManuallyChanged"],
      priceManuallyChanged:
          json["priceManuallyChanged"],
      discountManullyChanged:
          json["discountManullyChanged"],*/
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Item_No": this.Item_No,
      "Item_Name": this.Item_Name,
      "Barcode": this.Barcode,
      "HSNCode": this.HSNCode,
      "Store_Code": this.Store_Code,
      "Onhand": this.Onhand,
      "Price": this.Price,
      "Discount": this.Discount,
      "BatchCode": this.BatchCode,
      "TaxCode": this.TaxCode,
      "TaxRate": this.TaxRate,
      "IsInclusive": this.IsInclusive,
      "FormId": this.FormId,
      "UOM": this.UOM,
      "UOM_quantity": this.UOM_quantity,
      "LineRemarks": this.LineRemarks,
      "MRP": this.MRP,
      "PurchasePrice": this.PurchasePrice,
      "Cost": this.Cost,
      "SellingPrice": this.SellingPrice,
      "SellingDis": this.SellingDis,
      "Supplier": this.Supplier,
      "Type": this.Type,
      "GSTCess": this.GSTCess,
      "quantity": this.quantity,
      "quntityManuallyChanged": this.quntityManuallyChanged,
      "UOMManuallyChanged": this.UOMManuallyChanged,
      "priceManuallyChanged": this.priceManuallyChanged,
      "discountManullyChanged": this.discountManullyChanged,
    };
  }

  num? Cost;
  num? SellingPrice;
  num? SellingDis;
  String? Supplier;
  String? Type;
  num? GSTCess;
  num? quantity;

  bool quntityManuallyChanged;
  bool UOMManuallyChanged;
  bool priceManuallyChanged;
  bool discountManullyChanged;

  SingleItemM(
      {
       this.Item_No,
       this.Item_Name,
       this.Barcode,
       this.HSNCode,
       this.Store_Code,
       this.Onhand,
       this.Price,
       this.Discount,
       this.BatchCode,
       this.TaxCode,
       this.TaxRate,
       this.IsInclusive,
       this.FormId,
       this.UOM,
       this.UOM_quantity,
       this.LineRemarks,
       this.MRP,
       this.PurchasePrice,
       this.Cost,
       this.SellingPrice,
       this.SellingDis,
       this.Supplier,
       this.Type,
       this.GSTCess,
      this.UOMManuallyChanged = false,
      this.quntityManuallyChanged = false,
      this.priceManuallyChanged = false,
      this.discountManullyChanged = false,
       this.quantity});

/*
  factory SingleItemM.fromJson(Map<String, dynamic> json) =>
      _$SingleItemMFromJson(json);

  Map<String, dynamic> toJson() => _$SingleItemMToJson(this);
*/

  bool get isInclusive => IsInclusive == "Y";

  double get priceAfterDiscount => Price! * (100 - Discount!) / 100;

  num? get preTaxAmount => isInclusive
      ? priceAfterDiscount - (TaxRate! * priceAfterDiscount) / (100 + TaxRate!)
      : Price;

  double get taxAmount => preTaxAmount! * TaxRate! / 100;

  num get preTaxPriceTotal => preTaxAmount! * quantity! * (UOM_quantity!);

  double get taxAmountTotal => taxAmount * quantity! * (UOM_quantity!);

  double get priceWithTaxTotal => preTaxPriceTotal + taxAmountTotal;
}
