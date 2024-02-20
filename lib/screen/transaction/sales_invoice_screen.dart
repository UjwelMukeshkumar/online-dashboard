// import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:glowrpt/callbackinterface.dart';

import 'package:glowrpt/model/employe/EmpLoadM.dart';
import 'package:glowrpt/model/item/SingleItemM.dart';
import 'package:glowrpt/model/other/SearchM.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/model/party/SinglePartyDetailsM.dart';
import 'package:glowrpt/model/transaction/DocumentLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/utility.dart';
import 'package:glowrpt/widget/other/ItemSearchDeligate.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../model/route/PlannerRouteLoadM.dart';
import '../../widget/pos/cart_item.dart';
import '../bar_code_screen.dart';
import 'invoice_submit_screen.dart';

class SalesInVoiceScreen extends StatefulWidget {
  String? title;
  int? formId;
  RouteDetailsBean? rootDetails;
  String? empId;
  int? rootId;
  bool isDeliveryForm;
  String? itemNumber;

  SalesInVoiceScreen(
      {this.formId,
      this.title,
      this.empId,
      this.rootDetails,
      this.rootId,
      this.isDeliveryForm = false,
      this.itemNumber});

  @override
  _SalesInVoiceScreenState createState() => _SalesInVoiceScreenState();
}

