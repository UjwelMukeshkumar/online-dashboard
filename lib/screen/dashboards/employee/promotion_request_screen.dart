import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/manager/PromotionLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class PromotionRequestScreen extends StatefulWidget {
  @override
  State<PromotionRequestScreen> createState() => _PromotionRequestScreenState();
}

class _PromotionRequestScreenState extends State<PromotionRequestScreen> {
   CompanyRepository? compRepo;

   PromotionLoadM? promotionLoad;

   PromotionBean? fromDesignation;

   SubpromotionBean? toDesignation;

   List<SubpromotionBean>? toDesignations;

  String? remarks;
  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadPromotion();
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(
      height: 12,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Request For Promotion".tr),
      ),
      body: promotionLoad != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownSearch(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                       dropdownSearchDecoration: InputDecoration(
                         labelText: "From Designation".tr,
                       )
                    ),

                    selectedItem: fromDesignation,
                    items: promotionLoad!.promotion,
                    onChanged: (item) {
                      setState(() {
                        fromDesignation = item;
                      });
                    },
                  ),
                  space,
                  DropdownSearch(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "To Designation".tr,
                        )
                    ),

                    selectedItem: toDesignation,
                    items: toDesignations??[],
                    onChanged: (item) {
                      setState(() {
                        toDesignation = item;
                      });
                    },
                  ),
                  space,
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter Remarks".tr,
                      border: textFieldBorder,
                    ),
                    minLines: 3,
                    maxLines: 4,
                    onChanged: (text) {
                      remarks = text;
                    },
                  ),
                  Expanded(child: Container()),
                  FractionallySizedBox(
                      widthFactor: 1,
                      child: ElevatedButton(
                          onPressed: insertPromotion, child: Text("Submit".tr)))
                ],
              ),
            )
          : Center(child: CupertinoActivityIndicator()),
    );
  }

  Future<void> loadPromotion() async {
    promotionLoad = await Serviece.promotionLoad(
        context: context, api_key: compRepo!.getSelectedApiKey(), type: "E");
    fromDesignation = promotionLoad?.promotion.first;
    toDesignations = promotionLoad?.subpromotion
            .where((element) => element.Id == fromDesignation?.Id)
            .toList() ??
        [];
    if (toDesignations!.length > 0) toDesignation = toDesignations?.first;
     setState(() {});
  }

  insertPromotion() async {
    if (remarks == null || remarks!.isEmpty) {
      showToast("Enter Remarks");
      return;
    }
    if (toDesignation == null) {
      showToast("Please Select To Designation");
      return;
    }
    var response = await Serviece.promotionRequest(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        remarks: remarks.toString(),
        fromDeig: fromDesignation!.Id.toString(),
        toDesig: toDesignation!.Id.toString(),
        date: MyKey.getCurrentDate());
    if (response != null) {
      showToast("Request Success");
      Navigator.pop(context, true);
    }
  }
}
