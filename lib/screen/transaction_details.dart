import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:glowrpt/model/DocumentSplitter.dart';
import 'package:glowrpt/model/other/LedgerM.dart';
import 'package:glowrpt/model/other/TDetailsM.dart';
import 'package:glowrpt/model/other/THeadderM.dart';
import 'package:glowrpt/print/PdfApi.dart';
// import 'package:glowrpt/print/PdfServiece.dart';



import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/create_new_party.dart';
import 'package:glowrpt/screen/sales_documents_screen.dart';
import 'package:glowrpt/service/DateService.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/date/days_selector_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:toast/toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:get/get.dart';

import 'dashboards/sales/pending_bills_list.dart';

class TransactionDetails extends StatefulWidget {
  String id;
  String type;
  String apiKey;
  String fromDate;
  String todate;
  String title;
  String? RecNum;
  String? Sequence;
  String? InitNo;

  TransactionDetails({
    required this.id,
    required this.type,
    required this.apiKey,
    required this.fromDate,
    required this.todate,
    required this.title,
   this.RecNum,
   this.Sequence,
   this.InitNo,
  });

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails>
    with SingleTickerProviderStateMixin {
   THeadderM? hedder;

  List<TDetailsM> detailsList = [];

  bool isLoading = false;

  String qyery = "";

   List<TDetailsM>? fullList;

  var list = ["Ask Details"];
   String? _selected;
  var tabController;
  ScreenshotController screenshotController = ScreenshotController();

   CompanyRepository? compRepo;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    getTransaction();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      /*     floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),*/
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 16),
            // height: 200,
            color: AppColor.background,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppBar(
                    leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Card(
                        elevation: 4,
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColor.title,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(44)),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    title: InkWell(
                      onTap: openEditPartyScreen,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          // widget.ledgerM.getLeadingTitle()??"",
                          hedder?.name ?? "",
                          style: TextStyle(fontSize: 14),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: openEditPartyScreen,
                          icon: Icon(
                            Icons.edit_outlined,
                            color: AppColor.vyaparIcon,
                          ))
                    ],
                  ),
                ),
                Card(
                  elevation: 6,
                  child: ListTile(
                    title: Text(widget.title),
                    subtitle: Text(MyKey.currencyFromat(
                        // widget.ledgerM.balance.toString(),
                        hedder?.closingBalance.toString() ?? "0",
                        decimmalPlace: 0)),
                    leading: Transform.rotate(
                        angle: -2.5,
                        child: Icon(
                          Icons.arrow_circle_up_outlined,
                          color: AppColor.positiveGreen,
                          size: 40,
                        )),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          child: InkWell(
                            onTap: () => shareNotification(hedder!, textTheme),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.notifications_active_outlined),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: DaysSelectorWidget(
                            valueChanged: (list) {
                              widget.fromDate = list.first;
                              widget.todate = list.last;
                              getTransaction();
                            },
                            intialText: "Select date".tr,
                            hideTriling: true,
                            dateTypes: DateService.dateTypesYearBased,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12, right: 12, left: 12),
            height: 65,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search Transactions".tr,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.black45)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.black45))),
              onChanged: (text) {
                qyery = text.toLowerCase();
                appLayFilter();
              },
            ),
          ),
          /*   ElevatedButton(onPressed: (){
            Serviece.getPendingBills(context: context,
                api_key: widget.apiKey,
                pageNo: "1",
                code: widget.id);
          }, child: Text("Get tata test")),*/
          if (["C", "S"].contains(widget.type))
            Expanded(
                child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.blue,
                  labelColor: Colors.blue,
                  unselectedLabelStyle: TextStyle(color: Colors.grey),
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                    controller: tabController,
                    tabs: ["Transaction".tr, "Pending Bills".tr]
                        .map((e) => Tab(
                              child: Text(e),
                            ))
                        .toList()),
                Expanded(
                  child: TabBarView(controller: tabController, children: [
                    LedgerList(
                      apiKey: widget.apiKey,
                      type: widget.type,
                      id: widget.id,
                      detailsList: detailsList,
                      isLoading: isLoading,
                      hedder: hedder,
                    ),
                    PendingBillsList(
                      code: widget.id,
                    )
                  ]),
                )
              ],
            ))
          else
            Expanded(
              child: LedgerList(
                apiKey: widget.apiKey,
                type: widget.type,
                id: widget.id,
                detailsList: detailsList,
                isLoading: isLoading,
                hedder: hedder,
              ),
            )
        ],
      ),
    );
  }

  Future<void> getTransaction() async {
    setState(() {
      isLoading = true;
    });
    var data = await Serviece.getTrasaction(context, widget.apiKey, widget.id,
        widget.fromDate, widget.todate, widget.type, "1"); //pageNo
    isLoading = false;
    hedder = THeadderM.fromJson(data["Header"][0]);
    List details = data["Details"];
    fullList = details.map((e) => TDetailsM.fromJson(e)).toList();
    appLayFilter();
  }

  void appLayFilter() {
    detailsList.clear();
    if (qyery.isEmpty) {
      detailsList.addAll(fullList!);
    } else {
      detailsList.addAll(fullList!.where(
          (element) => element.toString().toLowerCase().contains(qyery)));
    }
    setState(() {});
  }

  void openEditPartyScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateNewParty(
                  code: hedder?.code,
                )));
  }

  shareNotification(THeadderM hedder, TextTheme textTheme) {
    screenshotController
        .captureFromWidget(
            SizedBox(
              width: 300,
              height: 230,
              child: Scaffold(
                body: Container(
                    height: 230,
                    // padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 52,
                          padding: EdgeInsets.all(8),
                          color: AppColor.barBlueDark,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.notifications_active_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${compRepo?.getSelectedUser().organisation}",
                                    style: textTheme.bodyText1!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "${compRepo?.getSelectedUser().companyEmail}",
                                    style: textTheme.bodyText2!
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 178,
                          width: double.infinity,
                          color: AppColor.backgroundDark,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Self Payment Reminder",
                                style: textTheme.headline6,
                              ),
                              SizedBox(height: 8),
                              Text(
                                MyKey.currencyFromat(
                                    hedder.closingBalance.toString() ?? "0"),
                                style: textTheme.headline6!
                                    .copyWith(color: AppColor.red91),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "As of ${MyKey.getCurrentDate()}",
                                style: textTheme.subtitle1,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  children: [
                                    Text("Sent via"),
                                    SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                            "assets/ic_launcher.png"))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
            context: context,
            delay: Duration(seconds: 2))
        .then((image) async {
      if (image != null) {
        // final directory = await getApplicationDocumentsDirectory();
        final directory = await getExternalStorageDirectory();
        final imagePath = await File('${directory!.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        /// Share Plugin
        await FlutterShare.shareFile(
            title: 'Example share',
            text: """
            Hi,
It's a friendly reminder to you for paying ${MyKey.currencyFromat(hedder.closingBalance?.toString() ?? "0")} to me.

Thank you,
${compRepo!.getSelectedUser().organisation}
            """,
            filePath: imagePath.path,
            fileType: 'image/png',
            chooserTitle: 'Example Chooser Title');
      }
    });
  }
}

class LedgerList extends StatefulWidget {
  bool isLoading;
  String apiKey;
  List<TDetailsM> detailsList;
  String id;
  String type;
  THeadderM? hedder;

  LedgerList({
    required this.isLoading,
    required this.apiKey,
    required this.detailsList,
    required this.id,
    required this.type,
     this.hedder,
  });

  @override
  State<LedgerList> createState() => _LedgerListState();
}

class _LedgerListState extends State<LedgerList> {
   CompanyRepository? compRepo;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      child: !widget.isLoading
          ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.detailsList.length,
              // separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, postion) {
                var item = widget.detailsList[postion];
                var document = DocumentSplitter(document: item.Document);
                if (item.balance == 0) {
                  return Container();
                }
                return InkWell(
                  onTap: () async {
                    if (item.category == "Opening Balance" ||
                        item.category == "Future Transactions") {
                      Toast.show("Extracting ");
                      var list = await Serviece.getOpeningBalanceDetails(
                          context: context,
                          api_key: widget.apiKey,
                          code: widget.id,
                          fromdate: item.date,
                          type: widget.type,
                          category: item.category);
                      widget.detailsList.remove(item);
                      widget.detailsList.insertAll(postion, list);
                      setState(() {});
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesDocumentsScreen(
                                    type: item.Source_Type,
                                    Sequence: document.sequence,
                                    InitNo: document.initNumber,
                                    RecNum: document.recNo,
                                  )));
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // color: AppColor.chartBacground,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(child: Text(item.category)),
                                  Text("#${item.rowNum}",
                                      style: textTheme.caption),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Visibility(
                                        child: Text(
                                            "${item.Document.toString()}  ",
                                            style: textTheme.caption),
                                      ),
                                      Text(
                                          "${MyKey.currencyFromat(item.balance.toString(), decimmalPlace: 0)}")
                                    ],
                                  ),
                                  Text(
                                    "${DateFormat("dd MMM").format(DateFormat("dd/MM/yyyy").parse(item.date))}",
                                    style: textTheme.caption,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Balance: ${MyKey.currencyFromat(item.RunningTotal.toString(), decimmalPlace: 0)}")
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Visibility(
                                        visible:
                                            item.category != "Opening Balance",
                                        child: IconButton(
                                            onPressed: () => printDetails(
                                                widget.hedder!, item),
                                            icon: Icon(
                                              Icons.print,
                                              color: Colors.black45,
                                            )),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          // onPressed: () =>
                                          //     shareDetails(widget.hedder, item),
                                          icon: Icon(
                                            Icons.share,
                                            color: Colors.black45,
                                          )),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.black45,
                                        ),
                                        padding:
                                            EdgeInsets.only(left: 8, right: 0),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }

  Future<void> printDetails(THeadderM headderM, TDetailsM detailsM) async {
    String? criptString = await Serviece.getCriptString(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        fullDocument: detailsM.Document,
        DocumentNumber: detailsM.DocumentNo.toString());
    var docSplitter = DocumentSplitter(document: detailsM.Document);
    String printUrl =
        "https://print.glowsis.com/p?t=${detailsM.DocumentNo}-${compRepo!.getSelectedUser().orgId}-$criptString";
    final Uri _url = Uri.parse(printUrl);
    launchUrl(_url, mode: LaunchMode.externalApplication);
    // PdfApi.printPdf(PdfService.generateTransactionPdf(
    //     headderM: headderM,
    //     detailsM: detailsM,
    //     user: compRepo.getSelectedUser()));
  }
}
