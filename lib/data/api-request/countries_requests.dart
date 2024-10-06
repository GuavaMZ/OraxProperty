import 'package:oraxproperty/domain/model/countries.dart';
import 'package:oraxproperty/main.dart';

class CountriesRequests {
  Future getListOfCountries() async {
    CountriesModel countriesModel;
    try {
      final res = await supabase.from('allowed_countries').select();
      countriesModel = CountriesModel(countries: res);
      return res;
    } catch (e) {
      return e;
    }
  }
}
