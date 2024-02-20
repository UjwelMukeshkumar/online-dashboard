// import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/library/CollectionOperation.dart';
import 'package:glowrpt/model/item/SingleItemM.dart';
import 'package:glowrpt/model/other/DefaultM.dart';
import 'package:glowrpt/model/other/SearchM.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/model/party/SinglePartyDetailsM.dart';
import 'package:glowrpt/model/transaction/DocumentLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
// import 'package:glowrpt/screen/pos/PosInvoiceHeadderM.dart';
// import 'package:glowrpt/screen/pos/PosInvoiceLineM.dart';
import 'package:glowrpt/screen/pos/pos_invoice_submit_screen.dart';
// import 'package:glowrpt/screen/transaction/invoice_submit_screen.dart';
import 'package:glowrpt/service/CartService.dart';
import 'package:glowrpt/util/Constants.dart';
// import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/ItemSearchDeligate.dart';
import 'package:glowrpt/widget/pos/cart_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class PosSalesInVoiceScreen extends StatefulWidget {
  DefaultM? defaultUserData;
  PosSalesInVoiceScreen({this.defaultUserData});

  @override
  _PosSalesInVoiceScreenState createState() => _PosSalesInVoiceScreenState();
}

class _PosSalesInVoiceScreenState extends State<PosSalesInVoiceScreen> {
  CompanyRepository? compRepo;

  SinglePartyDetailsM? selectedParty;

  bool isInclude = false;
  var tecBarCode = TextEditingController();
  List<SingleItemM> itemList = [];
  List<TextEditingController> tecQuantity = [];
  @override
  var tecMrp = TextEditingController();
  var scrollController = ScrollController();

  DocumentLoadM? documentLoadM;

  CartService? cart;
  GlobalKey keyDropdown = GlobalKey();

