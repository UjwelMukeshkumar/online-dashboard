import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/manager/AccountLoadM.dart';
import 'package:glowrpt/model/other/CatSectionM.dart';
import 'package:glowrpt/model/other/DocM.dart';
import 'package:glowrpt/model/party/PartyGroupM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/cat_section_item.dart';
import 'package:glowrpt/widget/other/line_item_widget.dart';
import 'package:glowrpt/widget/other/party_group_item.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';

import '../item_with_gp_screeen.dart';
import 'package:get/get.dart';

class TaxListScreen extends StatefulWidget {
  bool? isSale;
  List<String>? dateListLine;
  String? dateRangeText;

  TaxListScreen({this.isSale, this.dateListLine, this.dateRangeText});

  @override
  State<TaxListScreen> createState() => _TaxListScreenState();
}

class _TaxListScreenState extends State<TaxListScreen> {
  late CompanyRepository compRepo;

  // List<String> dateListLine;
  List<PartyGroupM>? filteredList;
  DocM? docM;

  List<PartyGroupM> fullList = [];

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
        title: Text("Tax Details".tr),
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
                          labelText: "Filter By"
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
                            onTap: () {},
                            child: PartyGroupItem(
                              position: position,
                              item: item,
                              // type: DocType.section,
                              apiKey: compRepo.getSelectedApiKey(),
                            ));
                      }),
                ),
              ],
            )
          : Center(child: CupertinoActivityIndicator()),
    );
  }

  Future<void> loadData() async {
    var data = await Serviece.getTaxcodeDetails(
        context: context,
        api_key: compRepo.getSelectedApiKey(),
        FromDate: widget.dateListLine!.first,
        ToDate: widget.dateListLine!.last,
        dateRangeText: widget.dateRangeText!,
        IsPageing: "N");
    var lise = List<PartyGroupM>.from(
        data["List"].map((x) => PartyGroupM.fromJson(x)));
    fullList = lise;
    filtering();
  }

  filtering() {
    filteredList = fullList.where((element) {
      print(element.GPPercent);
      if (query.isEmpty) {
        return true;
      } else {
        return element.getTitle
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element.getAmount.toString().contains(query);
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
        filteredList!.sort((a, b) => a.Name.toString()
            .trim()
            .toLowerCase()
            .compareTo(b.getTitle.toString().trim().toLowerCase()));
      else if (selectedSort == Sort.Descending) {
        filteredList!.sort((a, b) => b.getTitle
            .toString()
            .trim()
            .toLowerCase()
            .compareTo(a.getTitle.toString().trim().toLowerCase()));
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
