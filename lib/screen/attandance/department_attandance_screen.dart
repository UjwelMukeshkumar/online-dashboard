import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/attandace/AttandanceBranchM.dart';
import 'package:glowrpt/model/attandace/DepartmentAttandance.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class DepartmentAttandanceScreen extends StatefulWidget {
  AttandanceBranchM item;
  DepartmentAttandanceScreen({required this.item});

  @override
  State<DepartmentAttandanceScreen> createState() =>
      _DepartmentAttandanceScreenState();
}

class _DepartmentAttandanceScreenState
    extends State<DepartmentAttandanceScreen> {
  late List<DepartmentAttandance> attandanceList;

  late CompanyRepository companyRep;

  @override
  void initState() {
    
    super.initState();
    companyRep = Provider.of<CompanyRepository>(context, listen: false);
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.item.Branch),
        ),
        body: attandanceList != null
            ? ListView.builder(
                itemCount: attandanceList.length,
                itemBuilder: (context, postion) {
                  var item = attandanceList[postion];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Card(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(item.Name),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text("Present".tr,
                                            style: textTheme.caption),
                                        Text(
                                          (item.Present ?? "").toString(),
                                          style: textTheme.headline6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Absent ".tr,
                                          style: textTheme.caption,
                                        ),
                                        Text((item.Leave ?? "").toString(),
                                            // "GP ${data?.gp}%",
                                            style: textTheme.headline6),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: CupertinoActivityIndicator(),
              ));
  }

  Future<void> loadDetails() async {
    attandanceList = await Serviece.getDepartmentWiseAttandance(
        context: context,
        api_key: companyRep.getUserByOrgName(widget.item.Branch)!.apiKey);
    setState(() {});
  }
}
