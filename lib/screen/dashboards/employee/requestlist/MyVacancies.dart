import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/employee/approval/ApprovalScreen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/employee/RequestItem.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class MyVacancies extends StatefulWidget {
  String element;

  MyVacancies(this.element);

  @override
  _MyVacanciesState createState() => _MyVacanciesState();
}

class _MyVacanciesState extends State<MyVacancies> {
  List? list;

   CompanyRepository? compRepo;

  @override
  void initState() {
    
    super.initState();
    compRepo= Provider.of<CompanyRepository>(context,listen: false);

    getRequestList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.element}"),
      ),
      body: Center(
        child: list != null
            ? ListView.builder(
                itemCount: list!.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = list![index];
                  return RequestItem(
                    title: "${item["EmpName"]}",
                    leadLetter: "${item["EmpName"].toString().substring(0,1)}",
                    subTitle: "${item["RequestID"]} - ${item["Remarks"]}",
                    trailing1: "${item["CreatedDate"]}",
                    trailing2: "${item["ApprovalLevel"]}",
                    onTap: (){
                      String url="hrm/vacanciesaprooval";
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ApprovalScreen(item,widget.element,url)));
                    },
                  );
                })
            : CupertinoActivityIndicator(),
      ),
    );
  }

  Future getRequestList() async {
    var url = MyKey.baseUrl + "hrm/vacancieslist";
    Map params = {"api_key": compRepo!.getSelectedApiKey(), "AppName": MyKey.appName};
    var result = await MyKey.postWithApiKey(url, params, context);
    if (result != null) {
      setState(() {
        list = result["Details"];
      });
      if (list!.length == 0) {
        showToast("Success");
        // Toast.show("Success", context, duration: Toast.LENGTH_LONG);
      }
    }
  }
}
