import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:glowrpt/model/item/ItemSaleReportM.dart';
import 'package:glowrpt/model/other/CatSectionM.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/model/other/HedderParams.dart';
import 'package:glowrpt/model/party/PartyGroupM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/cat_section_item.dart';
import 'package:glowrpt/widget/other/flexible_widget.dart';
import 'package:glowrpt/widget/other/line_item_widget.dart';
import 'package:glowrpt/widget/main_tabs/sub/customer_list_screen.dart';
import 'package:glowrpt/widget/main_tabs/sub/item_bill_list_screen.dart';
import 'package:glowrpt/widget/main_tabs/sub/sales_item_by_supplier_screen.dart';
import 'package:glowrpt/widget/other/party_group_item.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';

import '../item_with_gp_screeen.dart';
import 'package:get/get.dart';

class PartyGroupFullList extends StatefulWidget {
  bool? isSupplier;
  bool? isGroups;
  List<String>? dateListLine;

  PartyGroupFullList({this.isSupplier, this.dateListLine, this.isGroups});

  @override
  State<PartyGroupFullList> createState() => _PartyGroupFullListState();
}

class _PartyGroupFullListState extends State<PartyGroupFullList> {
  late CompanyRepository compRepo;

  // List<String> dateListLine;
  List<ItemSaleReportM>? linesList;
  DocM? docM;

  int pageSize = 100;
  String query = "";
  String selectedSort = Sort.Default;
  PagewiseLoadController? _pageLoadController;
  var selectedField = "Name";

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    _pageLoadController = PagewiseLoadController(
      pageSize: pageSize,
      pageFuture: (pageNo) => loadData(pageNo! + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.isSupplier! ? "Supplier".tr : "Customer"} ${widget.isGroups! ? " Group" : ""}"
                .tr),
      ),
      body: Column(
        children: [
          ExpansionTile(
            trailing: Icon(Icons.sort),
            title: TextField(
              decoration: InputDecoration(
                  border: textFieldBorder, labelText: "Search".tr),
              onChanged: (text) {
                query = text;
                _pageLoadController!.reset();
              },
            ),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownSearch<String>(
                   popupProps: PopupProps.menu(
                    // showSearchBox: true,
                    // isFilterOnline: true,
                  ),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                    labelText: "Filter By",
                  )),
                  selectedItem: selectedField,
                  items: ["GP".tr, "Name".tr],
                  // label: "Filter By",
                  onChanged: (parent) {
                    selectedField = parent!;
                    _pageLoadController!.reset();
                  },
                  // mode: Mode.MENU,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: RadioGroup<String>.builder(
                  groupValue: selectedSort,
                  onChanged: (value) => setState(() {
                    selectedSort = value!;
                    _pageLoadController!.reset();
                  }),
                  direction: Axis.horizontal,
                  items: Sort.all,
                  itemBuilder: (item) => RadioButtonBuilder(
                    item,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: PagewiseListView(
                // pageSize: pageSize,
                pageLoadController: _pageLoadController!,
                noItemsFoundBuilder: (_) => Text("No Details Found".tr),
                // pageFuture:(pageNo)=> loadData(pageNo+1),
                itemBuilder: (context, item, position) {
                  var partyGroupM = PartyGroupM.fromJson(item);
                  return InkWell(
                    onTap: () {
                      if (widget.isGroups!) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CustomerListScreen(
                            dateListLine: widget.dateListLine!,
                            partyGroupM: partyGroupM,
                            isSupplier: widget.isSupplier!,
                          );
                        }));
                      } else {
                        if (widget.isSupplier!) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SalesItemBySupplierScreen(
                                item: partyGroupM,
                                dataList: widget.dateListLine!);
                          }));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ItemBillListScreen(
                                item: partyGroupM,
                                dataList: widget.dateListLine!,
                                isSupplier: widget.isSupplier!);
                          }));
                        }
                      }
                    },
                    child: PartyGroupItem(
                      position: position,
                      item: partyGroupM,
                      // type: DocType.section,
                      apiKey: compRepo.getSelectedApiKey(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<List> loadData(int pageNo) async {
    var response = await Serviece.getParyGroups(
        context: context,
        api_key: compRepo.getSelectedApiKey(),
        FromDate: widget.dateListLine!.first,
        ToDate: widget.dateListLine!.last,
        isGroup: widget.isGroups!,
        apiPageNumber: pageNo,
        PageSize: pageSize,
        Sortyby: Sort.getSortApiTag(selectedSort),
        Orderby: selectedField,
        query: query,
        CVtype: getCvType(
            isSupplier: widget.isSupplier!, isGroups: widget.isGroups!));
    return response["List"];
  }
}
