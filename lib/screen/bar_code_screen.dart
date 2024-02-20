import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:glowrpt/model/other/ItemDetailsM.dart';
import 'package:glowrpt/model/other/ItemM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/KeyValues.dart';
import 'package:shimmer/shimmer.dart';

import '../model/other/SearchM.dart';
import 'item_details_screen.dart';
import 'package:get/get.dart';

class BarCodeScreen extends StatefulWidget {
  String barcode;
  String apiKey;
  ValueChanged<SearchM>? onItemSelect;
  BarCodeScreen(
    this.barcode,
    this.apiKey, {
     this.onItemSelect,
  });

  @override
  _BarCodeScreenState createState() => _BarCodeScreenState();
}

class _BarCodeScreenState extends State<BarCodeScreen> {
  ItemDetailsM? itemDetails;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getItemByBarCode(widget.barcode);
    // getItemByBarCode("0000123456784");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ElevatedButton(
                onPressed: () async {
                  widget.barcode = await FlutterBarcodeScanner.scanBarcode(
                      "#000000", "Cancel", true, ScanMode.BARCODE);
                  setState(() {});
                },
                child: Text("New Bar Code")),
            widget.barcode != null
                ? BarcodeWidget(
                    barcode: Barcode.code128(),
                    // barcode: Barcode.isbn(drawEndChar: true,drawIsbn: false),
                    data: widget.barcode,
                    errorBuilder: (context, error) => Container())
                : Container(),
            if (itemDetails != null)
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: itemDetails!.ItemDetails!.length,
                  itemBuilder: (context, position) {
                    var item = itemDetails!.ItemDetails![position];
                    return Card(
                      margin: EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () {
                          openItemDetails(item);
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            children: [
                              KeyValues(
                                  keys: "Item Name".tr, values: item.Item_Name??""),
                              KeyValues(
                                keys: "Group Code".tr,
                                // values: item.GroupCode ?? "",
                                values: item.GroupCode.toString(),
                              ),
                              KeyValues(
                                  keys: "On Hand".tr,
                                  values: item.OnHand.toString()),
                              KeyValues(
                                  keys: "Barcode".tr, values: item.Barcode??""),
                              KeyValues(
                                  keys: "TaxCode".tr, values: item.TaxCode??""),
                              KeyValues(
                                  keys: "Manufacture".tr,
                                  values: item.Manufacture??""),
                              KeyValues(
                                  keys: "Remarks".tr,
                                  values: item.Remark??""),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            if (isLoading)
              SizedBox(
                height: 200.0,
                child: Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.black87,
                    highlightColor: Colors.white,
                    child: Text(
                      'Fetching Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<void> getItemByBarCode(String barcode) async {
    setState(() {
      isLoading = true;
    });
    itemDetails = await Serviece.getItemDetailslByBarCode(
        context, widget.apiKey, widget.barcode);
    setState(() {
      isLoading = false;
    });
    if (itemDetails?.ItemDetails?.length == 1) {
      openItemDetails(itemDetails!.ItemDetails!.first);
    }
  }

  Future<void> openItemDetails(ItemM item) async {
    if (widget.onItemSelect == null) {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetailsScreen(
                    itemNo: item.Item_No.toString(),
                    api_key: widget.apiKey,
                  )));
    } else {
      var searchM = SearchM.fromJson(item.toJson());

       Navigator.pop(context, searchM);
      // await Navigator.pop(context, searchM);
      // await Navigator.pop(context,searchM);
    }
  }
}
