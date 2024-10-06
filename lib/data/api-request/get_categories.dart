import 'package:oraxproperty/domain/model/categories.dart';
import 'package:oraxproperty/main.dart';

class GetCategoriesRequest {
  Future getAdPropertyCategories() async {
    PropertyCategoriesModel propertyCategories;
    try {
      final res = await supabase.from('property_categories').select();
      propertyCategories = PropertyCategoriesModel(categories: res);
      return res;
    } catch (e) {
      return e.toString();
    }
  }
}
