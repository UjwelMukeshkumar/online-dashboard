import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:glowrpt/model/other/JurnalM.dart';
// import 'package:glowrpt/model/other/SearchM.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
// import 'package:glowrpt/widget/other/app_drop_down_inpu.dart';
// import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

// import '../../UserModel.dart';

class JurnalScreen extends StatefulWidget {
  JurnalType type;
  String title;

  JurnalScreen(this.type, this.title);

  @override
  _JurnalScreenState createState() => _JurnalScreenState();
}

class _JurnalScreenState extends State<JurnalScreen> {
  String? gender;

   CompanyRepository? compRepo;

  List<PartySearchM> dataList = [];

  bool debitFirstPary = false;
  var tecAmount = TextEditingController();
  var tecRemark = TextEditingController();

  PartySearchM? party1;

  PartySearchM? party2;

  String? selectedDate;

  bool isLoding = false;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    selectedDate = MyKey.displayDateFormat.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 30);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  space,
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Transaction Date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    initialValue: DateTime.now(),
                    /*validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,*/
                    onDateSelected: (DateTime value) {
                      selectedDate = MyKey.displayDateFormat.format(value);
                    },
                    dateFormat: MyKey.displayDateFormat,
                  ),
                  space,
                  Row(
                    children: [
                      FlutterSwitch(
                        inactiveText: "Cr  ",
                        activeText: "Dr  ",
                        showOnOff: true,
                        padding: 4.0,
                        inactiveColor: Colors.red,
                        activeColor: Colors.green,
                        value: debitFirstPary,
                        onToggle: (value) {
                          setState(() {
                            debitFirstPary = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DropdownSearch<PartySearchM>(
                          popupProps: PopupProps.bottomSheet(
                            searchFieldProps: TextFieldProps(
                              ),
                            showSearchBox: true,
                            isFilterOnline: true,
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelText: widget.type == JurnalType.PartyToParty
                                ? "Party *"
                                : "Account *",
                          )),
                          asyncItems: (text) => Serviece.partySearch(
                              context: context,
                              api_key: compRepo!.getSelectedApiKey(),
                              Type: getApiType(),
                              query: text),
                          // mode: Mode.BOTTOM_SHEET,
                          //autoFocusSearchBox: true,
                          // showSearchBox: true,
                          // label: widget.type == JurnalType.PartyToParty
                          //     ? 'Party *'
                          //     : "Account *",
                          // isFilteredOnline: true,

                          // onFind: (text) => Serviece.partySearch(
                          //     context: context,
                          //     api_key: compRepo.getSelectedApiKey(),
                          //     Type: getApiType(),
                          //     query: text),
                          onChanged: (party) {
                            party1 = party;
                          },
                        ),
                      ),
                    ],
                  ),
                  space,
                  TextFormField(
                    controller: tecAmount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Amount", border: textFieldBorder),
                  ),
                  Divider(
                    thickness: 20,
                    height: 35,
                  ),
                  Row(
                    children: [
                      FlutterSwitch(
                        inactiveText: "Cr  ",
                        activeText: "Dr  ",
                        // activeTextColor: Colors.black,
                        showOnOff: true,
                        padding: 4.0,
                        inactiveColor: Colors.red,
                        activeColor: Colors.green,
                        value: !debitFirstPary,
                        onToggle: (value) {
                          setState(() {
                            debitFirstPary = !value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DropdownSearch<PartySearchM>(
                          popupProps: PopupProps.bottomSheet(
                            searchFieldProps: TextFieldProps(autofocus: true),
                            showSearchBox: true,
                            isFilterOnline: true,
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelText: widget.type == JurnalType.PartyToParty
                                ? "Party *"
                                : "Account *",
                          )),
                          
                          asyncItems: (text) => Serviece.partySearch(
                              context: context,
                              api_key: compRepo!.getSelectedApiKey(),
                              Type: getApiType(),
                              query: text),

                          // mode: Mode.BOTTOM_SHEET,
                          //autoFocusSearchBox: true,
                          // showSearchBox: true,
                          // label: widget.type == JurnalType.PartyToParty
                          // ? 'Party *'
                          // : "Account *",
                          // isFilteredOnline: true,
                          // onFind: (text) => Serviece.partySearch(
                          //     context: context,
                          //     api_key: compRepo.getSelectedApiKey(),
                          //     Type: getApiType(),
                          //     query: text),
                          onChanged: (party) {
                            party2 = party;
                          },
                        ),
                      ),
                    ],
                  ),
                  space,
                  TextFormField(
                    controller: tecRemark,
                    decoration: InputDecoration(
                        labelText: "Remarks", border: textFieldBorder),
                  ),
                ],
              ),
            ),
            FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                    onPressed: isLoding ? null : insertJurnal,
                    child: Text("Save")))
          ],
        ),
      ),
    );
  }

  insertJurnal() async {
    if (party1 == null) {
      message("Please Select First Party");
      return;
    }
    if (party2 == null) {
      message("Please Select Second Party");
      return;
    }
    if (tecAmount.text.isEmpty) {
      message("Please Enter Amount");
      return;
    }
    var jurnalLine = [
      JurnalM(
        LineNum: 1,
        Type: getParamType(),
        Code: party1?.code,
        Credit: debitFirstPary ? 0 : double.parse(tecAmount.text),
        Debit: !debitFirstPary ? 0 : double.parse(tecAmount.text),
        Internal_Account: party1?.account,
        // Internal_Account: party1 != null ? double.parse(party1!.account) : 0.0,
        Name: party1!.name.toString(),
        Remarks: tecRemark.text,
      ),
      JurnalM(
        LineNum: 2,
        Type: getParamType(),
        Code: party2?.code,
        Credit: !debitFirstPary ? 0 : double.parse(tecAmount.text),
        Debit: debitFirstPary ? 0 : double.parse(tecAmount.text),
        Internal_Account: party2?.account,
        // Internal_Account: party2 != null ? double.parse(party2!.account) : 0.0,
        Name: party2!.name.toString(),
        Remarks: tecRemark.text,
      ),
    ];
    setState(() {
      isLoding = true;
    });
    var response = await Serviece.insertJurnal(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        date: selectedDate!,
        remark: tecRemark.text,
        dat: json.encode(jurnalLine));
    setState(() {
      isLoding = false;
    });
    if (response != null) {
      message('inserted successfully');
      Navigator.pop(context);
    }
  }

  message(String message) {
    Toast.show(message);
  }

  getApiType() {
    if (widget.type == JurnalType.PartyToParty) {
      return "All";
    }
    if (widget.type == JurnalType.Jurnal) {
      return "A";
    }
  }

  getParamType() {
    
    if (widget.type == JurnalType.PartyToParty) {
      return "C";
    }
    if (widget.type == JurnalType.Jurnal) {
      return "A";
    }
  }
}
