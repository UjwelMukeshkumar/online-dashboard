import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/Price1M.dart';
import 'package:glowrpt/model/item/PriceM.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/KeyValues.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class PriceWindowCreate extends StatefulWidget {
  PriceM item;
  num mrp;

  PriceWindowCreate(this.item, this.mrp);

  @override
  _PriceWindowCreateState createState() => _PriceWindowCreateState();
}

class _PriceWindowCreateState extends State<PriceWindowCreate> {
  TextEditingController tecDiscount = TextEditingController();
  TextEditingController tecNetPrice = TextEditingController();
  TextEditingController tecGp = TextEditingController();
  String data = "Initial Value";
  @override
  void initState() {
    
    super.initState();
    updateTextBox();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      title: Text('Update'.tr),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.item.PriceListName}",
                  style: textTheme.subtitle2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /*    Row(
                      children: [
                        Text("Cost ",style: textTheme.caption,),
                        Text("${widget.item.cost.toStringAsFixed(2)}",style: textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),*/
                    SizedBox(height: 4),
                    /*   Row(
                      children: [
                        Text("TaxRate ",style: textTheme.caption,),
                        Text("${widget.item.taxRate.toStringAsFixed(2)}%",style: textTheme.subtitle1,),
                      ],
                    ),*/
                  ],
                )
              ],
            ),
            /*  Row(
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue:
                    widget.item.taxRate.toStringAsFixed(2),
                    readOnly: true,
                    decoration:
                    InputDecoration(labelText: "Tax Rate")
                  ),
                ),
              ],
            ),*/

            CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                // controlAffinity: ListTileControlAffinity.leading,
                title: Text("Tax Inclusive".tr),
                value: widget.item.Is_Inclusive == "Y",
                onChanged: (value) {
                  /*    setState(() {
                    widget.item.updateInclusieve(value);
                    tecDiscount.text=widget.item.discount.toStringAsFixed(2);
                    tecNetPrice.text=widget.item.netPrice.toStringAsFixed(2);
                    tecGp.text=widget.item.gp.toStringAsFixed(2);
                  });*/
                }),
            Divider(
              height: 0,
              thickness: 1,
              color: Colors.black45,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.Price.toString(),
                    readOnly: true,
                    decoration: InputDecoration(labelText: "Price".tr),
                    onChanged: (text) {
                      widget.item.Price = double.tryParse(text)!;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: tecDiscount,
                      decoration: InputDecoration(labelText: "Discount%".tr),
                      onChanged: (text) {
                        /*     widget.item.updateDiscountPercent(text);
                      tecNetPrice.text=widget.item.netPrice.toStringAsFixed(2);
                      tecGp.text=widget.item.gpCalculated.toStringAsFixed(2);*/
                      }),
                  flex: 1,
                ),
              ],
            ),
            /*       Row(
              children: [
                Expanded(child:  TextFormField(
                    keyboardType:
                    TextInputType.number,
                    controller: tecNetPrice,
                    decoration: InputDecoration(
                        labelText: "Net Price"),
                    onChanged: (text) {
             */ /*         widget.item.updateNetPrice(text);
                      tecDiscount.text=widget.item.discount.toStringAsFixed(2);
                      tecGp.text=widget.item.gpCalculated.toStringAsFixed(2);*/ /*
                    })),
                SizedBox(width: 4),
                Expanded(child: TextFormField(
                    keyboardType:
                    TextInputType.number,
                    controller: tecGp,
                    decoration: InputDecoration(
                        labelText: "GP%"),
                    onChanged: (text) {
                      widget.item.updateGpPercent(text);
                      tecDiscount.text=widget.item.discount.toStringAsFixed(2);
                      tecNetPrice.text=widget.item.netPrice.toStringAsFixed(2);
                    }))
              ],
            )*/
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
            widget.item.Discount = double.parse(tecDiscount.text);
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void updateTextBox() {
    widget.item.Price = widget.mrp;
    tecDiscount.text = widget.item.Discount.toStringAsFixed(2);
    tecNetPrice.text = widget.item.Price.toStringAsFixed(2);
    // tecGp.text=widget.item..toStringAsFixed(2);
  }
}
