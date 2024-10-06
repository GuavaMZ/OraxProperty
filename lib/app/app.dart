// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';

import 'package:oraxproperty/presentation/resources/routes_manager.dart';
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp._internal();

  int appState = 0;

  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    localization.init(mapLocales: [
      MapLocale('ar', AppStrings.AR,
          fontFamily: FontConstants.arabicFontFamily),
      MapLocale('en', AppStrings.EN, fontFamily: FontConstants.outfitFontFamily)
    ], initLanguageCode: 'ar');
    localization.onTranslatedLanguage = _onTranslatedLanguage;

    checkAndroidVersion();

    checkAppState();

    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  // var listener = InternetConnectionChecker().onStatusChange.listen((status) {
  //   switch (status) {
  //     case InternetConnectionStatus.connected:
  //       Fluttertoast.showToast(msg: 'Data connection is available.');
  //       break;
  //     case InternetConnectionStatus.disconnected:
  //       Fluttertoast.showToast(msg: 'You are disconnected from the internet.');
  //       break;
  //   }
  // });

  checkAppState() async {
    InternetConnection().onStatusChange.listen((status) {
      switch (status) {
        case InternetStatus.connected:
          Fluttertoast.showToast(msg: 'Data connection is available.');
          // AwesomeDialog(context: context, width: displayWidth(context) * 0.85)
          //     .show();
          break;
        case InternetStatus.disconnected:
          Fluttertoast.showToast(
              msg: AppStrings.noNetworkText.getString(context));

          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return const AlertDialog();
          //   },
          // );
          break;
      }
    });
  }

  checkAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    ValueHolders.androidVersion = androidInfo.version.release;
  }

  Future<bool> checkFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTime = prefs.getBool('isFirstTime');
    if (isFirstTime == null) {
      // await prefs.setBool('isFirstTime',false);
      return true;
    } else {
      return false;
    }
  }

  pushToOnBoarding() async {
    final bool isFirstTime = await checkFirstTime();
    if (isFirstTime) {
      context.pushReplacement('/onboarding/view');
    } else {
      context.pushReplacement('/login/view');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      // navigatorKey: navigatorKey,
      // theme: getApplicationTheme(),
      // onGenerateRoute: RouteGenerator.getRoute,
      // initialRoute: Routes.logOrRegRoute,
    );
  }
}
