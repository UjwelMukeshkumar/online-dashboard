// import 'package:avatar_letter/avatar_letter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:glowrpt/library/CollectionOperation.dart';
import 'package:toast/toast.dart';
import '../../model/other/DefaultM.dart';
import 'package:glowrpt/model/pos/PosGroupM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/pos/pos_item_screen.dart';
import 'package:glowrpt/screen/pos/pos_sales_invoice_screen.dart';
import 'package:glowrpt/screen/pos/pos_settings.dart';
import 'package:glowrpt/screen/transaction/sales_invoice_screen.dart';
import 'package:glowrpt/service/CartService.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/cahched_img.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/party/PartySearchM.dart';
import 'package:get/get.dart';

class PosGroupScreen extends StatefulWidget {
  @override
  State<PosGroupScreen> createState() => _PosGroupScreenState();
}

class _PosGroupScreenState extends State<PosGroupScreen> {
  CompanyRepository? compRepo;

  CartService? cart;

  PagewiseLoadController<PosGroupM>? _pageLoadController;

  String query = "";

  DefaultM? defaults;
  GlobalKey keyDropdown = GlobalKey();

  @override
  void initState() {
    super.initState();
    // keyDropdown.currentState.
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    getDefault();
    SharedPreferences.getInstance().then((value) => setState(() {
          cart = CartService(value, compRepo!.getSelectedUser());
        }));
    _pageLoadController = PagewiseLoadController<PosGroupM>(
        pageSize: 20,
        pageFuture: (pageIndex) => Serviece.getPosItemGroup(
            context: context,
            api_key: compRepo!.getSelectedApiKey(),
            pageNo: (pageIndex! + 1).toString(),
            query: query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(
              labelText: "Search Category".tr,
              // border: textFieldBorder,
              suffix: Icon(Icons.search)),
          onChanged: (text) {
            query = text;
            _pageLoadController?.reset();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                MyKey.openDropdown(keyDropdown);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PosSettings()));
              },
              icon: Icon(Icons.settings)),
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 4),
            child: InkWell(
              onTap: openCartPage,
              child: SizedBox(
                height: 40,
                width: 40,
                child: Stack(
                  children: [
                    Center(
                        child: Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColor.title,
                    )),
                    //  CircleAvatar()
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 186, 22, 11),
                            child: Text(
                              "${cart?.getAll().length}",
                              style: TextStyle(fontSize: 12),
                            ),
                            // text: "${cart?.getAll()?.length}",
                            // textColor: Colors.white,
                            // textColorHex: "ffffff",
                            // backgroundColorHex: "ff00bb",
                            // backgroundColor: Colors.red,
                            // size: 6,
                            // fontSize: 12,
                            // letterType: LetterType.Circular,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: false,
            maintainState: true,
            maintainAnimation: true,
            child: DropdownSearch<PartySearchM>(
              popupProps: PopupProps.modalBottomSheet(
                  showSearchBox: true,
                  isFilterOnline: true,
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Select Paty".tr),
                  )),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                labelText: "With".tr,
              )),
              // mode: Mode.BOTTOM_SHEET,
              key: keyDropdown,
              // popupTitle: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text("Select Paty".tr),
              // ),
              // showSearchBox: true,
              // isFilteredOnline: true,
              // onFind: (text) => Serviece.posPartySearch(
              //     context: context,
              //     api_key: compRepo.getSelectedApiKey(), //for supplier
              //     query: text),
              asyncItems: (text) => Serviece.posPartySearch(
                context: context,
                api_key: compRepo!.getSelectedApiKey(),
                query: text,
              ),
              onChanged: (party) async {
                var singleParty = await Serviece.getPosCvSinglePartyDetails(
                    api_key: compRepo!.getSelectedApiKey(),
                    cvCode: party!.CVCode.toString(),
                    context: context);
                defaults?.Details?.add(DetailsBean(
                    CVName: singleParty.CVCode,
                    CVCode: singleParty.CVCode,
                    PriceList: singleParty.PriceList));
              },
            ),
          ),
          Expanded(
            child: PagewiseListView<PosGroupM>(
              // pageSize: 20,
              noItemsFoundBuilder: (_) => Text("No Details Found".tr),
              pageLoadController: _pageLoadController,
              itemBuilder: (context, item, position) {
                return Card(
                  child: ListTile(
                    onTap: () => openItemScreen(item),
                    title: Text(item.GrpName ?? ""),
                    leading: SizedBox(
                        width: 60,
                        child: CachedImg(
                          url: item.Image ?? "",
                          itemName: item.GrpName ?? "",
                          isSmall: true,
                        )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  openItemScreen(PosGroupM item) async {
    if (defaults?.Details?.tryFirst == null) {
      MyKey.openDropdown(keyDropdown);
      return;
    }
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PosItemScreen(
                  group: item,
                  defaultM: defaults,
                )));
    if (result == true) {
      setState(() {});
    }
  }

  Future<void> openCartPage() async {
    if (defaults?.Details?.tryFirst == null) {
      MyKey.openDropdown(keyDropdown);
      return;
    }
    var isSuccess = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PosSalesInVoiceScreen(defaultUserData: defaults)));
    setState(() {});
  }

  Future<void> getDefault() async {
    defaults = await Serviece.getDefault(
        context: context, api_key: compRepo!.getSelectedApiKey());
    print("Defaults ${defaults}");
    if (defaults?.Details?.tryFirst == null) {
      print("open dropdown called");
      MyKey.openDropdown(keyDropdown);
    }
  }
}
