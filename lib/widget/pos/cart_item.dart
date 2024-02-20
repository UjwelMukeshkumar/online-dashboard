// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:glowrpt/library/CollectionOperation.dart';
// import 'package:glowrpt/model/party/PartySearchM.dart';
// import 'package:glowrpt/repo/Provider.dart';
// import 'package:glowrpt/util/Serviece.dart';
// import 'package:provider/provider.dart';
//
// import '../../model/item/SingleItemM.dart';
// import '../../model/transaction/DocumentLoadM.dart';
// import '../../util/Constants.dart';
// import '../../util/MyKey.dart';
// import 'package:get/get.dart';
//
// class CartItem extends StatefulWidget {
//   SingleItemM item;
//   DocumentLoadM documentLoadM;
//   TextEditingController etcQuantity;
//   Function(SingleItemM) onUpdate;
//   FocusNode? focusNodeQuntity;
//   bool isDeliveryForm;
//
//   CartItem({
//     required this.item,
//     required this.documentLoadM,
//     required this.etcQuantity,
//     required this.onUpdate,
//     this.focusNodeQuntity,
//     this.isDeliveryForm = false,
//   });
//
//   @override
//   State<CartItem> createState() => _CartItemState();
// }
//
// class _CartItemState extends State<CartItem> {
//   late FocusNode focusNodeRate;
//   late FocusNode focusNodeDiscount;
//   TextEditingController tecRate = TextEditingController();
//   TextEditingController tecUomQauntity = TextEditingController();
//   TextEditingController tecUomLine = TextEditingController();
//   TextEditingController tecDiscount = TextEditingController();
//
//   UOMBean? selectedUom;
//
//   CompanyRepository? compRepo;
//
//   PartySearchM? selectedSupplier;
//   @override
//   void initState() {
//     compRepo = Provider.of<CompanyRepository>(context, listen: false);
//     super.initState();
//     focusNodeRate = FocusNode();
//     focusNodeDiscount = FocusNode();
//     if (widget.focusNodeQuntity == null) {
//       widget.focusNodeQuntity = FocusNode();
//     }
//     tecRate.text = widget.item.Price.toString();
//     tecDiscount.text = widget.item.Discount.toString();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var textTheme = Theme.of(context).textTheme;
//     var sizedBox = SizedBox(height: 10);
//     return Card(
//       elevation: 5,
//       margin: EdgeInsets.all(4),
//       child: InkWell(
//         onTap: () {
//           // openItemDetails(item.Item_No);
//         },
//         child: Container(
//           padding: EdgeInsets.all(8),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                       child: Text(
//                     widget.item.Item_Name,
//                     style: textTheme.subtitle1,
//                   )),
//                   Text("${widget.item.Onhand} Nos".tr, style: textTheme.caption)
//                 ],
//               ),
//               // sizedBox,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(widget.item.Barcode, style: textTheme.caption),
//                   Text(widget.item.TaxCode, style: textTheme.caption)
//                 ],
//               ),
//               // sizedBox,
//               Visibility(
//                 visible: widget.item.LineRemarks.isNotEmpty,
//                 child: Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(widget.item.LineRemarks,
//                         style: textTheme.caption?.copyWith(
//                             fontStyle: FontStyle.italic,
//                             color: AppColor.title))),
//               ),
//               Container(
//                   height: 1,
//                   color: Colors.black12,
//                   margin: EdgeInsets.only(bottom: 8, top: 4)),
//               Form(
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         focusNode: widget.focusNodeQuntity,
//                         controller: widget.etcQuantity,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                             labelText: "Quantity".tr, border: textFieldBorder),
//                         onChanged: (text) {
//                           widget.item.quantity = double.tryParse(text) ?? 0;
//                           widget.item.quntityManuallyChanged = true;
//
//                           try {
//                             tecUomLine.text = (widget.item.UOM_quantity *
//                                     widget.item.quantity)
//                                 .toString();
//                           } catch (e) {
//                             print(e);
//                           }
//                           widget.onUpdate(widget.item);
//                         },
//                         onFieldSubmitted: (_) {
//                           focusNodeRate.requestFocus();
//                           tecRate.selection = TextSelection(
//                             baseOffset: 0,
//                             extentOffset: tecRate.text.length,
//                           );
//                         },
//                         // autofocus: itemList.last == item,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Expanded(
//                       child: DropdownSearch<UOMBean>(
//                         popupProps: PopupProps.bottomSheet(
//                           showSearchBox: true,
//                           isFilterOnline: true,
//                         ),
//                         dropdownDecoratorProps: DropDownDecoratorProps(
//                             dropdownSearchDecoration: InputDecoration(
//                           labelText: "UOM",
//                         )),
//                         // mode: Mode.BOTTOM_SHEET,
//                         selectedItem: widget.documentLoadM.UOM.firstWhere(
//                           (element) => element.Code == widget.item.UOM,
//                           // orElse: () => null,
//                         ),
//                         // popupSafeArea:
//                         //     PopupSafeAreaProps(maintainBottomViewPadding: true),
//                         // autoFocusSearchBox: true,
//                         // showSearchBox: true,
//                         items: widget.documentLoadM.UOM,
//                         // label: "UOM",
//                         onChanged: (uom) {
//                           // specific for delivery form
//                           selectedUom = uom!;
//                           tecUomQauntity.text = uom.UOMQty.toString();
//                           tecUomLine.text =
//                               (uom.UOMQty * widget.item.quantity).toString();
//                           //old code
//                           widget.item.UOM = uom.Code;
//                           widget.item.UOM_quantity = uom.UOMQty;
//                           widget.item.UOMManuallyChanged = true;
//                           widget.onUpdate(widget.item);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (widget.isDeliveryForm) ...[
//                 sizedBox,
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: tecUomQauntity,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: "UOM Qauntity".tr,
//                           border: textFieldBorder,
//                         ),
//                         onFieldSubmitted: (_) {
//                           focusNodeDiscount.requestFocus();
//                           tecDiscount.selection = TextSelection(
//                             baseOffset: 0,
//                             extentOffset: tecDiscount.text.length,
//                           );
//                         },
//                         onChanged: (text) {
//                           var uomQuantity = double.parse(text);
//                           tecUomLine.text =
//                               (uomQuantity * widget.item.quantity).toString();
//                           widget.item.UOM_quantity = uomQuantity;
//                           // widget.item.Price = double.tryParse(text) ?? 0;
//                           // widget.item.priceManuallyChanged = true;
//                           widget.onUpdate(widget.item);
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                           controller: tecUomLine,
//                           readOnly: true,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             labelText: "Line Qty".tr,
//                             border: textFieldBorder,
//                           ),
//                           onChanged: (text) {
//                             // widget.item.discountManullyChanged = true;
//                             // widget.onUpdate(widget.item);
//                             // widget.item.Discount = double.tryParse(text) ?? 0;
//                           }),
//                     ),
//                   ],
//                 ),
//               ],
//               sizedBox,
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       focusNode: focusNodeRate,
//                       controller: tecRate,
//                       readOnly:
//                           widget.documentLoadM.Auth.tryFirst!.isPriceReadOnly,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: "Rate (Price/Unit)".tr,
//                         border: textFieldBorder,
//                       ),
//                       onFieldSubmitted: (_) {
//                         focusNodeDiscount.requestFocus();
//                         tecDiscount.selection = TextSelection(
//                           baseOffset: 0,
//                           extentOffset: tecDiscount.text.length,
//                         );
//                       },
//                       onChanged: (text) {
//                         widget.item.Price = double.tryParse(text) ?? 0;
//                         widget.item.priceManuallyChanged = true;
//                         widget.onUpdate(widget.item);
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     width: 4,
//                   ),
//                   Expanded(
//                     child: TextFormField(
//                         controller: tecDiscount,
//                         readOnly: widget
//                             .documentLoadM.Auth.tryFirst!.isDiscountReadOnly,
//                         focusNode: focusNodeDiscount,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: "Discount %".tr,
//                           border: textFieldBorder,
//                         ),
//                         autovalidateMode: AutovalidateMode.always,
//                         validator: (text) =>
//                             (double.tryParse(text!) ?? 0) >= 100
//                                 ? "Should be < 100"
//                                 : null,
//                         onChanged: (text) {
//                           widget.item.discountManullyChanged = true;
//                           widget.onUpdate(widget.item);
//                           widget.item.Discount = double.tryParse(text) ?? 0;
//                         }),
//                   ),
//                 ],
//               ),
//               sizedBox,
//               if (widget.isDeliveryForm) ...[
//                 DropdownSearch<PartySearchM>(
//                   popupProps: PopupProps.menu(
//                     showSearchBox: true,
//                     isFilterOnline: true,
//                   ),
//                   dropdownDecoratorProps: DropDownDecoratorProps(
//                       dropdownSearchDecoration: InputDecoration(
//                     labelText: "Supplier",
//                   )),
//                   // mode: Mode.MENU,
//                   selectedItem: selectedSupplier,
//                   asyncItems: (text) => Serviece.partySearch(
//                       context: context,
//                       api_key: compRepo!.getSelectedApiKey(),
//                       Type: "S", //for supplier
//                       query: text),
//                   // showSearchBox: true,
//                   // label: "Supplier",
//                   // isFilteredOnline: true,
//                   // onFind: (text) => Serviece.partySearch(
//                   //     context: context,
//                   //     api_key: compRepo.getSelectedApiKey(),
//                   //     Type: "S", //for supplier
//                   //     query: text),
//                   onChanged: (party) {
//                     selectedSupplier = party;
//                     widget.item.Supplier = party!.CVCode;
//                     widget.onUpdate(widget.item);
//                     // getSinglePartyDetails(party.CVCode);
//                   },
//                 ),
//                 sizedBox,
//                 TextFormField(
//                     decoration: InputDecoration(
//                       labelText: "Remarks".tr,
//                       border: textFieldBorder,
//                     ),
//                     autovalidateMode: AutovalidateMode.always,
//                     onChanged: (text) {
//                       widget.item.LineRemarks = text;
//                       widget.onUpdate(widget.item);
//                     })
//               ]
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     focusNodeRate.dispose();
//     focusNodeDiscount.dispose();
//     super.dispose();
//   }
// }
/////////////////////////////////////////////////////////////////////////////////
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/library/CollectionOperation.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import '../../model/item/SingleItemM.dart';
import '../../model/transaction/DocumentLoadM.dart';
import '../../util/Constants.dart';
import '../../util/MyKey.dart';
import 'package:get/get.dart';

