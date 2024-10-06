import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/data/api-request/get_advertisments.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/confirm_before_seding/viewmodel/edit_confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class EditVillasForSaleViewModel extends ChangeNotifier {
  assignValues(
    String bedrooms,
    String livingrooms,
    String bathrooms,
    String price,
    bool hasCarEntrance,
    String apartments,
    String? propertyAge,
    String area,
    bool hasSpecialRoof,
    bool hasdoubleEntrances,
    bool hasSpecialEntrance,
    bool furnished,
    String streetWidth,
    bool driverRoom,
    bool kitchen,
    bool maidRoom,
    bool pool,
    bool duplex,
    bool basement,
    bool stairs,
  ) {
    bedroomsChoice = bedrooms;
    livingRoomChoice = livingrooms;
    bathroomsChoice = bathrooms;
    priceFromController.text = price;
    haveCarEntrance = hasCarEntrance;
    apartmentChoice = apartments;
    propertyAgeChoice = propertyAge;
    areaFromController.text = area;
    haveSpecialRoof = hasSpecialRoof;
    havedoubleEntrances = hasdoubleEntrances;
    haveSpecialEntrance = hasSpecialEntrance;
    isFurnished = furnished;
    streetWidthChoice = streetWidth;
    hasDriverRoom = driverRoom;
    hasMaidRoom = maidRoom;
    hasPool = pool;
    withStairs = stairs;
    hasKitchen = kitchen;
    hasBasement = basement;
    isDuplex = duplex;
  }

  Future getAdData(adId, categoryId) async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      final res = await getAdvertisementsRequest.getAdDetails(adId, categoryId);
      assignValues(
        res[0]['bedrooms'],
        res[0]['livingrooms'],
        res[0]['bathrooms'],
        res[0]['price'],
        res[0]['has_car_entrance'],
        res[0]['apartments'],
        res[0]['property_age'],
        res[0]['area'],
        res[0]['has_special_roof'],
        res[0]['has_double_entrance'],
        res[0]['has_special_entrance'],
        res[0]['is_furnished'],
        res[0]['street_width'],
        res[0]['has_driver_room'],
        res[0]['has_kitchen'],
        res[0]['has_maid_room'],
        res[0]['has_pool'],
        res[0]['is_duplex'],
        res[0]['has_basement'],
        res[0]['with_stairs'],
      );
      // notifyListeners();
      return res;
    } catch (e) {
      return e;
    }
  }

  String bedroomsChoice = '';
  String livingRoomChoice = '';
  String bathroomsChoice = '';
  String apartmentChoice = '';
  TextEditingController priceFromController = TextEditingController();
  TextEditingController priceToController = TextEditingController();
  String? propertyAgeChoice;
  String? streetWidthChoice;
  TextEditingController areaFromController = TextEditingController();
  TextEditingController areaToController = TextEditingController();
  bool haveCarEntrance = false;
  bool hasDriverRoom = false;
  bool hasMaidRoom = false;
  bool hasPool = false;
  bool withStairs = false;
  bool isFurnished = false;
  bool hasKitchen = false;
  bool hasBasement = false;
  bool isDuplex = false;
  bool havedoubleEntrances = false;
  bool haveSpecialRoof = false;
  bool haveSpecialEntrance = false;

  List<String> bedroomsQuantity = [
    AppStrings.allText,
    AppStrings.oneText,
    AppStrings.twoText,
    AppStrings.threeText,
    AppStrings.fourText,
    AppStrings.fiveText,
    AppStrings.sixOrMore,
  ];

  List<String> apartmentsQuantity = [
    AppStrings.allText,
    AppStrings.oneText,
    AppStrings.twoText,
    AppStrings.threeText,
    AppStrings.fourText,
  ];

  List<String> livingRoomsQuantity = [
    AppStrings.allText,
    AppStrings.oneOrMore,
    AppStrings.twoOrMore,
    AppStrings.threeOrMore,
  ];

  List<String> bathroomsQuantity = [
    AppStrings.allText,
    AppStrings.oneOrMore,
    AppStrings.twoOrMore,
    AppStrings.threeOrMore,
  ];

  List<String> propertyAges = [
    AppStrings.allText,
    AppStrings.lessThanAYearText,
    AppStrings.lessThan2YearText,
    AppStrings.lessThan3YearText,
    AppStrings.lessThan4YearText,
    AppStrings.lessThan5YearText,
    AppStrings.lessThan6YearText,
    AppStrings.lessThan7YearText,
    AppStrings.lessThan8YearText,
    AppStrings.lessThan9YearText,
    AppStrings.lessThan10YearText,
    AppStrings.lessThan11YearText,
    AppStrings.lessThan12YearText,
    AppStrings.lessThan13YearText,
    AppStrings.lessThan14YearText,
    AppStrings.lessThan15YearText,
    AppStrings.lessThan16YearText,
    AppStrings.lessThan17YearText,
    AppStrings.lessThan18YearText,
    AppStrings.lessThan19YearText,
    AppStrings.lessThan20YearText,
  ];

  List<String> streetWidth = [
    AppStrings.moreThan5Text,
    AppStrings.moreThan10Text,
    AppStrings.moreThan15Text,
    AppStrings.moreThan20Text,
    AppStrings.moreThan25Text,
    AppStrings.moreThan30Text,
    AppStrings.moreThan35Text,
    AppStrings.moreThan40Text,
    AppStrings.moreThan45Text,
    AppStrings.moreThan50Text,
  ];

  void toggleNotifyListener() {
    notifyListeners();
  }

  checkEmpty(BuildContext context) {
    if (bedroomsChoice == '') {
      Fluttertoast.showToast(
          msg:
              '${AppStrings.bedroomText.getString(context)} ${AppStrings.cantBeEmptyText.getString(context)}');
      return false;
    }

    if (apartmentChoice == '') {
      Fluttertoast.showToast(
          msg:
              '${AppStrings.apartmentsText.getString(context)} ${AppStrings.cantBeEmptyText.getString(context)}');
      return false;
    }

    if (livingRoomChoice == '') {
      Fluttertoast.showToast(
          msg:
              '${AppStrings.livingRoomText.getString(context)} ${AppStrings.cantBeEmptyText.getString(context)}');
      return false;
    }
    if (bathroomsChoice == '') {
      Fluttertoast.showToast(
          msg:
              '${AppStrings.bathRoomText.getString(context)} ${AppStrings.cantBeEmptyText.getString(context)}');
      return false;
    }

    if (priceFromController.text == '' || priceFromController.text.isEmpty) {
      Fluttertoast.showToast(
          msg:
              '${AppStrings.priceText.getString(context)} ${AppStrings.cantBeEmptyText.getString(context)}');
      return false;
    }

    if (areaFromController.text == '' || areaFromController.text.isEmpty) {
      Fluttertoast.showToast(
          msg:
              '${AppStrings.areaText.getString(context)} ${AppStrings.cantBeEmptyText.getString(context)}');
      return false;
    }
    if (propertyAgeChoice == null) {
      Fluttertoast.showToast(
          msg:
              '${AppStrings.propertyAgeText.getString(context)} ${AppStrings.cantBeEmptyText.getString(context)}');
      return false;
    }
    return true;
  }

  void assignAdValsToConfirmDetailsMap(BuildContext context) async {
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.apartmentsText] =
        apartmentChoice;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText] =
        bedroomsChoice;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.livingRoomText] =
        livingRoomChoice;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText] =
        bathroomsChoice;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.propertyAgeText] =
        propertyAgeChoice ?? 'N/A';
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.streetWidthText] =
        streetWidthChoice ?? 'N/A';
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] =
        isFurnished == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] =
        haveCarEntrance == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.driverRoomText] =
        hasDriverRoom == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.kitchenText] =
        hasKitchen == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.maidRoomText] =
        hasMaidRoom == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.poolText] =
        hasPool == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.stairsText] =
        withStairs == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.duplexText] =
        isDuplex == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.basementText] =
        hasBasement == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.specialRoofText] =
        haveSpecialRoof == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.doubleEntranceText] =
        havedoubleEntrances == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.speacialEntranceText] =
        haveSpecialEntrance == false ? AppStrings.noText : AppStrings.yesText;
    if (ValueHolders.adsOrRequest == 'Ads') {
      EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText] =
          priceFromController.text;
      EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText] =
          '${areaFromController.text}m²';
    } else {
      EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText] =
          '${priceFromController.text} - ${priceToController.text}';
      EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText] =
          '${areaFromController.text}m² - ${areaToController.text}m²';
    }
  }
}
