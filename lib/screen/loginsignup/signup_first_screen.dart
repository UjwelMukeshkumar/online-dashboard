import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/auth/RetDetailsM.dart';
import 'package:glowrpt/model/other/SignupM.dart';
import 'package:glowrpt/screen/loginsignup/OtpVerifySignup.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/other/auth_popup_widget.dart';
import 'package:toast/toast.dart';

// Company Name
// Address
// Email
// Mobile Number

class SignupFirstScreen extends StatefulWidget {
  bool isConnectWithExistingCompany;

  SignupFirstScreen(this.isConnectWithExistingCompany);

  @override
  _SignupFirstScreenState createState() => _SignupFirstScreenState();
}

class _SignupFirstScreenState extends State<SignupFirstScreen> {
  var formKey = GlobalKey<FormState>();

  var tecCompanyName = TextEditingController();

  var tecAddress = TextEditingController();

  var tecEmial = TextEditingController();

  var tecMobileNumber = TextEditingController();

  var tecUSerName = TextEditingController();

  var tecPassword = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 10);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      space,
                      Image.asset(
                        "assets/ic_launcher.png",
                        height: 100,
                      ),
                      space,
                      TextFormField(
                        controller: tecCompanyName,
                        decoration: InputDecoration(
                            labelText: "Company Name",
                            prefixIcon: Icon(Icons.account_balance)),
                        validator: (text) => validator(text),
                      ),
                      space,
                      TextFormField(
                        controller: tecAddress,
                        decoration: InputDecoration(
                            labelText: "Address",
                            prefixIcon: Icon(Icons.subject_rounded)),
                        validator: (text) => validator(text),
                      ),
                      space,
                      TextFormField(
                        controller: tecEmial,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email", prefixIcon: Icon(Icons.email)),
                        validator: (text) => validator(text),
                      ),
                      space,
                      TextFormField(
                        controller: tecMobileNumber,
                        keyboardType: TextInputType.phone,
                        // textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: "Mobile Number",
                            prefixIcon: Icon(Icons.phone)),
                        onFieldSubmitted: (text) => moveToNext,
                        validator: (text) => validator(text),
                      ),
                      TextFormField(
                        controller: tecUSerName,
                        // keyboardType: TextInputType.phone,
                        // textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: "User Name",
                            prefixIcon: Icon(Icons.account_box)),
                        onFieldSubmitted: (text) => moveToNext,
                        validator: (text) => validator(text),
                      ),
                      TextFormField(
                        controller: tecPassword,
                        // keyboardType: TextInpu,
                        // textInputAction: TextInputAction.next,
                        obscureText: true,
                        // autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock_open)),
                        validator: (text) {
                          var exp = RegExp(
                              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])[A-Za-z\d#$@!%&*?]{8,30}$");
                          return exp.hasMatch(text!)
                              ? null
                              : "at least 8 characters\n"
                                  "at least 1 numeric character\n"
                                  "at least 1 lowercase letter\n"
                                  "at least 1 uppercase letter\n"
                                  "at least 1 special character\n";
                        },
                        onFieldSubmitted: (text) => moveToNext,
                      ),
                    ],
                  ),
                ),
              )),
              isLoading
                  ? CupertinoActivityIndicator()
                  : ElevatedButton(
                      onPressed: moveToNext, child: Text("Sing up")),
              // ElevatedButton(onPressed: posting, child: Text("Testing"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> moveToNext() async {
    Serviece.getIp();
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var singupResponse = await Serviece.signup(
          context: context,
          Address: tecAddress.text,
          Email: tecEmial.text,
          Mobile: tecMobileNumber.text,
          Organisation: tecCompanyName.text,
          PassWord: tecPassword.text,
          UserCode: tecUSerName.text,
          isConnectWithExistingCompany: widget.isConnectWithExistingCompany);
      setState(() {
        isLoading = false;
      });
      if (singupResponse != null) {
        if (widget.isConnectWithExistingCompany){
          var retDetails =
          RetDetailsM.fromJson(singupResponse["RetDetails"][0]);
          List<String> tokenList = await Serviece.getFcmTokens(
              context: context, Organisation: tecCompanyName.text);
          String deviceId =
              "fm0PClMWLEH9uvC42u_xT4:APA91bHLsPe1dvzQdOzufTElETP1o69ykOVF7sJBKJk8q5Ae6aZnNkPT7Ilj0onqP5CPrAdlWBe-kDFlxUPA1E2R7apZniFmZQ2TT0nWdGX_laN6cJgZABi-wuytUwd5MTact4UehteO";
          String deviceId2 =
              "eUy8rf4i6ExGk3ASNH6lw4:APA91bFp6GwDIgacjkCBQ_bhKe2cySHy4y3xV91qlRnOcoS_QZtgSphksOPYyesaWNSzFE-y9CnKGzTu_aNECrk7zoxfXdG3T9LRkN8_g9-Y8ucd89lohvus6fjlFcxhDw9CKoRPTNqS";

          var response = await Future.wait(tokenList
              .map((e) => Serviece.sentPushNotification(
            userName: tecUSerName.text,
            to: e,
            key1: retDetails.Key1.toString(),
            key2: retDetails.Key2.toString(),
            key3: retDetails.Key3.toString(),
            request_id: retDetails.RequestId.toString()
          ))
              .toList());
          showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Your Passkey'),
                  content: AuthPopupWidget(retDetailsM: retDetails,),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }else{
          var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpVerifySignup(
                    mobile: tecMobileNumber.text,
                  )));
          Navigator.pop(
              context, SignupM.fromJson(singupResponse["Details"][0]));
        }
      }
    }
  }

  validator(text) => text.isEmpty ? "Please enter value" : null;
}
