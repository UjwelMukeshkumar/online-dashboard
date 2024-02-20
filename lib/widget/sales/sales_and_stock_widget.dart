import 'package:flutter/material.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/sales/list_details_screeen.dart';
import 'package:glowrpt/screen/dashboards/sales_dash_board_widget.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SalesAndStockWidget extends StatefulWidget {
  bool isStock;

  SalesAndStockWidget({this.isStock = false});

  @override
  State<SalesAndStockWidget> createState() => _SalesAndStockWidgetState();
}

class _SalesAndStockWidgetState extends State<SalesAndStockWidget> {
   Map? countList;
   CompanyRepository? compRepo;
  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    salesAndStockActivity();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    double sizeOfContainer = MediaQuery.of(context).size.width / 3;
    return countList != null
        ? AppCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        //TODO : fixthis
                        Text(
                            "${widget.isStock ? "Stock".tr : "Sales".tr} Activity "
                                .tr,
                            style: textTheme.headline6),
                        Text(
                          "(In Quantity)".tr,
                          style: textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeOfContainer,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: countList!.keys.length,
                        itemBuilder: (context, position) {
                          var keys = countList!.keys.elementAt(position);
                          return InkWell(
                            onTap: () {
                              var item = countList![keys].first;
                              return openListClick(item["Type"], item["Text"]);
                            },
                            child: CardItem(countList![keys].first,
                                sizeOfContainer, position),
                          );
                        }),
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  Future<void> salesAndStockActivity() async {
    countList = await Serviece.getLsvCount(
        context: context,
        fromdate: MyKey.getCurrentDate(),
        todate: MyKey.getCurrentDate(),
        api_key: compRepo!.getSelectedApiKey(),
        SplitType: widget.isStock ? "ST" : "SL");
    setState(() {});
  }

  openListClick(String type, keys) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListDetailsScreen(
                  type: type,
                  title: keys,
                )));
  }
}
