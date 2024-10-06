import 'package:flutter/material.dart';
import 'package:oraxproperty/data/api-request/favourites_requests.dart';

class FavouritesViewModel extends ChangeNotifier {
  Future getFavouriteAds(String uid) async {
    FavouritesRequests favouritesRequests = FavouritesRequests();
    try {
      final res = await favouritesRequests.getFavAds(uid);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future removeFromFav(String uid, int adID) async {
    FavouritesRequests favouritesRequests = FavouritesRequests();
    try {
      final res = await favouritesRequests.removeFav(adID, uid);
      return res;
    } catch (e) {
      return e;
    }
  }

  void toggleNotifyListener(){
    notifyListeners();
  }
}
