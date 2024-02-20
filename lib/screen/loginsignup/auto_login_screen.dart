import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/loginsignup/OtpVerify.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../../app.dart';

class AutoLoginScreen extends StatefulWidget {
  @override
  State<AutoLoginScreen> createState() => _AutoLoginScreenState();
}

class _AutoLoginScreenState extends State<AutoLoginScreen> {
  Timer? timer;
  List<String> messages = [
    "Fetching Information",
    "Passing Information to Server",
    "Waiting For Response",
    "Analysing Response",
    "Retrying"
  ];

  int ticker = 0;

  CompanyRepository? companyRep;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    companyRep = Provider.of<CompanyRepository>(context, listen: false);
    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto login Attempt"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(child: Image.asset("assets/ic_launcher.png")),
          SizedBox(
            height: 50,
          ),
          Visibility(
            visible: isLoading,
            // visible: false,
            child: Text(
              "${messages[ticker % messages.length]}..",
              style: Theme.of(context).textTheme.headline6,
            ),
            replacement: Column(
              children: [
                Text("Re Login Failed"),
                TextButton(
                  onPressed: autoLogin,
                  child: Text("Retry"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void continueProcess() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted)
        setState(() {
          ticker = timer.tick;
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  Future<bool> autoLogin() async {
    setState(() {
      isLoading = true;
    });
    continueProcess();
    var item = companyRep!.getPrimaryUser();

    var lastUrl = "erp_login";
    String url = "${MyKey.baseUrl}$lastUrl";
    print("url $url");
    print("user ${userToJson(item!)}");
    Map params = Map<String, String>();

    params['org'] = item.organisation;
    params['username'] = item.userCode;
    params['password'] = item.password;
    params['syskey'] = companyRep?.getSyskey() ?? "";
    print("params $params");
    var result = await http.post(Uri.parse(url), body: params);
    var strUser = result.body;
    print("result $strUser");
//      var user = User.fromJson(strUser);
    var user = userFromJson(strUser);
    if (user.errorNo == 0) {
      user.userCode = item.userCode;
      user.password = item.password;
      user.syskey = item.syskey;
      user.organisation = item.organisation;
      companyRep!.updateUser(user);
      showToast("Re-login Success");
      timer!.cancel();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => App()));
      return true;
    } else if (user.errorNo == 607) {
      showToast("Mobile number does not exist");
      return false;
    } else if (user.errorNo == 606) {
      var otpVerified = await Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OtpVerify(
                user: item.userCode!,
                orgId: user.loggedOrgId.toString(),
                organisationName: item.organisation!,
                password: item.password!,
              )));
      if (otpVerified == true) {
        return await autoLogin();
      }
    } else {
      setState(() {
        isLoading = false;
        timer!.cancel();
      });
      showToast("Invalid login details");
      return false;
    }
    return false;
  }
}
