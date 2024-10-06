import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

class changePhoneView extends StatefulWidget {
  const changePhoneView({super.key});

  @override
  State<changePhoneView> createState() => changePhoneViewState();
}

class changePhoneViewState extends State<changePhoneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: ColorManager.bgColor,
       resizeToAvoidBottomInset: false,
       body: SingleChildScrollView(
         child: Column(
          children: [
            SizedBox(
                height: displayHeight(context) * 0.06,
              ),
              SizedBox(
                width: displayWidth(context),
                height: AppSize.s60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon:
                          SvgPicture.asset('assets/images/arrow-circle-left.svg'),
                    ),
                    TextContainer(
                      width: displayWidth(context) * 0.69,
                      text: AppStrings.changePhoneText.getString(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                       
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                        height: displayHeight(context) * 0.08,
                      ),
                      TextContainer(
                        width: displayWidth(context) * 0.75,
                        text: AppStrings.newPhoneNumberText.getString(context),
                        fontSize: 16,
                        color: ColorManager.loginPageFontColor,
                         
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                        margin: const EdgeInsets.only(bottom: AppMargin.m10),
                      ),
                      TextInputField(
                        // controller: _viewModel.phoneNumberController,
                        width: displayWidth(context) * 0.85,
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
                        height: displayHeight(context) * 0.5,
                      ),
                     SizedBox(
                        width: displayWidth(context) * 0.6,
                        height: AppSize.s50,
                        child: ElevatedButton(
                            onPressed: () async {
                              // if (_formKey.currentState!.validate()) {
                              //   try {
                              //     var res = await _viewModel.signInWithEmail(
                              //         _viewModel.phoneNumberController.text,
                              //         _viewModel.passwordController.text);
                              //   } catch (e) {
                              //     print(e);
                              //   }
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.buttonsColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s30))),
                            child: TextContainer(
                              fontSize: 20,
                              text: AppStrings.saveText.getString(context),
                              color: ColorManager.fontColor,
                               
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      
                     
          ],
       
           ),
       )
    );
  }
}