import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/data/api-request/update_advertisement.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class EditConfirmBeforeSendViewModel extends ChangeNotifier {
  static Map<String, dynamic> propertyAdDetails = {};
  static Map<String, String> propertyImages = {};
  static List prevPropertyImages = [];

  bool isLoading = false;

  indicateCategoryAndUpdateAd(BuildContext context) async {
    var res;

    switch (ValueHolders.categoryAdsType) {
      case AppStrings.apartmentForSaleText:
        res = await updateAparmentForSale();
        break;
      case AppStrings.apartmentForRentText:
        res = await updateApartmentForRent();
        break;
      case AppStrings.villasForSaleText:
        res = await updateVillaForSale();
        break;
      case AppStrings.villasForRentText:
        res = await updateApartmentForRent();
        break;
      case AppStrings.landForSaleText:
        res = await updateLandForSale();
        break;
      case AppStrings.landForRentText:
        res = await updateLandForRent();
        break;
    }
    print(res);
    return res;
  }

  updateAparmentForSale() async {
    UpdatePropertyAdvertisementRequest updatePropertyAdvertisementRequest =
        UpdatePropertyAdvertisementRequest();
    try {
      var res = await updatePropertyAdvertisementRequest.updateApartmentForSale(
        EditConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
        EditConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.bedroomText],
        EditConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.livingRoomText],
        EditConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.bathRoomText],
        EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.floorText],
        EditConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.propertyAgeText],
        EditConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.carEntranceText] ==
                'Yes'
            ? true
            : false,
        EditConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.specialRoofText] ==
                'Yes'
            ? true
            : false,
        EditConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.inAVillaText] ==
                'Yes'
            ? true
            : false,
        EditConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.doubleEntranceText] ==
                'Yes'
            ? true
            : false,
        EditConfirmBeforeSendViewModel
                    .propertyAdDetails[AppStrings.speacialEntranceText] ==
                'Yes'
            ? true
            : false,
        EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
        EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
        EditConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.discriptionText],
        EditConfirmBeforeSendViewModel.propertyImages,
        EditConfirmBeforeSendViewModel.prevPropertyImages,
        EditConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
        EditConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
        EditConfirmBeforeSendViewModel.propertyAdDetails['country'],
      );

      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  updateApartmentForRent() async {
    UpdatePropertyAdvertisementRequest updatePropertyAdvertisementRequest =
        UpdatePropertyAdvertisementRequest();
    try {
      var res = await updatePropertyAdvertisementRequest.updateApartmentForRent(
          EditConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.rentPayPeriodText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.bedroomText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.livingRoomText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.bathRoomText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.floorText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.propertyAgeText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.carEntranceText] ==
                  'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.specialRoofText] ==
                  'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.inAVillaText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.doubleEntranceText] ==
                  'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel
                      .propertyAdDetails[AppStrings.speacialEntranceText] ==
                  'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.discriptionText],
          EditConfirmBeforeSendViewModel.propertyImages,
          EditConfirmBeforeSendViewModel.prevPropertyImages,
          EditConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          EditConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          EditConfirmBeforeSendViewModel.propertyAdDetails['country']);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  updateVillaForSale() async {
    UpdatePropertyAdvertisementRequest updatePropertyAdvertisementRequest =
        UpdatePropertyAdvertisementRequest();
    try {
      var res = await updatePropertyAdvertisementRequest.updateVillaForSale(
          EditConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.bedroomText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.livingRoomText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.bathRoomText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.propertyAgeText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.specialRoofText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.doubleEntranceText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.speacialEntranceText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.priceText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.apartmentsText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.streetWidthText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.driverRoomText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.kitchenText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.duplexText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.basementText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.stairsText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.maidRoomText] == 'Yes' ? true : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.poolText] == 'Yes' ? true : false,
          EditConfirmBeforeSendViewModel.propertyImages,
          EditConfirmBeforeSendViewModel.prevPropertyImages,
          EditConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          EditConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          EditConfirmBeforeSendViewModel.propertyAdDetails['country']);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  updateVillaForRent() async {
    UpdatePropertyAdvertisementRequest updatePropertyAdvertisementRequest =
        UpdatePropertyAdvertisementRequest();
    try {
      var res = await updatePropertyAdvertisementRequest.updateVillaForRent(
          EditConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.bedroomText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.livingRoomText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.bathRoomText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.propertyAgeText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.specialRoofText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.doubleEntranceText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.speacialEntranceText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.priceText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.apartmentsText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.streetWidthText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.driverRoomText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.kitchenText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.duplexText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.basementText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.stairsText] == 'Yes'
              ? true
              : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.maidRoomText] == 'Yes' ? true : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.poolText] == 'Yes' ? true : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.airConditionedText] == 'Yes' ? true : false,
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.rentPayPeriodText],
          EditConfirmBeforeSendViewModel.propertyImages,
          EditConfirmBeforeSendViewModel.prevPropertyImages,
          EditConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          EditConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          EditConfirmBeforeSendViewModel.propertyAdDetails['country']);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  updateLandForSale() async {
    UpdatePropertyAdvertisementRequest updatePropertyAdvertisementRequest =
        UpdatePropertyAdvertisementRequest();
    try {
      var res = await updatePropertyAdvertisementRequest.updateLandForSale(
          EditConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.priceText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.landTypeText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          // EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] == 'Yes'
          //     ? true
          //     : false,
          EditConfirmBeforeSendViewModel.propertyImages,
          EditConfirmBeforeSendViewModel.prevPropertyImages,
          EditConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          EditConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          EditConfirmBeforeSendViewModel.propertyAdDetails['country'],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.streetWidthText]);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  updateLandForRent() async {
    UpdatePropertyAdvertisementRequest updatePropertyAdvertisementRequest =
        UpdatePropertyAdvertisementRequest();
    try {
      var res = await updatePropertyAdvertisementRequest.updateLandForRent(
          EditConfirmBeforeSendViewModel.propertyAdDetails['category_id'],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.priceText],
          EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.landTypeText],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.discriptionText],
          // EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] == 'Yes'
          //     ? true
          //     : false,
          EditConfirmBeforeSendViewModel.propertyImages,
          EditConfirmBeforeSendViewModel.prevPropertyImages,
          EditConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'],
          EditConfirmBeforeSendViewModel.propertyAdDetails['location_address'],
          EditConfirmBeforeSendViewModel.propertyAdDetails['country'],
          EditConfirmBeforeSendViewModel
              .propertyAdDetails[AppStrings.streetWidthText]);
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
