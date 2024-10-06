import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3AC387),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BottomRoundedContainer(
              color: const Color(0xffffffff),
              height: displayHeight(context) * 0.5,
              widgets: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: AppSize.s3,
                        width: displayWidth(context) * 0.25,
                        margin:
                            EdgeInsets.only(top: displayHeight(context) * 0.04),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s20),
                          color: ColorManager.bgColor2,
                        ),
                      ),
                      TextContainer(
                        text: 'Reset Password',
                        fontSize: 30,
                        fontFamily: 'Outfit',
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.15,
                      ),
                      TextContainer(
                        width: displayWidth(context) * 0.75,
                        text: AppStrings.phoneNumberText.getString(context),
                        fontSize: 16,
                        color: ColorManager.loginPageFontColor,
                         
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                        margin: const EdgeInsets.only(bottom: AppMargin.m10),
                      ),
                      TextInputField(
                        // controller: _viewModel.phoneNumberController,
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
                      SizedBox(
                        height: displayHeight(context) * 0.05,
                      ),
                      SizedBox(
                        width: displayWidth(context) * 0.6,
                        height: AppSize.s50,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  // var res = await _viewModel.signInWithEmail(
                                  //     _viewModel.phoneNumberController.text,
                                  //     _viewModel.passwordController.text);
                                } catch (e) {
                                  print(e);
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
                              text: AppStrings.signinText.getString(context),
                              color: ColorManager.fontColor,
                               
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
