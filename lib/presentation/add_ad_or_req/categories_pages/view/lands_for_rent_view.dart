import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/viewmodel/lands_for_rent_viewmodel.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/confirm_before_seding/viewmodel/confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class LandsForRentView extends StatefulWidget {
  const LandsForRentView({super.key});

  @override
  State<LandsForRentView> createState() => _LandsForRentViewState();
}

class _LandsForRentViewState extends State<LandsForRentView> {
    @override
  void dispose() {
    ConfirmBeforeSendViewModel.propertyAdDetails.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LandsForRentViewModel(),
      child: Scaffold(
        backgroundColor: ColorManager.bgColor,
        resizeToAvoidBottomInset: false,
        body: Consumer<LandsForRentViewModel>(
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
                              text:
                                  AppStrings.landForRentText.getString(context),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      TextContainer(
                        text: AppStrings.priceText.getString(context),
                        width: displayWidth(context) * 0.9,
                        fontSize: 13,
                        color: const Color.fromARGB(255, 135, 88, 88),
                        margin: EdgeInsets.only(
                            bottom: displayHeight(context) * 0.01,
                            top: displayHeight(context) * 0.02),
                      ), // Textcontainer
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
                              errorBorderRadius: displayHeight(context) * 0.015,
                              enabledBorderRadius:
                                  displayHeight(context) * 0.015,
                              focusedBorderRadius:
                                  displayHeight(context) * 0.015,
                              maxLines: 1,
                              obsecureText: false,
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
                                errorBorderRadius:
                                    displayHeight(context) * 0.015,
                                enabledBorderRadius:
                                    displayHeight(context) * 0.015,
                                focusedBorderRadius:
                                    displayHeight(context) * 0.015,
                                maxLines: 1,
                                obsecureText: false,
                                keyboardType: TextInputType.number,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: displayWidth(context) * 0.045),
                                hintText: AppStrings.toText.getString(context),
                              ),
                          ],
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
                              errorBorderRadius: displayHeight(context) * 0.015,
                              enabledBorderRadius:
                                  displayHeight(context) * 0.015,
                              focusedBorderRadius:
                                  displayHeight(context) * 0.015,
                              maxLines: 1,
                              obsecureText: false,
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
                                errorBorderRadius:
                                    displayHeight(context) * 0.015,
                                enabledBorderRadius:
                                    displayHeight(context) * 0.015,
                                focusedBorderRadius:
                                    displayHeight(context) * 0.015,
                                maxLines: 1,
                                obsecureText: false,
                                keyboardType: TextInputType.number,
                                hintText: AppStrings.toText.getString(context),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: displayWidth(context) * 0.045),
                              ),
                          ],
                        ),
                      ),
                      TextContainer(
                        width: displayWidth(context) * 0.9,
                        text: AppStrings.landTypeText.getString(context),
                        fontSize: 13,
                        color: ColorManager.blackColor,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                        margin: EdgeInsets.only(
                            bottom: displayHeight(context) * 0.01,
                            top: displayHeight(context) * 0.02),
                      ),
                      Container(
                        width: displayWidth(context) * 0.88,
                        height: displayHeight(context) * 0.06,
                        decoration: BoxDecoration(
                            color: ColorManager.lightGreyColor2,
                            borderRadius: BorderRadius.circular(
                                displayHeight(context) * 0.015),
                            boxShadow: const [
                              // BoxShadow(
                              //   color: Color(0x3F000000),
                              //   blurRadius: 4,
                              //   offset: Offset(0, 0),
                              //   spreadRadius: 0,
                              // )
                            ]),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              elevation: 2,
                              alignment: AlignmentDirectional.topStart,
                              value: viewModel.landTypeChoice,
                              padding: EdgeInsets.only(
                                  left: displayWidth(context) * 0.02),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  displayHeight(context) * 0.035)),
                              icon: Container(
                                alignment: AlignmentDirectional.centerStart,
                                margin: EdgeInsets.only(
                                    right: displayWidth(context) * 0.04),
                                child: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: ColorManager.lightGreenColor,
                                ),
                              ),
                              items: [
                                for (String type in viewModel.landsType)
                                  DropdownMenuItem(
                                    value: type,
                                    child: TextContainer(
                                      text: type.getString(context),
                                      fontSize: 14,
                                      width: displayWidth(context) * 0.68,
                                      color: ColorManager.fontColor3,
                                    ),
                                  ),
                              ],
                              onChanged: (String? newValue) {
                                Provider.of<LandsForRentViewModel>(context,
                                        listen: false)
                                    .landTypeChoice = newValue;
                                viewModel.landTypeChoice = newValue;
                                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                viewModel.notifyListeners();
                              },
                            ),
                          ),
                        ),
                      ),
                      TextContainer(
                        text: AppStrings.streetWidthText.getString(context),
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
                          borderRadius: BorderRadius.circular(
                              displayHeight(context) * 0.02),
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
                              borderRadius: BorderRadius.all(Radius.circular(
                                  displayHeight(context) * 0.02)),
                              value: viewModel.streetWidthChoice,
                              icon: Container(
                                alignment: AlignmentDirectional.centerStart,
                                margin: EdgeInsets.only(
                                    right: displayWidth(context) * 0.04),
                                child: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: ColorManager.lightGreenColor,
                                ),
                              ),
                              items: viewModel.streetWidth
                                  .map<DropdownMenuItem<String>>((String e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: TextContainer(
                                    text: e.getString(context),
                                    fontSize: 16,
                                    color: ColorManager.fontColor3,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                Provider.of<LandsForRentViewModel>(context,
                                        listen: false)
                                    .streetWidthChoice = newValue!;
                                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                viewModel.notifyListeners();
                              },
                            ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      SizedBox(
                        width: displayWidth(context) * 0.45,
                        height: displayHeight(context) * 0.06,
                        child: ElevatedButton(
                            onPressed: () async {
                              viewModel
                                  .assignAdValsToConfirmDetailsMap(context);
                              bool anyEmpty = viewModel.checkEmpty(context);
                              if (anyEmpty != false) {
                                context.push('/add_ad_or_req/discription/view');
                              }
                              // context
                              //     .push('/add_ad_or_req/choosing_media/view');
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
                )),
      ),
    );
  }
}
