import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/data/api-request/post_advertisement.dart';
import 'package:oraxproperty/data/api-request/post_request.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class ConfirmBeforeSendViewModel extends ChangeNotifier {
  static Map<String, dynamic> propertyAdDetails = {};
  static Map<String, String> propertyImages = {};

  bool isLoading = false;

  indicateCategoryAndPostAd(BuildContext context) async {
    var res;
    switch (ValueHolders.adsOrRequest) {
      case 'Request':
        switch (ValueHolders.categoryAdsType) {
          case AppStrings.apartmentForSaleText:
            res = await postApartmentForSaleOrder();
            break;
          case AppStrings.apartmentForRentText:
            res = await postApartmentForRentOrder();
            break;
          case AppStrings.villasForSaleText:
            res = await postVillaForSaleOrder();
            break;
          case AppStrings.villasForRentText:
            res = await postVillaForRentOrder();
            break;
        }
        break;
      case 'Ads':
        switch (ValueHolders.categoryAdsType) {
          case AppStrings.apartmentForSaleText:
            res = await postAparmentForSale();
            break;
          case AppStrings.apartmentForRentText:
            res = await postApartmentForRent();
            break;
          case AppStrings.villasForSaleText:
            res = await postVillaForSale();
            break;
          case AppStrings.villasForRentText:
            res = await postApartmentForRent();
            break;
          case AppStrings.landForSaleText:
            res = await postLandForSale();
            break;
          case AppStrings.landForRentText:
            res = await postLandForRent();
            break;
        }
        break;
      default:
    }
    print(res);
    return res;
  }

  postAparmentForSale() async {
    PostPropertyAdvertisementRequest postPropertyAdvertisementRequest =
        PostPropertyAdvertisementRequest();
    try {
      var res = await postPropertyAdvertisementRequest.postApartmentForSale(
        supabase.auth.currentUser!.id,
        ConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.livingRoomText],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.floorText],
        ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.propertyAgeText],
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.carEntranceText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.specialRoofText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.inAVillaText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.doubleEntranceText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.speacialEntranceText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
        ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.discriptionText],
        ConfirmBeforeSendViewModel.propertyImages,
        ConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
        ConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
        ConfirmBeforeSendViewModel.propertyAdDetails['country'],
      );

      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  postApartmentForRent() async {
    PostPropertyAdvertisementRequest postPropertyAdvertisementRequest =
        PostPropertyAdvertisementRequest();
    try {
      var res = await postPropertyAdvertisementRequest.postApartmentForRent(
          supabase.auth.currentUser!.id,
          ConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.rentPayPeriodText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.livingRoomText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.floorText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.propertyAgeText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.specialRoofText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.inAVillaText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.doubleEntranceText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.speacialEntranceText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          ConfirmBeforeSendViewModel.propertyImages,
          ConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          ConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          ConfirmBeforeSendViewModel.propertyAdDetails['country']);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  postVillaForSale() async {
    PostPropertyAdvertisementRequest postPropertyAdvertisementRequest =
        PostPropertyAdvertisementRequest();
    try {
      var res = await postPropertyAdvertisementRequest.postVillaForSale(
          supabase.auth.currentUser!.id,
          ConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.livingRoomText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.propertyAgeText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.specialRoofText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.doubleEntranceText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.speacialEntranceText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.apartmentsText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.streetWidthText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.driverRoomText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.kitchenText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.duplexText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.basementText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.stairsText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.maidRoomText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.poolText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyImages,
          ConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          ConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          ConfirmBeforeSendViewModel.propertyAdDetails['country']);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  postVillaForRent() async {
    PostPropertyAdvertisementRequest postPropertyAdvertisementRequest =
        PostPropertyAdvertisementRequest();
    try {
      var res = await postPropertyAdvertisementRequest.postVillaForRent(
          supabase.auth.currentUser!.id,
          ConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.livingRoomText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.propertyAgeText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.specialRoofText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.doubleEntranceText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.speacialEntranceText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.apartmentsText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.streetWidthText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.driverRoomText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.kitchenText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.duplexText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.basementText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.stairsText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.maidRoomText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.poolText] == 'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.airConditionedText] == 'Yes' ? true : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.rentPayPeriodText],
          ConfirmBeforeSendViewModel.propertyImages,
          ConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          ConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          ConfirmBeforeSendViewModel.propertyAdDetails['country']);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  postLandForSale() async {
    PostPropertyAdvertisementRequest postPropertyAdvertisementRequest =
        PostPropertyAdvertisementRequest();
    try {
      var res = await postPropertyAdvertisementRequest.postLandForSale(
          supabase.auth.currentUser!.id,
          ConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.landTypeText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          // ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] == 'Yes'
          //     ? true
          //     : false,
          ConfirmBeforeSendViewModel.propertyImages,
          ConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          ConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          ConfirmBeforeSendViewModel.propertyAdDetails['country'],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.streetWidthText]);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  postLandForRent() async {
    PostPropertyAdvertisementRequest postPropertyAdvertisementRequest =
        PostPropertyAdvertisementRequest();
    try {
      var res = await postPropertyAdvertisementRequest.postLandForRent(
          supabase.auth.currentUser!.id,
          ConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.landTypeText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          // ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] == 'Yes'
          //     ? true
          //     : false,
          ConfirmBeforeSendViewModel.propertyImages,
          ConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          ConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          ConfirmBeforeSendViewModel.propertyAdDetails['country'],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.streetWidthText]);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  postApartmentForSaleOrder() async {
    PostPropertyRequestRequest postPropertyRequestRequest =
        PostPropertyRequestRequest();
    try {
      var res = await postPropertyRequestRequest.postRequestApartmentForSale(
          supabase.auth.currentUser!.id,
          ConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.livingRoomText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.floorText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.propertyAgeText],
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.carEntranceText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.specialRoofText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.inAVillaText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.doubleEntranceText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.speacialEntranceText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          ConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          ConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          ConfirmBeforeSendViewModel.propertyAdDetails['country']);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  postApartmentForRentOrder() async {
    PostPropertyRequestRequest postPropertyRequestRequest =
        PostPropertyRequestRequest();
    try {
      var res = await postPropertyRequestRequest.postApartmentRequestForRent(
          supabase.auth.currentUser!.id,
          ConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.rentPayPeriodText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.livingRoomText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.floorText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.propertyAgeText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.specialRoofText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.inAVillaText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.doubleEntranceText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.speacialEntranceText] ==
                  'Yes'
              ? true
              : false,
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
          ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          ConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          ConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          ConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          ConfirmBeforeSendViewModel.propertyAdDetails['country']);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  postVillaForSaleOrder() async {
    PostPropertyRequestRequest postPropertyRequestRequest =
        PostPropertyRequestRequest();
    try {
      var res = await postPropertyRequestRequest.postVillaRequestForSale(
        supabase.auth.currentUser!.id,
        ConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.livingRoomText],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText],
        ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.propertyAgeText],
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.carEntranceText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.specialRoofText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.doubleEntranceText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.speacialEntranceText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
        ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.discriptionText],
        ConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
        ConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
        ConfirmBeforeSendViewModel.propertyAdDetails['country'],
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.furnishedText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.apartmentsText],
        ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.streetWidthText],
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.driverRoomText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.kitchenText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.duplexText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.basementText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.stairsText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.maidRoomText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.poolText] ==
                'Yes'
            ? true
            : false,
      );
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  postVillaForRentOrder() async {
    PostPropertyRequestRequest postPropertyRequestRequest =
        PostPropertyRequestRequest();
    try {
      var res = await postPropertyRequestRequest.postVillaForRent(
        supabase.auth.currentUser!.id,
        ConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.livingRoomText],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText],
        ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.propertyAgeText],
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.carEntranceText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.specialRoofText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.doubleEntranceText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.speacialEntranceText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
        ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.discriptionText],
        ConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
        ConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
        ConfirmBeforeSendViewModel.propertyAdDetails['country'],
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.furnishedText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.apartmentsText],
        ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.streetWidthText],
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.driverRoomText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.kitchenText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.duplexText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.basementText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.stairsText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.maidRoomText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.poolText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.airConditionedText] ==
                'Yes'
            ? true
            : false,
        ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.rentPayPeriodText],
      );
      return res;
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
    }
  }
}
