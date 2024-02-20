// import 'package:cached_network_image/cached_network_image.dart';

import 'dart:convert';

// import 'package:avatar_letter/avatar_letter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/DashBoardProvider.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/repo/SettingsManagerRepository.dart';
import 'package:glowrpt/screen/bar_code_screen.dart';
import 'package:glowrpt/screen/my_drawer.dart';
import 'package:glowrpt/screen/route/employee/route_summary_screen.dart';
import 'package:glowrpt/screen/route/select_route_screen1.dart';
import 'package:glowrpt/screen/settings/settings_purchase_screen.dart';
import 'package:glowrpt/screen/settings/settings_sales_screen.dart';
import 'package:glowrpt/service/FirebaseServiece.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:glowrpt/screen/settings/settings_manager_screen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/SearchBox.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../app.dart';
import 'dashboards/account_dash_board_widget.dart';
import 'dashboards/employee_dash_board_widget.dart';
import 'dashboards/hrm_dash_board_widget.dart';
import 'dashboards/manager_dash_board_widget.dart';
import 'dashboards/purchase_dash_board_widget.dart';
import 'dashboards/sales_dash_board_widget.dart';
import 'notification/notification_page.dart';
import 'package:get/get.dart';

class LandScreen extends StatefulWidget {
  @override
  _LandScreenState createState() => _LandScreenState();
}

class _LandScreenState extends State<LandScreen> {
  // Db db = Db.internal();

  User? useer;

  User? _selectedItem;

  List<User> usersList = [];

  var date = DateTime.now();
  List<String>? dateListLine;
  List<String>? dateListHeader;
  var dateFormater = DateFormat("dd/MM/yyyy");

  //

  int tabPosition = 0;

  CompanyRepository? companyRep;

  SettingsManagerRepository? settings;

  String? arryApiKey;

  DashBoardRepository? dashBoardRepo;

  String dtRange = "Today";

  var response;

  @override
  void initState() {
    super.initState();
    companyRep = Provider.of<CompanyRepository>(context, listen: false);

    getFcmToken();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    settings = Provider.of<SettingsManagerRepository?>(context);
    dashBoardRepo = Provider.of<DashBoardRepository?>(context);

    var today = "Today, ${date.day} ${DateFormat("MMM").format(date)}";
    var _dateListLine = [
      dateFormater.format(date),
      today,
      dateFormater.format(date)
    ];
    dateListLine = _dateListLine;
    dateListHeader = _dateListLine;
    usersList = companyRep!.getAllUser();
    print('$usersList');
    print(
        "***********************************************************************************************");
    print("Api_Key= ${companyRep?.getSelectedApiKey()}");
    print(
        "***********************************************************************************************");
  }

  double iconSize = 30;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // companyRep = Provider.of<CompanyRepository>(context, listen: false);
    var textTheme = Theme.of(context).textTheme;

