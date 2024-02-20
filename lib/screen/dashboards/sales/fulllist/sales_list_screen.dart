import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
// import 'package:glowrpt/localdependency/lib/flutter_pagewise.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/pdf/SalesHistory.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/line_item_widget.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SalesListScreen extends StatefulWidget {
  bool? isSale;
  List<String>? dateListLine;

  SalesListScreen({this.isSale, this.dateListLine});

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen> {
  late CompanyRepository compRepo;

  // List<String> dateListLine;
  int pageSize = 100;
  DocM? docM;
  String query = "";
  String selectedSort = Sort.Default;
  PagewiseLoadController<LinesBean>? _pageLoadController;
  var selectedField = "Name";

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    _pageLoadController = PagewiseLoadController<LinesBean>(
      pageSize: pageSize,
      pageFuture: (pageNo) => loadData(pageNo! + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text("${widget.isSale! ? "Sales".tr : "Purchase".tr} Details".tr),
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
                      _pageLoadController?.reset();
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
                      _pageLoadController?.reset();
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
              child: PagewiseListView<LinesBean>(
                  noItemsFoundBuilder: (_) => Text("No Details Found".tr),
                  pageLoadController: _pageLoadController!,
                  itemBuilder: (context, item, position) {
                    return LineItemWidget(
                      item: item,
                      position: position,
                      excludeGp: false,
                      selectedItem: compRepo.getSelectedUser(),
                      type: widget.isSale! ? "SP" : "PI",
                    );
                  }),
            ),
          ],
        ));
  }

  Future<List<LinesBean>> loadData(int pageNo) async {
    docM = await Serviece.getHomedoc(context, compRepo.getSelectedApiKey(),
        widget.dateListLine!.first, widget.dateListLine!.last, pageNo, query,
        endPont: widget.isSale! ? "homedoc" : "prdoc",
        IsPageing: "Y",
        PageSize: pageSize,
        Orderby: selectedField,
        Sortyby: Sort.getSortApiTag(selectedSort));

    return docM!.Lines;
  }
}
