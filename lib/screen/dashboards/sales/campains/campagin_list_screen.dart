import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/model/campain/CampainListItemM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/sales/campains/campains_screen.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:provider/provider.dart';

class CampaginListScreen extends StatefulWidget {
  const CampaginListScreen({Key? key}) : super(key: key);

  @override
  State<CampaginListScreen> createState() => _CampaginListScreenState();
}

class _CampaginListScreenState extends State<CampaginListScreen> {
  CompanyRepository? companyRepo;

  List<CampainListItemM>? campaignList;

  @override
  void initState() {
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Get.to(() => CampainsScreen());

          loadData();
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: Text("Campaign"),
      ),
      body: campaignList != null
          ? ListView.builder(
              itemCount: campaignList?.length,
              itemBuilder: (context, postion) {
                var item = campaignList?[postion];
                return AppCard(
                  child: ListTile(
                    onTap: () async {
                      await Get.to(() => CampainsScreen(
                            campainListItemM: item,
                          ));

                      loadData();
                      setState(() {});
                    },
                    title: Text("${item?.DocName}"),
                    subtitle: Text("${item?.PriceList}"),
                  ),
                );
              })
          : CupertinoActivityIndicator(),
    );
  }

  Future<void> loadData() async {
    campaignList = await Serviece.getCampaginList(
        context: context, api_key: companyRepo!.getSelectedApiKey());
    setState(() {});
  }
}
