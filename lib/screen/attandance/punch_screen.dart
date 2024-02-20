import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/attandace/EmpAttandanceM.dart';
import 'package:glowrpt/model/attandace/PunchM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/KeyValues.dart';
import 'package:get/get.dart';

class PunchScreen extends StatefulWidget {
  String apiKey;
  DateTime dateTime;
  String empId;

  PunchScreen({
   required this.apiKey,
   required this.dateTime,
   required this.empId,
  });

  @override
  _PunchScreenState createState() => _PunchScreenState();
}

class _PunchScreenState extends State<PunchScreen> {
  late HeaderBean headder;

  late List<LinesBean> punchList;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getPunchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Punch Details".tr),
      ),
      body: isLoaded
          ? Column(
              children: [
                ListTile(title: Text("Day Details".tr)),
                Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        KeyValues(
                            keys: "Shift begin".tr,
                            values: headder?.ShiftBeginTime ?? "N/A"),
                        KeyValues(
                            keys: "Shift end".tr,
                            values: headder?.ShiftEndTime ?? "N/A"),
                        KeyValues(
                            keys: "First Punch".tr,
                            values: headder?.FirstPunch ?? "N/A"),
                        KeyValues(
                            keys: "Last Punch".tr,
                            values: headder?.LastPunch ?? "N/A"),
                      ],
                    ),
                  ),
                ),
                ListTile(title: Text("Punch Details".tr)),
                Expanded(
                    child: ListView.builder(
                        itemCount: punchList.length,
                        itemBuilder: (context, position) {
                          var item = punchList[position];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(item.PT),
                          );
                        })),
              ],
            )
          : Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }

  getPunchDetails() async {
    PunchM? punchM = await Serviece.getPunchDetails(
        context: context,
        api_key: widget.apiKey,
        Date: MyKey.displayDateFormat.format(widget.dateTime),
        EmpId: widget.empId);
    isLoaded = true;

    try {
      headder = punchM!.Header.first;
    } catch (e) {
      headder = HeaderBean();
    }
    punchList = punchM!.Lines;
    setState(() {});
  }
}
