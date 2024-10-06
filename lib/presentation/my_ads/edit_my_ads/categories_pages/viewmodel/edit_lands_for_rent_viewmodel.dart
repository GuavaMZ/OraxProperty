import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/data/api-request/get_advertisments.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/confirm_before_seding/viewmodel/edit_confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class EditLandsForRentViewModel extends ChangeNotifier {
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
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.landTypeText] =
        landTypeChoice ?? 'N/A';
    // EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.carEntranceText] =
    //     haveCarEntrance == false ? AppStrings.noText : AppStrings.yesText;
    EditConfirmBeforeSendViewModel
            .propertyAdDetails[AppStrings.streetWidthText] =
        streetWidthChoice ?? 'N/A';
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

  Future getAdData(adId, categoryId) async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      final res = await getAdvertisementsRequest.getAdDetails(adId, categoryId);
      assignValues(
        res[0]['price'],
        res[0]['area'],
        res[0]['type'],
        res[0]['street_width'],
      );
      // notifyListeners();
    
      return res;
    } catch (e) {
      return e;
    }
  }

  assignValues(String price, String area, String type, String streetWidth) {
    priceFromController.text = price;
    areaFromController.text = area;
    landTypeChoice = type;
    streetWidthChoice = streetWidth;
  }
}
