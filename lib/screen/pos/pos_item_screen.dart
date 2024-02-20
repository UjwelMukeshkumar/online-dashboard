import 'package:flutter/material.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:glowrpt/library/DefaultQuantity.dart';
import 'package:glowrpt/model/item/SingleItemM.dart';
import 'package:glowrpt/model/other/SearchM.dart';
import 'package:glowrpt/model/pos/PosGroupM.dart';
import 'package:glowrpt/model/transaction/DocumentLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/service/CartService.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/cahched_img.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../model/other/DefaultM.dart';
import '../../widget/pos/cart_item.dart';
import 'package:get/get.dart';

class PosItemScreen extends StatefulWidget {
  PosGroupM? group;
  DefaultM? defaultM;
  PosItemScreen({this.group, this.defaultM});

  @override
  State<PosItemScreen> createState() => _PosItemScreenState();
}

class _PosItemScreenState extends State<PosItemScreen> {
   CompanyRepository? compRepo;

  CartService? cart;

  String query = "";

  PagewiseLoadController<SearchM>? _pageLoadController;

  bool? askForCustomeQuantity;

  DocumentLoadM? documentLoadM;

  @override
  void initState() {
    super.initState();
    DefaultQuantity().getAskForCustomeQuantiy().then((value) {
      askForCustomeQuantity = value;
    });

    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    Serviece.getDocumentLoad(
      context: context,
      apiKey: compRepo!.getSelectedApiKey())
        .then((value) {
      documentLoadM = value;
    });
    SharedPreferences.getInstance().then((value) => setState(() {
          cart = CartService(value, compRepo!.getSelectedUser());
        }));
    _pageLoadController = PagewiseLoadController<SearchM>(
        pageSize: 20,
        pageFuture: (pageIndex) => Serviece.getPosItem(
            context: context,
            api_key: compRepo!.getSelectedApiKey(),
            pageNo: (pageIndex! + 1).toString(),
            groupid: widget.group!.Grp_Id.toString(),
            query: query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(
              labelText: "Search Items".tr,
              // border: textFieldBorder,
              suffix: Icon(Icons.search)),
          onChanged: (text) {
            query = text;
            _pageLoadController?.reset();
          },
        ),
      ),
      body: PagewiseListView<SearchM>(
        // pageSize: 20,
        noItemsFoundBuilder: (_) => Text("No Details Found".tr),
        // pageFuture: (pageIndex) => ,
        pageLoadController: _pageLoadController,
        itemBuilder: (context, item, position) {
          return Card(
            child: ListTile(
              onTap: () async {
                Toast.show("Please Wait...");
                if (askForCustomeQuantity!) {
                  SingleItemM singleItemM =
                      await Serviece.getPosSingleItemDetails(
                          api_key: compRepo!.getSelectedApiKey(),
                          cvCode: widget.defaultM?.Details?.first.CVCode??"",
                          context: context,
                          itemNumber: item.itemNo??"",
                          pricelist: widget.defaultM?.Details?.first.PriceList
                              .toString()??"",
                          quantiy: 1);
                  await showQuantityDialog(singleItemM);
                } else {
                  if (await cart!.addNew(
                      item: item,
                      context: context,
                      compRepo: compRepo,
                      defaultM: widget.defaultM)) {
                    Toast.show("Added");
                  } else {
                    Toast.show("Count updated");
                  }
                }
                Navigator.pop(context, true);
              },
              title: Text("${item.itemName}"),
              subtitle: Text(item.brand.toString()),
              trailing: Text(item.mrp.toString()),
              leading: SizedBox(
                  width: 60,
                  child: CachedImg(
                    url: item.image.toString(),
                    itemName: item.itemName.toString(),
                    isSmall: true,
                  )),
            ),
          );
        },
      ),
    );
  }


  Future showQuantityDialog(SingleItemM item) {
    var etcQuantity = TextEditingController();
    SingleItemM? updatedSingleItem;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(8),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          // title: Text("Enter Quantity"),
          content: CartItem(
            documentLoadM: documentLoadM!,
            item: item,
            etcQuantity: etcQuantity,
            onUpdate: (updatedItem) {
              //like stream
              updatedSingleItem = updatedItem;
            },
          ),
          actions: [
            ElevatedButton(
                onPressed: () =>
                    saveWithQuantity(etcQuantity.text, updatedSingleItem!),
                child: Text("Done"))
          ],
        );
      },
    );
  }
  // Future<bool> showQuantityDialog(SingleItemM item) {
  //   var etcQuantity = TextEditingController();
  //   SingleItemM updatedSingleItem;
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         insetPadding: EdgeInsets.all(8),
  //         titlePadding: EdgeInsets.zero,
  //         contentPadding: EdgeInsets.zero,
  //         // title: Text("Enter Quantity"),
  //         content: CartItem(
  //           documentLoadM: documentLoadM,
  //           item: item,
  //           etcQuantity: etcQuantity,
  //           onUpdate: (updatedItem) {
  //             //like stream
  //             updatedSingleItem = updatedItem;
  //           },
  //         ),
  //         actions: [
  //           ElevatedButton(
  //               onPressed: () =>
  //                   saveWithQuantity(etcQuantity.text, updatedSingleItem),
  //               child: Text("Done"))
  //         ],
  //       );
  //     },
  //   );
  // }

  saveWithQuantity(String text, SingleItemM singleItemM) async {
    double count = double.tryParse(text)!;
    if (count == null) {
      Toast.show("Invalid Count");
      return;
    }
    if (await cart!.addNew(singleItemM: singleItemM, quntity: count)) {
      Toast.show("Added");
    } else {
      Toast.show("Count updated");
    }
    Navigator.pop(context);
  }
}
