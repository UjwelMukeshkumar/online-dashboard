import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glowrpt/screen/ItemLedgerScreen.dart';
import 'package:glowrpt/screen/PartyLedgerScreen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/widget/other/list_tile_button.dart';
import 'package:get/get.dart';

class LedgerButtons extends StatelessWidget {
  const LedgerButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: ListTileButton(
                padding: EdgeInsets.only(left: 8, right: 4),
                title: "Party Ledger".tr,
                icon: Icons.collections_bookmark_outlined,
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (cotext) => PartyLedgerScreen()));
                }),
          ),
          Expanded(
            child: ListTileButton(
              padding: EdgeInsets.only(right: 8, left: 4),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (cotext) => ItemLedgerScreen()));
              },
              title: "Item Ledger".tr,
              icon: Icons.collections_bookmark,
            ),
          ),
        ],
      ),
    );
  }
}
