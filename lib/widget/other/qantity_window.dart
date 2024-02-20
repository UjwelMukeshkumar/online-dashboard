import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/ItemM.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:toast/toast.dart';

class QuantitWindow extends StatefulWidget {
  ItemM item;
  String itemNo;
  String api_key;

  QuantitWindow(
    this.item,
   {
    required this.itemNo,
    required this.api_key});

  @override
  _QuantitWindowState createState() => _QuantitWindowState();
}

class _QuantitWindowState extends State<QuantitWindow> {
  TextEditingController itemCountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  String data = "Initial Value";

  String remark = "";

   num? newQuantity;

  @override
  void initState() {
    super.initState();
    updateTextBox();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      title: Text('Update Item Count'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                    keyboardType: TextInputType.number,
                    controller: itemCountController,
                    decoration: InputDecoration(labelText: "Enter Count"),
                    onChanged: (text) {
                      newQuantity = num.parse(text);
                    }),
                TextFormField(
                    controller: remarksController,
                    decoration: InputDecoration(labelText: "Remark"),
                    onChanged: (text) {
                      remark = text;
                    }),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Update'),
          onPressed: () async {
            var data = await Serviece.updateItemCount(
                context: context,
                api_key: widget.api_key,
                itemNo: widget.itemNo,
                remark: remarksController.text,
                CountedQty: newQuantity.toString());
            if (data != null) {
              Toast.show("Updated");
              widget.item.CountedQty = newQuantity!;
              Navigator.pop(context, true);
            }
          },
        ),
      ],
    );
  }

  void updateTextBox() {
    itemCountController.text = widget.item.CountedQty.toString();
    remarksController.text = widget.item.Remark ?? "";
  }
}
