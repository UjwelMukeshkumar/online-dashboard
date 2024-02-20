import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/library/AppSctring.dart';
import 'package:glowrpt/library/DateFactory.dart';
import 'package:glowrpt/model/campain/CampaginResponseM.dart';
import 'package:glowrpt/model/campain/CampainItem.dart';
import 'package:glowrpt/model/campain/CampainListItemM.dart';
import 'package:glowrpt/model/campain/CampainM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/dashboards/sales/campains/campain_items_screen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';

enum Campagin { ByPrice, ByDiscount }

enum DiscountBy { Bulk, Item }

class CampainsScreen extends StatefulWidget {
  CampainListItemM? campainListItemM;

  CampainsScreen({ Key? key,this.campainListItemM}) : super(key: key);

  @override
  State<CampainsScreen> createState() => _CampainsScreenState();
}

class _CampainsScreenState extends State<CampainsScreen> {
  var _formKey = GlobalKey<FormState>();

  CompanyRepository? companyRepo;

  CampainM? comapainM;

  Campagin campagin = Campagin.ByPrice;
  DiscountBy discountBy = DiscountBy.Bulk;
  var etcFromDate = TextEditingController();
  var etcToDate = TextEditingController();
  var etcCampaignName = TextEditingController();

  String? fromDate;

  String? toDate;

  // String campainName;

  CampaginResponseM? campaingDetails;

  bool isEdit = false;

  HeaderBean? headder;

  @override
  void initState() {
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
    if (widget.campainListItemM != null) {
      isEdit = true;
    }
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 10);

    return Scaffold(
      appBar: AppBar(
        title: Text("Campaign"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isEdit && campaingDetails == null
            ? Center(child: CupertinoActivityIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: etcCampaignName,
                      decoration: InputDecoration(
                        labelText: "Campaign Name",
                        border: textFieldBorder,
                      ),
                      validator: (text) =>
                          text!.isEmpty ? "Enter Campaign Name" : null,

                    ),
                    space,
                    Row(
                      children: [
                        Expanded(
                            child: DateTimePicker(
                          type: DateTimePickerType.dateTime,
                          // initialValue: DateTime.now().toDisplayDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          dateLabelText: 'From',
                          controller: etcFromDate,

                          onChanged: (val) {
                            fromDate = val;
                          },
                          dateMask: "dd/MM/yyyy HH:mm",
                          validator: (val) =>
                              val!.isEmpty ? "Pick From Date" : null,
                          onSaved: (val) {},
                        )),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                            child: DateTimePicker(
                          type: DateTimePickerType.dateTime,
                          // initialValue: DateTime.now().toDisplayDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          dateLabelText: 'To',
                          controller: etcToDate,
                          dateMask: "dd/MM/yyyy HH:mm",
                          onChanged: (val) {
                            toDate = val;
                          },
                          validator: (val) =>
                              val!.isEmpty ? "Pick To Date" : null,
                          onSaved: (val) {},
                        )),
                      ],
                    ),
                    space,
                    Column(
                      children: [
                        ListTile(
                          title: Text("Set Offers"),
                        ),
                        RadioListTile(
                          value: Campagin.ByPrice,
                          groupValue: campagin,
                          onChanged: (onChanged) {
                            setState(() {
                              campagin = onChanged!;
                            });
                          },
                          title: Text("By Price"),
                        ),
                        RadioListTile(
                          value: Campagin.ByDiscount,
                          groupValue: campagin,
                          onChanged: (onChanged) {
                            setState(() {
                              campagin = onChanged!;
                            });
                          },
                          title: Text("By Discount"),
                        ),
                        Visibility(
                            visible: campagin == Campagin.ByDiscount,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                children: [
                                  RadioListTile(
                                    value: DiscountBy.Bulk,
                                    groupValue: discountBy,
                                    onChanged: (onChanged) {
                                      setState(() {
                                        discountBy = onChanged!;
                                      });
                                    },
                                    title: Text("Bulk"),
                                  ),
                                  RadioListTile(
                                    value: DiscountBy.Item,
                                    groupValue: discountBy,
                                    onChanged: (onChanged) {
                                      setState(() {
                                        discountBy = onChanged!;
                                      });
                                    },
                                    title: Text("Item"),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("From Date ${etcFromDate.text}== To Date ${etcToDate.text}");
                            print("From Date ${etcFromDate.text.toPickerDate.toDisplayDateTime}== To Date ${etcToDate.text.toPickerDate.toDisplayDateTime}");

                            Get.to(() => CampainItemsScreen(
                                  comapainM: comapainM,
                                  campainName: etcCampaignName.text,
                                  fromDateWithTime: etcFromDate
                                      .text.toPickerDate.toDisplayDateTime,
                                  toDateWithTime: etcToDate
                                      .text.toPickerDate.toDisplayDateTime,
                                  campagin: campagin,
                                  discountBy: discountBy,
                              campaginResponseM: campaingDetails,
                                ));
                          }
                        },
                        child: Text("Continue"))
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> loadData() async {
    comapainM = (await Serviece.getCampainLoad(
        context: context, api_key: companyRepo!.getSelectedApiKey())) as CampainM;
    if (widget.campainListItemM != null) {
      campaingDetails = await Serviece.getCampainDetails(
          context: context,
          api_key: companyRepo!.getSelectedApiKey(),
          RecNum: widget.campainListItemM!.RecNum.toString(),
          Sequence: widget.campainListItemM!.Sequence.toString());
      headder=campaingDetails?.Header?.first;
      etcCampaignName.text=headder?.DocName??"";
      etcFromDate.text=headder?.FromDate?.toDate.toPickerDisplayDate??"";
      // etcFromDate.text=headder.FromDate.replaceAll("/", "-");
      etcToDate.text=headder?.ReversalDate?.toDate.toPickerDisplayDate??"";

     if(headder?.offer_type==DiscountType.DiscountItem.name){
        campagin=Campagin.ByDiscount;
        discountBy=DiscountBy.Item;
      }else if(headder?.offer_type==DiscountType.DiscountBulk.name){
        campagin=Campagin.ByDiscount;
        discountBy=DiscountBy.Bulk;
      }

      print("etcFromDate.text ${etcFromDate.text}");
    }
    setState(() {});
  }
}
