import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/app/shared_prefs.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  bool isPassObsecure = true;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // final supabase = Supabase.instance.client;

  late final StreamSubscription<AuthState> _authSubscription;
  User? user;

  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      final AuthResponse res = await supabase.auth
          .signInWithPassword(email: email, password: password);
      if(res.session?.accessToken != null){
        storeUserAccessToken(res.session!.accessToken);
        context.pushReplacement('/homepage');
      }
      

    } catch (e) {
      if (e is ClientException) {
        if (!context.mounted) return;
        Fluttertoast.showToast(
            msg: AppStrings.socketExceptionText.getString(context));
        context.pop();
      } else if (e is AuthException) {
        if (!context.mounted) return;
        Fluttertoast.showToast(
            msg: AppStrings.invalidCredntialText.getString(context));
        context.pop();
      }
    }
  }

  Future<void> userSignIn(
      String phone, String password, BuildContext context) async {
    try {
      final res =
          await supabase.from('users').select().match({'phone_number': phone});
      if (res.isNotEmpty) {
        if (!context.mounted) return;
        await signInWithEmail(res[0]['email'], password, context);
        storeUserFirstName(res[0]['full_name']);
        ValueHolders.isGuest == false;
        notifyListeners();
        // checkUserState(context);
      } else {
        if (!context.mounted) return;
        Fluttertoast.showToast(
            msg: AppStrings.invalidCredntialText.getString(context));
        context.pop();
      }
    } catch (e) {
      if (e is ClientException) {
        if (!context.mounted) return;
        Fluttertoast.showToast(
            msg: AppStrings.socketExceptionText.getString(context));
        context.pop();
      } else if (e is AuthException) {
        if (!context.mounted) return;
        Fluttertoast.showToast(
            msg: AppStrings.invalidCredntialText.getString(context));
        context.pop();
      }
    }
  }

  checkUserState(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // _authSubscription = supabase.auth.onAuthStateChange.listen((data) {
    // final AuthChangeEvent event = data.event;
    String? userToken = prefs.getString('userToken');
    if(userToken != null){
      if (await checkAccesToken(prefs.getString('userToken')!)) {
      ValueHolders.isGuest  = false;
      context.pushReplacement('/homepage');
    } else {
      return;
    }
    }else{
      return;
    }
    

    // final Session? session = data.session;
    // if (event == AuthChangeEvent.signedIn) {

    // }
    // });
  }

  void storeUserFirstName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userFirstName', name);
    SharedPrefs.userFirstName = name;
  }

  void storeUserAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
    
    // checkAccesToken(prefs.getString('userToken').toString());
    // SharedPrefs.userFirstName = name;
  }

  checkAccesToken(String userToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('userToken');
    if (token == null || token == "null" || token != userToken) {
      return false;
    } else if (token == userToken) {
      return true;
    }
  }

  void getUserFirstName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPrefs.userFirstName = prefs.getString('userFirstName') ?? '';
    notifyListeners();
  }
}
