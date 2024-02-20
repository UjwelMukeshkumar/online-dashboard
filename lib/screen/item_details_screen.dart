// import 'package:another_carousel_pro/another_carousel_pro.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:glowrpt/model/other/BrandM.dart';
import 'package:glowrpt/model/other/GroupM.dart';
import 'package:glowrpt/model/other/SectionM.dart';
import 'package:glowrpt/model/other/SupplierM.dart';
import 'package:glowrpt/model/other/TaxM.dart';
import 'package:glowrpt/model/other/TypeM.dart';
// import 'package:glowrpt/repo/Provider.dart';
// import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/model/other/ItemM.dart';
import 'package:glowrpt/model/other/Price1M.dart';
import 'package:glowrpt/screen/StockM.dart';
import 'package:glowrpt/screen/image_viewer.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/KeyValues.dart';
import 'package:glowrpt/widget/other/price_widget.dart';
import 'package:glowrpt/widget/other/price_window.dart';
import 'package:glowrpt/widget/other/qantity_window.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
// import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
//  import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
// import 'package:provider/provider.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
// import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
// import 'package:carousel_slider/carousel_slider.dart';

// import 'image_viewer.dart';
import 'item_transaction_details.dart';

class ItemDetailsScreen extends StatefulWidget {
  String itemNo;
  String api_key;

  ItemDetailsScreen({
    required this.itemNo,
    required this.api_key,
  });

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  var hsnController = TextEditingController();
  var mrpDiscountController = TextEditingController();
  ItemM? item;

  List<ItemM>? relatedItems;
  bool isLoaded = false;

  String? selectedImageUrl;

  List? propretyList;

  var _userReview = TextEditingController();

  List<Price1M>? priceList;

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

  List<TypeM>? typeList;

  TypeM? selectedType;

  String? storeName;

