import 'package:flutter/material.dart';
import 'package:oraxproperty/data/api-request/update_user_profile.dart';
import 'package:oraxproperty/main.dart';

class UpdateProfileViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController tellUsController = TextEditingController();
  // TextEditingController nameController = TextEditingController();
  String? membershipType;

  bool isLoading = false;

  Future updateProfile(String name, String email, String phoneNumber,
      String brief, String membershipType) async {
    UpdateUserProfileRequest updateUserProfileRequest =
        UpdateUserProfileRequest();
    try {
      var res = await updateUserProfileRequest.updateUserProfile(
          supabase.auth.currentUser!.id ,
          name,
          email,
          phoneNumber,
          brief,
          'Null');
      return res;
    } catch (e) {
      return e;
    }
  }
}
