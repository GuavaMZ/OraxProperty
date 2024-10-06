import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/data/api-request/get_categories.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class ChooseAdCategoryViewModel extends ChangeNotifier {
  List<String> adCategories = [
    AppStrings.apartmentForSaleText,
    AppStrings.apartmentForRentText,
    AppStrings.villasForSaleText,
    AppStrings.villasForRentText,
    AppStrings.landForSaleText,
    AppStrings.landForRentText,
  ];

  List<String> categoriesPages = [
    '/categories_pages/apartments_for_sale',
    '/categories_pages/apartments_for_rent',
    '/categories_pages/villas_for_sale',
    '/categories_pages/villas_for_rent',
    '/categories_pages/lands_for_sale',
    '/categories_pages/lands_for_rent',
  ];

  List<String> adCategoriesIcons = [
    ImageAssets.apartmentIcon,
    ImageAssets.apartmentForRent,
    ImageAssets.villasIcon,
    ImageAssets.villaForRent,
    ImageAssets.landsIcon,
    ImageAssets.landsIcon
  ];

  getAdCategories() async {
    GetCategoriesRequest getCategoriesRequest = GetCategoriesRequest();
    try {
      final res = await getCategoriesRequest.getAdPropertyCategories();
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
