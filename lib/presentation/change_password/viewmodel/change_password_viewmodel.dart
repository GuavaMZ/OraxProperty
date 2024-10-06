import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/data/api-request/change_password.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  bool isLoading = false;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  Future doChangePassword(
      String newPass, String confirmPass, BuildContext context) async {
    ChangePasswordRequest changePasswordRequest = ChangePasswordRequest();
    try {
      final res = changePasswordRequest.changeUserPassword(
          newPass, confirmPass, context);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  toggleNotifyListener(){
    notifyListeners();
  }
}
