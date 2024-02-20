import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/consise/ConsiceM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/consise/consice_item.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ConsiceTabScreen extends StatefulWidget {
  UserListBean user;
  List<String> dateList;

  ConsiceTabScreen(this.user, this.dateList);

  @override
  _ConsiceTabScreenState createState() => _ConsiceTabScreenState();
}

class _ConsiceTabScreenState extends State<ConsiceTabScreen>
    with AutomaticKeepAliveClientMixin {
  late CompanyRepository companyRepo;

  List<DocumetListBean>? list;

  @override
  void initState() {
    
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadTata();
  }

  @override
  Widget build(BuildContext context) {
    return list != null
        ? ListView.builder(
            itemCount: list!.length,
            itemBuilder: (context, position) {
              return ConsiceItem(list![position]);
            })
        : Center(
            child: CupertinoActivityIndicator(),
          );
  }

  Future<void> loadTata() async {
    ConsiceM? data = await Serviece.getConciseRport(
        context: context,
        api_key: companyRepo.getSelectedApiKey(),
        userId: widget.user.User_Id.toString(),
        dtRange: "Today",
        frmdate: widget.dateList.first,
        todate: widget.dateList.last);
    list = data!.DocumetList;
    if (mounted) setState(() {});
  }

  @override
  bool get wantKeepAlive => false;
}
