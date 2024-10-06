import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/confirm_before_seding/viewmodel/confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class LandsForRentViewModel extends ChangeNotifier {
  TextEditingController priceFromController = TextEditingController();
  TextEditingController priceToController = TextEditingController();

  TextEditingController areaFromController = TextEditingController();
  TextEditingController areaToController = TextEditingController();

  String? landTypeChoice = AppStrings.residentialText;
  String? streetWidthChoice;

  List<String> landsType = [
    AppStrings.residentialText,
    AppStrings.commercialText,
    AppStrings.residentialOrCommercialText
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

  checkEmpty(BuildContext context) {
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
    return true;
  }

  assignAdValsToConfirmDetailsMap(BuildContext context) async {
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.landTypeText] =
        landTypeChoice ?? 'N/A';
    // ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] =
    //     haveCarEntrance == false ? AppStrings.noText : AppStrings.yesText;
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.streetWidthText] =
        streetWidthChoice ?? 'N/A';
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
