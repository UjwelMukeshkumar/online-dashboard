import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/manager/PromotionLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class DesignationMasterScreen extends StatefulWidget {
  @override
  _DesignationMasterScreenState createState() =>
      _DesignationMasterScreenState();
}

class _DesignationMasterScreenState extends State<DesignationMasterScreen> {
   CompanyRepository? compRepo;

  PromotionLoadM? promotionLoad;

  String? promotionName;

  PromotionBean? itemToEdit;
  var tecPromotion = TextEditingController();

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadPromotion();
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(
      height: 20,
    );
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Designation Master".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            space,
            TextFormField(
              controller: tecPromotion,
              decoration: InputDecoration(
                labelText: "Designation Title".tr,
                border: textFieldBorder,
              ),
            ),
            space,
            ListTile(
              title: Text(
                "Select Options".tr,
                style: textTheme.headline6,
              ),
            ),
            Expanded(
              child: promotionLoad != null
                  ? ListView.builder(
                      itemCount: promotionLoad!.promotion.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: InkWell(
                              onTap: () {
                                if (kDebugMode) {
                                  itemToEdit = promotionLoad!.promotion[index];
                                  tecPromotion.text = itemToEdit!.Name;
                                }
                              },
                              child: Text(promotionLoad!.promotion[index].Name)),
                          value:
                              promotionLoad!.promotion[index].selected == true,
                          onChanged: (value) {
                            setState(() {
                              promotionLoad!.promotion[index].selected = value!;
                            });
                          },
                        );
                      })
                  : Center(
                      child: CupertinoActivityIndicator(),
                    ),
            ),
            ElevatedButton(
                onPressed: insertPromotionMaster,
                child: Text("Create Designation".tr))
          ],
        ),
      ),
    );
  }

  Future<void> loadPromotion() async {
    promotionLoad = await Serviece.promotionLoad(
        context: context, api_key: compRepo!.getSelectedApiKey(), type: "M");
    setState(() {});
  }

  Future<void> insertPromotionMaster() async {
    promotionName = tecPromotion.text;
    if (promotionName == null || promotionName!.isEmpty) {
      showToast("Promotion Title");
      return;
    } //PromotionId
    var selectedPromotions = promotionLoad!.promotion
        .where((element) => element.selected == true)
        .toList();
    var supPromo = json
        .encode(selectedPromotions.map((e) => {"PromotionId": e.Id}).toList());
    var response = await Serviece.insertPromotion(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        name: promotionName!,
        subpromotions: supPromo,
        id: itemToEdit?.Id.toString() ?? "0");
    if (response != null) {
      showToast("Designation Created Successfully");
      Navigator.pop(context, true);
    }
  }
}