class _SalesInVoiceScreenState extends State<SalesInVoiceScreen>
    implements Salesinvoicecallback {
  CompanyRepository? compRepo;
  List<String> optionsFindBy = ["Search", "QR scan"];
  String? option;
  SinglePartyDetailsM? party;
  bool dataloaded = false;
  bool isInclude = false;
  var tecBarCode = TextEditingController();
  var tecMrp = TextEditingController();
  var scrollController = ScrollController();
  List<TextEditingController> tecs = [];
  List<FocusNode> focusNodesQuantity = [];

  List<SingleItemM> selectedItemList = [];

  DocumentLoadM? documentLoadM;

  PartySearchM? selectedParty;
  bool isItemSelected = false;

  @override
  void initState() {
    super.initState();
    option = optionsFindBy.first;
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    if (widget.rootDetails != null) {
      selectedParty = PartySearchM(
          CVCode: widget.rootDetails?.CVCode,
          CVName: widget.rootDetails?.CVName);
      getSinglePartyDetails(widget.rootDetails!.CVCode!);
    }
    Utility.setSalesPageRefreshCallBack(this);
    loadPager();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var sizedBox = SizedBox(height: 10);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(title: Text("${widget.title}"), actions: [
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: DropdownSearch<PartySearchM>(
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    isFilterOnline: true,
                  ),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                    labelText: "${party?.CVName ?? ""}",
                  )),
                  asyncItems: (text) => Serviece.partySearch(
                      context: context,
                      api_key: compRepo!.getSelectedApiKey(),
                      Type: [
                        DocumentFormId.Sales,
                        DocumentFormId.SalesReturn,
                        DocumentFormId.SalesOrder,
                        DocumentFormId.DeleveryForm
                      ].contains(widget.formId)
                          ? "C"
                          : "S", //for supplier
                      query: text),
                  enabled: widget.rootDetails == null,
                  selectedItem: selectedParty,

                  onChanged: (party) {
                    selectedParty = party;
                    getSinglePartyDetails(party!.CVCode.toString());
                  },
                  // itemAsString: (PartySearchM party) =>party.CVName??"",
                ),
              ),
            )
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: selectedItemList.length != 0
                        ? ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: selectedItemList.length,
                            itemBuilder: (BuildContext context, int index) {
                              print("hello");
                              // return Text("Helo");
                              var item = selectedItemList[index];
                              print(selectedItemList.length);
                              if (selectedItemList.last == item)
                                tecs[index].selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: tecs[index].text.length);
                              // return ListTile(title: Text("Testing"),);
                              return Dismissible(
                                  key: Key("${item.Item_No}"),
                                  onDismissed: (i) {
                                    selectedItemList.removeAt(index);
                                    tecs[index].dispose();
                                    focusNodesQuantity[index].dispose();
                                    tecs.removeAt(index);
                                    focusNodesQuantity.removeAt(index);
                                  },
                                  child: Column(
                                    children: [
                                      if (index == 0) ...[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${selectedItemList.length == 0 ? "Select" : "Add"} Product by",
                                              textAlign: TextAlign.center,
                                              style: textTheme.titleSmall,
                                            ),
                                            Flexible(
                                              child: RadioGroup<String>.builder(
                                                  direction: Axis.horizontal,
                                                  groupValue: option.toString(),
                                                  onChanged: (item) {
                                                    setState(() {
                                                      option = item;
                                                    });
                                                  },
                                                  items: optionsFindBy,
                                                  itemBuilder: (item) {
                                                    return RadioButtonBuilder(
                                                        item);
                                                  }),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                          visible: selectedItemList.length > 0,
                                          child: Text(
                                            "Swipe To delete",
                                            style: textTheme.caption!.copyWith(
                                                fontStyle: FontStyle.italic,
                                                color: AppColor.title),
                                          ),
                                        ),
                                      ],
                                      Text(selectedItemList[index]
                                          .Item_Name
                                          .toString()),
                                      CartItem(
                                        focusNodeQuntity:
                                            focusNodesQuantity[index],
                                        documentLoadM: documentLoadM!,
                                        item: selectedItemList[index],
                                        etcQuantity: tecs[index],
                                        onUpdate: (updatedItem) {
                                          //like stream
                                          item = updatedItem;
                                        },
                                        isDeliveryForm: widget.isDeliveryForm,
                                      )
                                    ],
                                  ));
                            },
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("Add Product...!")),
                            ],
                          )),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text(
                            "${selectedItemList.length == 0 ? "Add Product" : "Add More"}"),
                        onPressed: () {
                          if (party == null) {
                            Toast.show("Select Party");
                            return;
                          }
                          if (option == optionsFindBy.first) {
                            startItemWindowFromSearch();
                          } else {
                            startItemSearcByQa();
                          }
                        },
                      ),
                    )),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.formId == 10 ||
                                widget.formId == 12 ||
                                widget.formId == 8
                            ? ElevatedButton(
                                child: Text("Choose Method"),
                                onPressed: () {
                                  if (party == null) {
                                    Toast.show("Select Party");
                                    return;
                                  } else if (selectedItemList.length == 0) {
                                    Toast.show("Select Products");
                                    return;
                                  }
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Choose Method'),
                                        content: Text(
                                            'Select the method to save the form:'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // Close the dialog
                                              //saveForm(false); // Save as Draft
                                              openSubmitScreen("SAVE & DRAFT");
                                            },
                                            child: Text('Save as Draft'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // Close the dialog
                                              //saveForm(true); // Save and Post
                                              openSubmitScreen("SAVE & POST");
                                            },
                                            child: Text('Save and Post'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  // openSubmitScreen();
                                },
                              )
                            : ElevatedButton(
                                child: Text("Save"),
                                onPressed: () {
                                  if (party == null) {
                                    Toast.show("Select Party");
                                    return;
                                  } else if (selectedItemList.length == 0) {
                                    Toast.show("Select Products");
                                    return;
                                  }

                                  openSubmitScreen(null);
                                },
                              ),
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: ElevatedButton(
                    //         child: Text("Save"),
                    //         onPressed: () {
                    //           if (party == null) {
                    //             Toast.show("Select party ");
                    //             return;
                    //           }
                    //           else  if( selectedItemList.length == 0){
                    //              Toast.show("Select Product ");
                    //             return;
                    //           }
                    //           openSubmitScreen();
                    //         }),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Future<void> loadPager() async {
    documentLoadM = await Serviece.getDocumentLoad(
        context: context, apiKey: compRepo!.getSelectedApiKey());

    setState(() {});
  }

  void startItemWindowFromSearch() async {
    if (party == null) {
      Toast.show("Select Party");
      return;
    }
    await showSearch(
      context: context,
      delegate: ItemSearchDelegate(
          apiKey: compRepo!.getSelectedApiKey(), onItemSelect: itemSelected),
    );
  }
//   void startItemWindowFromSearch() async {
//   if (party == null) {
//     Toast.show("Select Party");
//     return;
//   }
//   SearchM? selected = await showSearch(
//     context: context,
//     delegate: ItemSearchDelegate(
//       apiKey: compRepo!.getSelectedApiKey(),
//       onItemSelect: itemSelected,
//       itemSelectedCallback: itemSelected, // Pass the function here
//     ),
//   );
//   // itemSelected(selected); // Remove this line, as it's already called in the delegate
// }

  getSinglePartyDetails(String cvCode) async {
    this.party = await Serviece.getSinglePartyDetails(
      apiKey: compRepo!.getSelectedApiKey(),
      cvCode: cvCode,
      context: context,
    );
    // if (selectedItemList.isEmpty) {
    //   startItemWindowFromSearch();
    // }
    // setState(() {});
  }

/////////////////////////hakeem//////////////
  // itemSelected(SearchM? item) async {
  //   SingleItemM? singleItemM;
  //   item!=null?
  //     singleItemM = await Serviece.getSingleItemDetails(
  //         apiKey: compRepo!.getSelectedApiKey(),
  //         cvCode: party!.CVCode.toString(),
  //         context: context,
  //         document: widget.formId.toString(),
  //         itemNumber: item.itemNo.toString(),
  //         pricelist: party!.PriceList.toString()):Text("No item found");
  //
  //   if (singleItemM != null) if (mounted)
  //     setState(() {
  //       singleItemM!.quantity = 1;
  //       singleItemM.UOM_quantity = 1;
  //       selectedItemList!.add(singleItemM);
  //       tecs.add(TextEditingController(text: "1"));
  //       focusNodesQuantity.add(FocusNode());
  //     });
  //   await Future.delayed(Duration(milliseconds: 100));
  //   scrollController.animateTo(scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  //   // await Future.delayed(Duration(milliseconds: 500));
  //   focusNodesQuantity.last.requestFocus();
  // }

  itemSelected(SearchM? item) async {
    if (selectedItemList
        .any((existingItem) => existingItem.Item_No == item?.itemNo)) {
      return;
    }

    SingleItemM? singleItemM;

    if (item != null) {
      await Serviece.getSingleItemDetails(
        apiKey: compRepo!.getSelectedApiKey(),
        cvCode: party!.CVCode.toString(),
        context: context,
        document: widget.formId.toString(),
        itemNumber: item.itemNo.toString(),
        pricelist: party!.PriceList.toString(),
      ).then((value) async {
        singleItemM = value;
        if (singleItemM != null) {
          if (mounted) {
            setState(() {
              singleItemM?.quantity = 1;
              singleItemM?.UOM_quantity = 1;

              selectedItemList.add(singleItemM!);
              print(selectedItemList);
              tecs.add(TextEditingController(text: "1"));
              focusNodesQuantity.add(FocusNode());
            });
          }

          await Future.delayed(Duration(milliseconds: 100));
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeIn,
          );

          // await Future.delayed(Duration(milliseconds: 500));
          focusNodesQuantity.last.requestFocus();
        }
      });
    } else {
      print("No item found");
      return Center(
          child: Text(
              "No Item Found...")); // or handle the case when item is null in an appropriate way
    }
  }

  void openSubmitScreen(String? savemode) {
    if (selectedItemList.where((element) => element.quantity == null).length >
        0) {
      Toast.show('Enter Quantity');
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InvoiceSubmitScreen(
                  empId: widget.empId.toString(),
                  rootDetails: widget.rootDetails,
                  rootId: widget.rootId,
                  itemList: selectedItemList ?? [],
                  documentLoadM: documentLoadM,
                  selectedPary: party!,
                  formNo: widget.formId ?? 0,
                  isDeliveryForm: widget.isDeliveryForm,
                  savemode :savemode 
                )));
  }

  Future<bool> _onWillPop() async {
    if (selectedItemList.isEmpty) {
      return true;
    }
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to go back'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //<-- SEE HERE
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                // <-- SEE HERE
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void dispose() {
    tecBarCode.dispose();
    tecMrp.dispose();
    scrollController.dispose();
    tecs.forEach((element) {
      element.dispose();
    });
    focusNodesQuantity.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  Future<void> startItemSearcByQa() async {
    var barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Cancel", true, ScanMode.BARCODE);

    if (barcodeScanRes != "-1") {
      SearchM searchItemFromBarcode = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BarCodeScreen(
                    barcodeScanRes,
                    compRepo!.getSelectedApiKey(),
                    onItemSelect: (item) {},
                  )));

      if (searchItemFromBarcode != null) {
        itemSelected(searchItemFromBarcode);
      }
    }
  }

  @override
  void salesRefreshPage(SearchM item) {
    itemSelected(item);
  }
}