    // var space = SizedBox(height: 36);
    _selectedItem = companyRep?.getSelectedUser();
    return
        // companyRep.
        Scaffold(
      key: scaffoldKey,
      // backgroundColor: AppColor.barBlueLigt,

      drawer: MyDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton:
          dashBoardRepo?.dashBoards == DashBoardType.RoutesDashboard
              ? null
              : Container(
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.black12, width: 1)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (settings!.scanbarCode)
                            IconButton(
                              onPressed: () async {
                                var barcodeScanRes =
                                    await FlutterBarcodeScanner.scanBarcode(
                                        "#000000",
                                        "Cancel",
                                        true,
                                        ScanMode.BARCODE);
                                print(barcodeScanRes != "-1");
                                if (barcodeScanRes != "-1")
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BarCodeScreen(
                                              barcodeScanRes,
                                              _selectedItem!.apiKey)));
                              },
                              icon: Image.asset('assets/icons/barcode.png'),
                              color: AppColor.title,
                            ),
                          // SearchBox(),
                          SearchBox(
                            onItemSelect: (item) {
                              // Do something with the selected item
                            },
                          ),

                          IconButton(
                            onPressed: hardRefresh,
                            icon: Icon(Icons.refresh),
                            color: AppColor.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
      body: SafeArea(
        child: Container(
          color: CardProperty.color,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: ListTile(
                    title: PopupMenuButton<User>(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dashBoardRepo?.getTitle() ?? "Select Dashboard".tr,
                            // "test",
                            style: textTheme.subtitle2,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${_selectedItem?.organisation}",
                            style: textTheme.caption,
                          )
                        ],
                      ),
                      onSelected: (e) {
                        print("Select companyu");
                        _selectedItem = e;
                        companyRep?.updateSelectedUser(_selectedItem!);
                        hardRefresh();
                        // refreshAllData();
                      },

                      padding: EdgeInsets.zero,
                      // initialValue: choices[_selection],
                      itemBuilder: (BuildContext context) => usersList.map((e) {
                        return PopupMenuItem<User>(
                          value: e,
                          child: Container(
                            // padding: EdgeInsets.all(22),
                            child: ListTile(
                              title: Text(e.organisation ?? ""),
                              contentPadding: EdgeInsets.all(8),
                              horizontalTitleGap: 0,
                              subtitle: Text(e.username ?? ""),
                              leading: Container(
                                  height: double.infinity,
                                  child: Icon(
                                    Icons.account_balance,
                                    color: AppColor.title,
                                  )),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    leading: InkWell(
                      onTap: () => scaffoldKey.currentState?.openDrawer(),
                      child: CircleAvatar(
                        backgroundColor: AppColor.notificationBackgroud,
                        child: Center(
                          child: Text(
                            "${_selectedItem?.username?[0] ?? ""}",
                            style: TextStyle(fontSize: 23),
                          ),
                        ),

                        // child: Text(
                        //   "${_selectedItem?.username ?? ""}",
                        //   style: TextStyle(color: Colors.white, fontSize: 23),
                        // ),
                      ),
                      // child: AvatarLetter(
                      //   backgroundColor: AppColor.notificationBackgroud,
                      //   textColor: Colors.white,
                      //   fontSize: 23,
                      //   upperCase: true,
                      //   numberLetters: 2,
                      //   letterType: LetterType.Circular,
                      //   text: '${_selectedItem?.username ?? " "}',
                      // ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                if (dashBoardRepo!.dashBoards ==
                                    DashBoardType.MangerDashboard)
                                  return SettingsManagerScreen();
                                if (dashBoardRepo?.dashBoards ==
                                    DashBoardType.SalesDashboard)
                                  return SettingsSalesScreen();
                                if (dashBoardRepo?.dashBoards ==
                                    DashBoardType.PurchaseDashboard)
                                  return SettingsPurchaseScreen();
                                return SettingsManagerScreen();
                              }));
                            },
                            icon: Icon(
                              Icons.settings,
                              color: AppColor.title,
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationPage()));
                          },
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Stack(
                              children: [
                                /*  Align(
                                    child: Icon(
                                      Icons.add_comment_sharp,
                                      color: AppColor.notificationBackgroud,
                                    ),
                                    alignment: Alignment(-0.3, 0.2),
                                  ),*/
                                Center(
                                    child: Icon(
                                  Icons.message,
                                  color: AppColor.title,
                                )),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      margin: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(
                                              "Choose Dashboard".tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          if (companyRep!.hasEmployeeDB()) ...[
                                            ListTile(
                                              leading:
                                                  new Icon(Icons.work_outline),
                                              title: new Text(
                                                  'Employee Dashboard'.tr),
                                              onTap: () {
                                                dashBoardRepo?.dashBoards =
                                                    DashBoardType
                                                        .EmployeeDashboard;
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Divider(
                                              height: 0,
                                            )
                                          ],
                                          if (companyRep!.hasSalesDB()) ...[
                                            ListTile(
                                              leading: Image.asset(
                                                "assets/icons/sale.png",
                                                height: 24,
                                              ),
                                              title: new Text(
                                                  'Sales Dashboard'.tr),
                                              onTap: () {
                                                dashBoardRepo?.dashBoards =
                                                    DashBoardType
                                                        .SalesDashboard;
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Divider(
                                              height: 0,
                                            )
                                          ],
                                          if (companyRep!.hasPurchaseDB()) ...[
                                            ListTile(
                                              leading: Image.asset(
                                                "assets/icons/purchase.png",
                                                height: 24,
                                              ),
                                              title: new Text(
                                                  'Purchase Dashboard'.tr),
                                              onTap: () {
                                                dashBoardRepo?.dashBoards =
                                                    DashBoardType
                                                        .PurchaseDashboard;
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Divider(
                                              height: 0,
                                            )
                                          ],
                                          if (companyRep!.hasAccountDB()) ...[
                                            ListTile(
                                              leading: Image.asset(
                                                  "assets/icons/cash_bank.png",
                                                  height: 24),
                                              title: new Text(
                                                  'Accounts Dashboard'.tr),
                                              onTap: () {
                                                dashBoardRepo?.dashBoards =
                                                    DashBoardType
                                                        .AccountsDashboard;
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Divider(
                                              height: 0,
                                            )
                                          ],
                                          if (companyRep!.hasHRMDB())
                                            ListTile(
                                              leading: new Icon(
                                                  Icons.manage_accounts),
                                              title:
                                                  new Text('HRM Dashboard'.tr),
                                              onTap: () {
                                                dashBoardRepo?.dashBoards =
                                                    DashBoardType.HRMDashboard;
                                                Navigator.pop(context);
                                              },
                                            ),
                                          Divider(
                                            height: 0,
                                          ),
                                          if (companyRep!.hasMangerDB())
                                            ListTile(
                                              leading:
                                                  new Icon(Icons.account_box),
                                              title: new Text(
                                                  'Manager Dashboard'.tr),
                                              onTap: () {
                                                dashBoardRepo?.dashBoards =
                                                    DashBoardType
                                                        .MangerDashboard;
                                                Navigator.pop(context);
                                              },
                                            ),
                                          Divider(
                                            height: 0,
                                          ),
                                          if (companyRep!.hasStakeholder())
                                            ListTile(
                                              leading: new Icon(Icons
                                                  .supervised_user_circle_outlined),
                                              title: new Text('Stakeholder'.tr),
                                              onTap: () {
                                                dashBoardRepo?.dashBoards =
                                                    DashBoardType.Stakeholder;
                                                Navigator.pop(context);
                                              },
                                            ),
                                          Divider(
                                            height: 0,
                                          ),
                                          if (companyRep!.hasRTMDB())
                                            ListTile(
                                              leading:
                                                  new Icon(Icons.account_box),
                                              title: new Text(
                                                  'Routes Dashboard'.tr),
                                              onTap: () {
                                                dashBoardRepo?.dashBoards =
                                                    DashBoardType
                                                        .RoutesDashboard;
                                                Navigator.pop(context);
                                              },
                                            ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.apps,
                              color: AppColor.title,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    if (dashBoardRepo?.dashBoards ==
                        DashBoardType.EmployeeDashboard) ...[
                      EmployeeDashBoardWidget()
                    ],
                    if (dashBoardRepo?.dashBoards ==
                        DashBoardType.SalesDashboard) ...[SalesDashBoards()],

                    if (dashBoardRepo?.dashBoards ==
                        DashBoardType.Stakeholder) ...[
                      SalesDashBoards(
                        isSatakeHolder: true,
                      )
                    ],
                    if (dashBoardRepo?.dashBoards ==
                        DashBoardType.PurchaseDashboard) ...[
                      PurchaseDashBoards()
                    ],
                    if (dashBoardRepo?.dashBoards ==
                        DashBoardType.AccountsDashboard) ...[
                      AccountDashBoardWidget(settings!)
                    ],
                    if (dashBoardRepo?.dashBoards ==
                        DashBoardType.HRMDashboard) ...[HrmDashBoardWidget()],
                    if (dashBoardRepo?.dashBoards ==
                        DashBoardType.MangerDashboard) ...[
                      ManagerDashBoardWidget()
                    ],
                    if (dashBoardRepo?.dashBoards ==
                        DashBoardType.RoutesDashboard) ...[
                      SelectRouteScreen1()
                    ],

                    // AppCard(
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 8),
                    //     child: Column(
                    //       children: [
                    //         ListTile(
                    //           onTap: inProgress,
                    //           leading: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(
                    //                 Icons.video_call_outlined,
                    //                 color: AppColor.title,
                    //               ),
                    //             ],
                    //           ),
                    //           title: Text("Training Videos".tr),
                    //           subtitle:
                    //               Text("Watch Videos on how to use the App".tr),
                    //         ),
                    //         Divider(height: 0, indent: 70, endIndent: 20),
                    //         ListTile(
                    //           onTap: inProgress,
                    //           leading: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(
                    //                 Icons.fullscreen,
                    //                 color: AppColor.title,
                    //               ),
                    //             ],
                    //           ),
                    //           title: Text("24X7 Help".tr),
                    //           subtitle: Text(
                    //               "Get quick answer to all your business related queries"
                    //                   .tr),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Divider(indent: 70),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  inProgress() {
    Toast.show("In Progress".tr);
  }

  void refreshAllData() {
    var date = DateTime.now();
    var today = "Today, ${date.day} ${DateFormat("MMM").format(date)}";
    var _dateListLine = [
      dateFormater.format(date),
      today,
      dateFormater.format(date)
    ];
    dateListLine = _dateListLine;
    dateListHeader = _dateListLine;
    // print("ApiKey ${_selectedItem.apiKey}");
    // updateHeadder();
    // updateReceivablePayableCash();
    // call notifiy change listener
  }

  void hardRefresh() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => App()));
  }

  Future<void> getFcmToken() async {
    if (kIsWeb) return;
    var token = await FirebaseMessaging.instance.getToken();
    print("Fcm token ${token}");
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        print("getInitialMessage ${event.data}");
        // showAlert(event, context);
      }
    });
    FirebaseMessaging.onMessage.listen((event) {
      print("onMessage ${event.data}");
      showAlert(event, context);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("onMessageOpenedApp ${event.data}");
      showAlert(event, context);
    });
    //FirebaseMessaging.onBackgroundMessage((message) => showAlert(message));

    fcmIOSpart();
    Serviece.insertFcmToken(
        api_key: companyRep!.getSelectedApiKey(),
        context: context,
        token: token!);
    // companyRep
  }

  Future<void> fcmIOSpart() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
  }

  Future<void> showAlert(RemoteMessage event, BuildContext buildContext) async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        var textTheme = Theme.of(context).textTheme;
        return Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    event.notification!.title!,
                    style: textTheme.headline6,
                  ),
                ),
                Text(event.notification!.body!),
                SizedBox(
                  height: 8,
                ),
                if (event.data["type"] != PushNotificationType.LoginRequest &&
                    event.data["type"] != PushNotificationType.addNewCustomer &&
                    event.data["type"] !=
                        PushNotificationType.changeRouteActiveState) ...[
                  Column(
                    children: [
                      event.data["key_1"],
                      event.data["key_2"],
                      event.data["key_3"],
                      "-1"
                    ].map((e) {
                      var isDeny = e == "-1";
                      return InkWell(
                        onTap: () {
                          numberOptionTaped(e, isDeny, event, buildContext);
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    !isDeny ? e.toString() : "Deny",
                                    style: textTheme.headline6!.copyWith(
                                        color: isDeny
                                            ? AppColor.negativeRed
                                            : AppColor.positiveGreen),
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            Divider(height: 0)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ] else ...[
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                              ),
                              onPressed: () {
                                yesOrNoRequest(event.data, isApproved: false);
                              },
                              child: Text("Reject".tr)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ElevatedButton(
                              onPressed: () {
                                yesOrNoRequest(event.data, isApproved: true);
                              },
                              child: Text("Accept".tr)),
                        ),
                      )
                    ],
                  ),
                ],
                SizedBox(
                  height: 18,
                )
              ],
            ),
          ],
        );
      },
    );
  }

  void numberOptionTaped(
      e, bool isDeny, RemoteMessage event, BuildContext buildContext) {
    User user;
    if (DateTime.now().difference(event.sentTime!).inMinutes > 1) {
      return;
    }

    if (event.data["type"] == PushNotificationType.salesPurchaseEdit) {
      int orgId = int.parse(event.data["org_id"].toString());
      user = companyRep!.getUserByOrgId(orgId)!;
      if (user == null) {
        Toast.show("Corresponding login not fount1");
        return;
      }
    } else {
      //User Creation
      user = companyRep!.getPrimaryUser()!;
    }
    Serviece.approveRequest(
      context: buildContext,
      api_key: user.apiKey.toString(),
      PassKey: e,
      org_id: user.orgId.toString(),
      requestId: event.data["request_id"],
      type: event.data["type"],
    );
    Navigator.pop(context);
  }

  Future<void> yesOrNoRequest(Map<String, dynamic> data,
      {required bool isApproved}) async {
    var type = data["type"];
    if (type == PushNotificationType.addNewCustomer ||
        type == PushNotificationType.changeRouteActiveState) {
      var decode = json.decode(data["RequestDetails"])[0];
      print(decode);
      String requestId = decode["RequestID"].toString();
      var user = companyRep!.getUserByOrgId(decode["Org_Id"]);
      if (user == null) {
        Toast.show("Corresponding login not fount3");
        return;
      }
      response = await Serviece.changeUserRequestStatus(
          api_key: user.apiKey,
          context: context,
          RequestId: requestId,
          Status: isApproved ? "Y" : "N",
          RequestType: type);
    } else {
      var user = companyRep!.getUserByOrgName(data["OrgName"]);
      if (user == null) {
        Toast.show("Corresponding login not fount2");
        return;
      }
      response = await Serviece.acceptLoginRequest(
          context: context,
          api_key: user.apiKey,
          orgId: data["OrgName"],
          userCode: data["UserCode"],
          requestId: data["request_id"],
          isApproved: isApproved);
    }

    if (response != null) {
      Toast.show(isApproved ? "Accepted".tr : "Rejected".tr);
      Navigator.pop(context);
    }
  }
}
