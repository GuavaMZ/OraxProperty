import 'package:flutter/material.dart';
import 'package:oraxproperty/data/api-request/favourites_requests.dart';
import 'package:oraxproperty/data/api-request/get_advertisments.dart';
import 'package:oraxproperty/data/api-request/get_user_details.dart';
import 'package:oraxproperty/data/api-request/support_data.dart';
import 'package:oraxproperty/domain/model/support_data.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class AdDetailsViewModel extends ChangeNotifier {
  List specificationCirlesNames = [
    AppStrings.bedroomText,
    AppStrings.livingRoomText,
    AppStrings.bathRoomText,
    AppStrings.areaText
  ];
  List specificationCirlesIcons = [
    ImageAssets.roomsIcon,
    ImageAssets.livingIcon,
    ImageAssets.bathIcon,
    ImageAssets.areaIcon
  ];
  List specificationCirlesData = [
    'bedrooms',
    'livingrooms',
    'bathrooms',
    'area'
  ];
  List specificationOutOfDetails = [
    'uid',
    'description',
    'price',
    'bucket_path',
    'category_id',
    'location_latlng',
    'location_address'
  ];

  Future getAdDetails(adId, categoryId) async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      final res = await getAdvertisementsRequest.getAdDetails(adId, categoryId);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getUserDetails(String uid) async {
    GetUserDetails getUserDetails = GetUserDetails();
    try {
      final res = getUserDetails.getUserProfileDetails(uid);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future addToFav(String uid, int adID) async {
    FavouritesRequests favouritesRequests = FavouritesRequests();
    try {
      final res = await favouritesRequests.makeAdFav(adID, uid);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future checkIfFav(String uid, int adID) async {
    FavouritesRequests favouritesRequests = FavouritesRequests();
    try {
      final res = await favouritesRequests.checkFav(adID, uid);
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

  toggleNotifyListener(){
    notifyListeners();
  }

  getSupporters() async {
    SupportDataRequests supportDataRequests = SupportDataRequests();
    try {
      List<SupportersData> res = await supportDataRequests.getSupportData();
      return res;
    } catch (e) {
      return e;
    }
  }
}