  @override
  void initState() {
    super.initState();
    getItemDeatils();
    getPriceList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: isLoaded
          ? ListView(
              children: [
                AspectRatio(
                  aspectRatio: 1.3,
                  child: item != null
                      ? carousel.CarouselSlider(
                          options: carousel.CarouselOptions(
                              autoPlay: true, viewportFraction: 1
                              // aspectRatio: 5/2
                              ),
                          items: [
                            if (item?.Image != null && item!.Image!.isNotEmpty)
                              item?.Image,
                            if (item?.ImageUrl1 != null &&
                                item!.ImageUrl1!.isNotEmpty)
                              item?.ImageUrl1,
                            if (item?.ImageUrl2 != null &&
                                item!.ImageUrl2!.isNotEmpty)
                              item?.ImageUrl2,
                            if (item?.ImageUrl3 != null &&
                                item!.ImageUrl3!.isNotEmpty)
                              item?.ImageUrl3,
                          ].where((e)=>e!=null && e.isNotEmpty).map((e)  {
                            return InkWell(
                              onTap: () {
                                if(e!= null && e.isNotEmpty){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyImageViewer(
                                        selectedImageUrl: e.toString(),
                                      ),
                                    ),
                                  );
                                }
                           
                              },
                              child: CachedNetworkImage(
                                imageUrl: e.toString(),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            );
                          }).toList(),
                        )

                      // ?
                      // Carousel(
                      //     images: [
                      //       if (item?.Image != null) item?.Image,
                      //       if (item?.ImageUrl1 != null) item?.ImageUrl1,
                      //       if (item?.ImageUrl2 != null) item?.ImageUrl2,
                      //       if (item?.ImageUrl3 != null) item?.ImageUrl3,
                      //     ].map((e) {
                      //       return InkWell(
                      //         onTap: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => MyImageViewer(
                      //                         selectedImageUrl: e.toString(),
                      //                       )));
                      //         },
                      //         child: CachedNetworkImage(
                      //           imageUrl: e.toString(),
                      //           progressIndicatorBuilder:
                      //               (context, url, downloadProgress) =>
                      //                   CircularProgressIndicator(
                      //             value: downloadProgress.progress,
                      //           ),
                      //           errorWidget: (context, url, error) =>
                      //               Icon(Icons.error),
                      //         ),
                      //       );
                      //     }).toList(),
                      //     noRadiusForIndicator: false,
                      //     dotSize: 4.0,
                      //     dotSpacing: 10.0,
                      //     dotColor: Colors.black26,
                      //     indicatorBgPadding: 2.0,
                      //     dotBgColor: Colors.purple.withOpacity(0),
                      //     boxFit: BoxFit.fill,
                      //     animationDuration: Duration(milliseconds: 500),
                      //     animationCurve: Curves.ease,
                      //   )
                      : Center(
                          child: Text("Image Not Available"),
                        ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // API for this is Inventory posting list
                                // On its click. Show with similar design as the ledger, you showed me.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ItemTransactionDetails(
                                      id: item?.Item_No.toString() ?? "",
                                      apiKey: widget.api_key,
                                      // fromDate: fromDate,
                                      // todate: todate,
                                    ),
                                  ),
                                );
                              },
                              child: Text("View Transaction".tr),
                            ),
                            Row(
                              children: [
                                Text("On Hand: ".tr),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(item?.OnHand.toString() ?? ""),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text("Price: ".tr),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: PriceWidget(
                                      price:
                                          item?.SalesPrice?.toDouble() ?? 0.0),
                                ),
                                Text("MRP: ".tr),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: PriceWidget(
                                      price: item?.MRP!.toDouble() ?? 0.0),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: item?.Cost != "xxx",
                              child: Row(
                                children: [
                                  Text("Cost: ".tr),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child:
                                        // Text("Chekking")
                                        PriceWidget(
                                            price: double.tryParse(
                                                    item?.Cost ?? 0.0) ??
                                                0.0),
                                  ),
                                  Text("GP: ".tr),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    // child: Text("Chekking"),
                                    //  child:   Text(
                                    //         "${double.tryParse(item?.GP)?.toStringAsFixed(2) ?? 0.0}%"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: hsnController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "HSN Code".tr,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: mrpDiscountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Mrp Discount".tr,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                          title: Text("inactive".tr),
                          value: item?.Inactive == "Y",
                          onChanged: (value) {
                            setState(() {
                              item?.Inactive = value! ? "Y" : "N";
                            });
                          }),
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () async {
                        await showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          // user must tap button!
                          builder: (BuildContext context) {
                            return QuantitWindow(
                              item!,
                              api_key: widget.api_key,
                              itemNo: widget.itemNo,
                            );
                          },
                        );
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Counted Quantity ${item?.CountedQty}",
                          style: TextStyle(color: AppColor.barBlue),
                        ),
                      ),
                    ))
                  ],
                ),
                ListTile(
                  title: Text(item?.Item_Name ?? ""),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Text(
                    item?.Description ?? "",
                    style: textTheme.subtitle2,
                  ),
                ),
                Divider(),
                Padding(
                  padding: dropdownPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tax".tr, style: textTheme.subtitle2),
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
                Padding(
                  padding: dropdownPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Brand".tr, style: textTheme.subtitle2),
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
                      Text("Type".tr,
                          style: Theme.of(context).textTheme.subtitle2),
                      DropdownButton<TypeM>(
                          items: typeList!
                              .map((e) => DropdownMenuItem<TypeM>(
                                    child: Text(e.TypeName),
                                    value: e,
                                  ))
                              .toList(),
                          value: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
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
                      Text("Supplier".tr,
                          style: Theme.of(context).textTheme.subtitle2),
                      DropdownButton<SupplierM>(
                          items: supplierList!
                              .map((e) => DropdownMenuItem<SupplierM>(
                                    child: Text(e.CVName),
                                    value: e,
                                  ))
                              .toList(),
                          value: selectedSupplier,
                          onChanged: (value) {
                            setState(() {
                              selectedSupplier = value;
                            });
                          },
                          isExpanded: true),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                      onPressed: updateItem, child: Text("Update Item".tr)),
                ),
                ExpansionTile(
                  title: Text("Store".tr),
                  subtitle: TextButton(
                    onPressed: () async {
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("New Store".tr),
                            content: Container(
                              child: TextField(
                                onChanged: (text) {
                                  storeName = text;
                                },
                                decoration: InputDecoration(
                                  labelText: "Enter Store Name".tr,
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Cancel".tr)),
                              TextButton(
                                  onPressed: addStore,
                                  child: Text("Update".tr)),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Add New Store".tr),
                  ),
                  children: [
                    if (stockList != null)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: stockList?.length,
                          itemBuilder: (context, position) {
                            var item = stockList?[position];
                            return Card(
                              margin: EdgeInsets.all(4),
                              child: InkWell(
                                onTap: () async {
                                  // getPriceList();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      children: item!
                                          .toJson()
                                          .keys
                                          .map((e) => KeyValues(
                                                keys: e,
                                                values:
                                                    item.toJson()[e].toString(),
                                              ))
                                          .toList()),
                                ),
                              ),
                            );
                          }),
                  ],
                ),
                ExpansionTile(
                  title: Text("Price List".tr),
                  children: [
                    if (priceList != null)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: priceList?.length,
                          itemBuilder: (context, position) {
                            var item = priceList?[position];
                            return Card(
                              margin: EdgeInsets.all(4),
                              child: InkWell(
                                onTap: () async {
                                  await showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return PriceWindow(
                                        item!,
                                        api_key: widget.api_key,
                                        itemNo: widget.itemNo,
                                      );
                                    },
                                  );
                                  getPriceList();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      KeyValues(
                                          keys: "Name".tr,
                                          values: item?.priceListName ?? ""),
                                      KeyValues(
                                          keys: "Price".tr,
                                          values: item?.price.toString() ?? ""),
                                      KeyValues(
                                          keys: "Is inclusive".tr,
                                          values: item?.isInclusive ?? ""),
                                      KeyValues(
                                          keys: "Discount".tr,
                                          values:
                                              item?.discount.toString() ?? ""),
                                      KeyValues(
                                          keys: "Cost".tr,
                                          values: item?.cost.toString() ?? ""),
                                      KeyValues(
                                          keys: "Gp%".tr,
                                          values: item?.gp.toString() ?? ""),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                  ],
                ),
              ],
            )
          : Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }

  void getItemDeatils() {
    Serviece.getItemDetails(context, widget.api_key, widget.itemNo)
        .then((value) {
      setState(() {
        isLoaded = true;
        if (value.ItemDetails!.isNotEmpty) item = value.ItemDetails?.first;
        selectedImageUrl = item?.Image;

        sectionList = value.Section;
        selectedSection = sectionList != null
            ? sectionList?.firstWhere(
                (element) => element.Id == item?.SectionCode,
                orElse: () => sectionList!.first)
            : null;

        brandList = value.Brand;
        selectedBrand = brandList?.firstWhere(
            (element) => element.Id == item?.BrandCode,
            orElse: () => brandList!.first);

        taxList = value.Tax;
        selectedTax = taxList?.firstWhere(
            (element) => element.TaxCode == item?.TaxCode,
            orElse: () => taxList!.first);

        groupLisrt = value.ItemGroup;
        selectedGroup = groupLisrt?.firstWhere(
            (element) => element.Grp_Id == item?.GroupCode,
            orElse: () => groupLisrt!.first);

        supplierList = value.Supplier;
        selectedSupplier = supplierList?.firstWhere(
            (element) => element.CVCode == item?.Supplier.toString(),
            orElse: () => supplierList!.first);

        typeList = value.Type;
        selectedType = typeList?.firstWhere(
            (element) => element.TypeId == item?.Type,
            orElse: () => typeList!.first);

        stockList = value.Stock;

        hsnController.text = item?.HSNCode ?? "";
        mrpDiscountController.text = item?.MRPDiscount.toString() ?? "";
      });
    });
  }

  Future<void> getPriceList() async {
    priceList =
        await Serviece.getPriceList(context, widget.api_key, widget.itemNo);
    setState(() {});
    // priceList = value.priceList1;
  }

  Future<void> updateItem() async {
    var response = await Serviece.updatItemdetails(
        context: context,
        api_key: widget.api_key,
        Brand: selectedBrand!.Id.toString(),
        Group: selectedGroup!.Grp_Id.toString(),
        Inactive: item!.Inactive.toString(),
        HsnCode: hsnController.text,
        ItemNo: widget.itemNo,
        MrpDiscount: mrpDiscountController.text,
        Section: selectedSection?.Id.toString() ?? "",
        Supplier: selectedSupplier?.CVCode ?? "",
        TaxCode: selectedTax?.TaxCode ?? "",
        Type: selectedTax?.TaxCode ?? "");
    if (response != null) {
      Toast.show("Item updated successfully");
      getItemDeatils();
    }
  }

  Future<void> addStore() async {
    var response = await Serviece.addStore(
        context: context,
        api_key: widget.api_key,
        StroreName: storeName.toString());
    if (response != null) {
      Navigator.pop(context, true);
      getItemDeatils();
    }
  }
}
