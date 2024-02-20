import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/screen/land_screen.dart';
import 'package:glowrpt/screen/loginsignup/LoginScrean.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
   CompanyRepository? companyrepo;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    companyrepo = Provider.of<CompanyRepository>(context);
    SharedPreferences.getInstance().then((value) {
      setState(() {
        companyrepo?.updatePreference(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return getFirstScreen();
  }

  getFirstScreen() {
    // var companyrepo = Provider.of<CompanyRepository>(context,listen: true);
    if (companyrepo?.pref == null) {
      return Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    } else if (companyrepo!.getAllUser().isNotEmpty) {
      return LandScreen();
      // return RouteMapScreen();
    } else {
      return LoginScreen();
    }
  }
}
