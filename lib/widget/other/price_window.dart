import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/Price1M.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/KeyValues.dart';
import 'package:toast/toast.dart';

class PriceWindow extends StatefulWidget {
  Price1M item;
  String itemNo;
  String api_key;

  PriceWindow(
    this.item, {
  required  this.itemNo,
  required  this.api_key,
  });

  @override
  _PriceWindowState createState() => _PriceWindowState();
}

class _PriceWindowState extends State<PriceWindow> {
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
      title: Text('Update'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.item.priceListName}",
                  style: textTheme.subtitle2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Cost ",
                          style: textTheme.caption,
                        ),
                        Text(
                          "${widget.item.cost.toStringAsFixed(2)}",
                          style: textTheme.subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "TaxRate ",
                          style: textTheme.caption,
                        ),
                        Text(
                          "${widget.item.taxRate.toStringAsFixed(2)}%",
                          style: textTheme.subtitle1,
                        ),
                      ],
                    ),
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
                title: Text("Tax Inclusive"),
                value: widget.item.isInclusive == "Y",
                onChanged: (value) {
                  setState(() {
                    widget.item.updateInclusieve(value!);
                    tecDiscount.text = widget.item.discount.toStringAsFixed(2);
                    tecNetPrice.text = widget.item.netPrice.toStringAsFixed(2);
                    tecGp.text = widget.item.gp.toStringAsFixed(2);
                  });
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
                    initialValue: widget.item.price.toString(),
                    readOnly: false,
                    decoration: InputDecoration(labelText: "Price"),
                    onChanged: (text) {
                      widget.item.price = double.tryParse(text)!;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: tecDiscount,
                      decoration: InputDecoration(labelText: "Discount%"),
                      onChanged: (text) {
                        widget.item.updateDiscountPercent(text);
                        tecNetPrice.text =
                            widget.item.netPrice.toStringAsFixed(2);
                        tecGp.text =
                            widget.item.gpCalculated.toStringAsFixed(2);
                      }),
                  flex: 1,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: tecNetPrice,
                        decoration: InputDecoration(labelText: "Net Price"),
                        onChanged: (text) {
                          widget.item.updateNetPrice(text);
                          tecDiscount.text =
                              widget.item.discount.toStringAsFixed(2);
                          tecGp.text =
                              widget.item.gpCalculated.toStringAsFixed(2);
                        })),
                SizedBox(width: 4),
                Expanded(
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: tecGp,
                        decoration: InputDecoration(labelText: "GP%"),
                        onChanged: (text) {
                          widget.item.updateGpPercent(text);
                          tecDiscount.text =
                              widget.item.discount.toStringAsFixed(2);
                          tecNetPrice.text =
                              widget.item.netPrice.toStringAsFixed(2);
                        }))
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
            var data = await Serviece.updatePriceDetails(
                context,
                widget.api_key,
                widget.itemNo,
                widget.item.priceListNo.toString(),
                widget.item.price.toString(),
                widget.item.discount.toString(),
                widget.item.isInclusive);
            if (data == "Inserted") {
              Toast.show("Updated");
              setState(() {});
            }
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void updateTextBox() {
    tecDiscount.text = widget.item.discount.toStringAsFixed(2);
    tecNetPrice.text = widget.item.netPrice.toStringAsFixed(2);
    tecGp.text = widget.item.gp.toStringAsFixed(2);
  }
}
