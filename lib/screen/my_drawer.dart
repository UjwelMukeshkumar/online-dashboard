// import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/Rpos/r_pos_screen.dart';
import 'package:glowrpt/screen/RposOrder/r_pos_order_screen.dart';
import 'package:glowrpt/screen/company_manager_screen.dart';
import 'package:glowrpt/screen/pos/pos_group_screen.dart';
import 'package:glowrpt/screen/settings/settings_manager_screen.dart';
import 'package:glowrpt/screen/transaction/ExpenceScreen.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:provider/provider.dart';
import 'consise/consise_report_screen.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  CompanyRepository? companyrepo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    companyrepo = Provider.of<CompanyRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    var user = companyrepo!.getPrimaryUser();
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.notificationBackgroud,
              ),
              currentAccountPicture: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: InkWell(
                      onTap: kDebugMode
                          ? () {
                              print(companyrepo!.getSelectedApiKey());
                            }
                          : null,
                      child: CircleAvatar(
                        radius: 200,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Text(
                            user?.username?[1] ?? "No User",textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 60, color: Colors.blue),
                          ),
                        ),
                      ),
                      // child: AvatarLetter(
                      //   size: 200,
                      //   backgroundColor: Colors.white,
                      //   backgroundColorHex: "#344234",
                      //   textColorHex: "#ffffff",
                      //   textColor: Colors.blue,
                      //   fontSize: 60,
                      //   upperCase: true,
                      //   numberLetters: 1,
                      //   letterType: LetterType.Circular,
                      //   text: user?.username ?? "No User",
                      // ),
                    ),
                  ),
                ),
              ),
              accountName: Text("${user?.username ?? "No Name"}",
                  style: TextStyle(color: Colors.white)),
              accountEmail: Text("${user?.mobile ?? "No Number"}",
                  style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout".tr),
              onTap: () {
                companyrepo!.logout();
                Navigator.pop(context);
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.trending_up),
            //   title: Text("Expense".tr),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => ExpenceScreen()));
            //   },
            // ),
            ListTile(
              leading: Icon(CupertinoIcons.rectangle_stack_fill_badge_minus),
              title: Text("Manage Company".tr),
              onTap: () {
                Navigator.pop(context);
                manageCompany();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings".tr),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsManagerScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.point_of_sale_sharp),
              title: Text("POS".tr),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PosGroupScreen()));
              },
            ),
             ListTile(
              leading: Image.asset("assets/tray.png",width: 24,height: 24,),
              title: Text("R POS".tr),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RestuarentPosScreen()));
              },
            ),
             ListTile(
               leading: Image.asset(
                "assets/menu.png",width: 24,height: 24,
              ),
            
              title: Text("R POS Order".tr),
           
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RestuarentPosOrderScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.report_gmailerrorred_outlined),
              title: Text("Concise Report".tr),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConsiseReportScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("English"),
              onTap: () {
                var locale = Locale('en', 'US');
                Get.updateLocale(locale);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("Arabic"),
              onTap: () {
                var locale = Locale('ar', 'SA');
                Get.updateLocale(locale);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> manageCompany() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CompanyManagerScreen()));
  }
}
