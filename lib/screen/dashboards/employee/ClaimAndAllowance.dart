import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/BasicResponse.dart';
import 'package:glowrpt/model/employe/ExpenceTypeM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import '../../../util/loader_animation.dart';

class ClaimAndAllowance extends StatefulWidget {
  @override
  _ClaimAndAllowanceState createState() => _ClaimAndAllowanceState();
}

enum ExpenceType { Expence, Advance }

class _ClaimAndAllowanceState extends State<ClaimAndAllowance> {
  TextEditingController tec_datePicker = TextEditingController();
  TextEditingController tec_amount = TextEditingController();
  TextEditingController tec_remarks = TextEditingController();
   User? user;
  List expenceList = [];
  final _formKey = GlobalKey<FormState>();
  bool isNoProcess = true;
  dynamic _expence;

//  TextEditingController tec_amount = TextEditingController();
  File? _imagePath;

   CompanyRepository? compRepo;

  bool isLoading = false;

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

        _imagePath = await entity!.file;
        setState(() {});
      } on Exception catch (error) {
        print("error: $error");
      }
    }
  }

  var _selectedValue = ExpenceType.Expence;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    user = compRepo!.getSelectedUser();
    tec_datePicker.text = MyKey.displayDateFormat.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Claim And Allowance".tr),
      ),
      body: isLoading
          ? LoadingAnimation()
          : ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading: Radio(
                                      value: ExpenceType.Expence,
                                      groupValue: _selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedValue = value!;
                                        });
                                      },
                                    ),
                                    title: Text("Expense".tr),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    leading: Radio(
                                        value: ExpenceType.Advance,
                                        groupValue: _selectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedValue = value!;
                                          });
                                        }),
                                    title: Text("Advance".tr),
                                  ),
                                )
                              ],
                            ),
                            /* KeyValueDate(
                        controller: tec_datePicker,
                      ),*/
                            DropdownSearch<ExpenceTypeM>(
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                isFilterOnline: false,
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                labelText: "Select Expense Type".tr,
                              )),
                              asyncItems: (text) => Serviece.getExpenceList(context: context, 
                              api_key: compRepo!.getSelectedApiKey()),

                              // mode: Mode.MENU,
                              //autoFocusSearchBox: true,
                              // showSearchBox: true,
                              // label: "Select Expense Type".tr,
                              // isFilteredOnline: false,
                              // onFind: (text) => Serviece.getExpenceList(
                              //   context: context,
                              //   api_key: compRepo.getSelectedApiKey(),
                              // ),
                              onChanged: (party) {
                                setState(() {
                                  _expence = party!.toJson();
                                });
                              },
                            ),
                            TextFormField(
                                controller: tec_amount,
                                keyboardType: TextInputType.number,
                                validator: (text) {
                                  return double.parse(text!) == 0.0
                                      ? "Amount Invalid"
                                      : null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Amount".tr,
                                )),
                            TextFormField(
                              controller: tec_remarks,
                              keyboardType: TextInputType.multiline,
                              maxLines: 8,
                              minLines: 1,
                              decoration: InputDecoration(
                                labelText: "Remarks".tr,
                              ),
                              validator: (text) {
                                return text!.isEmpty
                                    ? "Please enter Remarks".tr
                                    : null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text("Select Your Document From".tr)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Container(),
                                  flex: 1,
                                ),
                                TextButton.icon(
                                    onPressed: () {
                                      getImageFile(true);
                                    },
                                    icon: Icon(Icons.camera_alt_outlined),
                                    label: Text("Camera".tr)),
                                // SizedBox(
                                //   width: 20,
                                // ),
                                // TextButton.icon(
                                //     onPressed: () {
                                //       getImageFile(false);
                                //     },
                                //     icon: Icon(Icons.image_outlined),
                                //     label: Text("Gallery".tr)),
                                Expanded(
                                  child: Container(),
                                  flex: 1,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: _imagePath == null
                                    ? Container(
                                        child: SizedBox(
                                          height: 150,
                                        ),
                                      )
                                    : Image.file(
                                        File(_imagePath!.path),
                                        height: 300,
                                      ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: FractionallySizedBox(
                                alignment: Alignment.bottomRight,
                                widthFactor: .4,
                                child: MaterialButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    LoadingAnimation();
                                    if (_formKey.currentState!.validate()) {
                                      
                                  requistForAllowance();
                                    }else{
                                      

                                    }
                                  },
                                  child: isNoProcess
                                      ? Text(
                                          "Save".tr,
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : CupertinoActivityIndicator(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future requistForAllowance() async {
    setState(() {
      LoadingAnimation();
    });

    String api_key = user!.apiKey;
    String docImage = "0000";
    if (_imagePath != null) {
      List<int> imageBytes = await _imagePath!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      String lastUrl1 = "hrm/fileimageinsert";
      var url = MyKey.baseUrl + lastUrl1;
      Map imageParams = {
        "api_key": api_key,
        "org_id": user!.orgId.toString(),
        "xfiles": base64Image
      };
      print("params $imageParams");
      var response = await http.post(Uri.parse(url), body: imageParams);
      print("response ${response.body}");
      var basicResponse = basicResponseFromJson(response.body);
      if (basicResponse.error) {
        // Toast.show();
        showToast("Document Uploading Failed");
        setState(() {
          isNoProcess = true;
        });
        return;
      }
      docImage = basicResponse.message.trim();
    }

    String lastUrl = "hrm/expense";
    var url = "${MyKey.baseUrl}$lastUrl";
    var data = [
      {
        'api_key': api_key,
        'amount': tec_amount.text,
        'allowance': _expence["Code"],
        'remark': tec_remarks.text,
        'docimage': docImage,
        'date': MyKey.getCurrentDate(),
        "IsAdavance": _selectedValue == ExpenceType.Advance ? "Yes" : "No"
      }
    ];
    Map params = {"data": json.encode(data)};
    print("params $params");
    setState(() {
      isLoading = true;
    });
    dynamic result = await MyKey.postWithApiKey(url, params, context);
    setState(() {
      isLoading = false;
      if (result == null) return expenceList = result;
    });
    Navigator.pop(context);
  }
}
