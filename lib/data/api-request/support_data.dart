import 'package:oraxproperty/domain/model/support_data.dart';
import 'package:oraxproperty/main.dart';

class SupportDataRequests {
  getSupportData() async {
    SupportersModel supportersModel;
    try {
      final res = await supabase.from('support_data').select('*');
      supportersModel = SupportersModel.fromJson(res);
      // print(supportersModel.supporters);
      return supportersModel.supporters;
    } catch (e) {
      return e;
    }
  }
}
