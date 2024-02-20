import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/transaction/PartyLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/util/loader_animation.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

class CreateNewParty extends StatefulWidget {
  String? type;
  String? title;
  String? code;
  String? fromRouteReference;

  CreateNewParty({
    this.type,
    this.title,
    this.code,
    this.fromRouteReference = "",
  });

  @override
  _CreateNewPartyState createState() => _CreateNewPartyState();
}

class _CreateNewPartyState extends State<CreateNewParty> {
  var tecName = TextEditingController();

  var tecPhone = TextEditingController();

  var tecEmail = TextEditingController();
  var tecAddress = TextEditingController();
  var tecPinCode = TextEditingController();
  var tecGstNumber = TextEditingController();

  var formKey = GlobalKey<FormState>();

  CompanyRepository? compRepo;

  PartyLoadM? partyLoad;
  bool isLoading = false;
  GsttypeBean? selectedGstType;

  PricelistBean? selectedPriceList;

  StateBean? selectedState;

  GroupBean? selectedGroup;

  bool isUpdateParty = false;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    load();
  }

  @override
  Widget build(BuildContext context) {
    var downArrow = Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            top: -10,
            // child: Icon(Icons.add)),
            child: Icon(Icons.arrow_drop_down)),
      ],
    );
    var space = SizedBox(
      height: 20,
    );
    return Scaffold(
      appBar: AppBar(
        //TODO : fixthis
        title: Text("Create New ${widget.type == "E" ? "Employee" : "Party"}"),
      ),
      body: isLoading
          ? LoadingAnimation()
          : Column(
              children: [
                Expanded(
                  child: partyLoad != null
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: formKey,
                            child: ListView(
                              children: [
                                space,
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Name".tr,
                                      border: textFieldBorder),
                                  validator: (text) =>
                                      text!.isEmpty ? "Enter Name" : null,
                                  controller: tecName,
                                ),
                                space,
                                TextFormField(
                                  controller: tecPhone,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      labelText: "Mobile Number".tr,
                                      border: textFieldBorder),
                                ),
                                if (widget.type != "E") ...[
                                  space,
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: tecEmail,
                                    decoration: InputDecoration(
                                        labelText: "Email".tr,
                                        border: textFieldBorder),
                                  ),
                                  space,
                                  TextFormField(
                                    controller: tecAddress,
                                    decoration: InputDecoration(
                                        labelText: "Address".tr,
                                        border: textFieldBorder),
                                    maxLines: 10,
                                    minLines: 1,
                                  ),
                                  space,
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: tecPinCode,
                                    decoration: InputDecoration(
                                        labelText: "Pin Code".tr,
                                        border: textFieldBorder),
                                  ),
                                  space,
                                  SizedBox(
                                    height: 60,
                                    child: DropdownSearch<StateBean>(
                                      popupProps: PopupProps.bottomSheet(
                                        showSearchBox: true,
                                        isFilterOnline: true,
                                      ),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                        labelText: "State".tr,
                                      )),
                                      // showSearchBox: true,
                                      selectedItem: selectedState,
                                      items: partyLoad!.state,
                                      // mode: Mode.BOTTOM_SHEET,
                                      // dropdownSearchDecoration: InputDecoration(
                                      //     // hintText: "State".tr,
                                      //     border: textFieldBorder),
                                      // dropDownButton: downArrow,
                                      onChanged: (item) {
                                        selectedState = item;
                                      },
                                    ),
                                  ),
                                  space,
                                  TextFormField(
                                    controller: tecGstNumber,
                                    decoration: InputDecoration(
                                        labelText: "GST Number".tr,
                                        border: textFieldBorder),
                                  ),
                                  space,
                                  SizedBox(
                                    height: 60,
                                    child: DropdownSearch<GsttypeBean>(
                                      popupProps: PopupProps.bottomSheet(
                                        showSearchBox: true,
                                        isFilterOnline: true,
                                      ),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                        labelText: "GST Type".tr,
                                        border: textFieldBorder,
                                      )),
                                      // showSearchBox: true,
                                      selectedItem: selectedGstType,
                                      items: partyLoad!.gsttype,
                                      // mode: Mode.BOTTOM_SHEET,
                                      // dropDownButton: downArrow,
                                      // dropdownSearchDecoration: InputDecoration(
                                      //     hintText: "GST Type".tr,
                                      //     border: textFieldBorder),
                                      onChanged: (item) {
                                        selectedGstType = item;
                                      },
                                    ),
                                  ),
                                  space,
                                  SizedBox(
                                    height: 60,
                                    child: DropdownSearch<PricelistBean>(
                                      popupProps: PopupProps.bottomSheet(
                                        showSearchBox: true,
                                        isFilterOnline: true,
                                      ),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                        labelText: "Price List".tr,
                                        border: textFieldBorder,
                                      )),
                                      // showSearchBox: true,
                                      selectedItem: selectedPriceList,
                                      items: partyLoad!.pricelist,
                                      // dropDownButton: downArrow,
                                      // mode: Mode.BOTTOM_SHEET,
                                      // dropdownSearchDecoration: InputDecoration(
                                      //     hintText: "Price List".tr,
                                      //     border: textFieldBorder),
                                      onChanged: (item) {
                                        selectedPriceList = item;
                                      },
                                    ),
                                  ),
                                  space,
                                  SizedBox(
                                    height: 60,
                                    child: DropdownSearch<GroupBean>(
                                      popupProps: PopupProps.bottomSheet(
                                        showSearchBox: true,
                                        isFilterOnline: true,
                                      ),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                        labelText: "Group".tr,
                                        border: textFieldBorder,
                                      )),
                                      // showSearchBox: true,
                                      selectedItem: selectedGroup,
                                      items: partyLoad!.group,
                                      // mode: Mode.BOTTOM_SHEET,
                                      // dropDownButton: downArrow,
                                      // dropdownSearchDecoration: InputDecoration(
                                      // hintText: "Group".tr,
                                      // border: textFieldBorder,
                                      onChanged: (item) {
                                        selectedGroup = item;
                                      },
                                    ),
                                  ),
                                  space,
                                ]
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: CupertinoActivityIndicator(),
                        ),
                ),
                // GST Number, GST Type, Address, Pin, State, Price list, group. Text boxes
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: saveDataToServer, child: Text("Save".tr)),
                )
              ],
            ),
    );
  }

  Future<void> saveDataToServer() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (formKey.currentState!.validate()) {
        if (selectedState == null && widget.type != "E") {
          Toast.show("Select State");
          return;
        }
        var response = await Serviece.createNewParty(
          context: context,
          isUpdate: isUpdateParty,
          api_key: compRepo!.getSelectedApiKey(),
          CVName: tecName.text.trim(),
          MobileNo: tecPhone.text.trim(),
          Email: tecEmail.text.trim(),
          Type: widget.type.toString(),
          Address: tecAddress.text.toString(),
          PinCode: tecPinCode.text.trim(),
          GSTNo: tecGstNumber.text.trim(),
          CVGroup: selectedGroup?.Grp_Code.toString() ?? "",
          GSTType: selectedGstType?.Type ?? "",
          priceList: selectedPriceList?.PriceListNo.toString() ?? "",
          State: selectedState?.State_Id.toString() ?? "",
          CVCode: widget.code ?? "",
          fromRouteReference: widget.fromRouteReference.toString(),
        );
        if (response != null) {
          isLoading = false;
          Toast.show("Created Successfully");
          Navigator.pop(context, true);
        }
      }
    } catch (error) {
      Toast.show("API Error : $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> load() async {
    partyLoad = await Serviece.getPartyLoad(
        context: context, api_key: compRepo!.getSelectedApiKey());
    if (widget.code != null) {
      isUpdateParty = true;
      loadPartyData();
    }
    setState(() {});
  }

  Future<void> loadPartyData() async {
    var cvDetails = await Serviece.getCvDetails(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        cvCode: widget.code.toString());
    tecName.text = cvDetails.CVName;
    tecPhone.text = cvDetails.MobileNo;
    tecEmail.text = cvDetails.Email;
    tecAddress.text = cvDetails.Address;
    tecPinCode.text = cvDetails.PinCode.toString();
    tecGstNumber.text = cvDetails.GSTNo.toString();
    try {
      selectedState = partyLoad?.state.firstWhere(
        (element) => element.State_Id == cvDetails.State,
        // orElse: () => null,
      );
    } catch (e) {
      print(e);
    }
    try {
      selectedGstType = partyLoad?.gsttype.firstWhere(
        (element) => element.Type == cvDetails.GSTType,
        // orElse: () => null,
      );
    } catch (e) {
      print(e);
    }
    try {
      selectedPriceList = partyLoad!.pricelist.firstWhere(
        (element) => element.PriceListNo == cvDetails.PriceList,
        // orElse: () => null,
      );
    } catch (e) {
      print(e);
    }
    try {
      selectedGroup = partyLoad!.group.firstWhere(
        (element) => element.Grp_Code == cvDetails.CVGroup,
        // orElse: () => null,
      );
    } catch (e) {
      print(e);
    }
    setState(() {});
  }
}
