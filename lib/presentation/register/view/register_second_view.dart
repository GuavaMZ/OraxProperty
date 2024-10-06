import 'package:flutter/material.dart';

import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterSecondView extends StatefulWidget {
  const RegisterSecondView({super.key});

  @override
  State<RegisterSecondView> createState() => _RegisterSecondViewState();
}

class _RegisterSecondViewState extends State<RegisterSecondView> {
  final _formKey = GlobalKey<FormState>();
  final RegisterViewModel _viewModel = RegisterViewModel();

  @override
  void dispose() {
    _viewModel.disposeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RegisterViewModel(),
      child: Scaffold(
        backgroundColor: ColorManager.bgColor2,
        // resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: BottomRoundedContainer(
                  height: displayHeight(context) * 0.9,
                  widgets: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            height: AppSize.s3,
                            width: displayWidth(context) * 0.25,
                            margin: EdgeInsets.only(
                                top: displayHeight(context) * 0.02),
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
                            margin: const EdgeInsets.only(
                                top: AppMargin.m10, bottom: AppMargin.m10),
                          ),
                          StatefulBuilder(
                              builder: (context, setImageProfileState) {
                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: displayWidth(context) * 0.105,
                                  backgroundColor: ColorManager.whiteColor,
                                  backgroundImage: _viewModel.imageTemp != null
                                      ? FileImage(_viewModel.imageTemp)
                                      : null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorManager.lightGreenColor,
                                        ),
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      try {
                                        await _viewModel.profileImagePicker();

                                        setImageProfileState(() {});
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: e.toString());
                                      }
                                    },
                                    child: TextContainer(
                                      fontSize: 15,
                                      text: AppStrings.uploadImageText
                                          .getString(context),
                                      color: ColorManager.lightGreenColor,
                                    )),
                              ],
                            );
                          }),
                          SizedBox(
                            height: displayHeight(context) * 0.005,
                          ),
                          TextContainer(
                            width: displayWidth(context) * 0.75,
                            text: AppStrings.nameText.getString(context),
                            fontSize: 16,
                            color: ColorManager.signupPageFontColor,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.left,
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m10),
                          ),
                          TextInputField(
                            controller: _viewModel.nameController,
                            width: displayWidth(context) * 0.77,
                            height: displayHeight(context) * 0.065,
                            focusedBorderRadius: AppSize.s30,
                            enabledBorderRadius: AppSize.s30,
                            errorBorderRadius: AppSize.s30,
                            obsecureText: false,
                            maxLines: 1,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: displayHeight(context) * 0.02,
                                horizontal: displayWidth(context) * 0.04),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                          TextContainer(
                            width: displayWidth(context) * 0.75,
                            text: AppStrings.emailText.getString(context),
                            fontSize: 16,
                            color: ColorManager.signupPageFontColor,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.left,
                            margin: EdgeInsets.only(
                                bottom: AppMargin.m10,
                                top: displayHeight(context) * 0.02),
                          ),
                          TextInputField(
                            controller: _viewModel.emailController,
                            width: displayWidth(context) * 0.77,
                            height: displayHeight(context) * 0.065,
                            focusedBorderRadius: AppSize.s30,
                            enabledBorderRadius: AppSize.s30,
                            errorBorderRadius: AppSize.s30,
                            maxLines: 1,
                            obsecureText: false,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: displayHeight(context) * 0.02,
                                horizontal: displayWidth(context) * 0.04),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                          TextContainer(
                            width: displayWidth(context) * 0.75,
                            text: AppStrings.tellUsMoreText.getString(context),
                            fontSize: 16,
                            color: ColorManager.signupPageFontColor,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.left,
                            margin: EdgeInsets.only(
                                bottom: AppMargin.m10,
                                top: displayHeight(context) * 0.02),
                          ),
                          TextInputField(
                            controller: _viewModel.moreController,
                            width: displayWidth(context) * 0.77,
                            height: AppSize.s80,
                            focusedBorderRadius: AppSize.s30,
                            enabledBorderRadius: AppSize.s30,
                            errorBorderRadius: AppSize.s30,
                            obsecureText: false,
                            maxLines: 4,
                            contentPadding: const EdgeInsets.only(
                                left: AppPadding.p16, top: AppPadding.p16),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                          // TextContainer(
                          //   width: displayWidth(context) * 0.75,
                          //   text: AppStrings.membershipTypeText.getString(context),
                          //   fontSize: 16,
                          //   color: ColorManager.signupPageFontColor,

                          //   fontWeight: FontWeight.bold,
                          //   textAlign: TextAlign.left,
                          //   margin: EdgeInsets.only(
                          //       bottom: AppMargin.m10,
                          //       top: displayHeight(context) * 0.02),
                          // ),
                          // Container(
                          //   width: displayWidth(context) * 0.75,
                          //   height: displayHeight(context) * 0.065,
                          //   padding:
                          //       EdgeInsets.only(left: displayWidth(context) * 0.05),
                          //   decoration: BoxDecoration(
                          //       color: ColorManager.whiteColor,
                          //       borderRadius: BorderRadius.circular(AppSize.s30),
                          //       boxShadow: const [
                          //         BoxShadow(
                          //           color: Color(0x3F000000),
                          //           blurRadius: 4,
                          //           offset: Offset(0, 0),
                          //           spreadRadius: 0,
                          //         )
                          //       ]),
                          //   child: DropdownButton(
                          //     elevation: 2,
                          //     alignment: AlignmentDirectional.center,
                          //     underline: const SizedBox(),
                          //     value: _viewModel.membershipType,
                          //     icon: Container(
                          //       margin: EdgeInsets.only(
                          //           left: displayWidth(context) * 0.3),
                          //       alignment: Alignment.center,
                          //       child: const Icon(
                          //         Icons.keyboard_arrow_down_rounded,
                          //         color: ColorManager.lightGreenColor,
                          //       ),
                          //     ),
                          //     items: [
                          //       DropdownMenuItem(
                          //         value: 'Property Seeker',
                          //         child: TextContainer(
                          //           text: AppStrings.propertySeekerText
                          //               .getString(context),
                          //           fontSize: 16,

                          //           fontWeight: FontWeightManager.regular,
                          //           color: ColorManager.lightGreenColor,
                          //         ),
                          //       ),
                          //       DropdownMenuItem(
                          //         value: 'Owner',
                          //         child: TextContainer(
                          //           text: AppStrings.ownerText.getString(context),
                          //           fontSize: 16,

                          //           fontWeight: FontWeightManager.regular,
                          //           color: ColorManager.lightGreenColor,
                          //         ),
                          //       ),
                          //       DropdownMenuItem(
                          //         value: 'Marketer',
                          //         child: TextContainer(
                          //           text:
                          //               AppStrings.marketerText.getString(context),
                          //           fontSize: 16,

                          //           fontWeight: FontWeightManager.regular,
                          //           color: ColorManager.lightGreenColor,
                          //         ),
                          //       ),
                          //       DropdownMenuItem(
                          //         value: 'Company',
                          //         child: TextContainer(
                          //           text: AppStrings.companyText.getString(context),
                          //           fontSize: 16,

                          //           fontWeight: FontWeightManager.regular,
                          //           color: ColorManager.lightGreenColor,
                          //         ),
                          //       )
                          //     ],
                          //     onChanged: (String? newValue) {
                          //       setState(() {
                          //         _viewModel.membershipType = newValue;
                          //       });
                          //     },
                          //   ),
                          // ),
                          SizedBox(
                            height: displayHeight(context) * 0.045,
                          ),
                          Consumer<RegisterViewModel>(
                            builder: (BuildContext context, viewModel,
                                    Widget? child) =>
                                SizedBox(
                              width: displayWidth(context) * 0.6,
                              height: displayHeight(context) * 0.065,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (_viewModel
                                          .emailController.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: AppStrings.emailIsEmptyText
                                                .getString(context));
                                        return;
                                      }
                                      if (_viewModel
                                          .nameController.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: AppStrings.nameIsEmptyText
                                                .getString(context));
                                        return;
                                      }
                                      Provider.of<RegisterViewModel>(context,
                                              listen: false)
                                          .isLoading = true;
                                      showProgressIndicator(
                                          context,
                                          viewModel.isLoading,
                                          AppStrings.registeringAccountText
                                              .getString(context));
                                      try {
                                        ValueHolders
                                                .regUserDetails['user_email'] =
                                            _viewModel.emailController.text;
                                        ValueHolders
                                                .regUserDetails['user_brief'] =
                                            _viewModel.moreController.text;
                                        ValueHolders.regUserDetails[
                                                'user_full_name'] =
                                            _viewModel.nameController.text;

                                        await _viewModel.signUpNewUser(context);
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: e.toString());
                                      }
                                      viewModel.isLoading = false;
                                    }
                                    context.pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ColorManager.buttonsColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s30))),
                                  child: TextContainer(
                                    fontSize: 20,
                                    text: AppStrings.signupText
                                        .getString(context),
                                    color: ColorManager.fontColor,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          // CustomProgressIndicator(isLoading: _viewModel.isLoading)
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
