import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/SignupM.dart';
import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/loginsignup/signup_first_screen.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'OtpVerify.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  bool isAddToList;

  LoginScreen({this.isAddToList = false});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form_key = GlobalKey<FormState>();
  final _tec_companyName = TextEditingController();
  final _ted_userName = TextEditingController();
  final _tec_password = TextEditingController();

  final _focus_node_companyName = FocusNode();
  final _focus_node_userName = FocusNode();
  final _focus_node_password = FocusNode();
  bool _rememberMe = false;
  SharedPreferences? _preferences;

  bool? isHide;

  CompanyRepository? companyrepo;

  // Db db = Db.internal();
  @override
  void initState() {
    super.initState();
    isHide = true;

    SharedPreferences.getInstance().then((preference) {
      _preferences = preference;

      _tec_companyName.text = _preferences?.getString(MyKey.org) ?? "";
      _ted_userName.text = _preferences?.getString(MyKey.username) ?? "";
      _tec_password.text = _preferences?.getString(MyKey.password) ?? "";
      var savedRemember = _preferences!.getBool(MyKey.rememberMe);
      _rememberMe = savedRemember == null ? false : savedRemember;
      setState(() {});

      // if (kDebugMode) {
      //   _tec_companyName.text = 'testDb';
      //   _ted_userName.text = 'hrShamsu';
      //   _tec_password.text = 'Shamsu@987';
      // }

         if (kDebugMode) {
        _tec_companyName.text = 'abcd ltd';
        _ted_userName.text = 'hakeem';
        _tec_password.text = 'User@3424';
      }

    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    companyrepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.isAddToList ? "Add Company" : "Login"),
      ),
      body: Center(
        child: Form(
            key: _form_key,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        _tec_companyName.text = 'Edu clt';
                        _ted_userName.text = 'ConnectedCMP';
                        _tec_password.text = 'CMP@456';
                      }
                    },
                    child: FractionallySizedBox(
                      child: Image.asset("assets/logo.jpg"),
                      widthFactor: .3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "LOGIN",
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (text) {
                      changeFocut(
                          _focus_node_companyName, _focus_node_userName);
                    },
                    focusNode: _focus_node_companyName,
                    controller: _tec_companyName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter company name".tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.work),
                        hintText: "Company Name".tr,
                        labelText: "Company Name".tr),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (text) {
                      changeFocut(_focus_node_userName, _focus_node_password);
                    },
                    focusNode: _focus_node_userName,
                    controller: _ted_userName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter user name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.verified_user),
                        hintText: "User Name".tr,
                        labelText: "User Name".tr),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.send,
                    onFieldSubmitted: (context) {
                      loginRequest();
                    },
                    focusNode: _focus_node_password,
                    controller: _tec_password,
                    obscureText: isHide!,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: "password".tr,
                      labelText: "Password".tr,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHide = !isHide!;
                          });
                        },
                        icon: Icon(
                            isHide! ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, top: 6),
                    child: CheckboxListTile(
                      value: _rememberMe,
                      title: Text("Remember Me"),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: .3,
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_form_key.currentState!.validate()) {
                          if (widget.isAddToList) {
                            addNewCompany();
                          } else {
                            loginRequest();
                          }
                        }
                      },
                      child: Text('Login'),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        SignupM signupM = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignupFirstScreen(false)));
                        if (signupM != null) {
                          _tec_companyName.text = signupM.Organisation;
                          _tec_password.text = signupM.Password;
                          _ted_userName.text = signupM.UserName;
                        }
                      },
                      child: Text("Create New Company")),
                  TextButton(
                      onPressed: () async {
                        SignupM signupM = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupFirstScreen(true)));
                        if (signupM != null) {
                          _tec_companyName.text = signupM.Organisation;
                          _tec_password.text = signupM.Password;
                          _ted_userName.text = signupM.UserName;
                        }
                      },
                      child: Text("Connect with existing company")),
                ],
              ),
            )),
      ),
    );
  }

  Future loginRequest() async {
    //BuildConfig.DEBUG?"QFX8CV2H1LIPBMUMOGONO8FXQ2NDOZIR5JXIZ6NTQI0EDS9HT697S1E7LSE01461UUINXKNE3K06GW8BVY81AFH83GDSE508XDHQ4GIKOSCAHWAF4MBFBQGD54AI0FUWXTCYGKHF8JRQM5SSGL599RH8K6QKQS4RC9FEDGRJZ7UDC2M28RY2DI5BERWNRP465EEFSR7H8507TTEI1F0KN2A0KP75HMP0UZE90A8KBEVWQW6BEVYS4PT5ZHZ35W88XZH0HTCOXSW2SW0VEB8DIFW6JPRAOIIUEECAS2WAIJNQ":

    var lastUrl = "erp_login";
    String url = "${MyKey.baseUrl}$lastUrl";
    print("url $url");
    Map params = Map();
    var org = _tec_companyName.text;
    params['org'] = org;
    var userId = _ted_userName.text;
    params['username'] = userId;
    params['password'] = _tec_password.text;
    // User user= await db.getUserByIdentity(org+userId);
    var sysKey = _preferences?.getString(MyKey.syskey);
    // var sysKey = user?.syskey??"";
    // params['syskey'] = user?.syskey??"";
    params['syskey'] = sysKey ?? "";
    print("params $params");
    var response = http.post(Uri.parse(url), body: params);
    response.then(
      (result) async {
        var strUser = result.body;
        print("result $strUser");
//      var user = User.fromJson(strUser);
        var user = userFromJson(strUser);
        if (user.errorNo == 0) {
          //_preferences.setString(MyKey.user, user.toJsonString());
          _preferences?.setBool(MyKey.rememberMe, _rememberMe);
          if (_rememberMe) {
            _preferences?.setString(MyKey.org, org);
            _preferences?.setString(MyKey.username, userId);
            _preferences?.setString(MyKey.password, _tec_password.text);
          } else {
            _preferences?.setString(MyKey.org, "");
            _preferences?.setString(MyKey.username, "");
            _preferences?.setString(MyKey.password, "");
          }
          _preferences?.setString(
              org + userId + MyKey.passwordUserBase, _tec_password.text);
          _preferences?.setString(
              org + userId + MyKey.userNameUserBase, userId);
          user.userCode = userId;
          user.password = _tec_password.text;
          user.syskey = sysKey;
          companyrepo?.updateUser(user);
          // await db.adduser(user);
          /*Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LandScreen()));*/
        } else if (user.errorNo == 607) {
          showToast("Mobile number does not exist");
        } else if (user.errorNo == 606) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => OtpVerify(
                    user: userId,
                    orgId: user.loggedOrgId.toString(),
                    organisationName: org,
                    password: _tec_password.text,
                  )));
        } else {
          showToast("Invalid login details");
        }
        // }).catchError(
        //   (onErro) {
        //     showToast(onErro.toString() + "\n " + lastUrl);

        //     print(onErro);
      },
    );
  }

  changeFocut(FocusNode currentFocusNode, FocusNode nextFocusNod) {
    FocusScope.of(context).requestFocus(nextFocusNod);
    currentFocusNode.unfocus();
  }

  Future<void> addNewCompany() async {
    var user = companyrepo!.getPrimaryUser();
    var response = await Serviece.addMoreCompany(
        context: context,
        api_key: user!.apiKey,
        OrgName: user.organisation!,
        branchOrg: _tec_companyName.text,
        branchUser: _ted_userName.text,
        branchPwd: _tec_password.text);
    if (response != null) {
      Navigator.pop(context, true);
    }
  }
}
