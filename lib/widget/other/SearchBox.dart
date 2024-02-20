import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/SearchM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/model/other/ItemM.dart';
import 'package:provider/provider.dart';

import 'ItemSearchDeligate.dart';

class SearchBox extends StatelessWidget {
  String lastSelectedString = "";
  String categoryId;
  List<ItemM>? itemList;
  // ValueChanged<SearchM>? onItemSelect;
  ValueChanged<SearchM> onItemSelect = (item) {
    print('Default callback called with item: $item');
  };


  SearchBox({this.categoryId = "All",  this.itemList,
        required this.onItemSelect});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var selectedCompany =
            Provider.of<CompanyRepository>(context, listen: false);

        if (onItemSelect != null) {
          startItemWindowFromSearch(
              context,
              lastSelectedString,
              categoryId,
              itemList ?? [],
              selectedCompany.getSelectedUser().apiKey,
              onItemSelect);
              print('onItemSelect value: $onItemSelect');

        } else {
          print('onItemSelect is null');
          print('onItemSelect value: $onItemSelect');

          // Handle this case as per your application's requirements.
        }
      },

      // onTap: () {
      //   var selectedCompany =
      //       Provider.of<CompanyRepository>(context, listen: false);
      //   startItemWindowFromSearch(context, lastSelectedString, categoryId,
      //       itemList??[], selectedCompany.getSelectedUser().apiKey, onItemSelect !);
        
        
      //     // var selectedCompany =
      //     //     Provider.of<CompanyRepository>(context, listen: false);

      //     // if (itemList != null &&
      //     //     onItemSelect != null) {
      //     //   startItemWindowFromSearch(
      //     //       context,
      //     //       lastSelectedString,
      //     //       categoryId,
      //     //       itemList??[],
      //     //       selectedCompany.getSelectedUser().apiKey,
      //     //       onItemSelect!);
      //     // } else {
      //     //   print('Item List: $itemList');
      //     // print('Selected User: ${selectedCompany.getSelectedUser()}');
      //     // print('On Item Select: $onItemSelect');

      //     //   print('Some required values are null');
      //     // }
      
      // },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.search
            // size: 20,
            // color: Colors.black87,
            ),
      ),
    );
  }
}

void startItemWindowFromSearch(
    BuildContext context,
    String lastSelectedString,
    String categoryId,
    List<ItemM> itemList,
    String apiKey,
    ValueChanged<SearchM> onItemSelect) async {
  SearchM? selectdItem = await showSearch(
    context: context,
    delegate: ItemSearchDelegate(apiKey: apiKey, onItemSelect: onItemSelect),
  );
  onItemSelect.call(selectdItem!);
}