  PartySearchM? selectedItem;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    SharedPreferences.getInstance().then((value) {
      cart = CartService(value, compRepo!.getSelectedUser());
      itemList.addAll(cart!.getAll());
      itemList.forEach((element) {
        tecQuantity
            .add(TextEditingController(text: element.quantity.toString()));
      });
    });
    var defaultUserData = widget.defaultUserData!.Details!.tryFirst;
    selectedItem = PartySearchM(
        CVCode: defaultUserData!.CVCode, CVName: defaultUserData.CVName);
    loadPager();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var sizedBox = SizedBox(height: 10);
    return Scaffold(
        appBar: AppBar(title: Text("Invoice".tr)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownSearch<PartySearchM>(
                popupProps: PopupProps.menu(
                    showSearchBox: true,
                    isFilterOnline: true,
                    title: Text("Selected Pary".tr)),
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText: "With".tr,
                )),
                asyncItems: (text) => Serviece.posPartySearch(
                  context: context,
                  api_key: compRepo!.getSelectedApiKey(),
                  query: text,
                ),
                // mode: Mode.MENU,
                key: keyDropdown,
                //autoFocusSearchBox: true,
                // popupTitle: Text("Select Paty".tr),
                // showSearchBox: true,
                selectedItem: selectedItem,
                // label: "${widget.defaultUserData.CVName}",
                // label: "${widget.defaultUserData.CVName}",

                // isFilteredOnline: true,
                // onFind: (text) => Serviece.posPartySearch(
                //     context: context,
                //     api_key: compRepo.getSelectedApiKey(), //for supplier
                //     query: text),
                onChanged: (party) => getSinglePartyDetails(party!),
              ),
              sizedBox,
              ListTile(
                title: Text(
                  "${itemList.length == 0 ? "Select".tr : "Add".tr} Product by"
                      .tr
                      .tr,
                  textAlign: TextAlign.center,
                ),
                subtitle: InkWell(
                  onTap: () => startItemWindowFromSearch(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Search".tr),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: itemList.length > 0,
                  child: Text("Swipe To Delete".tr,
                      // style: textTheme.caption!.copyWith(
                      style: textTheme.bodySmall!.copyWith(
                          fontStyle: FontStyle.italic, color: AppColor.title))),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = itemList[index];
                    if (itemList.last == item)
                      tecQuantity[index].selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: tecQuantity[index].text.length);
                    return Dismissible(
                      key: Key("${item.Item_No}"),
                      onDismissed: (i) {
                        setState(() {
                          itemList.removeAt(index);
                          tecQuantity[index].dispose();
                          tecQuantity.removeAt(index);
                          cart!.removeItem(item);
                        });
                      },
                      child: CartItem(
                        documentLoadM: documentLoadM!,
                        item: item,
                        etcQuantity: tecQuantity[index],
                        onUpdate: (updatedItem) {
                          item.Discount = updatedItem.Discount;
                          item.Price = updatedItem.Price;
                          item.UOM = updatedItem.UOM;
                          item.UOM_quantity = updatedItem.UOM_quantity;
                          item.quantity = updatedItem.quantity;
                        },
                        focusNodeQuntity: null,
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Add More".tr),
                      onPressed: () => startItemWindowFromSearch(),
                    ),
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          child: Text("Save".tr),
                          onPressed: () => openSubmitScreen()),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Future<void> loadPager() async {
    documentLoadM = await Serviece.getDocumentLoad(
        context: context, apiKey: compRepo!.getSelectedApiKey());
    setState(() {});
    selectedParty = await Serviece.getPosCvSinglePartyDetails(
        api_key: compRepo!.getSelectedApiKey(),
        cvCode: widget.defaultUserData!.Details!.tryFirst!.CVCode.toString(),
        context: context);
  }

  void startItemWindowFromSearch() async {
    if (selectedParty == null) {
      Toast.show("Select Party");
      return;
    }
    SearchM? selectdItem = await showSearch(
      context: context,
      delegate: ItemSearchDelegate(
          apiKey: compRepo!.getSelectedApiKey(), onItemSelect: itemSelected),
    );
    itemSelected(selectdItem!);
  }

  getSinglePartyDetails(PartySearchM party) async {
    this.selectedParty = await Serviece.getPosCvSinglePartyDetails(
        api_key: compRepo!.getSelectedApiKey(),
        cvCode: party.CVCode.toString(),
        context: context);
    var newItemList = await Future.wait(cart!
        .getAll()
        .map((item) => Serviece.getPosSingleItemDetails(
            api_key: compRepo!.getSelectedApiKey(),
            cvCode: party.CVCode.toString(),
            context: context,
            itemNumber: item.Item_No.toString(),
            pricelist: this.selectedParty!.PriceList.toString(),
            quantiy: item.quantity?.toDouble()))
        .toList());
    var maluallyChangedList = itemList
        .where((element) =>
            element.discountManullyChanged == true ||
            element.priceManuallyChanged == true ||
            element.quntityManuallyChanged == true ||
            element.UOMManuallyChanged == true)
        .toList();
    bool isOverite = true;
    if (maluallyChangedList.length > 0) {
      isOverite = (await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("Do you want overwrite manually changed fields?"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("No")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("Yes"))
              ],
            );
          }))!;
      print("is overite ${isOverite}");
    }

    newItemList.forEach((e) {
      var firstWhere = itemList
          .firstWhere((oldListElement) => oldListElement.Item_No == e.Item_No);

      if (isOverite || firstWhere.UOMManuallyChanged != true)
        firstWhere.UOM = e.UOM;
      if (isOverite || firstWhere.UOMManuallyChanged != true)
        firstWhere.UOM_quantity = e.UOM_quantity; //for safty
      if (isOverite || firstWhere.priceManuallyChanged != true)
        firstWhere.Price = e.Price;
      if (isOverite || firstWhere.quntityManuallyChanged != true)
        firstWhere.quantity = e.quantity;
      if (isOverite || firstWhere.discountManullyChanged != true)
        firstWhere.Discount = e.Discount;
    });

    print(newItemList.map((e) => e.Item_Name));
    setState(() {});
  }

  itemSelected(SearchM item) async {
    if (selectedItem != null) {
      SingleItemM singleItemM = await Serviece.getPosSingleItemDetails(
          api_key: compRepo!.getSelectedApiKey(),
          cvCode: selectedParty?.CVCode??"",
          context: context,
          // document: widget.formId.toString(),
          itemNumber: item.itemNo.toString(),
          pricelist: selectedParty?.PriceList.toString()??"");
      if (item != null)
        setState(() {
          singleItemM.quantity = 1;
          itemList.add(singleItemM);
          tecQuantity.add(TextEditingController(text: "1"));
        });
      await Future.delayed(Duration(milliseconds: 500));
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      print("moved");
    } else {
      print("Null occured");
    }
    
  }

  void openSubmitScreen() {
    if (itemList.where((element) => element.quantity == null).length > 0) {
      Toast.show('Enter Quantity');
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PosInvoiceSubmitScreen(
                  itemList: itemList,
                  documentLoadM: documentLoadM,
                  selectedPary: selectedParty,
                  formNo: 4791,
                )));
  }
}
