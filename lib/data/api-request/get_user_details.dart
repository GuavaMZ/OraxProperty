import 'package:oraxproperty/main.dart';

class GetUserDetails {
  Future getUserProfileDetails(String uID) async {
    try {
      final res = await supabase.from('users').select('*').eq('uid', uID);
      return res;
    } catch (e) {
      return e;      
    }
  }
}