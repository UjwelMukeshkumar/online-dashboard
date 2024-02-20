// import 'dart:io';

import 'package:background_location_tracker/background_location_tracker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/app.dart';
import 'package:glowrpt/core/local_string.dart';
// import 'package:glowrpt/model/other/User.dart';
import 'package:glowrpt/repo/DashBoardProvider.dart';
import 'package:glowrpt/repo/SettingsManagerRepository.dart';
import 'package:glowrpt/repo/SettingsPurchaseRepository.dart';
import 'package:glowrpt/repo/SettingsSalesRepository.dart';
import 'package:glowrpt/service/BackgroundLocationServiece.dart';

import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';
// import 'package:toast/toast.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'repo/Provider.dart';

// https://glowsis-dashboard.web.app
// https://glowsis-dashboard.web.app

@pragma('vm:entry-point')
void backgroundCallback() {
  BackgroundLocationTrackerManager.handleBackgroundUpdated(
    (data) async => Repo().update(data),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: (!kIsWeb)
        ? null
        : FirebaseOptions(
            apiKey: "AIzaSyClqBNJ2uahJQwyOwxxCKkgdbT4Rh2b_uY",
            appId: "1:224997907940:web:8e7b78c8965e90f1ecbbf1",
            messagingSenderId: "224997907940",
            projectId: "G-DK7DC25QW6",
          ),
  );
  await BackgroundLocationTrackerManager.initialize(
    backgroundCallback,
    config: const BackgroundLocationTrackerConfig(
      loggingEnabled: true,
      androidConfig: AndroidConfig(
        notificationIcon: 'explore',
        trackingInterval: Duration(seconds: 15),
        distanceFilterMeters: null,
        // enableNotificationLocationUpdates: true
      ),
      iOSConfig: IOSConfig(
        activityType: ActivityType.FITNESS,
        distanceFilterMeters: null,
        restartAfterKill: true,
      ),
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? pref;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        pref = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ToastContext().init(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CompanyRepository>(
              create: (_) => CompanyRepository()),
          ChangeNotifierProvider<SettingsManagerRepository>(
              create: (_) => SettingsManagerRepository(pref!)),
          ChangeNotifierProvider<SettingsSalesRepository>(
              create: (_) => SettingsSalesRepository(pref!)),
          ChangeNotifierProvider<SettingsPurchaseRepository>(
              create: (_) => SettingsPurchaseRepository(pref!)),
          ChangeNotifierProvider<BackgroundLocationServiece>(
              create: (_) => BackgroundLocationServiece()),
          ChangeNotifierProxyProvider<CompanyRepository, DashBoardRepository>(
            create: (_) => DashBoardRepository(pref!, null),
            update: (BuildContext context, comanyRepo, dashBoord) =>
                DashBoardRepository(pref!, comanyRepo),
          ),
        ],
        child: GetMaterialApp(
          title: "Glowsis Dashboard",
          debugShowCheckedModeBanner: false,
          translations: LocalString(),
          locale: Locale("en", "US"),
          theme: new ThemeData(
            // useMaterial3: true,
            primaryColor: AppColor.notificationBackgroud,

            // accentColor: AppColor.notificationBackgroud,
            secondaryHeaderColor: Colors.red,
            scaffoldBackgroundColor: AppColor.appBackground,

            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              titleTextStyle: Theme.of(context).textTheme.titleLarge,
              iconTheme: IconThemeData(
                color: AppColor.title,
              ),
            ),
            textTheme: GoogleFonts.openSansTextTheme(
                    Theme.of(context).textTheme)
                // TextTheme(
                //   subtitle1: TextStyle(color: AppColor.title, fontSize: 14),
                //   bodyText1: TextStyle(color: AppColor.title, fontSize: 14),
                //   headline6: TextStyle(color: AppColor.title, fontSize: 14),
                // )
                .copyWith(),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green,
            )
                .copyWith()
                .copyWith(primary: Colors.blue, secondary: AppColor.background),
          ),
          home: App(),
          // home: TestScreen(),
          // home: LocationTestScreenNew(),
        ));
  }
}

class Repo {
  static Repo? _instance;

  Repo._();

  factory Repo() => _instance ??= Repo._();

  Future<void> update(BackgroundLocationUpdateData data) async {
    final text = 'Location Update:zyzzzz Lat: ${data.lat} Lon: ${data.lon}';
    // ignore: avoid_print
    // sendNotification(text);
    await LocationDao().saveLocation(data);
  }
}

class LocationDao {
  static const _locationsKey = 'background_updated_locations';
  static const _locationSeparator = '-/-/-/';

  static LocationDao? _instance;

  LocationDao._();

  factory LocationDao() => _instance ??= LocationDao._();

  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async =>
      _prefs ??= await SharedPreferences.getInstance();

  Future<void> saveLocation(BackgroundLocationUpdateData data) async {
    var companyRepository = CompanyRepository();
    companyRepository.updatePreference(await prefs);

    try {
      await Serviece.insertNewLocation(
          // context: Get.context,
          //   api_key: "glowsis.database.windows.net@C521@716QGSHHVTMY128GN6DXGZGG3VOA8ITT6UF1E74V81DGRQ0C9G@57346@c9viU1cqoTCJ0TUYx8puOdx7r33735Wy3374fwSGKj7ozUfdVYQk1cwO4wA20BbLNlCTfUCqwwMzIecG4=",
          api_key: companyRepository.getSelectedApiKey(),
          lat: data.lat,
          lan: data.lon,
          accuracy: data.horizontalAccuracy);
      print("success ${data.horizontalAccuracy}");
    } catch (e) {
      print("Falied " + e.toString());
    }
/*    final moviesRef = FirebaseFirestore.instance
        .collection('Test')
        .add({"test":"test"});*/

    final locations = await getLocations();
    locations.add(
        '${DateTime.now().toIso8601String()}       ${data.lat},${data.lon}');
    await (await prefs)
        .setString(_locationsKey, locations.join(_locationSeparator));
  }

  Future<List<String>> getLocations() async {
    final prefs = await this.prefs;
    await prefs.reload();
    final locationsString = prefs.getString(_locationsKey);
    if (locationsString == null) return [];
    return locationsString.split(_locationSeparator);
  }

  Future<void> clear() async => (await prefs).clear();
}
