import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:glowrpt/library/AppSctring.dart';
import 'package:glowrpt/model/campain/CampaginResponseM.dart';
import 'package:glowrpt/model/campain/CampainHeadderM.dart';
import 'package:glowrpt/model/campain/CampainItem.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/sales/campains/campains_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../../model/campain/CampainM.dart';
import 'package:http/http.dart' as http;

enum DiscountType { Price, DiscountItem, DiscountBulk }

class CampainItemsScreen extends StatefulWidget {
  final CampainM? comapainM;
  final String fromDateWithTime;
  final String toDateWithTime;
  final String campainName;
  final Campagin campagin;
  final DiscountBy discountBy;
  final CampaginResponseM? campaginResponseM;

  const CampainItemsScreen({
    Key? key,
     this.comapainM,
    required this.fromDateWithTime,
    required this.toDateWithTime,
    required this.campainName,
    required this.campagin,
    required this.discountBy,
     this.campaginResponseM,
  }) : super(key: key);

  @override
  State<CampainItemsScreen> createState() => _CampainItemsScreenState();
}

class _CampainItemsScreenState extends State<CampainItemsScreen> {
  CompanyRepository? companyRepo;
  List<CampainItem> campainList = [];
  PriceListBean? selectedPriceList;

  String? bulkDiscount;
  DiscountType? discountType;

  @override
  void initState() {
    // TODO: implement initState

    if (widget.campagin == Campagin.ByPrice) {
      discountType = DiscountType.Price;
    } else {
      if (widget.discountBy == DiscountBy.Bulk) {
        discountType = DiscountType.DiscountBulk;
      } else {
        discountType = DiscountType.DiscountItem;
      }
    }
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    if (widget.campaginResponseM != null) {
      selectedPriceList = widget.comapainM?.PriceList.firstWhereOrNull(
          (element) =>
              element.PriceList ==
              widget.campaginResponseM?.Header?.first.PriceList);

      campainList.addAll(widget.campaginResponseM!.LinesDt as Iterable<CampainItem>);
      // show products in the product
      // if price list manually change all product list will be clear
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campaign Items"),
        // title: Text("${discountType.name}"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: DropdownSearch<PriceListBean>(
                     popupProps: PopupProps.menu(
                      showSearchBox: true,
                      isFilterOnline: true,
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: "Price List",
                    )),
                    selectedItem: selectedPriceList,
                    items: widget.comapainM?.PriceList??[],
                    //label: "Price List",
                    onChanged: (parent) {
                      setState(() {
                        selectedPriceList = parent;
                      });
                    },
                    // mode: Mode.MENU,
                  ),
                ),
                if (discountType == DiscountType.DiscountBulk) ...[
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: TextFormField(
                    onChanged: (newPrice) {
                      bulkDiscount = newPrice;
                    },
                    decoration: InputDecoration(
                        border: textFieldBorder, labelText: "Bulk Discount"),
                  ))
                ]
              ],
            ),
          ),
          Visibility(
            visible: selectedPriceList != null,
            child: IconButton(
              onPressed: () async {
                /*     var itemList = await Serviece.getCamapinItemDetails(
                    context: context,
                    api_key: companyRepo.getSelectedApiKey(),
                    pricelist: selectedPriceList.PriceList.toString(),
                    // searchValue: barcodeScanRes);
                    searchValue: "50545");
                setState(() {
                  campainList.addAll(itemList);
                });
                return;*/

                var barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    "#000000", "Cancel", true, ScanMode.BARCODE);
                print(barcodeScanRes != "-1");
                if (barcodeScanRes != "-1") {
                  var itemList = await Serviece.getCamapinItemDetails(
                      context: context,
                      api_key: companyRepo!.getSelectedApiKey(),
                      pricelist: selectedPriceList!.PriceList.toString(),
                      searchValue: barcodeScanRes);
                  setState(() {
                    campainList.addAll(itemList);
                  });
                }
              },
              icon: Image.asset('assets/icons/barcode.png'),
              color: AppColor.title,
            ),
          ),
          Expanded(
            child:
             ListView.builder(

              shrinkWrap: true,
                itemCount: campainList.length,
                itemBuilder: (context, position) {
                  var item = campainList[position];
                  return AppCard(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.Item_Name),
                      ),
                      subtitle: Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      border: textFieldBorder,
                                      labelText: "Current Price"),
                                  initialValue: item.Price.toString(),
                                ),
                              ),
                            ),
                            if (discountType != DiscountType.DiscountBulk)
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  onChanged: (newPrice) {
                                    if (discountType == DiscountType.Price) {
                                      item.New_Price = newPrice.toDouble;
                                    } else {
                                      item.Discprec = newPrice.toDouble;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: textFieldBorder,
                                      labelText:
                                          discountType == DiscountType.Price
                                              ? "New Price"
                                              : "Discount Percent"),
                                ),
                              )),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          FractionallySizedBox(
              widthFactor: .95,
              child: ElevatedButton(onPressed: submit, child: Text("Submit")))
        ],
      ),
    );
  }

  Future<void> submit() async {
    if (discountType == DiscountType.DiscountBulk) {
      if (bulkDiscount == null || bulkDiscount!.isEmpty) {
        showToast("Please Enter Bulk Discount");
        return;
      }
    }
    campainList.map((e) {
      int index = campainList.indexOf(e) + 1;
      e.SI_No = index;
      if (discountType == DiscountType.Price) e.Old_Price = e.Price!;
      if (discountType == DiscountType.DiscountBulk)
        e.Discprec = bulkDiscount!.toDouble;
      return e;
    }).toList();

    var response = await Serviece.insertCampain(
      api_key: companyRepo!.getSelectedApiKey(),
      context: context,
      headder: CampainHeadderM(
          PriceList: selectedPriceList?.PriceList,
          fromDate: widget.fromDateWithTime,
          reversalDate: widget.toDateWithTime,
          api_key: companyRepo!.getSelectedApiKey(),
          // docName: widget.comapainM.NextNum.toString(),
          docName: widget.campainName,
          offer_type: discountType!.name
          //
          ),
      itemList: campainList,
    );
    if (response != null) {
      Get.back();
      showToast("Updated");
    }
  }
}
