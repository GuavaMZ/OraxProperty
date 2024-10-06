import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/confirm_before_seding/viewmodel/confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class VillasForRentViewModel extends ChangeNotifier {
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
  bool isAirConditioned = false;
  String rentPayPeriodChoice = '';
  bool hasSpecialRoof = false;
  bool hasDoubleEntrance = false;
  bool hasSpecialEntrance = false;

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

  List<String> rentPayPeriod = [
    AppStrings.dailyText,
    AppStrings.monthlyText,
    AppStrings.yearlyText,
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
    if (rentPayPeriodChoice == '') {
      Fluttertoast.showToast(
          msg:
              '${AppStrings.rentPayPeriodText.getString(context)} ${AppStrings.cantBeEmptyText.getString(context)}');
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
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.rentPayPeriodText] =
        rentPayPeriodChoice;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.apartmentsText] =
        apartmentChoice;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText] =
        bedroomsChoice;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.livingRoomText] =
        livingRoomChoice;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText] =
        bathroomsChoice;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.propertyAgeText] =
        propertyAgeChoice ?? 'N/A';
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.streetWidthText] =
        streetWidthChoice ?? 'N/A';
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] =
        isFurnished == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] =
        haveCarEntrance == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.driverRoomText] =
        hasDriverRoom == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.airConditionedText] =
        isAirConditioned == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.kitchenText] =
        hasKitchen == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.maidRoomText] =
        hasMaidRoom == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.poolText] =
        hasPool == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.stairsText] =
        withStairs == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.duplexText] =
        isDuplex == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.basementText] =
        hasBasement == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.specialRoofText] =
        hasSpecialRoof == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.doubleEntranceText] =
        hasDoubleEntrance == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.speacialEntranceText] =
        hasSpecialEntrance == false ? AppStrings.noText : AppStrings.yesText;
    if (ValueHolders.adsOrRequest == 'Ads') {
      ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText] =
          priceFromController.text;
      ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText] =
          '${areaFromController.text}m²';
    } else {
      ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.priceText] =
          '${priceFromController.text} - ${priceToController.text}';
      ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.areaText] =
          '${areaFromController.text}m² - ${areaToController.text}m²';
    }
  }
}
