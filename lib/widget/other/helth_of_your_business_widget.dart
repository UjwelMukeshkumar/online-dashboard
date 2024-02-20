import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/repo/SettingsManagerRepository.dart';
import 'package:glowrpt/screen/cash_convertion_cycle.dart';
import 'package:glowrpt/screen/debit_credit_analisy%20.dart';
import 'package:glowrpt/screen/finacial_dashboard_screen.dart';
import 'package:glowrpt/screen/liquidity_score_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'grid_tile_widget.dart';

class HelthOfYourBusinessWidget extends StatefulWidget {

  @override
  _HelthOfYourBusinessWidgetState createState() =>
      _HelthOfYourBusinessWidgetState();
}

class _HelthOfYourBusinessWidgetState extends State<HelthOfYourBusinessWidget> {
   SettingsManagerRepository? settings;

   CompanyRepository? compRepo;
  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context,listen: false);
  }

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    settings = Provider.of<SettingsManagerRepository>(context);

  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var itemList = getWidget(textTheme);
    return AppCard(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Health of your business",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: itemList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, postion) {
                return itemList[postion];
              })
        ],
      ),
    );
  }

  List<Widget> getWidget(TextTheme textTheme) {
    return [
      if (settings!.LiquidityScor)
        GridTileWidget(
          title: "Liquidity Score",
          widget: Image.asset("assets/icons/liquidity_score.png"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LiquidityScoreScreen(
                          title: "title",
                          selectedItem: compRepo!.getSelectedUser(),
                          dateListLine: MyKey.getDefaultDateListAsToday(),
                        )));
          },
        ),
      if (settings!.FinancialDashBoar)
        GridTileWidget(
          title: "Financial DashBoard",
          widget: Icon(Icons.bar_chart),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FinacialDashboardScreen(
                          selectedItem:  compRepo!.getSelectedUser(),
                          dateListLine: MyKey.getDefaultDateListAsToday(),
                        )));
          },
        ),
      if (settings!.DebitCreditAnalysi)
        GridTileWidget(
          title: "Debit Credit Analysis",
          // subWidget:Icons.list  ,
          widget: Image.asset("assets/icons/average_credit_life.png"),
          onTap: () {
            Toast.show("In Progress");
            return;

          },
        ),
      if (settings!.CashConventionCycl)
        GridTileWidget(
          title: "Cash Convention Cycle",
          widget: Image.asset("assets/icons/cycle.png"),
          subWidget: Image.asset(
            "assets/icons/cash.png",
            color: AppColor.notificationBackgroud,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CashConvertionCycle(
                          selectedItem:  compRepo!.getSelectedUser(),
                          dateListLine: MyKey.getDefaultDateListAsToday(),
                        )));
          },
        ),
      if (settings!.ProfitRatio)
        GridTileWidget(
          title: "Profit Ratio",
          widget: Image.asset("assets/icons/profit_lose.png"),
          subWidget: Text(
            "X : Y",
            style: textTheme.caption,
          ),
          onTap: () {
            Toast.show("In Progress");
            return;
          },
        ),
    ];
  }
}
