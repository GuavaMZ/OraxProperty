import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends ChangeNotifier {
  int splashDuration = 3000;

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

  pushToOnBoarding(BuildContext context) async {
    final bool isFirstTime = await checkFirstTime();
    if (context.mounted) {
      if (isFirstTime) {
        context.pushReplacement('/onboarding/view');
      } else {
        context.pushReplacement('/login/view');
      }
    }
    
  }
}
