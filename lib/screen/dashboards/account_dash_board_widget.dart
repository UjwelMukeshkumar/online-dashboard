import 'package:flutter/material.dart';
import 'package:glowrpt/repo/SettingsManagerRepository.dart';
import 'package:glowrpt/widget/other/caroser_slider_widget.dart';
import 'package:glowrpt/widget/other/helth_of_your_business_widget.dart';
import 'package:glowrpt/widget/other/ledger_buttons.dart';
import 'package:glowrpt/widget/manager/total_branch_details_widget.dart';
import 'package:glowrpt/widget/other/recievable_payable_cash_widget.dart';
import 'package:glowrpt/widget/other/what_changed_since.dart';

class AccountDashBoardWidget extends StatelessWidget {
  SettingsManagerRepository settings;


  AccountDashBoardWidget(this.settings);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecievablePayableCashWidget(),
        //only for taking session if failed
        Visibility(
            visible: false,
            maintainState: true,
            child: TotalBranchDetailsWidget()),
        CaroserSliderWidget(),
        if (settings.whatChangedSince)
         WhatChangedSince(),
        LedgerButtons(),
        HelthOfYourBusinessWidget(
        ),
      ],
    );
  }
}
