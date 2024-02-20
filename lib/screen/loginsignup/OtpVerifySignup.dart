import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/model/consise/ConsiceM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class OtpVerifySignup extends StatefulWidget {
  String? mobile;

  OtpVerifySignup({this.mobile});

  @override
  _OtpVerifySignupState createState() => _OtpVerifySignupState();
}

class _OtpVerifySignupState extends State<OtpVerifySignup> {
  TextEditingController controller = TextEditingController();
  String thisText = "";
  String errorMessage = "";

  bool hasError = false;
  bool showWaiting = false;

  String? otpId;
//  String errorMessage;
  @override
  void initState() {
    
    super.initState();
    sentOtp();
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
                child: Text(thisText, style: Theme.of(context).textTheme.subtitle1),
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
                    setState(() {
                      showWaiting = true;
                    });
                    var response = await Serviece.signupOtpVerify(
                        context: context,
                        Mobile: widget.mobile!,
                        OtpId: otpId!,
                        Otp: text);
                    if (response != null) {
                      Navigator.pop(context, true);
                    } else {
                      setState(() {
                        hasError = true;
                        showWaiting = false;
                        errorMessage = "Something went wrong";
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

  Future<void> sentOtp() async {
    otpId =
        await Serviece.signupOtpSent(context: context, Mobile: widget.mobile!);
  }
}
