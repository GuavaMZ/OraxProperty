import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/data/api-request/get_advertisments.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/confirm_before_seding/viewmodel/edit_confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class EditAppartmentForSaleViewModel extends ChangeNotifier {
  List adDetails = [];
  assignValues(
      String bedrooms,
      String livingrooms,
      String bathrooms,
      String price,
      bool hasCarEntrance,
      String floorNumber,
      String? propertyAge,
      String area,
      bool hasSpecialRoof,
      bool inaVilla,
      bool hasdoubleEntrances,
      bool hasSpecialEntrance) {
    bedroomsChoice = bedrooms;
    livingRoomChoice = livingrooms;
    bathroomsChoice = bathrooms;
    priceFromController.text = price;
    haveCarEntrance = hasCarEntrance;
    floorNumberChoice = floorNumber;
    propertyAgeChoice = propertyAge;
    areaFromController.text = area;
    haveSpecialRoof = hasSpecialRoof;
    inAVilla = inaVilla;
    havedoubleEntrances = hasdoubleEntrances;
    haveSpecialEntrance = hasSpecialEntrance;
  }

  Future getAdData(adId, categoryId) async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      final res = await getAdvertisementsRequest.getAdDetails(adId, categoryId);
      adDetails = res;
      print(adDetails);
      assignValues(
          res[0]['bedrooms'],
          res[0]['livingrooms'],
          res[0]['bathrooms'],
          res[0]['price'],
          res[0]['has_car_entrance'],
          res[0]['floor_number'],
          res[0]['property_age'],
          res[0]['area'],
          res[0]['has_special_roof'],
          res[0]['is_apartment_in_a_villa'],
          res[0]['has_double_entrance'],
          res[0]['has_special_entrance']);
      notifyListeners();
      
      return res;
    } catch (e) {
      return e;
    }
  }

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
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bedroomText] =
        bedroomsChoice;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.livingRoomText] =
        livingRoomChoice;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.bathRoomText] =
        bathroomsChoice;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.floorText] =
        floorNumberChoice ?? 'N/A';
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.propertyAgeText] =
        propertyAgeChoice ?? 'N/A';
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] =
        haveCarEntrance == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.specialRoofText] =
        haveSpecialRoof == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.inAVillaText] =
        inAVilla == false ? AppStrings.noText : AppStrings.yesText;
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
