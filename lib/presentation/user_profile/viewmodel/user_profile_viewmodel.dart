import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/data/api-request/get_user_details.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileViewModel extends ChangeNotifier {
  bool isLoading = false;
  int? userRule;

  List<String> buttonsNames = [
    AppStrings.updateProfileText,
    AppStrings.myadsText,
    AppStrings.verifyAccountText,
    AppStrings.changePasswordText,
    AppStrings.supportText,
    AppStrings.languageText,
    AppStrings.blogText,
    AppStrings.logoutText,
  ];

  List<String> buttonsIcons = [
    ImageAssets.userIcon,
    ImageAssets.myadsIcon,
    ImageAssets.verifyIcon,
    ImageAssets.changePassword,
    ImageAssets.callSupportIcon,
    ImageAssets.languageIcon,
    ImageAssets.blogIcon,
    ImageAssets.logoutIcon,
  ];

  List buttonsOnPressed = [
    '/update_profile/view',
    '/my_ads/view',
    '/verify_account/view',
    '/change_password/view',
  ];

  signUserOut(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.remove('userToken');
      await supabase.auth.signOut();

      if (supabase.auth.currentUser == null) {
        if (!context.mounted) return;
        context.pushReplacement('/login/view');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future getUserRule() async{
    GetUserDetails getUserDetails = GetUserDetails();
    try {
      final res = await getUserDetails.getUserProfileDetails(supabase.auth.currentUser!.id);
      userRule = res[0]['user_rule'];
      notifyListeners();
      print(userRule);
    } catch (e) {
      return e;
    }
  }
}
