import 'package:flutter/material.dart';
import 'package:oraxproperty/data/api-request/countries_requests.dart';
import 'package:oraxproperty/data/api-request/get_categories.dart';
import 'package:oraxproperty/data/api-request/post_request.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class PropertyRequestDetailsViewModel extends ChangeNotifier {
  String? propertyCategory;
  String? propertyCountry;
  int? requestCategoryPageIndex;
  TabController? requestPagesController;

  int? countryID;
  int? categoryID;

  TextEditingController discriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController priceFromController = TextEditingController();
  TextEditingController priceToController = TextEditingController();

  TextEditingController areaFromController = TextEditingController();
  TextEditingController areaToController = TextEditingController();

  List<String> categoriesList = [
    AppStrings.apartmentForSaleText,
    AppStrings.apartmentForRentText,
    AppStrings.villasForSaleText,
    AppStrings.villasForRentText,
    AppStrings.landForSaleText,
    AppStrings.landForRentText,
  ];

  List<Map<String, dynamic>> countries = [];
  List<Map<String, dynamic>> categories = [];

  void changePropertyCategoryAndPage(String value) {
    propertyCategory = value;
    categoryID =
        categories[getIndex(categories, 'category_name', propertyCategory)]
            ['category_id'];
    notifyListeners();
  }

  void changeCountry(String value) {
    propertyCountry = value;
    countryID =
        countries[getIndex(countries, 'country_name_ar', propertyCountry)]
            ['id'];
    notifyListeners();
  }

  int getIndex(List<Map<String, dynamic>> list, String key, dynamic value) {
    return list.indexWhere((map) => map[key] == value);
  }

  Map<String, dynamic> propertyOrderDetails = {};

  assginValuesToMap() {
    propertyOrderDetails['category_id'] = categoryID;
    propertyOrderDetails['country'] = countryID;
    propertyOrderDetails['price_range'] =
        '${priceFromController.text}-${priceToController.text}';
    propertyOrderDetails['area_range'] =
        '${areaFromController.text}-${areaToController.text}';
    propertyOrderDetails['description'] = discriptionController.text;
    propertyOrderDetails['phone_number'] = phoneNumberController.text;
    propertyOrderDetails['email'] = emailController.text;
  }

  Future getAllowedCountries() async {
    CountriesRequests countriesRequests = CountriesRequests();
    try {
      final res = await countriesRequests.getListOfCountries();
      countries = res;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future getPropertyCategories() async {
    GetCategoriesRequest categoriesRequest = GetCategoriesRequest();
    try {
      final res = await categoriesRequest.getAdPropertyCategories();
      categories = res;
      print(categories);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future postPropertyOrder() async {
    PostPropertyRequestRequest postPropertyRequestRequest =
        PostPropertyRequestRequest();
    print(propertyOrderDetails);
    try {
      final res = await postPropertyRequestRequest.postPropertyOrder(
          propertyOrderDetails['category_id'],
          propertyOrderDetails['country'],
          propertyOrderDetails['price_range'],
          propertyOrderDetails['area_range'],
          propertyOrderDetails['description'],
          propertyOrderDetails['phone_number'],
          propertyOrderDetails['email']);
      return res;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
