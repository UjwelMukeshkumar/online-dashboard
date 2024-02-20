import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/manager/AccountLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class CreateNewAccount extends StatefulWidget {
  CreateNewAccount({Key? key}) : super(key: key);

  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
   CompanyRepository? compRepo;

   AccountLoadM? loadM;
  var tecNextNumber = TextEditingController();
  var tecAccountName = TextEditingController();

   ParentListBean? selectedParent;

   DrawerBean? selectedDrawer;

   ClassificationBean? selectedClassifiction;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    load();
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(
      height: 16,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Account".tr),
      ),
      body: loadM != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Enter Account Name".tr,
                              border: textFieldBorder),
                          controller: tecAccountName,
                        ),
                        space,
                        DropdownSearch<ParentListBean>(
                          // popupProps: PopupProps.bottomSheet(
                          // showSearchBox: true,
                          // isFilterOnline: true,
                          // ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelText: "Parent Account".tr,
                          )),
                          selectedItem: selectedParent,
                          items: loadM!.ParentList,
                          // label: "Parent Account".tr,
                          onChanged: (parent) {
                            selectedParent = parent!;
                          },
                        ),
                        space,
                        TextFormField(
                          controller: tecNextNumber,
                          decoration: InputDecoration(
                              labelText: "Account Code".tr,
                              border: textFieldBorder,
                              suffixIcon: InkWell(
                                onTap: getNextNumber,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.refresh),
                                ),
                              )),
                        ),
                        space,
                        DropdownSearch<DrawerBean>(
                          items: loadM!.Drawer,
                          // label: "Drawer".tr,
                          selectedItem: selectedDrawer,
                          onChanged: (selected) {
                            setState(() {
                              selectedDrawer = selected!;
                              selectedClassifiction =
                                  loadM!.Classification.firstWhere((element) =>
                                      element.Drawer ==
                                      selectedDrawer!.DisplayMember);
                            });
                          },
                        ),
                        space,
                        DropdownSearch<ClassificationBean>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Account Type".tr
                            )
                          ),
                          items: loadM!.Classification,
                          // label: "Account Type".tr,
                          selectedItem: selectedClassifiction,
                          onChanged: (selected) {
                            setState(() {
                              selectedClassifiction = selected!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  FractionallySizedBox(
                      widthFactor: 1,
                      child: ElevatedButton(
                          onPressed: insertAccount, child: Text("Save".tr)))
                ],
              ),
            )
          : Center(child: CupertinoActivityIndicator()),
    );
  }

  Future<void> load() async {
    loadM = await Serviece.getAccountLoad(
        context: context, api_key: compRepo!.getSelectedApiKey());
    selectedParent = loadM!.ParentList.first;
    selectedDrawer = loadM!.Drawer.first;
    selectedClassifiction = loadM!.Classification.firstWhere(
        (element) => element.Drawer == selectedDrawer!.DisplayMember);
    setState(() {});
  }

  Future<void> getNextNumber() async {
    if (selectedParent == null) {
      Toast.show("Please select parent account");
      return;
    }
    var nextNum = await Serviece.getNextNum(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        code: selectedParent!.Code.toString());
    tecNextNumber.text = nextNum.NextNum.first.Column1.toString();
  }

  Future<void> insertAccount() async {
    if (tecAccountName.text.isEmpty) {
      Toast.show("Please enter account name");
      return;
    }
    if (tecNextNumber.text.isEmpty) {
      Toast.show("Please enter account code");
      return;
    }
    var response = await Serviece.accountInsert(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        code: tecNextNumber.text,
        clasification: selectedClassifiction!.ValueMember,
        drawer: selectedDrawer!.ValueMember.toString(),
        parent: selectedParent!.Code.toString(),
        name: tecAccountName.text);
    if (response != null) {
      Toast.show("Saved");
      Navigator.pop(context, true);
    }
  }
}
