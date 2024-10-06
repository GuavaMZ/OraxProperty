import 'package:oraxproperty/domain/model/update_profile.dart';
import 'package:oraxproperty/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateUserProfileRequest {
  Future updateUserProfile(String uid, String name, String email,
      String phoneNumber, String brief, String membershipType) async {
    String? requestResult;
    Map<String, dynamic> updateUserProfile = UpdateProfileModel(
            uid: uid,
            full_name: name,
            email: email,
            phone_number: phoneNumber,
            brief: brief,
            membership_type: membershipType)
        .toJson();
    try {
      await supabase.auth
          .updateUser(UserAttributes(email: email, data: {
        'email': email,
        'full_name': name,
        'phone_number': phoneNumber,
        'brief': brief,
        'membership_type': membershipType,
      }))
          .then((value) async {
        await supabase
            .from('users')
            .update(updateUserProfile)
            .eq('uid', uid)
            .select();
        requestResult = 'Success';
      });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
    }
    return requestResult;
  }
}
