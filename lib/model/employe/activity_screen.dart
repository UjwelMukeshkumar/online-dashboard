import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/ExpenceM.dart';
import 'package:glowrpt/model/employe/ExpenceTypeM.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/employee/KeyValueSpinner.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late CompanyRepository compRepo;
  List<ExpenceTypeM> expenceList = [];
  late PartySearchM party1;
  var tecWhat = TextEditingController();
  var tecWhere = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // var tecWhat=TextEditingController();
  String? strWhen;
  String? strStartTime;
  String? strEndTime;

  // var _expence;
  List expences = [];

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    getEcpenceList();
    expences.add(null);
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(
      height: 16,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            expences.add(expenceList.first);
          });
        },
      ),
      appBar: AppBar(
        title: Text("Add Activity".tr),
      ),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: tecWhat,
                      decoration: InputDecoration(
                        labelText: "What".tr,
                        border: textFieldBorder,
                      ),
                      validator: (text) =>
                          text!.isEmpty ? "Invalid data".tr : null,
                    ),
                    space,
                    Row(
                      children: [
                        Expanded(
                            child: DateTimeField(
                          resetIcon: null,
                          decoration: InputDecoration(
                              labelText: "When".tr, border: textFieldBorder),
                          format: DateFormat("dd MMM, yy"),
                          onShowPicker: (context, currentValue) async {
                            final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                            strWhen = MyKey.displayDateFormat.format(date!);
                            return date;
                          },
                          validator: (date) =>
                              date == null ? "Invalid data".tr : null,
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: DateTimeField(
                            resetIcon: null,
                            decoration: InputDecoration(
                                labelText: "From".tr, border: textFieldBorder),
                            format: DateFormat("hh:mm a"),
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    currentValue ?? DateTime.now()),
                              );
                              if (time != null) {
                                strStartTime = DateFormat("HH:mm")
                                    .format(DateTimeField.convert(time)!);
                              }

                              return DateTimeField.convert(time);
                            },
                            validator: (date) =>
                                date == null ? "Invalid data" : null,
                          ),
                        )),
                        Expanded(
                            child: DateTimeField(
                          resetIcon: null,
                          decoration: InputDecoration(
                              labelText: "To".tr, border: textFieldBorder),
                          format: DateFormat("hh:mm a"),
                          onShowPicker: (context, currentValue) async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            if (time != null) {
                              strEndTime = DateFormat("HH:mm")
                                  .format(DateTimeField.convert(time)!);
                            }
                            return DateTimeField.convert(time);
                          },
                          validator: (date) =>
                              date == null ? "Invalid data".tr : null,
                        )),
                      ],
                    ),
                    space,
                    TextFormField(
                      controller: tecWhere,
                      decoration: InputDecoration(
                        labelText: "Where".tr,
                        border: textFieldBorder,
                      ),
                      validator: (text) =>
                          text!.isEmpty ? "Invalid data" : null,
                    ),
                    space,
                    DropdownSearch<PartySearchM>(
                      popupProps: PopupProps.modalBottomSheet(
                        showSearchBox: true,
                        isFilterOnline: true,
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        labelText: "With".tr,
                      )),
                      asyncItems: (text) => Serviece.partySearch(
                        context: context,
                        api_key: compRepo.getSelectedApiKey(),
                        Type: "E",
                        query: text,
                      ),
                      // mode: Mode.BOTTOM_SHEET,
                      // showSearchBox: true,
                      // label: "With".tr,
                      // isFilteredOnline: true,

                      // onFind: (text) => Serviece.partySearch(
                      //     context: context,
                      //     api_key: compRepo.getSelectedApiKey(),
                      //     Type: "E",
                      //     query: text),
                      onChanged: (party) {
                        party1 = party!;
                      },
                      validator: (date) => date == null ? "Invalid data" : null,
                    ),
                    space,
                  ],
                ),
              ),
            ),
          ),
          space,
          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: expences.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        DropdownSearch<ExpenceTypeM>(
                          popupProps: PopupProps.modalBottomSheet(
                            showSearchBox: true,
                            isFilterOnline: true,
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelText: "With".tr,
                          )),
                          //mode: Mode.BOTTOM_SHEET,
                          // autoFocusSearchBox: true,
                          //showSearchBox: true,
                          //label: "Select Expense Type".tr,
                          items: expenceList,
                          onChanged: (party) {
                            setState(() {
                              expences[index] = party!.toJson();
                            });
                          },
                        ),
                        space,
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Amount".tr, border: textFieldBorder),
                          onChanged: (text) {
                            expences[index]["Amount"] = text;
                          },
                          validator: (text) =>
                              text!.isEmpty ? "Invalid data" : null,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                ElevatedButton(onPressed: saveActivity, child: Text("Save".tr)),
          )
        ],
      ),
    );
  }

  Future getEcpenceList() async {
    expenceList = await Serviece.getExpenceList(
      context: context,
      api_key: compRepo.getSelectedApiKey(),
    );
    expences[0] = expenceList.first.toJson();
    if (mounted) setState(() {});
  }

  Future<void> saveActivity() async {
    if (formKey.currentState!.validate()) {
      var response = await Serviece.insertActivity(
          context: context,
          api_key: compRepo.getSelectedApiKey(),
          what: tecWhat.text,
          when: strWhen!,
          from: strStartTime!,
          to: strEndTime!,
          where: tecWhere.text,
          strWith: party1.code,
          expences: json.encode(expences.map((e) {
            e["AccountName"] = e["Name"];
            return e;
          }).toList()));
      if (response != null) {
        showToast("Saved");
        Navigator.pop(context);
      }
    }
  }
}
