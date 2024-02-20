// import 'dart:async';

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/callbackinterface.dart';

import 'package:glowrpt/model/other/SearchM.dart';
import 'package:glowrpt/screen/item_details_screen.dart';
import 'package:glowrpt/screen/transaction/sales_invoice_screen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/utility.dart';
import 'package:toast/toast.dart';

import 'cahched_img.dart';

class ItemSearchDelegate extends SearchDelegate<SearchM> {
  String apiKey;
  String? type;

  late StreamController<List<SearchM>> _resultStream;
  ValueChanged<SearchM> onItemSelect;
  //SalesInVoiceScreen inv;
  //Function (SearchM) itemSelectedCallback;
  ItemSearchDelegate({
    required this.apiKey,
    required this.onItemSelect,
    this.type,
    //required this.itemSelectedCallback,
  }) : _resultStream = StreamController<List<SearchM>>.broadcast();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
      /*IconButton(
        onPressed: () async {
          var barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#000000", "Cancel", true, ScanMode.BARCODE);

          if (barcodeScanRes != "-1"){
            SearchM searchItemFromBarcode = await  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BarCodeScreen(
                      barcodeScanRes,apiKey,
                      onItemSelect: onItemSelect,
                    )));

            if(searchItemFromBarcode!=null){
              Navigator.pop(context, searchItemFromBarcode);
            }
          }

        },
        icon: Image.asset('assets/icons/barcode.png'),
        color: AppColor.title,
      ),*/
    ];
  }

  SalesInVoiceScreen inv = SalesInVoiceScreen();
  @override
  Widget buildLeading(BuildContext context) {
    final SearchDelegate<SearchM?> searchDelegate = this;

    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          searchDelegate.close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestionView(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSuggestionView(context);
  }

  Widget buildSuggestionView(BuildContext context) {
    _resultStream.close();
    _resultStream = StreamController<List<SearchM>>.broadcast();
    // if (resultStream == null)
    // resultStream =
    Serviece()
        .itemSearch(
            context: context,
            apiKey: apiKey,
            query: query,
            type: type.toString())
        .asStream()
        .listen((data) {
      _resultStream.add(data);
    });
    return StreamBuilder<List<SearchM?>>(
      stream: _resultStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, position) {
                var item = snapshot.data?[position];

                return Card(
                  elevation: 6,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                    onTap: () {
                      // onItemSelect(item!);
                      try {
                        if (onItemSelect != null) {
                          Salesinvoicecallback? salesinvoicecallback =
                              Utility.getSalesRfreshCallBack();
                          salesinvoicecallback!.salesRefreshPage(item!);
                          Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SalesInVoiceScreen(
                          //               formId: DocumentFormId.SalesReturn,
                          //               title: "Sales ",
                          //               itemNumber: item.itemNo,
                          //               empId: null,
                          //               rootDetails: null,
                          //               rootId: 0,
                          //               isDeliveryForm: false,
                          //             ))
                          // MaterialPageRoute(
                          //     builder: (context) =>
                          //     ItemDetailsScreen(
                          //           itemNo: "${item?.itemNo}",
                          //           api_key: apiKey,
                          //         ))
                          // );
                        } else {
                          Navigator.pop(context, item);
                        }
                        debugPrint(
                            "Navigated to SalesInVoiceScreen. itemNo: ${item?.itemNo}");
                      } catch (e) {
                        showToast(e.toString());
                        print("Error navigating to ItemDetailsScreen: $e");
                      }
                    },

                    // onTap: () {
                    //   if (onItemSelect == null) {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => ItemDetailsScreen(
                    //                   itemNo: "${item?.itemNo}",
                    //                   api_key: apiKey,
                    //                 )));
                    //   } else {
                    //     Navigator.pop(context, item);
                    //   }
                    // },
                    title: Text(
                      "${item?.itemName.toString()}??",
                    ),

                    //
                    //
                    // subtitle: Text("In ${item.brand}"),
                    leading: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: CachedImg(
                            url: item?.image.toString() ?? "",
                            itemName: item?.itemName.toString() ?? "",
                            isSmall: true,
                          ),
                        ),
                      ),
                    ),
                    // trailing: Text("${item.currency} ${item.total.toString()}",style: textTheme.bodyText1,),
                  ),
                );
              });
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
