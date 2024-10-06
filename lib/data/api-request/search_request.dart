import 'package:oraxproperty/main.dart';

class SearchRequest {
  Future searchForProperties(String query) async {
    try {
      var results = supabase
          .rpc('search_for_properties', params: {'query': query}).select();
  
      return results;
    } catch (e) {
      return e;
    }
  }
}
