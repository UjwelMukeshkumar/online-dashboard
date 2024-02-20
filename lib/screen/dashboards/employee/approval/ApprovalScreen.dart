import 'package:flutter/material.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/employee/KeyValueTextAria.dart';
import 'package:glowrpt/widget/employee/KeyValuesApproveItem.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class ApprovalScreen extends StatelessWidget {
  Map item;
  String element;
  String endUrl;
  TextEditingController tec_remarks = TextEditingController();

  ApprovalScreen(this.item, this.element, this.endUrl);

  @override
  Widget build(BuildContext context) {
    tec_remarks.text = item["Remarks"];
    return Scaffold(
      appBar: AppBar(
        title: Text("${element} ${'Details'.tr}"),
      ),
//      body: ListView.builder(itemBuilder: null),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var keys = item.keys.toList();
                  var values = item.values.toList();
                  return KeyValuesApproveItem(
                      keys: keys[index], values: "${values[index]}");
                },
                itemCount: item.length,
              ),
            ),
            KeyValueTextArea(
              label: "Remarks".tr,
              tec: tec_remarks,
              minLine: 2,
            ),
            Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ElevatedButton(
                    // color: Colors.lightBlueAccent,
                    // textColor: Colors.white,
                    child: Text("Cancel".tr),
                    onPressed: () {
                      postResponse(2, context);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ElevatedButton(
                    // color: Colors.lightGreen,
                    // textColor: Colors.white,
                    child: Text("Update".tr),
                    onPressed: () {
                      postResponse(1, context);
                    },
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }

  Future postResponse(int i, BuildContext context) async {
    var compRepo = Provider.of<CompanyRepository>(context, listen: false);

    Map params = {
      "api_key": compRepo.getSelectedApiKey(),
      "RequestID": item["RequestID"].toString(),
      "Doc_Id": item["RequestID"].toString(),
      "Approved": "$i",
      "Remarks": "${tec_remarks.text}",
      "AppName": MyKey.appName,
      "ApprovedRemarks": item["ApprovedRemarks"]
    };
    var url = MyKey.baseUrl + endUrl;
    var result = await MyKey.postWithApiKey(url, params, context);
    if (result != null) {
      showToast("Updated");
      // Toast.show(, context);
      Navigator.of(context).pop();
    }
  }
}
