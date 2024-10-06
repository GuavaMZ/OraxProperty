import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

class ChoosingAdOrReqView extends StatefulWidget {
  const ChoosingAdOrReqView({super.key});

  @override
  State<ChoosingAdOrReqView> createState() => _ChoosingAdOrReqViewState();
}

class _ChoosingAdOrReqViewState extends State<ChoosingAdOrReqView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s30),
        ),
        color: ColorManager.whiteColor,
      ),
      child: Column(
        children: [
          TextContainer(
            text: AppStrings.whatDoYouWantToAddText.getString(context),
            fontSize: 18,
            color: ColorManager.darkGreenColor,
            fontWeight: FontWeight.bold,
            margin: EdgeInsets.only(top: displayHeight(context) * 0.035),
          ),
          if (ValueHolders.isGuest == false)
            ModalBottomSheetButton(
              onPressed: () {
                ValueHolders.adsOrRequest = 'Ads';
                context.push('/choose_ad_category/view');
              },
              buttonName: AppStrings.addANewAdText.getString(context),
              buttonDescription:
                  AppStrings.addANewAdDetailsText.getString(context),
              buttonIcon: ImageAssets.newAdIcon,
            ),
          ModalBottomSheetButton(
            onPressed: () {
              ValueHolders.adsOrRequest = 'Request';
              context.push('/my_requests/view');
            },
            buttonIcon: ImageAssets.newRequestsIcon,
            buttonName: AppStrings.myRequestsText.getString(context),
            buttonDescription:
                AppStrings.myRequestsDetailsText.getString(context),
          )
        ],
      ),
    );
  }
}
