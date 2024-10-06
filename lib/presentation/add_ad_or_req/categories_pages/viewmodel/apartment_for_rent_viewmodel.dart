import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/confirm_before_seding/viewmodel/confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class AppartmentForRentViewModel extends ChangeNotifier {
  String bedroomsChoice = '';
  String livingRoomChoice = '';
  String bathroomsChoice = '';
  TextEditingController priceFromController = TextEditingController();
  TextEditingController priceToController = TextEditingController();
  bool haveCarEntrance = false;
  String? floorNumberChoice;
  String? propertyAgeChoice;
  TextEditingController areaFromController = TextEditingController();
  TextEditingController areaToController = TextEditingController();
  bool haveSpecialRoof = false;
  bool inAVilla = false;
  bool havedoubleEntrances = false;
  bool haveSpecialEntrance = false;
  bool isFurnished = false;
  bool isAirConditioned = false;
  String rentPayPeriodChoice = '';

  List<String> bedroomsQuantity = [
    AppStrings.allText,
    AppStrings.oneText,
    AppStrings.twoText,
    AppStrings.threeText,
    AppStrings.fourText,
    AppStrings.fiveText,
    AppStrings.sixOrMore,
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

  List<String> floorNumbers = [
    AppStrings.allText,
    AppStrings.groundFloorText,
    AppStrings.secondFloorText,
    AppStrings.twoText,
    AppStrings.threeText,
    AppStrings.fourText,
    AppStrings.fiveText,
    AppStrings.sixText,
    AppStrings.sevenText,
    AppStrings.eigthText,
    AppStrings.nineText,
    AppStrings.tenText,
    AppStrings.elevenText,
    AppStrings.twilveText,
    AppStrings.thirteenText,
    AppStrings.fourteenText,
    AppStrings.fifteenText,
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

    if (floorNumberChoice == null) {
      Fluttertoast.showToast(
          msg:
              '${AppStrings.floorText.getString(context)} ${AppStrings.cantBeEmptyText.getString(context)}');
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

  assignAdValsToConfirmDetailsMap(BuildContext context) async {
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.rentPayPeriodText] =
        rentPayPeriodChoice;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText] =
        bedroomsChoice;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.livingRoomText] =
        livingRoomChoice;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText] =
        bathroomsChoice;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.floorText] =
        floorNumberChoice ?? 'N/A';
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.propertyAgeText] =
        propertyAgeChoice ?? 'N/A';
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.furnishedText] =
        isFurnished == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] =
        haveCarEntrance == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.specialRoofText] =
        haveSpecialRoof == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.inAVillaText] =
        inAVilla == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.doubleEntranceText] =
        havedoubleEntrances == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.speacialEntranceText] =
        haveSpecialEntrance == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.airConditionedText] =
        isAirConditioned == false ? AppStrings.noText : AppStrings.yesText;
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
