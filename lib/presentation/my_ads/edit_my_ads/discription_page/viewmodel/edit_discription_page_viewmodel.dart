import 'package:flutter/material.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/confirm_before_seding/viewmodel/edit_confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

class EditDiscriptionPageViewModel extends ChangeNotifier {
  TextEditingController discriptionController = TextEditingController();

  assignAdValsToConfirmDetailsMap(BuildContext context) async {
    EditConfirmBeforeSendViewModel.propertyAdDetails[AppStrings.discriptionText] =
        discriptionController.text;
  }
}
