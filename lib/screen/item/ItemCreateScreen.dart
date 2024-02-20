import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:glowrpt/model/other/BrandM.dart';
import 'package:glowrpt/model/other/GroupM.dart';
import 'package:glowrpt/model/other/Price1M.dart';
import 'package:glowrpt/model/other/SectionM.dart';
import 'package:glowrpt/model/other/SupplierM.dart';
import 'package:glowrpt/model/other/TaxM.dart';
import 'package:glowrpt/model/item/ItemLoadM.dart';
import 'package:glowrpt/model/item/PriceM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/item/price_window_create.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/KeyValues.dart';
import 'package:glowrpt/widget/other/price_window.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../StockM.dart';
import '../bar_code_screen.dart';
import 'package:get/get.dart';

class ItemCreateScreen extends StatefulWidget {
  String? title;
  String? type;

  ItemCreateScreen({this.title, this.type});

  @override
  _ItemCreateScreenState createState() => _ItemCreateScreenState();
}

class _ItemCreateScreenState extends State<ItemCreateScreen> {
  var formKey = GlobalKey<FormState>();

  CompanyRepository? companyRepo;

  List<PriceM>? priceList;

  List<SectionM>? sectionList;

  List<BrandM>? brandList;

  List<TaxM>? taxList;

  List<GroupM>? groupLisrt;

  TaxM? selectedTax;

  BrandM? selectedBrand;

  SectionM? selectedSection;

  GroupM? selectedGroup;

  List<StockM>? stockList;

  List<SupplierM>? supplierList;

  SupplierM? selectedSupplier;

  // List<TypeM> typeList;

  // TypeM selectedType;

  String? storeName;

  ItemLoadM? itemLoad;

  bool isLoaded = false;
  var tecItemName = TextEditingController();
  var tecMrp = TextEditingController();
  var tecHsnCode = TextEditingController();
  var tecBarCode = TextEditingController();

