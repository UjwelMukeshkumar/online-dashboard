import 'package:flutter/material.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/transaction/jurnal_screen.dart';
import 'package:glowrpt/screen/transaction/payment_recipt_screen.dart';
import 'package:glowrpt/screen/transaction/sales_invoice_screen.dart';
import 'package:glowrpt/screen/transaction/sales_screen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/other/PhonePeButton.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:provider/provider.dart';

import 'grid_tile_widget.dart';
import 'package:get/get.dart';
// Sales Invoice, sales order, sales return has same operation

// Purchase Invoice, purchase order, purchase return has same operation
class MyBottomSheet extends StatelessWidget {
  String typeTitle;
  bool isBottomSheet;

  MyBottomSheet(this.typeTitle, {this.isBottomSheet = true});

  @override
  Widget build(BuildContext context) {
    var compRepo = Provider.of<CompanyRepository>(context, listen: false);
    var space = SizedBox(height: 12);
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (typeTitle != "Suppliers") ...[
          ListTile(
            title: Text(
              "Sales Transaction".tr,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GridTileWidget(
                    onTap: () {
                      popBackIfBottomSheet(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesInVoiceScreen(
                                    title: "Sales Invoice".tr,
                                    formId: DocumentFormId.Sales,
                                  )));
                    },
                    title: "Invoice".tr,
                    widget: Image.asset(
                      "assets/icons/sale.png",
                      // color: Colors.white,
                    )),
                GridTileWidget(
                    onTap: () {
                      popBackIfBottomSheet(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesInVoiceScreen(
                                    title: "Sales Order".tr,
                                    formId: DocumentFormId.SalesOrder,
                                  )));
                    },
                    title: "Order".tr,
                    widget: Image.asset(
                      "assets/icons/purchase_order.png",
                      // color: Colors.white,
                    )),
                GridTileWidget(
                    onTap: () {
                      popBackIfBottomSheet(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesInVoiceScreen(
                                    title: "Sales Return".tr,
                                    formId: DocumentFormId.SalesReturn,
                                  )));
                    },
                    title: "Return".tr,
                    widget: Image.asset(
                      "assets/icons/purchase_return.png",
                      // color: Colors.white,
                    )),
                // Expanded(child: Container()),
              ],
            ),
          ),
          Visibility(
            visible: compRepo.getSelectedUser().ExportingOrg == "N",
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.12,
                  ),
                  GridTileWidget(
                      onTap: () {
                        popBackIfBottomSheet(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SalesInVoiceScreen(
                                      title: "Delivery".tr,
                                      formId: DocumentFormId.DeleveryForm,
                                      isDeliveryForm: true,
                                    )));
                      },
                      title: "Delivery".tr,
                      widget: Icon(Icons.format_align_center)),
                  // Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ],
        if (typeTitle != "Customers") ...[
          ListTile(
            title: Text(
              "Purchase Transaction".tr,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GridTileWidget(
                    onTap: () {
                      popBackIfBottomSheet(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesInVoiceScreen(
                                    title: "Purchase\nInvoice".tr,
                                    formId: DocumentFormId.Purchase,
                                  )));
                    },
                    title: "Invoice".tr,
                    widget: Image.asset(
                      "assets/icons/purchase.png",
                      // color: Colors.white,
                    )),
                GridTileWidget(
                    onTap: () {
                      popBackIfBottomSheet(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesInVoiceScreen(
                                    title: "Purchase\nOrder".tr,
                                    formId: DocumentFormId.PurchaseOrder,
                                  )));
                    },
                    title: "Order".tr,
                    widget: Image.asset(
                      "assets/icons/purchase_order.png",
                      // color: Colors.white,
                    )),
                GridTileWidget(
                    onTap: () {
                      popBackIfBottomSheet(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesInVoiceScreen(
                                    title: "Purchase\nReturn".tr,
                                    formId: DocumentFormId.PurchaseReturn,
                                  )));
                    },
                    title: "Return".tr,
                    widget: Image.asset(
                      "assets/icons/purchase_return.png",
                      // color: Colors.white,
                    )),
                // Expanded(child: Container()),
              ],
            ),
          ),
        ],
        ListTile(
          title: Text(
            "Fund Transfer".tr,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GridTileWidget(
                title: "To Party".tr,
                widget: Icon(
                  Icons.supervisor_account_sharp,
                  // color: Colors.white,
                ),
                onTap: () {
                  popBackIfBottomSheet(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JurnalScreen(
                              JurnalType.PartyToParty, "Party to party".tr)));
                },
              ),
              GridTileWidget(
                title: "Journal".tr,
                widget: Image.asset(
                  "assets/icons/jurnal.png",
                  // color: Colors.white,
                ),
                onTap: () {
                  popBackIfBottomSheet(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              JurnalScreen(JurnalType.Jurnal, "Journal")));
                },
              ),
              Container(),
              Container(),
            ],
          ),
        ),
        ListTile(
          title: Text(
            "Others".tr,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GridTileWidget(
                onTap: () {
                  popBackIfBottomSheet(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentReciptScreen(
                                isRecipt: true,
                              )));
                },
                title: "Receipt".tr,
                widget: Image.asset(
                  "assets/icons/recievable.png",
                  // color: Colors.white,
                )),
            GridTileWidget(
                onTap: () {
                  popBackIfBottomSheet(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentReciptScreen(
                                isRecipt: false,
                              )));
                },
                title: "Payment".tr,
                widget: Image.asset(
                  "assets/icons/payable.png",
                  // color: Colors.white,
                )),
            Container(),
            Container(),
          ],
        ),
        space
      ],
    );
    if (isBottomSheet) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            color: Colors.white),
        child: column,
      );
    } else {
      return AppCard(child: column);
    }
  }

  void popBackIfBottomSheet(BuildContext context) {
    if (isBottomSheet) Navigator.pop(context);
  }
}
