import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/screen/dashboards/employee/approval/ApprovalScreen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/employee/RequestItem.dart';

import 'package:toast/toast.dart';

class MyPunchRequests extends StatefulWidget {
  String element;

  MyPunchRequests(this.element);

  @override
  _MyPunchRequestsState createState() => _MyPunchRequestsState();
}

class _MyPunchRequestsState extends State<MyPunchRequests> {
  List? list;

  @override
  void initState() {
    
    super.initState();
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
                    title: "${item["User_Name"]}",
                    leadLetter: "${item["EmpName"].toString().substring(0,1)}",
                    subTitle: "${item["RequestID"]} - ${item["In_Out"]}",
                    trailing1: "${item["CreatedDate"]}",
                    trailing2: "${item["ApprovalLevel"]}",
                    onTap: (){
                      String url="hrm/PunchingRequestApprovel";
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ApprovalScreen(item,widget.element,url)));
                    },
                  );
                })
            : CupertinoActivityIndicator(),
      ),
    );
  }

  Future getRequestList() async {
    String apiKey = await MyKey.getApiKey();
    var url = MyKey.baseUrl + "/hrm/PunchingRequest/list";
    Map params = {"api_key": apiKey, "AppName": MyKey.appName};
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
