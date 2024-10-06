import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/app/app.dart';
import 'package:oraxproperty/app/shared_prefs.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final LoginViewModel _viewModel = LoginViewModel();
  // Widget showPasswordIcon = Icon(Icons.)
  @override
  void initState() {
    _viewModel.checkUserState(context);
    _viewModel.getUserFirstName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: ColorManager.bgColor2,
        // resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SizedBox(
                width: displayWidth(context),
                child: Image.asset(
                  ImageAssets.loginBgImage,
                  fit: BoxFit.fitWidth,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: BottomRoundedContainer(
                      height: displayHeight(context) * 0.72,
                      widgets: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: displayWidth(context) * 0.38,
                                ),
                                Container(
                                  height: AppSize.s3,
                                  width: displayWidth(context) * 0.25,
                                  margin: EdgeInsets.only(
                                      top: displayHeight(context) * 0.04),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s20),
                                    color: ColorManager.bgColor2,
                                  ),
                                ),
                                SizedBox(
                                  width: displayWidth(context) * 0.19,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: displayHeight(context) * 0.01),
                                  child: PopupMenuButton(
                                      position: PopupMenuPosition.under,
                                      itemBuilder: (BuildContext context) => [
                                            PopupMenuItem(
                                                child: TextButton(
                                              onPressed: () {
                                                if (localization
                                                        .getLanguageName() ==
                                                    'English') {
                                                  localization.translate('ar');
                                                } else {
                                                  localization.translate('en');
                                                }
                                              },
                                              child: TextContainer(
                                                  text: AppStrings.languageText
                                                      .getString(context),
                                                  fontSize: 14),
                                            )),
                                            PopupMenuItem(
                                                child: TextButton(
                                              onPressed: () {},
                                              child: TextContainer(
                                                  text: AppStrings.supportText
                                                      .getString(context),
                                                  fontSize: 14),
                                            )),
                                          ]),
                                )
                              ],
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.025,
                            ),
                            TextContainer(
                              width: displayWidth(context) * 0.75,
                              text: SharedPrefs.userFirstName != ''
                                  ? '${AppStrings.welcomeBackText.getString(context)} ${SharedPrefs.userFirstName}'
                                  : '',
                              fontSize: 20,
                              color: ColorManager.fontColor2,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
                              margin: EdgeInsets.only(
                                  bottom: displayHeight(context) * 0.035),
                            ),
                            TextContainer(
                              width: displayWidth(context) * 0.75,
                              text:
                                  AppStrings.phoneNumberText.getString(context),
                              fontSize: 16,
                              color: ColorManager.loginPageFontColor,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.left,
                              margin:
                                  const EdgeInsets.only(bottom: AppMargin.m10),
                            ),
                            TextInputField(
                              controller: _viewModel.phoneNumberController,
                              width: displayWidth(context) * 0.77,
                              height: AppSize.s50,
                              focusedBorderRadius: AppSize.s30,
                              enabledBorderRadius: AppSize.s30,
                              errorBorderRadius: AppSize.s30,
                              obsecureText: false,
                              keyboardType: TextInputType.phone,
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
                              color: ColorManager.loginPageFontColor,
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
                              // suffixIcon: SvgPicture.asset(assetName),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: displayWidth(context) * 0.54,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: TextContainer(
                                      text: AppStrings.forgotPasswordText
                                          .getString(context),
                                      fontSize: 12,
                                      color: ColorManager.loginPageFontColor,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            SizedBox(
                              width: displayWidth(context) * 0.6,
                              height: AppSize.s50,
                              child: Consumer<LoginViewModel>(
                                builder: (BuildContext context, viewModel,
                                        Widget? child) =>
                                    ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Provider.of<LoginViewModel>(context,
                                                    listen: false)
                                                .isLoading = true;
                                            showProgressIndicator(
                                                context,
                                                viewModel.isLoading,
                                                AppStrings.loggingInText
                                                    .getString(context));
                                            try {
                                              await _viewModel.userSignIn(
                                                  _viewModel
                                                      .phoneNumberController
                                                      .text,
                                                  _viewModel
                                                      .passwordController.text,
                                                  context);
                                            } catch (e) {
                                              print('E:$e');
                                            }
                                            viewModel.isLoading = false;
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorManager.buttonsColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s30))),
                                        child: TextContainer(
                                          fontSize: 20,
                                          text: AppStrings.signinText
                                              .getString(context),
                                          color: ColorManager.fontColor,
                                          fontWeight: FontWeight.bold,
                                        )),
                              ),
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            TextButton(
                                onPressed: () {
                                  context.push('/register');
                                },
                                child: TextContainer(
                                  text:
                                      AppStrings.signupText.getString(context),
                                  fontSize: 12,
                                  color: ColorManager.loginPageFontColor,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextButton(
                                onPressed: () {
                                  ValueHolders.isGuest = true;
                                  context.push('/homepage');
                                },
                                child: TextContainer(
                                  text: AppStrings.signinAsGuestText
                                      .getString(context),
                                  fontSize: 12,
                                  color: ColorManager.loginPageFontColor,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
