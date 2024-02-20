import 'package:flutter/material.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:toast/toast.dart';

import '../../library/DefaultQuantity.dart';

class PosSettings extends StatefulWidget {
  @override
  State<PosSettings> createState() => _PosSettingsState();
}

class _PosSettingsState extends State<PosSettings> {
  var etcQuantity = TextEditingController();

  bool askForCustomeQuantity=false;

  @override
  void initState() {
    
    super.initState();
    DefaultQuantity().getAskForCustomeQuantiy().then((value) {
      setState(() {
      askForCustomeQuantity = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pos Settings"),
      ),
      body: Column(
        children: [
          CheckboxListTile(
              title: Text("Ask for custom quantity"),
              value: askForCustomeQuantity,
              onChanged: (value) {
                setState(() {
                  askForCustomeQuantity = value!;
                });
                DefaultQuantity().setAskForCustomeQuantity(value!);
              }),
   /*       Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: etcQuantity,
                decoration: InputDecoration(
                  border: textFieldBorder,
                  labelText: "Default Quantity",
                ),
              ),
            ),
          ),*/
          //ElevatedButton(onPressed: saveSettings, child: Text("Save")),
        ],
      ),
    );
  }

  Future<void> saveSettings() async {
    bool isSaved = await DefaultQuantity().setQuantity(etcQuantity.text);
    if (isSaved) {
      Toast.show("Updated");
      Navigator.pop(context);
    } else {
      Toast.show("Invalid input");
    }
  }
}
