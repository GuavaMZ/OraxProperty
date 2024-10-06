import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final RegisterViewModel _viewModel = RegisterViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RegisterViewModel(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: ColorManager.bgColor2,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              child: BottomRoundedContainer(
                height: displayHeight(context) * 0.66,
                widgets: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: AppSize.s3,
                          width: displayWidth(context) * 0.25,
                          margin: EdgeInsets.only(
                              top: displayHeight(context) * 0.04),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            color: ColorManager.bgColor2,
                          ),
                        ),
                        TextContainer(
                          text: AppStrings.signupText.getString(context),
                          fontSize: 26,
                          color: ColorManager.signupPageFontColor,

                          fontWeight: FontWeightManager.regular,
                          // textAlign: TextAlign.left,
                          margin: const EdgeInsets.only(top: AppMargin.m15),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.045,
                        ),
                        TextContainer(
                          width: displayWidth(context) * 0.75,
                          text: AppStrings.phoneNumberText.getString(context),
                          fontSize: 16,
                          color: ColorManager.signupPageFontColor,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.left,
                          margin: const EdgeInsets.only(bottom: AppMargin.m10),
                        ),
                        TextInputField(
                          controller: _viewModel.phoneNumberController,
                          keyboardType: TextInputType.phone,
                          width: displayWidth(context) * 0.77,
                          height: AppSize.s50,
                          focusedBorderRadius: AppSize.s30,
                          enabledBorderRadius: AppSize.s30,
                          errorBorderRadius: AppSize.s30,
                          obsecureText: false,
                          contentPadding:
                              const EdgeInsets.only(left: AppPadding.p16),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                        TextContainer(
                          width: displayWidth(context) * 0.75,
                          text: AppStrings.passwordText.getString(context),
                          fontSize: 16,
                          color: ColorManager.signupPageFontColor,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.left,
                          margin: const EdgeInsets.only(
                              bottom: AppMargin.m10, top: AppMargin.m25),
                        ),
                        TextInputField(
                          controller: _viewModel.passwordController,
                          width: displayWidth(context) * 0.77,
                          height: AppSize.s50,
                          focusedBorderRadius: AppSize.s30,
                          enabledBorderRadius: AppSize.s30,
                          errorBorderRadius: AppSize.s30,
                          contentPadding:
                              const EdgeInsets.only(left: AppPadding.p16),
                          obsecureText: _viewModel.isPassObsecure,
                          maxLines: 1,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _viewModel.isPassObsecure =
                                      !_viewModel.isPassObsecure;
                                });
                              },
                              icon: SvgPicture.asset(ImageAssets.showPassIcon)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                        TextContainer(
                          width: displayWidth(context) * 0.75,
                          text: AppStrings.confirmPassText.getString(context),
                          fontSize: 16,
                          color: ColorManager.signupPageFontColor,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.left,
                          margin: const EdgeInsets.only(
                              bottom: AppMargin.m10, top: AppMargin.m25),
                        ),
                        TextInputField(
                          controller: _viewModel.confirmPasswordController,
                          width: displayWidth(context) * 0.77,
                          height: AppSize.s50,
                          focusedBorderRadius: AppSize.s30,
                          enabledBorderRadius: AppSize.s30,
                          errorBorderRadius: AppSize.s30,
                          contentPadding:
                              const EdgeInsets.only(left: AppPadding.p16),
                          obsecureText: _viewModel.isConfirmPassObsecure,
                          maxLines: 1,
                          suffixIcon: IconButton(
                              onPressed: () {
                                 setState(() {
                                  _viewModel.isConfirmPassObsecure =
                                      !_viewModel.isConfirmPassObsecure;
                                });
                              },
                              icon: SvgPicture.asset(ImageAssets.showPassIcon)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.045,
                        ),
                        SizedBox(
                          width: displayWidth(context) * 0.6,
                          height: AppSize.s50,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if(_viewModel.phoneNumberController.text.isEmpty){
                                     Fluttertoast.showToast(
                                        msg: AppStrings.phoneNumberIsEmptyText
                                            .getString(context));
                                    return;
                                  }
                                  if (_viewModel
                                          .passwordController.text.length <
                                      6) {
                                    Fluttertoast.showToast(
                                        msg: AppStrings.passwordConditionText
                                            .getString(context));
                                    return;
                                  }
                                  if (_viewModel.passwordController.text !=
                                      _viewModel
                                          .confirmPasswordController.text) {
                                    Fluttertoast.showToast(
                                        msg: AppStrings.notMatchedPasswordsText
                                            .getString(context));
                                    return;
                                  }
                                  try {
                                    ValueHolders.regUserDetails['user_phone'] =
                                        _viewModel.phoneNumberController.text;
                                    ValueHolders
                                            .regUserDetails['user_password'] =
                                        _viewModel.passwordController.text;
                                    context.push('/register/details');
                                  } catch (e) {
                                    Fluttertoast.showToast(msg: e.toString());
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.buttonsColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s30))),
                              child: TextContainer(
                                fontSize: 20,
                                text: AppStrings.signupText.getString(context),
                                color: ColorManager.fontColor,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
