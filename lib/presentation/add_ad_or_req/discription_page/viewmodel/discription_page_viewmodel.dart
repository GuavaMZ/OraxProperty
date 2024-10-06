import 'package:flutter/material.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/confirm_before_seding/viewmodel/confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class DiscriptionPageViewModel extends ChangeNotifier {
  TextEditingController discriptionController = TextEditingController();

  assignAdValsToConfirmDetailsMap(BuildContext context) async {
    ConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.discriptionText] =
        discriptionController.text;
  }
}
