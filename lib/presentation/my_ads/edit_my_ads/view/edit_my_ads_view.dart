import 'package:flutter/material.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/categories_pages/view/edit_apartment_for_rent_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/categories_pages/view/edit_apartment_for_sale_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/categories_pages/view/edit_lands_for_rent_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/categories_pages/view/edit_lands_for_sale_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/categories_pages/view/edit_villas_for_rent_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/categories_pages/view/edit_villas_for_sale_view.dart';

class EditMyAdsView extends StatefulWidget {
  const EditMyAdsView({super.key, this.data});
  final Map<String, dynamic>? data;
  @override
  State<EditMyAdsView> createState() => _EditMyAdsViewState();
}

class _EditMyAdsViewState extends State<EditMyAdsView> {
  @override
  Widget build(BuildContext context) {
    switch (widget.data?['category_id']) {
      case 1:
        return EditAppartmentForSaleView(data: widget.data);
      case 2:
        return EditAppartmentForRentView(data: widget.data);
      case 3:
        return EditVillasForSaleView(data: widget.data);
      case 4:
        return EditVillasForRentView(data: widget.data);
      case 5:
        return EditLandsForSaleView(data: widget.data);
      case 6:
        return EditLandsForRentView(data: widget.data);
      default:
        return const Center(child: Text('No category selected'));
    }
  }
}
