import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordRequest {
  Future changeUserPassword(
      String newPass, String confirmPass, BuildContext context) async {
    if (confirmPass == newPass) {
      try {
        final UserResponse res = await supabase.auth
            .updateUser(
          UserAttributes(password: newPass, data: {'password': newPass}),
        )
            .then((value) async {
          final res = await supabase
              .from('users')
              .update({'password': newPass}).eq('uid', value.user!.id);

          return res;
        });
        return res;
      } catch (e) {
        return e;
      }
    } else {
      Fluttertoast.showToast(
          msg: AppStrings.notMatchedPasswordText.getString(context));
    }
  }
}
