import 'package:flutter/material.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/view/apartment_for_rent_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/view/apartment_for_sale_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/view/villas_for_rent_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/view/villas_for_sale_view.dart';

class AddNewOrderViewModel extends ChangeNotifier {
  String? propertyCategory;
  int? requestCategoryPageIndex;
  final PageController requestPagesController = PageController();

  List<Widget> requestCategoriesPages = const [
    AppartmentForSaleView(),
    AppartmentForRentView(),
    VillasForSaleView(),
    VillasForRentView(),
  ];

  void changePropertyCategoryAndPage(String value) {
    propertyCategory = value;
    notifyListeners();
  }
}
