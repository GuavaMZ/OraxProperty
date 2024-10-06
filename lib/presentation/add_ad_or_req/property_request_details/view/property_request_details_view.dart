import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/property_request_details/viewmodel/property_request_details_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class PropertyRequestDetailsView extends StatefulWidget {
  const PropertyRequestDetailsView({super.key});

  @override
  State<PropertyRequestDetailsView> createState() =>
      _PropertyRequestDetailsViewState();
}

class _PropertyRequestDetailsViewState extends State<PropertyRequestDetailsView>
    with SingleTickerProviderStateMixin {
  final PropertyRequestDetailsViewModel _viewModel =
      PropertyRequestDetailsViewModel();

  @override
  void initState() {
    _viewModel.requestPagesController = TabController(
      length: 6,
      vsync: this,
    );

    Future.wait(
        [_viewModel.getAllowedCountries(), _viewModel.getPropertyCategories()]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _viewModel,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorManager.bgColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: displayHeight(context) * 0.05,
                ),
                SizedBox(
                  width: displayWidth(context),
                  height: AppSize.s60,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
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
                        text: AppStrings.propertyDetailsText.getString(context),
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
                TextContainer(
                  text: AppStrings.propertyTypeText.getString(context),
                  width: displayWidth(context) * 0.9,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.fontColor3,
                  margin: EdgeInsets.only(
                      bottom: displayHeight(context) * 0.01,
                      top: displayHeight(context) * 0.015),
                ),
                Consumer<PropertyRequestDetailsViewModel>(
                  builder: (BuildContext context, viewModel, Widget? child) =>
                      DropdownButtonFormField(
                    elevation: 1,
                    alignment: AlignmentDirectional.bottomCenter,
                    borderRadius: BorderRadius.all(
                        Radius.circular(displayHeight(context) * 0.04)),
                    value: _viewModel.propertyCategory,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: displayWidth(context) * 0.04),
                      constraints: BoxConstraints(
                          maxWidth: displayWidth(context) * 0.9,
                          maxHeight: displayHeight(context) * 0.063),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(
                            displayHeight(context) * 0.02),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(
                            displayHeight(context) * 0.02),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(
                            displayHeight(context) * 0.02),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(
                            displayHeight(context) * 0.02),
                      ),
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: ColorManager.lightGreenColor,
                    ),
                    items: _viewModel.categories
                        .map<DropdownMenuItem<dynamic>>((e) {
                      return DropdownMenuItem(
                        value: e['category_name'],
                        child: TextContainer(
                          text:
                              e['category_name'].toString().getString(context),
                          fontSize: 16,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.lightGreenColor,
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      Provider.of<PropertyRequestDetailsViewModel>(context,
                              listen: false)
                          .changePropertyCategoryAndPage(newValue!);
                    },
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                TextContainer(
                  text: AppStrings.countryText.getString(context),
                  width: displayWidth(context) * 0.9,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.fontColor3,
                  margin: EdgeInsets.only(
                      bottom: displayHeight(context) * 0.01,
                      top: displayHeight(context) * 0.015),
                ),
                Consumer<PropertyRequestDetailsViewModel>(
                  builder: (BuildContext context, viewModel, Widget? child) =>
                      DropdownButtonFormField(
                    elevation: 1,
                    alignment: AlignmentDirectional.bottomCenter,
                    borderRadius: BorderRadius.all(
                        Radius.circular(displayHeight(context) * 0.04)),
                    value: _viewModel.propertyCountry,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: displayWidth(context) * 0.04),
                      constraints: BoxConstraints(
                          maxWidth: displayWidth(context) * 0.9,
                          maxHeight: displayHeight(context) * 0.063),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(
                            displayHeight(context) * 0.02),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(
                            displayHeight(context) * 0.02),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(
                            displayHeight(context) * 0.02),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        borderRadius: BorderRadius.circular(
                            displayHeight(context) * 0.02),
                      ),
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: ColorManager.lightGreenColor,
                    ),
                    items: _viewModel.countries
                        .map<DropdownMenuItem<dynamic>>((e) {
                      return DropdownMenuItem(
                        value: e['country_name_ar'],
                        child: TextContainer(
                          text: e['country_name_ar'],
                          fontSize: 16,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.lightGreenColor,
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      Provider.of<PropertyRequestDetailsViewModel>(context,
                              listen: false)
                          .changeCountry(newValue!);
                    },
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
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
                        controller: _viewModel.areaFromController,
                        width: displayWidth(context) * 0.38,
                        height: displayHeight(context) * 0.055,
                        errorBorderRadius: displayHeight(context) * 0.02,
                        enabledBorderRadius: displayHeight(context) * 0.02,
                        focusedBorderRadius: displayHeight(context) * 0.02,
                        maxLines: 1,
                        obsecureText: false,
                        fillColor: ColorManager.greyColor3,
                        keyboardType: TextInputType.number,
                        hintText: AppStrings.fromText.getString(context),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: displayWidth(context) * 0.045),
                      ),
                      TextContainer(
                        text: '-',
                        fontSize: 13,
                        color: ColorManager.fontColor3,
                        fontWeight: FontWeight.w700,
                        width: displayWidth(context) * 0.115,
                        textAlign: TextAlign.center,
                      ),
                      TextInputField(
                        controller: _viewModel.areaToController,
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
                          controller: _viewModel.priceFromController,
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
                          hintText: AppStrings.fromText.getString(context)),
                      TextContainer(
                        text: '-',
                        fontSize: 13,
                        color: ColorManager.fontColor3,
                        fontWeight: FontWeight.w700,
                        width: displayWidth(context) * 0.115,
                        textAlign: TextAlign.center,
                      ),
                      TextInputField(
                        controller: _viewModel.priceToController,
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
                  text: AppStrings.discriptionText.getString(context),
                  width: displayWidth(context) * 0.9,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.fontColor3,
                  margin: EdgeInsets.only(
                      bottom: displayHeight(context) * 0.01,
                      top: displayHeight(context) * 0.015),
                ),

                TextInputField(
                  controller: _viewModel.discriptionController,
                  width: displayWidth(context) * 0.9,
                  height: displayHeight(context) * 0.22,
                  focusedBorderRadius: displayHeight(context) * 0.03,
                  errorBorderRadius: displayHeight(context) * 0.03,
                  enabledBorderRadius: displayHeight(context) * 0.03,
                  maxLines: 6,
                  obsecureText: false,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                TextContainer(
                  text: AppStrings.phoneNumberText.getString(context),
                  width: displayWidth(context) * 0.9,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.fontColor3,
                  margin: EdgeInsets.only(
                      bottom: displayHeight(context) * 0.01,
                      top: displayHeight(context) * 0.015),
                ),

                TextInputField(
                  controller: _viewModel.phoneNumberController,
                  width: displayWidth(context) * 0.9,
                  height: AppSize.s50,
                  focusedBorderRadius: displayHeight(context) * 0.03,
                  errorBorderRadius: displayHeight(context) * 0.03,
                  enabledBorderRadius: displayHeight(context) * 0.03,
                  contentPadding: const EdgeInsets.only(left: AppPadding.p16),
                  obsecureText: false,
                  maxLines: 1,
                  // suffixIcon: SvgPicture.asset(assetName),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                TextContainer(
                  text: AppStrings.emailText.getString(context),
                  width: displayWidth(context) * 0.9,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.fontColor3,
                  margin: EdgeInsets.only(
                      bottom: displayHeight(context) * 0.01,
                      top: displayHeight(context) * 0.015),
                ),
                TextInputField(
                  controller: _viewModel.emailController,
                  width: displayWidth(context) * 0.9,
                  height: AppSize.s50,
                  focusedBorderRadius: displayHeight(context) * 0.03,
                  errorBorderRadius: displayHeight(context) * 0.03,
                  enabledBorderRadius: displayHeight(context) * 0.03,
                  contentPadding: const EdgeInsets.only(left: AppPadding.p16),
                  obsecureText: false,
                  maxLines: 1,
                  // suffixIcon: SvgPicture.asset(assetName),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                SizedBox(
                  width: displayWidth(context) * 0.45,
                  height: displayHeight(context) * 0.06,
                  child: ElevatedButton(
                      onPressed: () async {
                        showProgressIndicator(context, true,
                            AppStrings.uploadingAdText.getString(context));
                        try {
                          await _viewModel.assginValuesToMap();
                          await _viewModel.postPropertyOrder();
                        } catch (e) {
                          print(e);
                        }
                        context.pop();
                        // context.push('/add_ad_or_req/choosing_media/view');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.buttonsColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  displayHeight(context) * 0.03))),
                      child: TextContainer(
                        fontSize: 20,
                        text: AppStrings.confirmText.getString(context),
                        color: ColorManager.fontColor,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.04,
                ),
                // Expanded(
                //   child: TabBarView(
                //     physics: const NeverScrollableScrollPhysics(),
                //     controller: _viewModel.requestPagesController,
                //     // onPageChanged: (index) {},
                //     children: [
                //       SingleChildScrollView(
                //         child: Column(
                //           children: [

                //           ],
                //         ),
                //       ),
                //       SingleChildScrollView(),
                //       SingleChildScrollView(),
                //       SingleChildScrollView(),
                //       SingleChildScrollView(),
                //       SingleChildScrollView(),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}
