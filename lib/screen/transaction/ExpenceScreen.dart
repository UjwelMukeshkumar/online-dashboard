import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/BasicResponse.dart';
import 'package:glowrpt/model/employe/ExpenceM.dart';
import 'package:glowrpt/model/other/ExpenceChildM.dart';
import 'package:glowrpt/model/other/SearchM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/model/transaction/ExpenceLineM.dart';
import 'package:glowrpt/model/transaction/ExpenceLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/ItemSearchDeligate.dart';
import 'package:glowrpt/widget/employee/KeyValueDate.dart';
import 'package:glowrpt/widget/employee/KeyValueSpinner.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

class ExpenceScreen extends StatefulWidget {
  @override
  _ExpenceScreenState createState() => _ExpenceScreenState();
}

enum ExpenceType { Expence, Asset }

class _ExpenceScreenState extends State<ExpenceScreen> {
  TextEditingController tec_datePicker = TextEditingController();
  TextEditingController tec_amount = TextEditingController();
  TextEditingController tec_remarks = TextEditingController();
  User? user;

  //List expenceList = [];
  final _formKey = GlobalKey<FormState>();
  bool isNoProcess = true;
  ListBean? _expence;

  TextEditingController tec_expence = TextEditingController();
  XFile? _imagePath;

   CompanyRepository? compRepo;

  ExpenceLoadM? expenceLoadE;
  ExpenceLoadM? expenceLoadA;

  List<ListBean>? expenceListE;
  List<ListBean>? expenceListA;
  List<SearchM> itemList = [];

  bool isGstEnabled = false;

  PartySearchM? selectedParty;

  bool isLoding = false;

