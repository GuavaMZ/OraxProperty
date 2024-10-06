import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/data/api-request/get_categories.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class AllCategoriesViewModel extends ChangeNotifier {
  List<String> categoriesNames = [
    // AppStrings.allText,
    AppStrings.apartmentForSaleText,
    AppStrings.apartmentForRentText,
    AppStrings.villasForSaleText,
    AppStrings.villasForRentText,
    AppStrings.landForSaleText,
    AppStrings.landForRentText,
  ];

  List<String> categoriesIcons = [
    // ImageAssets.allPropsIcon,
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
