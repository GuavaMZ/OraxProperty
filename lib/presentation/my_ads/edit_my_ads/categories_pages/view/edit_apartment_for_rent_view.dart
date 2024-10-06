import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraxproperty/app/value_holders.dart';

import 'package:oraxproperty/presentation/my_ads/edit_my_ads/categories_pages/viewmodel/edit_apartment_for_rent_viewmodel.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/confirm_before_seding/viewmodel/edit_confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class EditAppartmentForRentView extends StatefulWidget {
  const EditAppartmentForRentView({super.key, this.data});
  final Map<String, dynamic>? data;
  @override
  State<EditAppartmentForRentView> createState() =>
      _EditAppartmentForRentViewState();
}

class _EditAppartmentForRentViewState extends State<EditAppartmentForRentView> {
  final EditAppartmentForRentViewModel _viewModel =
      EditAppartmentForRentViewModel();

  @override
  void initState() {
    Future.wait([
      _viewModel.getAdData(widget.data?['ad_id'], widget.data?['category_id'])
    ]);
    super.initState();
  }

  @override
  void dispose() {
    EditConfirmBeforeSendViewModel.propertyAdDetails.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Scaffold(
          backgroundColor: ColorManager.bgColor,
          resizeToAvoidBottomInset: false,
          body: Consumer<EditAppartmentForRentViewModel>(
            builder: (BuildContext context, viewModel, Widget? child) =>
                SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: displayHeight(context) * 0.05,
                  ),
                  SizedBox(
                    width: displayWidth(context),
                    height: AppSize.s60,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: SvgPicture.asset(
                              'assets/images/arrow-circle-left.svg'),
                        ),
                        TextContainer(
                          width: displayWidth(context) * 0.77,
                          text: AppStrings.apartmentForRentText
                              .getString(context),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.025,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: displayWidth(context) * 0.012,
                    children: [
                      for (var element in viewModel.rentPayPeriod)
                        ChoiceChip(
                          showCheckmark: false,
                          label: TextContainer(
                            text: element.getString(context),
                            width: displayWidth(context) * 0.215,
                            height: displayHeight(context) * 0.03,
                            align: Alignment.center,
                            textAlign: TextAlign.center,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: viewModel.rentPayPeriodChoice == element
                                ? ColorManager.fontColor
                                : ColorManager.fontColor3,
                          ),
                          selected: viewModel.rentPayPeriodChoice == element,
                          backgroundColor: ColorManager.whiteColor,
                          disabledColor: ColorManager.whiteColor,
                          selectedColor: ColorManager.focusedInputFieldColor,
                          elevation: 1,
                          onSelected: (value) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .rentPayPeriodChoice = element;
                            viewModel.rentPayPeriodChoice = element;
                            viewModel.toggleNotifyListener();
                          },
                          shadowColor: ColorManager.transblackColor25,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: ColorManager.transblackColor25,
                                  width: 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  displayHeight(context) * 0.015))),
                        ),
                    ],
                  ),
                  TextContainer(
                    text: AppStrings.bedroomText.getString(context),
                    width: displayWidth(context) * 0.9,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.fontColor3,
                    margin: EdgeInsets.only(
                        bottom: displayHeight(context) * 0.01,
                        top: displayHeight(context) * 0.015),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: displayWidth(context) * 0.012,
                    children: [
                      for (var element in viewModel.bedroomsQuantity)
                        ChoiceChip(
                          showCheckmark: false,
                          label: TextContainer(
                            text: element.getString(context),
                            width: displayWidth(context) * 0.078,
                            height: displayHeight(context) * 0.048,
                            textAlign: TextAlign.center,
                            align: Alignment.center,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: viewModel.bedroomsChoice == element
                                ? ColorManager.fontColor
                                : ColorManager.fontColor3,
                          ),
                          selected: viewModel.bedroomsChoice == element,
                          backgroundColor: ColorManager.whiteColor,
                          disabledColor: ColorManager.whiteColor,
                          selectedColor: ColorManager.focusedInputFieldColor,
                          padding: const EdgeInsets.symmetric(),
                          elevation: 1,
                          onSelected: (value) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .bedroomsChoice = element;
                            viewModel.bedroomsChoice = element;
                            viewModel.toggleNotifyListener();
                          },
                          shadowColor: ColorManager.transblackColor25,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: ColorManager.transblackColor25,
                                  width: 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  displayHeight(context) * 0.015))),
                        ),
                    ],
                  ),
                  TextContainer(
                    text: AppStrings.livingRoomText.getString(context),
                    width: displayWidth(context) * 0.9,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.fontColor3,
                    margin: EdgeInsets.only(
                        bottom: displayHeight(context) * 0.01,
                        top: displayHeight(context) * 0.02),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: displayWidth(context) * 0.01,
                    children: [
                      for (var element in viewModel.livingRoomsQuantity)
                        ChoiceChip(
                          showCheckmark: false,
                          label: TextContainer(
                            text: element.getString(context),
                            width: displayWidth(context) * 0.1383,
                            height: displayHeight(context) * 0.03,
                            textAlign: TextAlign.center,
                            align: Alignment.center,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: viewModel.livingRoomChoice == element
                                ? ColorManager.fontColor
                                : ColorManager.fontColor3,
                          ),
                          selected: viewModel.livingRoomChoice == element,
                          backgroundColor: ColorManager.whiteColor,
                          disabledColor: ColorManager.whiteColor,
                          selectedColor: ColorManager.focusedInputFieldColor,
                          elevation: 1,
                          onSelected: (value) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .livingRoomChoice = element;
                            viewModel.livingRoomChoice = element;
                            viewModel.toggleNotifyListener();
                          },
                          shadowColor: ColorManager.transblackColor25,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: ColorManager.transblackColor25,
                                  width: 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  displayHeight(context) * 0.015))),
                        ),
                    ],
                  ),
                  TextContainer(
                    text: AppStrings.bathRoomText.getString(context),
                    width: displayWidth(context) * 0.9,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.fontColor3,
                    margin: EdgeInsets.only(
                        bottom: displayHeight(context) * 0.01,
                        top: displayHeight(context) * 0.02),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: displayWidth(context) * 0.01,
                    children: [
                      for (var element in viewModel.bathroomsQuantity)
                        ChoiceChip(
                          showCheckmark: false,
                          label: TextContainer(
                            text: element.getString(context),
                            width: displayWidth(context) * 0.1383,
                            height: displayHeight(context) * 0.03,
                            textAlign: TextAlign.center,
                            align: Alignment.center,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: viewModel.bathroomsChoice == element
                                ? ColorManager.fontColor
                                : ColorManager.fontColor3,
                          ),
                          selected: viewModel.bathroomsChoice == element,
                          backgroundColor: ColorManager.whiteColor,
                          disabledColor: ColorManager.whiteColor,
                          selectedColor: ColorManager.focusedInputFieldColor,
                          elevation: 1,
                          onSelected: (value) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .bathroomsChoice = element;
                            viewModel.bathroomsChoice = element;
                            viewModel.toggleNotifyListener();
                          },
                          shadowColor: ColorManager.transblackColor25,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: ColorManager.transblackColor25,
                                  width: 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  displayHeight(context) * 0.015))),
                        ),
                    ],
                  ),
                  TextContainer(
                    text: AppStrings.priceText.getString(context),
                    width: displayWidth(context) * 0.9,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.fontColor3,
                    margin: EdgeInsets.only(
                        bottom: displayHeight(context) * 0.01,
                        top: displayHeight(context) * 0.02),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextInputField(
                          controller: viewModel.priceFromController,
                          width: ValueHolders.adsOrRequest == 'Ads'
                              ? displayWidth(context) * 0.88
                              : displayWidth(context) * 0.38,
                          height: displayHeight(context) * 0.055,
                          errorBorderRadius: displayHeight(context) * 0.02,
                          enabledBorderRadius: displayHeight(context) * 0.02,
                          focusedBorderRadius: displayHeight(context) * 0.02,
                          maxLines: 1,
                          obsecureText: false,
                          fillColor: ColorManager.greyColor3,
                          keyboardType: TextInputType.number,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: displayWidth(context) * 0.045),
                          hintText: ValueHolders.adsOrRequest == 'Request'
                              ? AppStrings.fromText.getString(context)
                              : null,
                        ),
                        if (ValueHolders.adsOrRequest == 'Request')
                          TextContainer(
                            text: '-',
                            fontSize: 13,
                            color: ColorManager.fontColor3,
                            fontWeight: FontWeight.w700,
                            width: displayWidth(context) * 0.115,
                            textAlign: TextAlign.center,
                          ),
                        if (ValueHolders.adsOrRequest == 'Request')
                          TextInputField(
                            controller: viewModel.priceToController,
                            width: displayWidth(context) * 0.38,
                            height: displayHeight(context) * 0.055,
                            errorBorderRadius: displayHeight(context) * 0.02,
                            enabledBorderRadius: displayHeight(context) * 0.02,
                            focusedBorderRadius: displayHeight(context) * 0.02,
                            maxLines: 1,
                            obsecureText: false,
                            fillColor: ColorManager.greyColor3,
                            keyboardType: TextInputType.number,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: displayWidth(context) * 0.045),
                            hintText: AppStrings.toText.getString(context),
                          ),
                      ],
                    ),
                  ),
                  TextContainer(
                    text: AppStrings.floorText.getString(context),
                    width: displayWidth(context) * 0.9,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.fontColor3,
                    margin: EdgeInsets.only(
                        bottom: displayHeight(context) * 0.01,
                        top: displayHeight(context) * 0.02),
                  ),
                  Container(
                    width: displayWidth(context) * 0.88,
                    height: displayHeight(context) * 0.055,
                    // padding:
                    //     EdgeInsets.only(left: displayWidth(context) * 0.05),
                    decoration: BoxDecoration(
                      color: ColorManager.greyColor3,
                      borderRadius:
                          BorderRadius.circular(displayHeight(context) * 0.02),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          elevation: 2,
                          alignment: AlignmentDirectional.topStart,
                          menuMaxHeight: displayHeight(context) * 0.3,
                          padding: EdgeInsets.only(
                              left: displayWidth(context) * 0.01),
                          borderRadius: BorderRadius.all(
                              Radius.circular(displayHeight(context) * 0.02)),
                          value: viewModel.floorNumberChoice,
                          icon: Container(
                            alignment: AlignmentDirectional.centerStart,
                            margin: EdgeInsets.only(
                                right: displayWidth(context) * 0.04),
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: ColorManager.lightGreenColor,
                            ),
                          ),
                          items: viewModel.floorNumbers
                              .map<DropdownMenuItem<String>>((String e) {
                            return DropdownMenuItem(
                              value: e,
                              child: TextContainer(
                                text: e.getString(context),
                                fontSize: 16,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.fontColor3,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .floorNumberChoice = newValue!;
                            viewModel.toggleNotifyListener();
                          },
                        ),
                      ),
                    ),
                  ),
                  TextContainer(
                    text: AppStrings.propertyAgeText.getString(context),
                    width: displayWidth(context) * 0.9,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.fontColor3,
                    margin: EdgeInsets.only(
                        bottom: displayHeight(context) * 0.01,
                        top: displayHeight(context) * 0.02),
                  ),
                  Container(
                    width: displayWidth(context) * 0.88,
                    height: displayHeight(context) * 0.055,
                    // padding:
                    //     EdgeInsets.only(left: displayWidth(context) * 0.05),
                    decoration: BoxDecoration(
                      color: ColorManager.greyColor3,
                      borderRadius:
                          BorderRadius.circular(displayHeight(context) * 0.02),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          elevation: 2,
                          alignment: AlignmentDirectional.topStart,
                          menuMaxHeight: displayHeight(context) * 0.3,
                          padding: EdgeInsets.only(
                              left: displayWidth(context) * 0.01),
                          borderRadius: BorderRadius.all(
                              Radius.circular(displayHeight(context) * 0.02)),
                          value: viewModel.propertyAgeChoice,
                          icon: Container(
                            alignment: AlignmentDirectional.centerStart,
                            margin: EdgeInsets.only(
                                right: displayWidth(context) * 0.04),
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: ColorManager.lightGreenColor,
                            ),
                          ),
                          items: viewModel.propertyAges
                              .map<DropdownMenuItem<String>>((String e) {
                            return DropdownMenuItem(
                              value: e,
                              child: TextContainer(
                                text: e.getString(context),
                                fontSize: 16,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.fontColor3,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .propertyAgeChoice = newValue!;
                            viewModel.toggleNotifyListener();
                          },
                        ),
                      ),
                    ),
                  ),
                  TextContainer(
                    text: AppStrings.areaText.getString(context),
                    width: displayWidth(context) * 0.9,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.fontColor3,
                    margin: EdgeInsets.only(
                        bottom: displayHeight(context) * 0.01,
                        top: displayHeight(context) * 0.02),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextInputField(
                          controller: viewModel.areaFromController,
                          width: ValueHolders.adsOrRequest == 'Ads'
                              ? displayWidth(context) * 0.88
                              : displayWidth(context) * 0.38,
                          height: displayHeight(context) * 0.055,
                          errorBorderRadius: displayHeight(context) * 0.02,
                          enabledBorderRadius: displayHeight(context) * 0.02,
                          focusedBorderRadius: displayHeight(context) * 0.02,
                          maxLines: 1,
                          obsecureText: false,
                          fillColor: ColorManager.greyColor3,
                          keyboardType: TextInputType.number,
                          hintText: ValueHolders.adsOrRequest == 'Request'
                              ? AppStrings.fromText.getString(context)
                              : null,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: displayWidth(context) * 0.045),
                        ),
                        if (ValueHolders.adsOrRequest == 'Request')
                          TextContainer(
                            text: '-',
                            fontSize: 13,
                            color: ColorManager.fontColor3,
                            fontWeight: FontWeight.w700,
                            width: displayWidth(context) * 0.115,
                            textAlign: TextAlign.center,
                          ),
                        if (ValueHolders.adsOrRequest == 'Request')
                          TextInputField(
                            controller: viewModel.areaToController,
                            width: displayWidth(context) * 0.38,
                            height: displayHeight(context) * 0.055,
                            errorBorderRadius: displayHeight(context) * 0.02,
                            enabledBorderRadius: displayHeight(context) * 0.02,
                            focusedBorderRadius: displayHeight(context) * 0.02,
                            maxLines: 1,
                            obsecureText: false,
                            fillColor: ColorManager.greyColor3,
                            keyboardType: TextInputType.number,
                            hintText: AppStrings.toText.getString(context),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: displayWidth(context) * 0.045),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextContainer(
                        text: AppStrings.furnishedText.getString(context),
                        width: displayWidth(context) * 0.76,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.fontColor3,
                        margin: EdgeInsets.only(
                            bottom: displayHeight(context) * 0.01,
                            top: displayHeight(context) * 0.02),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.06,
                        child: Switch(
                          value: viewModel.isFurnished,
                          onChanged: (b) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .isFurnished = b;
                            viewModel.toggleNotifyListener();
                          },
                          activeColor: ColorManager.whiteColor,
                          inactiveTrackColor: ColorManager.greyColor2,
                          inactiveThumbColor: ColorManager.whiteColor,
                          trackOutlineWidth: const WidgetStatePropertyAll(0),
                          trackOutlineColor: const WidgetStatePropertyAll(
                              ColorManager.greyColor2),
                          activeTrackColor: ColorManager.lightGreenColor,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextContainer(
                        text: AppStrings.carEntranceText.getString(context),
                        width: displayWidth(context) * 0.76,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.fontColor3,
                        margin: EdgeInsets.only(
                            bottom: displayHeight(context) * 0.01,
                            top: displayHeight(context) * 0.02),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.06,
                        child: Switch(
                          value: viewModel.haveCarEntrance,
                          onChanged: (b) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .haveCarEntrance = b;
                            viewModel.toggleNotifyListener();
                          },
                          activeColor: ColorManager.whiteColor,
                          inactiveTrackColor: ColorManager.greyColor2,
                          inactiveThumbColor: ColorManager.whiteColor,
                          trackOutlineWidth: const WidgetStatePropertyAll(0),
                          trackOutlineColor: const WidgetStatePropertyAll(
                              ColorManager.greyColor2),
                          activeTrackColor: ColorManager.lightGreenColor,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextContainer(
                        text: AppStrings.specialRoofText.getString(context),
                        width: displayWidth(context) * 0.76,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.fontColor3,
                        margin: EdgeInsets.only(
                            bottom: displayHeight(context) * 0.01,
                            top: displayHeight(context) * 0.02),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.06,
                        child: Switch(
                          value: viewModel.haveSpecialRoof,
                          onChanged: (b) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .haveSpecialRoof = b;
                            viewModel.toggleNotifyListener();
                          },
                          activeColor: ColorManager.whiteColor,
                          inactiveTrackColor: ColorManager.greyColor2,
                          inactiveThumbColor: ColorManager.whiteColor,
                          trackOutlineWidth: const WidgetStatePropertyAll(0),
                          trackOutlineColor: const WidgetStatePropertyAll(
                              ColorManager.greyColor2),
                          activeTrackColor: ColorManager.lightGreenColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextContainer(
                        text: AppStrings.inAVillaText.getString(context),
                        width: displayWidth(context) * 0.76,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.fontColor3,
                        margin: EdgeInsets.only(
                            bottom: displayHeight(context) * 0.01,
                            top: displayHeight(context) * 0.02),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.06,
                        child: Switch(
                          value: viewModel.inAVilla,
                          onChanged: (b) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .inAVilla = b;
                            viewModel.toggleNotifyListener();
                          },
                          activeColor: ColorManager.whiteColor,
                          inactiveTrackColor: ColorManager.greyColor2,
                          inactiveThumbColor: ColorManager.whiteColor,
                          trackOutlineWidth: const WidgetStatePropertyAll(0),
                          trackOutlineColor: const WidgetStatePropertyAll(
                              ColorManager.greyColor2),
                          activeTrackColor: ColorManager.lightGreenColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextContainer(
                        text: AppStrings.doubleEntranceText.getString(context),
                        width: displayWidth(context) * 0.76,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.fontColor3,
                        margin: EdgeInsets.only(
                            bottom: displayHeight(context) * 0.01,
                            top: displayHeight(context) * 0.02),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.06,
                        child: Switch(
                          value: viewModel.havedoubleEntrances,
                          onChanged: (b) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .havedoubleEntrances = b;
                            viewModel.toggleNotifyListener();
                          },
                          activeColor: ColorManager.whiteColor,
                          inactiveTrackColor: ColorManager.greyColor2,
                          inactiveThumbColor: ColorManager.whiteColor,
                          trackOutlineWidth: const WidgetStatePropertyAll(0),
                          trackOutlineColor: const WidgetStatePropertyAll(
                              ColorManager.greyColor2),
                          activeTrackColor: ColorManager.lightGreenColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextContainer(
                        text:
                            AppStrings.speacialEntranceText.getString(context),
                        width: displayWidth(context) * 0.76,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.fontColor3,
                        margin: EdgeInsets.only(
                            bottom: displayHeight(context) * 0.01,
                            top: displayHeight(context) * 0.02),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.06,
                        child: Switch(
                          value: viewModel.haveSpecialEntrance,
                          onChanged: (b) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .haveSpecialEntrance = b;
                            viewModel.toggleNotifyListener();
                          },
                          activeColor: ColorManager.whiteColor,
                          inactiveTrackColor: ColorManager.greyColor2,
                          inactiveThumbColor: ColorManager.whiteColor,
                          trackOutlineWidth: const WidgetStatePropertyAll(0),
                          trackOutlineColor: const WidgetStatePropertyAll(
                              ColorManager.greyColor2),
                          activeTrackColor: ColorManager.lightGreenColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextContainer(
                        text: AppStrings.airConditionedText.getString(context),
                        width: displayWidth(context) * 0.76,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.fontColor3,
                        margin: EdgeInsets.only(
                            bottom: displayHeight(context) * 0.01,
                            top: displayHeight(context) * 0.02),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.06,
                        child: Switch(
                          value: viewModel.isAirConditioned,
                          onChanged: (b) {
                            Provider.of<EditAppartmentForRentViewModel>(context,
                                    listen: false)
                                .isAirConditioned = b;
                            viewModel.toggleNotifyListener();
                          },
                          activeColor: ColorManager.whiteColor,
                          inactiveTrackColor: ColorManager.greyColor2,
                          inactiveThumbColor: ColorManager.whiteColor,
                          trackOutlineWidth: const WidgetStatePropertyAll(0),
                          trackOutlineColor: const WidgetStatePropertyAll(
                              ColorManager.greyColor2),
                          activeTrackColor: ColorManager.lightGreenColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.45,
                    height: displayHeight(context) * 0.06,
                    child: ElevatedButton(
                        onPressed: () async {
                          viewModel.assignAdValsToConfirmDetailsMap(context);
                          bool anyEmpty = viewModel.checkEmpty(context);
                          if (anyEmpty != false) {
                            context.push('/edit_my_ads/discription/view',
                                extra: viewModel.adDetails);
                          }

                          // context.push('/add_ad_or_req/choosing_media/view');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.buttonsColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    displayHeight(context) * 0.03))),
                        child: TextContainer(
                          fontSize: 20,
                          text: AppStrings.nextText.getString(context),
                          color: ColorManager.fontColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