  Future getImageFile(bool isCamera) async {
    XFile? myImage;
    if (isCamera) {
      myImage = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      myImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imagePath = myImage;
    });
  }

  var _selectedValue = ExpenceType.Expence;
  final _multiKey = GlobalKey<DropdownSearchState<ListBean>>();

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    tec_datePicker.text = MyKey.displayDateFormat.format(DateTime.now());
    loadExpence();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "GST",
                  style: TextStyle(color: AppColor.title),
                ),
                CupertinoSwitch(
                    value: isGstEnabled,
                    onChanged: (value) {
                      setState(() {
                        isGstEnabled = value;
                      });
                    }),
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: Radio(
                                value: ExpenceType.Expence,
                                groupValue: _selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value!;
                                    selectionChanged();
                                  });
                                },
                              ),
                              title: Text("Expense"),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              leading: Radio(
                                  value: ExpenceType.Asset,
                                  groupValue: _selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value!;
                                      selectionChanged();
                                    });
                                  }),
                              title: Text("Asset"),
                            ),
                          )
                        ],
                      ),

                      /*     _selectedValue == ExpenceType.Expence
                          ? KeyValueSpinner(
                              title: "Select Expense Type",
                              modelList: expenceList,
                              initModel: _expence,
                              fieldName: "Name",
                              onChanged: (value) {
                                _expence = value;
                              },
                            )
                          : Container(),*/
                      DropdownSearch<ListBean>(
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                          isFilterOnline: true,
                        ),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                labelText: _selectedValue == ExpenceType.Expence
                                    ? "Expense"
                                    : "Asset")),

                        key: _multiKey,
                        selectedItem: _expence,
                        // mode: Mode.MENU,
                        items: _selectedValue == ExpenceType.Expence
                            ? expenceListE!
                            : expenceListA!,
                        //autoFocusSearchBox: true,
                        // showSearchBox: true,
                        // label: _selectedValue == ExpenceType.Expence
                        //     ? "Expense"
                        //     : "Asset",
                        onChanged: (expe) {
                          _expence = expe;
                        },
                      ),
                      Visibility(
                        visible: isGstEnabled,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: DropdownSearch<PartySearchM>(
                            popupProps: PopupProps.bottomSheet(
                              showSearchBox: true,
                              isFilterOnline: true,
                            ),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                              labelText: "Party *",
                            )),

                            // mode: Mode.BOTTOM_SHEET,
                            //autoFocusSearchBox: true,
                            // showSearchBox: true,
                            // label: "Party *",
                            // isFilteredOnline: true,
                            asyncItems: (text) => Serviece.partySearch(
                              context: context,
                              api_key: compRepo!.getSelectedApiKey(),
                              Type: "All",
                              query: text,
                            ),
                            // onFind: (text) => Serviece.partySearch(
                            //     context: context,
                            //     api_key: compRepo.getSelectedApiKey(),
                            //     Type: "All",
                            //     query: text),
                            onChanged: (party) {
                              selectedParty = party;
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select billed items",
                              style: textTheme.headline6),
                          TextButton.icon(
                            onPressed: isLoding ? null : selectItem,
                            label: Text("Add item"),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Item Name")),
                          Expanded(child: Text("Quantity")),
                          Expanded(child: Text("Rate")),
                          Expanded(child: Text("Amount")),
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: itemList.length,
                          itemBuilder: (context, position) {
                            var item = itemList[position];
                            return Row(
                              children: [
                                Expanded(child: Text(item.itemName.toString())),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      onChanged: (text) {
                                        setState(() {
                                          item.quantity =
                                              double.tryParse(text)!;
                                          print("Qantity ${item.quantity}");
                                        });
                                      },
                                      initialValue: "${item.quantity}",
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: item.mrp.toString(),
                                      keyboardType: TextInputType.number,
                                      onChanged: (text) {
                                        setState(() {
                                          item.mrp = double.tryParse(text)!;
                                          print("Qantity ${item.quantity}");
                                          print("Mrp ${item.mrp}");
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                        "${(item.mrp ?? 0) * (item.quantity ?? 0)}")),
                              ],
                            );
                          }),
                      TextFormField(
                          controller: tec_amount,
                          keyboardType: TextInputType.number,
                          validator: (text) {
                            return double.parse(text!) == 0
                                ? "Amount Invalid"
                                : null;
                          },
                          decoration: InputDecoration(
                            labelText: "Amount",
                          )),
                      TextFormField(
                        controller: tec_remarks,
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        minLines: 1,
                        decoration: InputDecoration(
                          labelText: "Remarks",
                        ),
                        validator: (text) {
                          return text!.isEmpty ? "Please enter Remarks" : null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: _imagePath == null
                              ? Container(
                                  child: SizedBox(
                                    height: 150,
                                  ),
                                )
                              : Image.file(
                                  File(_imagePath!.path),
                                  height: 300,
                                ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: FractionallySizedBox(
                          alignment: Alignment.bottomRight,
                          widthFactor: .4,
                          child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              if (!isNoProcess) return;
                              if (_formKey.currentState!.validate()) {
                                submit();
                              }
                            },
                            child: isNoProcess
                                ? Text(
                                    "SUBMIT",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : CupertinoActivityIndicator(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadExpence() async {
    expenceLoadE = await Serviece.expenceLoad(
        context: context, api_key: compRepo!.getSelectedApiKey(), type: "E");
    expenceListE = expenceLoadE?.Lists;

    expenceLoadA = await Serviece.expenceLoad(
        context: context, api_key: compRepo!.getSelectedApiKey(), type: "A");
    expenceListA = expenceLoadA?.Lists;
    setState(() {});
  }

  void selectionChanged() {
    _multiKey.currentState!.clear();
    itemList.clear();
  }

  Future<void> selectItem() async {
    SearchM? selectdItem = await showSearch(
      context: context,
      delegate: ItemSearchDelegate(
          apiKey: compRepo!.getSelectedApiKey(),
          type: _selectedValue == ExpenceType.Expence ? "Expense" : "Asset",
          onItemSelect: (item) {
            print("Slected");
          }),
    );
    if (selectdItem != null) {
      setState(() {
        selectdItem.quantity = 1;
        itemList.add(selectdItem);
      });
    }
  }

  Future<void> submit() async {
    if (_expence == null) {
      Toast.show("Please Select Account");
      return;
    }
    if (isGstEnabled) {
      if (selectedParty == null) {
        Toast.show("Please Select Party");
        return;
      }
    } else {
      selectedParty = null;
    }
    setState(() {
      isLoding = true;
    });
    var response = await Serviece.expenceInsert(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        date: MyKey.getCurrentDate(),
        netAmount: tec_amount.text,
        partyCode: selectedParty?.code ?? "",
        account: _expence!.Code.toString(),
        partyName: selectedParty?.Name ?? "",
        refDate: MyKey.getCurrentDate(),
        refNo: "1",
        expence: json.encode(itemList
            .map((e) => ExpenceLineM(
                  TaxCode: e.taxcode!.toString(),
                  Item_Name: e.itemName!,
                  Item_No: e.itemNo!,
                  Price: e.mrp!,
                  Quantity: e.quantity!,
                  TaxAmount: 0,
                  //todo later
                  Total: e.mrp! * e.quantity!,
                ))
            .toList()));
    setState(() {
      isLoding = false;
    });
    if (response != null) {
      Toast.show("Saved");
      Navigator.pop(context);
    }
  }
}
