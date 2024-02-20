import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/BasicResponse.dart';
import 'package:glowrpt/model/employe/EmpLoadM.dart';
import 'package:glowrpt/model/employe/OrgM.dart';
import 'package:glowrpt/model/employe/RoutPunchLodM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/service/BackgroundLocationServiece.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/employee/MenuItemIcon.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'dart:isolate';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/loader_animation.dart';

class RoutePunchinScreen extends StatefulWidget {
  EmpLoadM empLoadM;

  RoutePunchinScreen({required this.empLoadM});

  @override
  _RoutePunchinScreenState createState() => _RoutePunchinScreenState();
}

class _RoutePunchinScreenState extends State<RoutePunchinScreen> {
  ReceivePort port = ReceivePort();

  String logStr = '';
  bool? isRunning;
  DateTime? lastTimeLocation;

   CompanyRepository? compRepo;
  bool isNoProcess = true;
  File? _imagePath;

  List<OrgM>? companies;

  TypesBean? selectedTypes;
  bool isLoading = false;

  var formKey = GlobalKey<FormState>();

  RoutPunchLodM? routePunchLoad;

  String? imageId;

  XFile? myImage;
  var etcKm = TextEditingController();
  var remarks = TextEditingController();

   BackgroundLocationServiece? backgroundLocation;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    // loadConnectedCompanies();
    loadData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    backgroundLocation = Provider.of<BackgroundLocationServiece>(context);
    backgroundLocation!.getTrackingStatus();
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(
      height: 20,
      width: 4,
    );
    return Scaffold(
      appBar: AppBar(
        //punch insert for root
        title: Text("Punch In & Out".tr),
      ),
      body: isLoading
          ? LoadingAnimation()
          : Center(
              child: routePunchLoad != null
                  ? SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text("Your Status"),
                                trailing: backgroundLocation!.isTracking
                                    ? Text(
                                        "Tracking",
                                        style: TextStyle(color: Colors.green),
                                      )
                                    : Text("Not Tracking",
                                        style: TextStyle(color: Colors.orange)),
                              ),
                              SizedBox(
                                height: 60,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        getImageFile(true);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 19),
                                        child: Text("Take Photo"),
                                      ),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Or"),
                                    ),
                                    Expanded(
                                        child: TextFormField(
                                      controller: etcKm,
                                      decoration: InputDecoration(
                                          labelText: "Km",
                                          border: textFieldBorder),
                                    )),
                                  ],
                                ),
                              ),
                              space,
                              (myImage?.path != null &&
                                      imageId != null &&
                                      imageId != "0000")
                                  ? Image.file(
                                      File(myImage!.path),
                                      height: 300,
                                    )
                                  : Container(),
                              SizedBox(
                                // width: 250,
                                height: 60,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: DropdownButtonFormField<TypesBean>(
                                    value: selectedTypes,
                                    decoration: InputDecoration(
                                      labelText: "Select types".tr,
                                      filled: true,
                                      fillColor: Color(0xecedec),
                                      border: textFieldBorder,
                                    ),
                                    // underline: Container(),
                                    // hint: Text("Okay".tr),
                                    items: routePunchLoad!.Types.map(
                                        (e) => DropdownMenuItem(
                                              child: Text(e.Type),
                                              value: e,
                                            )).toList(),
                                    isExpanded: true,
                                    onChanged: (type) {
                                      setState(() {
                                        selectedTypes = type;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              space,
                              TextFormField(
                                controller: remarks,
                                decoration: InputDecoration(
                                    labelText: "Remark",
                                    border: textFieldBorder),
                              ),
                              space,
                              SizedBox(
                                width: 250,
                                child: MenuItemIcon(
                                  iconData: Icons.check_circle,
                                  title: "Punch In".tr,
                                  onTap: () async {

                                    insertPunch("IN", "RP");

                                  },
                                ),
                              ),
                              space,
                              SizedBox(
                                width: 250,
                                child: MenuItemIcon(
                                  title: "Punch Out".tr,
                                  iconData: Icons.error,
                                  onTap: () async {
                                    insertPunch("OUT", "RP");

                                    // onStop();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : CupertinoActivityIndicator(),
            ),
    );
  }

  Future insertPunch(String puch, String pUType) async {
     if(!formKey.currentState!.validate()){
      return;
    }
    if (selectedTypes == null) {
      showToast("Please Select Type");
      return;
    }
   /* if(puch=="IN"){
      backgroundLocation.startTracking();
    }else{
      backgroundLocation.stopTracking();
    }*/
    setState(() {
      isLoading = true;
    });
    String api_key = compRepo!.getSelectedApiKey();
    String docImage = "0000";
    if (_imagePath != null) {
      List<int> imageBytes = await _imagePath!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      String lastUrl1 = "hrm/fileimageinsert";
      var url = MyKey.baseUrl + lastUrl1;
      Map imageParams = {
        "api_key": api_key,
        "org_id": compRepo!.getSelectedUser().orgId.toString(),
        "xfiles": base64Image
      };
      print("params $imageParams");
      var response = await http.post(Uri.parse(url), body: imageParams);
      print("response ${response.body}");
      var basicResponse = basicResponseFromJson(response.body);
      if (basicResponse.error) {
        Toast.show("Document Uploading Failed");
        setState(() {
          isNoProcess = true;
        });
        return;
      }
      docImage = basicResponse.message.trim();
    }

    var response = await Serviece.routePunch(
        api_key: compRepo!.getSelectedApiKey(),
        context: context,
        Type: selectedTypes!.Type,
        DocImage: docImage,
        EmpCode: widget.empLoadM.EmployeeDetails.first.EmpCode,
        EmpName: widget.empLoadM.EmployeeDetails.first.EmpName,
        inOut: puch,
        KM: etcKm.text,
        Remarks: remarks.text,
        PUType: pUType);
    if (response != null) {
      isLoading = false;
      Toast.show("Success");
      Navigator.pop(context);
    }
  }

/*  Future<void> loadConnectedCompanies() async {
    companies = await Serviece.getConnectedCompanies(
        context: context, api_key: compRepo.getSelectedApiKey());
    selectedCompany = companies.firstWhere(
        (element) => element.Org_Id == compRepo.getPrimaryUser().orgId);
    setState(() {});
  }*/

  Future getImageFile(bool isCamera) async {
    if (await Permission.camera.request().isGranted) {
      try {
        final AssetEntity? entity =
            await CameraPicker.pickFromCamera(Get.context!,
                pickerConfig: CameraPickerConfig(
                    resolutionPreset: ResolutionPreset.medium,
                    enableRecording: false,
                    // preferredLensDirection: CameraLensDirection.front,
                    previewTransformBuilder: (context, controll, widget) {
                      return widget;
                    }),
                locale: Locale("EN"));

        _imagePath = (await entity?.file)!;
        setState(() {});
      } on Exception catch (error) {
        print("error: $error");
      }
    }
    /*  XFile myImage;
    if (isCamera) {
      myImage = await ImagePicker()
          .pickImage(source: ImageSource.camera, maxHeight: 256);
    }
    setState(() {
      _imagePath = myImage;
    });*/
  }

  // Future<String> uploadImageAndGetDocId() async {
  //   // String api_key = compRepo.getUserByOrgId(selectedTypes.Org_Id).apiKey;
  //   // XFile  myImage = await ImagePicker().pickImage(source: ImageSource.camera);
  //    myImage = await ImagePicker()
  //       .pickImage(source: ImageSource.camera,
  //        // imageQuality: 40
  //        maxHeight: 1024,
  //        maxWidth: 1024
  //    );
  //   String docImage = "0000";
  //   if (myImage != null) {
  //     List<int> imageBytes = await myImage.readAsBytes();
  //     String base64Image = base64Encode(imageBytes);
  //     String lastUrl1 = "hrm/fileimageinsert";
  //     var url = MyKey.baseUrl + lastUrl1;
  //     Map imageParams = {
  //       "api_key": compRepo.getSelectedApiKey(),
  //       "org_id": compRepo.getSelectedUser().orgId.toString(),
  //       "xfiles": base64Image
  //     };
  //     print("params $imageParams");
  //     var response = await http.post(Uri.parse(url), body: imageParams);
  //     print("response ${response.body}");
  //     var basicResponse = basicResponseFromJson(response.body);
  //     if (basicResponse.error) {
  //       Toast.show("Document Uploading Failed", context);
  //       return null;
  //     }
  //     docImage = basicResponse.message.trim();
  //     return docImage;
  //   }
  //   return null;
  // }

  Future<void> loadData() async {
    routePunchLoad = await Serviece.routePunchKmLoad(
        context: context, api_key: compRepo!.getSelectedApiKey());
    setState(() {});
  }
}
