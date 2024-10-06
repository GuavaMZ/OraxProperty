import 'package:flutter/material.dart';
import 'package:oraxproperty/data/api-request/get_advertisments.dart';

class MyAdsViewModel extends ChangeNotifier {
  getMyAds() async {
    GetAdvertisementsRequest getAdvertisementsRequest = GetAdvertisementsRequest();
    try {
      final res = await getAdvertisementsRequest.getMyAdvertisementsRPC();
      return res;
    } catch (e) {
      return e;
    }
  }
}