  @override
  void initState() {
    
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadAPIs();
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(
      height: 16,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Create ${widget.title}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              space,
              TextFormField(
                controller: tecItemName,
                decoration: InputDecoration(
                    labelText: "Item Name".tr, border: textFieldBorder),
                validator: (text) => text!.isEmpty ? "Enter Item Name" : null,
              ),
              space,
              TextFormField(
                controller: tecMrp,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "MRP".tr, border: textFieldBorder),
                validator: (text) => text!.isEmpty ? "Enter MRP" : null,
              ),
              space,
              TextFormField(
                controller: tecHsnCode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "HSN Code".tr, border: textFieldBorder),
              ),
              space,
              TextFormField(
                controller: tecBarCode,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "BAR Code".tr,
                    border: textFieldBorder,
                    suffixIcon: InkWell(
                        onTap: () async {
                          var barcodeScanRes =
                              await FlutterBarcodeScanner.scanBarcode(
                                  "#000000", "Cancel", true, ScanMode.BARCODE);
                          if (barcodeScanRes == "-1") {
                            Toast.show("Scanning Not success");
                          } else {
                            tecBarCode.text = barcodeScanRes;
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SizedBox(
                              height: 20,
                              child: Image.asset('assets/icons/barcode.png')),
                        ))),
              ),
              if (isLoaded) ...[
                Divider(),
                Padding(
                  padding: dropdownPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Brand".tr,
                          style: Theme.of(context).textTheme.subtitle2),
                      DropdownButton<BrandM>(
                          items: brandList!
                              .map((e) => DropdownMenuItem<BrandM>(
                                    child: Text(e.Name),
                                    value: e,
                                  ))
                              .toList(),
                          value: selectedBrand,
                          onChanged: (value) {
                            setState(() {
                              selectedBrand = value;
                            });
                          },
                          isExpanded: true),
                    ],
                  ),
                ),
                Padding(
                  padding: dropdownPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Section".tr,
                          style: Theme.of(context).textTheme.subtitle2),
                      DropdownButton<SectionM>(
                          items: sectionList!
                              .map((e) => DropdownMenuItem<SectionM>(
                                    child: Text(e.Name),
                                    value: e,
                                  ))
                              .toList(),
                          value: selectedSection,
                          onChanged: (value) {
                            setState(() {
                              selectedSection = value;
                            });
                          },
                          isExpanded: true),
                    ],
                  ),
                ),
                Padding(
                  padding: dropdownPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Group".tr,
                          style: Theme.of(context).textTheme.subtitle2),
                      DropdownButton<GroupM>(
                          items: groupLisrt!
                              .map((e) => DropdownMenuItem<GroupM>(
                                    child: Text(e.GrpName),
                                    value: e,
                                  ))
                              .toList(),
                          value: selectedGroup,
                          onChanged: (value) {
                            setState(() {
                              selectedGroup = value;
                            });
                          },
                          isExpanded: true),
                    ],
                  ),
                ),
                Padding(
                  padding: dropdownPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tax".tr,
                          style: Theme.of(context).textTheme.subtitle2),
                      DropdownButton<TaxM>(
                        items: taxList!
                            .map((e) => DropdownMenuItem<TaxM>(
                                  child: Text(e.TaxName),
                                  value: e,
                                ))
                            .toList(),
                        value: selectedTax,
                        onChanged: (value) {
                          setState(() {
                            selectedTax = value;
                          });
                        },
                        isExpanded: true,
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  title: Text("Price List".tr),
                  children: [
                    if (priceList != null)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: priceList!.length,
                          itemBuilder: (context, position) {
                            var item = priceList![position];
                            return Card(
                              margin: EdgeInsets.all(4),
                              child: InkWell(
                                onTap: () async {
                                  if (tecMrp.text.isEmpty) {
                                    showToast("Enter Mrp");
                                    return;
                                  }
                                  await showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return PriceWindowCreate(
                                          item, double.parse(tecMrp.text));
                                    },
                                  );
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      KeyValues(
                                          keys: "Name".tr,
                                          values: item.PriceListName),
                                      KeyValues(
                                          keys: "Price".tr,
                                          values: item.Price.toString()),
                                      KeyValues(
                                          keys: "Is inclusive".tr,
                                          values: item.Is_Inclusive),
                                      KeyValues(
                                          keys: "Discount".tr,
                                          values: item.Discount.toString()),
                                      /*        KeyValues(
                                          keys: "Cost",
                                          values: item.cost.toString()),
                                      KeyValues(
                                          keys: "Gp%",
                                          values: item.gp.toString()),*/
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                  ],
                ),
              ],
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      uploadProduct();
                    }
                  },
                  child: Text("Create Item".tr))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadAPIs() async {
    isLoaded = false;
    itemLoad = await Serviece.itemLoad(
        context: context, api_key: companyRepo!.getSelectedApiKey());
    isLoaded = true;
    sectionList = itemLoad!.Section;
    selectedSection = sectionList!.first;

    brandList = itemLoad!.Brand;
    selectedBrand = brandList!.first;

    taxList = itemLoad!.TaxMaster;
    selectedTax = taxList!.first;

    groupLisrt = itemLoad!.ItemGroup;
    selectedGroup = groupLisrt!.first;

    priceList = itemLoad!.PriceList;
    setState(() {});
  }

  Future<void> uploadProduct() async {
    var response = await Serviece.addProduct(
        context: context,
        api_key: companyRepo!.getSelectedApiKey(),
        Brand: selectedBrand!.Id.toString(),
        Bracode: tecBarCode.text,
        HSNCode: tecHsnCode.text,
        Inactive: "N",
        ItemGroup: selectedGroup!.Grp_Id.toString(),
        ItemName: tecItemName.text,
        MRP: tecMrp.text,
        MRPDisc: "0",
        Section: selectedSection!.Id.toString(),
        TaxCode: selectedTax!.TaxCode,
        PriceDt: json.encode(priceList!.map((e) => e.toJson()).toList()));
    if (response != null) {
      showToast("Created successfully");
      Navigator.pop(context);
    }
  }
}
