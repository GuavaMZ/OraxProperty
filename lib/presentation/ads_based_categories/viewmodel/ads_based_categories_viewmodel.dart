import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/data/api-request/get_advertisments.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdsBasedCategoryViewModel extends ChangeNotifier {
  GetAdvertisementsRequest getAdvertisementsRequest =
      GetAdvertisementsRequest();

  indicateCategoryAndGetAds(String category) async {
    switch (category) {
      case AppStrings.allText:
        break;
      case AppStrings.villasForSaleText:
        try {
          var res =
              await getAdvertisementsRequest.getVillaForSaleAdvertisements();
          return res;
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
        break;
      case AppStrings.villasForRentText:
        try {
          var res =
              await getAdvertisementsRequest.getVillaForRentAdvertisements();
          return res;
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
        break;
      case AppStrings.apartmentForRentText:
        try {
          var res = await getAdvertisementsRequest
              .getApartmentForRentAdvertisements();
          return res;
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
        break;
      case AppStrings.apartmentForSaleText:
        try {
          var res =
              await getAdvertisementsRequest.getApartmentsForSaleRPC();
          return res;
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
        case AppStrings.landForSaleText:
        try {
          var res =
              await getAdvertisementsRequest.getLandsForSaleRPC();
          return res;
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
        case AppStrings.landForRentText:
        try {
          var res =
              await getAdvertisementsRequest.getLandsForRentRPC();
          return res;
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
        break;
      default:
    }
  }

  getBucketsFiles(String path) async {
    final res = await supabase.storage.from('properties_ads').download(path);
    return res;
  }
}
