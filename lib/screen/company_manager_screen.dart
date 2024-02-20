import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../model/other/User.dart';

import 'loginsignup/LoginScrean.dart';
import 'loginsignup/OtpVerify.dart';
import 'package:get/get.dart';

class CompanyManagerScreen extends StatefulWidget {
  CompanyManagerScreen({Key? key}) : super(key: key);

  @override
  _CompanyManagerScreenState createState() => _CompanyManagerScreenState();
}

class _CompanyManagerScreenState extends State<CompanyManagerScreen> {
  // Db db = Db.internal();

  List<User> usersList = [];

  SharedPreferences? _pref;

  bool showLoader = false;

  CompanyRepository? companyrepo;

  @override
  void initState() {

    super.initState();
    companyrepo = Provider.of<CompanyRepository>(context, listen: false);
    SharedPreferences.getInstance().then((value) => _pref = value);
    updateList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Manager".tr),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool isAdded = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen(
                        isAddToList: true,
                      )));
          if (isAdded) {
            loginRequest();
          }
        },
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Visibility(
                visible: usersList.length > 0,
                child: InkWell(
                  onTap: () {
                    loginRequest();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Please Tap here to re-login".tr,
                      style: textTheme.caption!
                          .copyWith(color: AppColor.barBlueDark),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: usersList.length,
                    itemBuilder: (context, position) {
                      var item = usersList[position];
                      return Card(
                        margin: EdgeInsets.all(12),
                        color: item.isSessionExpired == 1
                            ? AppColor.red90
                            : Colors.white,
                        // color: item.isSessionExpired==1?Colors.red:Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(item.organisation!),
                              subtitle: Text(item.username!),
                              /*     trailing: InkWell(
                                  onTap: () async {
                                    await db.deleetUserByIdentity(item.identity);
                                    updateList();
                                  },
                                  child: Icon(Icons.delete)),*/
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
          if (showLoader)
            Container(
              child: CupertinoActivityIndicator(),
              color: Colors.black26,
              height: double.infinity,
              width: double.infinity,
            ),
        ],
      ),
    );
  }

  Future loginRequest() async {
    var item = companyrepo!.getPrimaryUser();
    setState(() {
      showLoader = true;
    });

    var lastUrl = "erp_login";
    String url = "${MyKey.baseUrl}$lastUrl";
    print("url $url");
    print("user ${userToJson(item!)}");
    Map params = Map<String, String>();

    params['org'] = item.organisation;
    params['username'] = item.userCode;
    params['password'] = item.password;
    params['syskey'] = item?.syskey ?? "";
    print("params $params");
    var response = http.post(Uri.parse(url), body: params);
    response.then((result) async {
      setState(() {
        showLoader = false;
      });
      var strUser = result.body;
      print("result $strUser");
//      var user = User.fromJson(strUser);
      var user = userFromJson(strUser);
      if (user.errorNo == 0) {
        user.userCode = item.userCode;
        user.password = item.password;
        user.syskey = item.syskey;
        user.organisation = item.organisation;
        companyrepo!.updateUser(user);
        updateList();
        Toast.show("Re-login Success");
      } else if (user.errorNo == 607) {
        Toast.show("Mobile number does not exist");
      } else if (user.errorNo == 606) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => OtpVerify(
                  user: item.userCode!,
                  orgId: user.loggedOrgId.toString(),
                  organisationName: item.organisation!,
                  password: item.password!,
                )));
      } else {
        Toast.show("Invalid login details");
      }
    }).catchError((onErro) {
      setState(() {
        showLoader = false;
      });
      Toast.show(onErro.toString() + "\n " + lastUrl);

      print(onErro);
    });
  }

  void updateList() {
    setState(() {
      usersList = companyrepo!.getAllUser();
    });
  }
}
