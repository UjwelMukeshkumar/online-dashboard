import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/manager/roaster/RoastLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

import 'create_new_shift_screen.dart';
import 'package:get/get.dart';

class ShiftListScreen extends StatefulWidget {
  @override
  State<ShiftListScreen> createState() => _ShiftListScreenState();
}

class _ShiftListScreenState extends State<ShiftListScreen> {
   CompanyRepository? compRepo;

  List<Shift_DetailsBean>? shiftList;

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shift Master".tr),
      ),
      body: shiftList != null
          ? Column(
              children: [
                TextButton(
                    onPressed: openCreatShift, child: Text("Create Shift".tr)),
                Expanded(
                  child: ListView.builder(
                      itemCount: shiftList!.length,
                      itemBuilder: (context, position) {
                        var item = shiftList![position];
                        return Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          color: AppColor.cardBackground,
                          child: ListTile(
                              title: Text(item.ShiftName.toString()),
                              subtitle: Text(item.ShiftCode.toString()),
                              trailing: Text(item.ShiftValue.toString()),
                              leading: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: Color(int.parse(item.ShiftColour.toString().substring(1),radix: 16)),
                                    //  color: Color(int.parse(
                                    //     item.ShiftColour.toString()
                                    //         .substring(1),
                                    //     radix: 16)),
                                  ))),
                        );
                      }),
                ),
              ],
            )
          : Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }

  Future<void> loadData() async {
    shiftList = await Serviece.getShiftList(
        context: context, api_key: compRepo!.getSelectedApiKey());
    setState(() {});
  }

  Future<void> openCreatShift() async {
    var response = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateNewShiftScreen()));
    if (response == true) {
      loadData();
    }
  }
}
