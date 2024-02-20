import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/BasicResponse.dart';
import 'package:glowrpt/model/employe/EmpLoadM.dart';
import 'package:glowrpt/model/employe/OrgM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/util/loader_animation.dart';
import 'package:glowrpt/widget/employee/MenuItemIcon.dart';

// import 'package:hrm_employee/custome/MenuItemIcon.dart';
// import 'package:hrm_employee/location/file_manager.dart';
// import 'package:hrm_employee/location/location_callback_handler.dart';
// import 'package:hrm_employee/location/location_service_repository.dart';

// import 'package:hrm_employee/model/BasicResponse.dart';
// import 'package:hrm_employee/model/User.dart';
// import 'package:hrm_employee/util/MyKey.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'dart:isolate';

// import 'package:flutter/material.dart';

import 'dart:async';
// import 'dart:isolate';
// import 'dart:ui';

// import 'package:background_locator/background_locator.dart';
// import 'package:background_locator/location_dto.dart';
// import 'package:background_locator/settings/android_settings.dart';
// import 'package:background_locator/settings/ios_settings.dart';
// import 'package:background_locator/settings/locator_settings.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PunchinScreen extends StatefulWidget {
  EmpLoadM? empLoadM;

  PunchinScreen(this.empLoadM);

  @override
  _PunchinScreenState createState() => _PunchinScreenState();
}

class _PunchinScreenState extends State<PunchinScreen> {
  ReceivePort port = ReceivePort();

  String logStr = '';
  bool isRunning = false;
  DateTime? lastTimeLocation;
  bool isLoading = false;

  CompanyRepository? compRepo;

  List<OrgM>? companies;

  OrgM? selectedCompany;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadConnectedCompanies();
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 20);
    // return Text("data");

    return Scaffold(
      appBar: AppBar(
        title: Text("Punch In & Out".tr),
      ),
      body: isLoading
          ? LoadingAnimation()
          : Center(
              child: companies != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // status,
                        SizedBox(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: DropdownButtonFormField<OrgM>(
                              value: selectedCompany,
                              decoration: InputDecoration(
                                labelText: "Select Location".tr,
                                filled: true,
                                fillColor: Color(0xecedec),
                                border: textFieldBorder,
                              ),
                              // underline: Container(),
                              // hint: Text("Okay".tr),
                              items: companies!
                                  .map((e) => DropdownMenuItem(
                                        child: Text(e.Organisation),
                                        value: e,
                                      ))
                                  .toList(),
                              isExpanded: true,
                              onChanged: (cmp) {
                                setState(() {
                                  selectedCompany = cmp;
                                });
                              },
                            ),
                          ),
                        ),
                        space,
                        SizedBox(
                          width: 250,
                          child: MenuItemIcon(
                            iconData: Icons.check_circle,
                            title: "Punch In".tr,
                            color: getColor(selectedCompany!),
                            onTap: () {
                              insertPunch("IN", "", "NP");
                            },
                          ),
                        ),
                        space,
                        SizedBox(
                          width: 250,
                          child: MenuItemIcon(
                            title: "Punch Out".tr,
                            color: getColor1(selectedCompany!),
                            iconData: Icons.error,
                            onTap: () {
                              insertPunch("OUT", "", "NP");
                              // onStop();
                            },
                          ),
                        )
                      ],
                    )
                  : CupertinoActivityIndicator(),
            ),
    );
  }

  Future insertPunch(String puch, String docImageId, String pUType) async {
    // print("Okay");
    // return;
    setState(() {
      isLoading = true;
    });
    var employeeDetailsBean = widget.empLoadM?.EmployeeDetails.first;
    var response = await Serviece.punchRequestInsert(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        In_Out: puch,
        EmpName: employeeDetailsBean!.EmpName.toString(),
        Org_Id: selectedCompany!.Org_Id.toString(),
        HomeCmp: selectedCompany!.Org_Id == compRepo!.getPrimaryUser()!.orgId
            ? "Y"
            : "N",
        EmpCode: employeeDetailsBean.EmpCode,
        doImageID: docImageId,
        PUType: pUType);
    if (response != null) {
      isLoading = false;
      showToast("Success");
      Navigator.pop(context);
    }
  }

  Future<void> loadConnectedCompanies() async {
    companies = await Serviece.getConnectedCompanies(
      context: context,
      api_key: compRepo!.getSelectedApiKey(),
    );
    print(companies.toString());
    selectedCompany = companies?.firstWhere(
        (element) => element.Org_Id == compRepo?.getPrimaryUser()?.orgId);
    setState(() {});
  }

  Future<String?> uploadImageAndGetDocId() async {
    String api_key =
        compRepo!.getUserByOrgId(selectedCompany!.Org_Id.toInt())!.apiKey;
    // XFile  myImage = await ImagePicker().pickImage(source: ImageSource.camera);
    XFile? myImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 40);
    String docImage = "0000";
    if (myImage != null) {
      List<int> imageBytes = await myImage.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      String lastUrl1 = "hrm/fileimageinsert";
      var url = MyKey.baseUrl + lastUrl1;
      Map imageParams = {
        "api_key": api_key,
        "org_id": selectedCompany!.Org_Id.toString(),
        "xfiles": base64Image
      };
      print("params $imageParams");
      var response = await http.post(Uri.parse(url), body: imageParams);
      print("response ${response.body}");
      var basicResponse = basicResponseFromJson(response.body);
      if (basicResponse.error) {
        Toast.show("Document Uploading Failed");
        return null;
      }
      docImage = basicResponse.message.trim();
      return docImage;
    }
    return null;
  }

  Color getColor(OrgM item) {
    switch (item.PunchStatus) {
      case "No Punch":
        return Colors.grey;
      // break;
      case "in":
        return Colors.green;
      // break;
      case "out":
        return Colors.red;
      // break;
      default:
        return Colors.white;
    }
  }

  Color getColor1(OrgM item) {
    switch (item.PunchOutStatus) {
      case "No Punch":
        return Colors.grey;
      // break;
      case "out":
        return Colors.red;
      // break;
      default:
        return Colors.white;
    }
  }
}
