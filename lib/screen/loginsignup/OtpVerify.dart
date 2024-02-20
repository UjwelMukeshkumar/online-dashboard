import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class OtpVerify extends StatefulWidget {
  String orgId;
  String user;
  String organisationName;
  String password;
  OtpVerify({
    required this.orgId,
    required this.user,
    required this.organisationName,
    required this.password,
  });

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  TextEditingController controller = TextEditingController();
  String thisText = "";
  String errorMessage = "";
  SharedPreferences? preferences;
  // Db db = Db.internal();
//  int pinLength = 4;

  bool hasError = false;
  bool showWaiting = false;
//  String errorMessage;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((preference) {
      this.preferences = preference;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Text(thisText,
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Verification Code",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Text(
                "Please type the verification code",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Center(
                child: PinCodeTextField(
                  autofocus: false,
                  controller: controller,
                  hideCharacter: true,
                  highlight: true,
                  highlightColor: Colors.blue,
                  defaultBorderColor: Colors.black,
                  hasTextBorderColor: Colors.green,
                  maxLength: 6,
                  hasError: hasError,
//                  maskCharacter: "😎",
                  maskCharacter: "*",

                  onTextChanged: (text) {
                    setState(() {
                      hasError = false;
                    });
                  },
                  onDone: (text) async {
                    Map params = Map();
                    params['OrgId'] = widget.orgId;
                    params['user'] = widget.user;
                    params['otp'] = text;
                    var url = MyKey.baseUrl + "getmobsyskey";
                    setState(() {
                      showWaiting = true;
                    });
                    var result =
                        await MyKey.postWithApiKey(url, params, context);
                    if (result != null) {
                      var syskey = result['SysKey'];
                      var newUser = User(
                          userCode: widget.user,
                          organisation: widget.organisationName,
                          syskey: syskey,
                          password: widget.password);
                      // db.adduser(newUser);
                      preferences!.setString(MyKey.syskey, syskey);
                      Toast.show("Otp verified");
                      Navigator.pop(context, true);
//                      Navigator.pop(context, 'Yep!');
                    } else {
                      setState(() {
                        hasError = true;
                        showWaiting = false;
                        errorMessage = "Something went wrong";
//                        errorMessageorMessage=result['message'];
                      });
                    }
                  },
                  wrapAlignment: WrapAlignment.spaceEvenly,
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                  pinTextStyle: TextStyle(fontSize: 30.0),
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                  pinBoxWidth: 40,
                ),
              ),
              Center(
                child: Visibility(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Please wait..."),
                        SizedBox(
                          width: 10,
                        ),
                        CupertinoActivityIndicator()
                      ],
                    ),
                  ),
                  visible: showWaiting,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                  visible: hasError,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