class CartItem extends StatefulWidget {
  final SingleItemM item;
  final DocumentLoadM documentLoadM;
  final TextEditingController etcQuantity;
  final Function(SingleItemM) onUpdate;
  FocusNode? focusNodeQuantity;
  final bool isDeliveryForm;

  CartItem({
    required this.item,
    required this.documentLoadM,
    required this.etcQuantity,
    required this.onUpdate,
    this.focusNodeQuantity,
    this.isDeliveryForm = false,
    FocusNode? focusNodeQuntity,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late FocusNode focusNodeRate;
  late FocusNode focusNodeDiscount;
  TextEditingController tecRate = TextEditingController();
  TextEditingController tecUomQauntity = TextEditingController();
  TextEditingController tecUomLine = TextEditingController();
  TextEditingController tecDiscount = TextEditingController();

  UOMBean? selectedUom;

  CompanyRepository? compRepo;

  PartySearchM? selectedSupplier;

  @override
  void initState() {
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    super.initState();
    focusNodeRate = FocusNode();
    focusNodeDiscount = FocusNode();
    if (widget.focusNodeQuantity == null) {
      widget.focusNodeQuantity = FocusNode();
    }
    tecRate.text = widget.item.Price.toString();
    tecDiscount.text = widget.item.Discount.toString();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var sizedBox = SizedBox(height: 10);
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          // openItemDetails(item.Item_No);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                     "${ widget.item.Item_Name }",
                      style: textTheme.subtitle1,
                    ),
                  ),
                  Text(
                    "${widget.item.Onhand} Nos".tr,
                    style: textTheme.caption,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                   "${ widget.item.Barcode}",
                    style: textTheme.caption,
                  ),
                  Text(
                    "${widget.item.TaxCode}",
                    style: textTheme.caption,
                  )
                ],
              ),
              Visibility(
                visible: widget.item.LineRemarks!.isNotEmpty,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                   "${ widget.item.LineRemarks}",
                    style: textTheme.caption?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: AppColor.title,
                    ),
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Colors.black12,
                margin: EdgeInsets.only(bottom: 8, top: 4),
              ),
              Form(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: widget.focusNodeQuantity,
                        controller: widget.etcQuantity,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Quantity".tr,
                          border: textFieldBorder,
                        ),
                        onChanged: (text) {
                          widget.item.quantity = double.tryParse(text) ?? 0;
                          widget.item.quntityManuallyChanged = true;

                          try {
                            tecUomLine.text = (widget.item.UOM_quantity! *
                                    widget.item.quantity!)
                                .toString();
                          } catch (e) {
                            print(e);
                          }
                          widget.onUpdate(widget.item);
                        },
                        onFieldSubmitted: (_) {
                          focusNodeRate.requestFocus();
                          tecRate.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: tecRate.text.length,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      // child: ListTile(title:Text("Testing...........")),
                      child: DropdownSearch<UOMBean?>(
                        popupProps: PopupProps.bottomSheet(
                          showSearchBox: true,
                          isFilterOnline: true,
                        ),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                          labelText: "UOM",
                        )),
                        // selectedItem: widget.documentLoadM.UOM?.firstWhere(
                          
                        //   (element) => element.Code  == widget.item.UOM,
                        //   // orElse: () =>null,
                        // ),
                        items: widget.documentLoadM.UOM??[],
                        onChanged: (uom) {
                          selectedUom = uom;
                          tecUomQauntity.text = uom?.UOMQty.toString() ?? "";
                          tecUomLine.text =
                              (uom?.UOMQty ?? 0 * widget.item.quantity!)
                                  .toString();
                          widget.item.UOM = uom?.Code ?? '';
                          widget.item.UOM_quantity = uom?.UOMQty ?? 0;
                          widget.item.UOMManuallyChanged = true;
                          widget.onUpdate(widget.item);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.isDeliveryForm) ...[
                sizedBox,
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: tecUomQauntity,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "UOM Qauntity".tr,
                          border: textFieldBorder,
                        ),
                        onFieldSubmitted: (_) {
                          focusNodeDiscount.requestFocus();
                          tecDiscount.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: tecDiscount.text.length,
                          );
                        },
                        onChanged: (text) {
                          var uomQuantity = double.tryParse(text) ?? 0;
                          tecUomLine.text =
                              (uomQuantity * widget.item.quantity!).toString();
                          widget.item.UOM_quantity = uomQuantity;
                          widget.onUpdate(widget.item);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: tecUomLine,
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Line Qty".tr,
                          border: textFieldBorder,
                        ),
                        onChanged: (text) {
                          // widget.item.discountManuallyChanged = true;
                          // widget.onUpdate(widget.item);
                          // widget.item.Discount = double.tryParse(text) ?? 0;
                        },
                      ),
                    ),
                  ],
                ),
              ],
              sizedBox,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      focusNode: focusNodeRate,
                      controller: tecRate,
                      readOnly:
                          widget.documentLoadM.Auth.tryFirst!.isPriceReadOnly,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Rate (Price/Unit)".tr,
                        border: textFieldBorder,
                      ),
                      onFieldSubmitted: (_) {
                        focusNodeDiscount.requestFocus();
                        tecDiscount.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: tecDiscount.text.length,
                        );
                      },
                      onChanged: (text) {
                        widget.item.Price = double.tryParse(text) ?? 0;
                        widget.item.priceManuallyChanged = true;
                        widget.onUpdate(widget.item);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: tecDiscount,
                      readOnly: widget
                          .documentLoadM.Auth.tryFirst!.isDiscountReadOnly,
                      focusNode: focusNodeDiscount,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Discount %".tr,
                        border: textFieldBorder,
                      ),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) => (double.tryParse(text!) ?? 0) >= 100
                          ? "Should be < 100"
                          : null,
                      onChanged: (text) {
                        widget.item.discountManullyChanged = true;
                        widget.onUpdate(widget.item);
                        widget.item.Discount = double.tryParse(text) ?? 0;
                      },
                    ),
                  ),
                ],
              ),
              sizedBox,
              if (widget.isDeliveryForm) ...[
                DropdownSearch<PartySearchM>(
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    isFilterOnline: true,
                  ),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                    labelText: "Supplier",
                  )),
                  selectedItem: selectedSupplier,
                  asyncItems: (text) => Serviece.partySearch(
                    context: context,
                    api_key: compRepo!.getSelectedApiKey(),
                    Type: "S", //for supplier
                    query: text,
                  ),
                  onChanged: (party) {
                    selectedSupplier = party;
                    widget.item.Supplier = party?.CVCode ?? '';
                    widget.onUpdate(widget.item);
                  },
                ),
                sizedBox,
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Remarks".tr,
                    border: textFieldBorder,
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: (text) {
                    widget.item.LineRemarks = text;
                    widget.onUpdate(widget.item);
                  },
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNodeRate.dispose();
    focusNodeDiscount.dispose();
    super.dispose();
  }
}
