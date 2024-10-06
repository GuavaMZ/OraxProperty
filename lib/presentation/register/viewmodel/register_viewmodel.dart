// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oraxproperty/app/shared_prefs.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterViewModel extends ChangeNotifier {
  bool isPassObsecure = true;
  bool isConfirmPassObsecure = true;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController moreController = TextEditingController();
  String? membershipType;
  final ImagePicker imagePicker = ImagePicker();
  File? image;
  var imageTemp;

  bool isLoading = false;

  Future signUpNewUser(BuildContext context) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
          email: ValueHolders.regUserDetails['user_email'],
          password: ValueHolders.regUserDetails['user_password'],
          data: {
            'phone_number': ValueHolders.regUserDetails['user_phone'],
            // 'password': ValueHolders.regUserDetails['user_password'],
            'is_verified': false,
            'email': ValueHolders.regUserDetails['user_email'],
            'full_name': ValueHolders.regUserDetails['user_full_name'],
            'brief': ValueHolders.regUserDetails['user_brief'],
            'membership_type': 'N/A',
            'profile_photo':
                'users_profile/${FileImage(imageTemp).file.path.toString().split('/').last}'
          });
      final Session? session = res.session;
      final User? user = res.user;

      Fluttertoast.showToast(
          msg: AppStrings.registerSuccessText.getString(context));
      ValueHolders.isGuest = false;
      await addUserToDatabase(user!.id);
    } catch (e) {
      if (e is ClientException) {
        Fluttertoast.showToast(
            msg: AppStrings.socketExceptionText.getString(context));
      } else if (e is AuthException) {
        Fluttertoast.showToast(msg: e.message);
      } else {
        if (imageTemp == null) {
          Fluttertoast.showToast(
              msg: AppStrings.choosePicPlease.getString(context));
        } else {
          Fluttertoast.showToast(msg: e.toString());
        }
      }
    }

    // await addUserToDatabase();
  }

  Future addUserToDatabase(String userID) async {
    try {
      await supabase
          .from('users')
          .insert({
            'uid': userID,
            'phone_number': ValueHolders.regUserDetails['user_phone'],
            // 'password': ValueHolders.regUserDetails['user_password'],
            'is_verified': false,
            'email': ValueHolders.regUserDetails['user_email'],
            'full_name': ValueHolders.regUserDetails['user_full_name'],
            'brief': ValueHolders.regUserDetails['user_brief'],
            'membership_type': 'Null',
            'profile_photo':
                'users_profile/${FileImage(imageTemp).file.path.toString().split('/').last}'
          })
          .select()
          .then((value) async {
            if (value != null) {
              supabase.storage
                  .from('users_profile')
                  .upload(image!.path.split('/').last, File(image!.path));
            }
          });
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }

  Future profileImagePicker() async {
    if (ValueHolders.androidVersion.contains('13')) {
      await Permission.photos.request();
    } else {
      await Permission.storage.request();
    }
    if (await Permission.photos.isGranted ||
        await Permission.storage.isGranted) {
      try {
        final image = await imagePicker.pickImage(
            source: ImageSource.gallery, imageQuality: 50);
        if (image == null) return;
        imageTemp = File(image.path);
        this.image = imageTemp;
      } on PlatformException catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      return const SnackBar(content: Text("zzzz"));
    }
  }

  void disposeModel() {
    phoneNumberController.dispose();
    passwordController.dispose();
    nameController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    moreController.dispose();
    ValueHolders.regUserDetails = {};
  }

  storeUserFirstName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userFirstName', name);
    SharedPrefs.userFirstName = name;
  }

  toggleNotifyListener(){
    notifyListeners();
  }
}
