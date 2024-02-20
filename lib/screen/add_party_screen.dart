import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:get/get.dart';

class AddPartyScreen extends StatefulWidget {
  @override
  _AddPartyScreenState createState() => _AddPartyScreenState();
}

class _AddPartyScreenState extends State<AddPartyScreen>
    with SingleTickerProviderStateMixin {
  var _tabController;
  var tabs = ["Addresses", "GST", "Opening Balance"];

  @override
  void initState() {
    
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Party".tr),
      ),
      body: Column(
        children: [
          Form(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Party Name".tr, border: textFieldBorder),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (text) =>
                      text.isEmpty ? "Enter party name".tr : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: "Contact Number".tr, border: textFieldBorder),
                ),
              ),
            ],
          )),
          TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: tabs
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e),
                    ))
                .toList(),
            indicatorColor: Colors.black26,
            indicatorWeight: 4,
          ),
          SizedBox(height: 8),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [Addresses(), GST(), OpeningBalance()],
          )),
          FractionallySizedBox(
            widthFactor: 1, // means 100%, you can change this to 0.8 (80%)
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Save".tr),
            ),
          ),
        ],
      ),
    );
  }
}

class Addresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                labelText: "Billing Address".tr, border: textFieldBorder),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                labelText: "Email Address".tr, border: textFieldBorder),
          ),
        ),
      ],
    );
  }
}

class GST extends StatefulWidget {
  @override
  _GSTState createState() => _GSTState();
}

class _GSTState extends State<GST> {
  List<String> gstType = [
    "Unregistered/Consumer".tr,
    "Registered - Regular".tr,
    "Registered - Composite".tr
  ];

  var slectedType;

  var selectedState;

  @override
  void initState() {
    
    super.initState();
    // slectedType=gstType.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton(
              hint: Text("Select Gst type".tr),
              isExpanded: true,
              value: slectedType,
              onChanged: (item) {
                setState(() {
                  slectedType = item;
                });
              },
              underline: Container(),
              items: gstType
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList()),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(4)),
        ),
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton(
              hint: Text("Select State".tr),
              isExpanded: true,
              value: selectedState,
              onChanged: (item) {
                setState(() {
                  selectedState = item;
                });
              },
              underline: Container(),
              items: gstStateList
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList()),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(4)),
        ),
      ],
    );
  }
}

class OpeningBalance extends StatefulWidget {
  @override
  _OpeningBalanceState createState() => _OpeningBalanceState();
}

class _OpeningBalanceState extends State<OpeningBalance> {
  DateTime? selectedDate;
  List<String> itemList = ["To Receive".tr, "To Pay".tr];
  String? _verticalGroupValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Opening Balance".tr, border: textFieldBorder),
              ),
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DateTimePicker(
                  initialValue: '',
                  decoration: InputDecoration(
                      border: textFieldBorder, labelText: "Select Date".tr),
                  dateMask: 'dd/MM/yyy',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date'.tr,
                  onChanged: (val) => print(val),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
              ),
            ),
          ],
        ),
        Container(
          child: RadioGroup<String>.builder(
            groupValue: _verticalGroupValue!,
            direction: Axis.horizontal,
            horizontalAlignment: MainAxisAlignment.start,
            onChanged: (value) => setState(() {
              _verticalGroupValue = value;
            }),
            items: itemList,
            itemBuilder: (item) => RadioButtonBuilder(item),
          ),
        )
      ],
    );
  }
}
