import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/manager/AccountLoadM.dart';
import 'package:glowrpt/model/other/CatSectionM.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/cat_section_item.dart';
import 'package:glowrpt/widget/other/line_item_widget.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';

import '../item_with_gp_screeen.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  bool? isSale;
  List<String>? dateListLine;

  CategoryListScreen({this.isSale, this.dateListLine});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late CompanyRepository compRepo;

  // List<String> dateListLine;
  List<CatSectionM>? filteredList;
  DocM? docM;

  List<CatSectionM> fullList = [];

  String query = "";

  String selectedSort = Sort.Default;

  var selectedField = "Name";

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    // dateListLine = MyKey.getDefaultDateListAsToday();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Details".tr),
      ),
      body: filteredList != null
          ? Column(
              children: [
                ExpansionTile(
                  trailing: Icon(Icons.sort),
                  title: TextField(
                    decoration: InputDecoration(
                        border: textFieldBorder, labelText: "Search".tr),
                    onChanged: (text) {
                      query = text;
                      filtering();
                    },
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                          filtering();
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
                  child: ListView.builder(
                      // shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: filteredList!.length,
                      itemBuilder: (context, position) {
                        var item = filteredList![position];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemWithGpScreeen(
                                          item: item,
                                          type: DocType.category,
                                          id: item.id,
                                          dateList: widget.dateListLine!,
                                          isSale: widget.isSale!,
                                        )));
                          },
                          child: CatSectionItem(
                            position: position,
                            item: item,
                            type: DocType.category,
                            apiKey: compRepo.getSelectedApiKey(),
                          ),
                        );
                      }),
                ),
              ],
            )
          : Center(child: CupertinoActivityIndicator()),
    );
  }

  Future<void> loadData() async {
    var data = await Serviece.getCategory(context, compRepo.getSelectedApiKey(),
        widget.dateListLine!.first, widget.dateListLine!.last, "", 0, "",
        endPont: widget.isSale! ? "CAT" : "PRCAT", IsPageing: "N");
    var list = List<CatSectionM>.from(
        data["List"].map((x) => CatSectionM.fromJson(x)));
    fullList = list;
    filtering();
  }

  filtering() {
    filteredList = fullList.where((element) {
      print(element.GPPercent);
      if (query.isEmpty) {
        return true;
      } else {
        return element.title
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element.SalesAmount.toString().contains(query);
      }
    }).toList();
    if (selectedSort == Sort.Default) {
      if (mounted) setState(() {});
    } else {
      sort();
    }
  }

  sort() {
    if (selectedField == "Name") {
      if (selectedSort == Sort.Ascending)
        filteredList!.sort((a, b) => a.title
            .toString()
            .trim()
            .toLowerCase()
            .compareTo(b.title.toString().trim().toLowerCase()));
      else if (selectedSort == Sort.Descending) {
        filteredList!.sort((a, b) => b.title
            .toString()
            .trim()
            .toLowerCase()
            .compareTo(a.title.toString().trim().toLowerCase()));
      }
    } else {
      if (selectedSort == Sort.Ascending)
        filteredList!.sort((a, b) =>
            ((a.GPPercent ?? 0.0) * 10000).toInt() -
            ((b.GPPercent ?? 0.0) * 10000).toInt());
      else if (selectedSort == Sort.Descending) {
        filteredList!.sort((a, b) =>
            ((b.GPPercent ?? 0.0) * 10000).toInt() -
            ((a.GPPercent ?? 0.0) * 10000).toInt());
      }
    }

    if (mounted) setState(() {});
  }
}
