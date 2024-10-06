import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:oraxproperty/presentation/update_profile/viewmodel/update_profile_viewmodel.dart';
import 'package:provider/provider.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => UpdateProfileViewState();
}

class UpdateProfileViewState extends State<UpdateProfileView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UpdateProfileViewModel _viewModel = UpdateProfileViewModel();
  @override
  Widget build(BuildContext context) {
    _viewModel.nameController.text =
        supabase.auth.currentUser!.userMetadata!['full_name'];
    _viewModel.emailController.text =
        supabase.auth.currentUser!.userMetadata!['email'];
    _viewModel.phoneController.text =
        supabase.auth.currentUser!.userMetadata!['phone_number'];
    _viewModel.tellUsController.text =
        supabase.auth.currentUser!.userMetadata!['brief'];
    _viewModel.membershipType =
        supabase.auth.currentUser!.userMetadata!['membership_type'];
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (BuildContext context) => UpdateProfileViewModel(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Consumer<UpdateProfileViewModel>(
                builder: (BuildContext context, viewModel, Widget? child) {
              return Column(
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
                          text: AppStrings.updateProfileText.getString(context),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.06,
                  ),
                  TextContainer(
                    width: displayWidth(context) * 0.80,
                    text: AppStrings.nameText.getString(context),
                    fontSize: 16,
                    color: ColorManager.blackColor,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.left,
                    margin: const EdgeInsets.only(bottom: AppMargin.m10),
                  ),
                  TextInputField(
                    controller: _viewModel.nameController,
                    width: displayWidth(context) * 0.85,
                    height: AppSize.s50,
                    focusedBorderRadius: AppSize.s30,
                    enabledBorderRadius: AppSize.s30,
                    errorBorderRadius: AppSize.s30,
                    obsecureText: false,
                    contentPadding: const EdgeInsets.only(left: AppPadding.p16),
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.015,
                  ),
                  TextContainer(
                    width: displayWidth(context) * 0.80,
                    text: AppStrings.emailText.getString(context),
                    fontSize: 16,
                    color: ColorManager.blackColor,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.left,
                    margin: const EdgeInsets.only(bottom: AppMargin.m10),
                  ),
                  TextInputField(
                    controller: _viewModel.emailController,
                    width: displayWidth(context) * 0.85,
                    height: AppSize.s50,
                    focusedBorderRadius: AppSize.s30,
                    enabledBorderRadius: AppSize.s30,
                    errorBorderRadius: AppSize.s30,
                    obsecureText: false,
                    contentPadding: const EdgeInsets.only(left: AppPadding.p16),
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.015,
                  ),
                  TextContainer(
                    width: displayWidth(context) * 0.80,
                    text: AppStrings.phoneNumberText.getString(context),
                    fontSize: 16,
                    color: ColorManager.blackColor,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.left,
                    margin: const EdgeInsets.only(bottom: AppMargin.m10),
                  ),
                  TextInputField(
                    controller: _viewModel.phoneController,
                    width: displayWidth(context) * 0.85,
                    height: AppSize.s50,
                    focusedBorderRadius: AppSize.s30,
                    enabledBorderRadius: AppSize.s30,
                    errorBorderRadius: AppSize.s30,
                    obsecureText: false,
                    contentPadding: const EdgeInsets.only(left: AppPadding.p16),
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.015,
                  ),
                  TextContainer(
                    width: displayWidth(context) * 0.8,
                    text: AppStrings.tellUsMoreText.getString(context),
                    fontSize: 16,
                    color: ColorManager.blackColor,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.left,
                    margin: const EdgeInsets.only(bottom: AppMargin.m10),
                  ),
                  TextInputField(
                    controller: _viewModel.tellUsController,
                    width: displayWidth(context) * 0.85,
                    height: AppSize.s50,
                    focusedBorderRadius: AppSize.s30,
                    enabledBorderRadius: AppSize.s30,
                    errorBorderRadius: AppSize.s30,
                    obsecureText: false,
                    contentPadding: const EdgeInsets.only(left: AppPadding.p16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  // TextContainer(
                  //   width: displayWidth(context) * 0.8,
                  //   text: AppStrings.membershipTypeText.getString(context),
                  //   fontSize: 16,
                  //   color: ColorManager.blackColor,
                  //   fontWeight: FontWeight.bold,
                  //   textAlign: TextAlign.left,
                  //   margin: const EdgeInsets.only(bottom: AppMargin.m10),
                  // ),
                  // Container(
                  //   width: displayWidth(context) * 0.85,
                  //   height: displayHeight(context) * 0.06,
                  //   decoration: BoxDecoration(
                  //       color: ColorManager.lightGreyColor2,
                  //       borderRadius: BorderRadius.circular(AppSize.s30),
                  //       boxShadow: const [
                  //         // BoxShadow(
                  //         //   color: Color(0x3F000000),
                  //         //   blurRadius: 4,
                  //         //   offset: Offset(0, 0),
                  //         //   spreadRadius: 0,
                  //         // )
                  //       ]),
                  //   child: DropdownButtonHideUnderline(
                  //     child: ButtonTheme(
                  //       alignedDropdown: true,
                  //       child: DropdownButton(
                  //         elevation: 2,
                  //         alignment: AlignmentDirectional.topStart,
                  //         value: viewModel.membershipType ??
                  //             supabase.auth.currentUser!
                  //                 .userMetadata!['membership_type']
                  //                 .toString(),
                  //         padding: EdgeInsets.only(
                  //             left: displayWidth(context) * 0.02),
                  //         borderRadius: BorderRadius.all(
                  //             Radius.circular(displayHeight(context) * 0.035)),
                  //         icon: Container(
                  //           alignment: AlignmentDirectional.centerStart,
                  //           margin: EdgeInsets.only(
                  //               right: displayWidth(context) * 0.04),
                  //           child: const Icon(
                  //             Icons.keyboard_arrow_down_rounded,
                  //             color: ColorManager.lightGreenColor,
                  //           ),
                  //         ),
                  //         items: [
                  //           DropdownMenuItem(
                  //             value: 'Property Seeker',
                  //             child: TextContainer(
                  //               text: AppStrings.propertySeekerText
                  //                   .getString(context),
                  //               fontSize: 14,
                  //               width: displayWidth(context) * 0.68,
                  //               fontWeight: FontWeightManager.regular,
                  //               color: ColorManager.fontColor3,
                  //             ),
                  //           ),
                  //           DropdownMenuItem(
                  //             value: 'Owner',
                  //             child: TextContainer(
                  //               text: AppStrings.ownerText.getString(context),
                  //               fontSize: 14,
                  //               width: displayWidth(context) * 0.68,
                  //               fontWeight: FontWeightManager.regular,
                  //               color: ColorManager.fontColor3,
                  //             ),
                  //           ),
                  //           DropdownMenuItem(
                  //             value: 'Marketer',
                  //             child: TextContainer(
                  //               text:
                  //                   AppStrings.marketerText.getString(context),
                  //               fontSize: 14,
                  //               width: displayWidth(context) * 0.68,
                  //               fontWeight: FontWeightManager.regular,
                  //               color: ColorManager.fontColor3,
                  //             ),
                  //           ),
                  //           DropdownMenuItem(
                  //             value: 'Company',
                  //             child: TextContainer(
                  //               text: AppStrings.companyText.getString(context),
                  //               fontSize: 14,
                  //               width: displayWidth(context) * 0.68,
                  //               fontWeight: FontWeightManager.regular,
                  //               color: ColorManager.fontColor3,
                  //             ),
                  //           )
                  //         ],
                  //         onChanged: (String? newValue) {
                  //           Provider.of<UpdateProfileViewModel>(context,
                  //                   listen: false)
                  //               .membershipType = newValue;
                  //           _viewModel.membershipType = newValue;
                  //           // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                  //           viewModel.notifyListeners();
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: displayHeight(context) * 0.07,
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.8,
                    height: AppSize.s50,
                    child: ElevatedButton(
                        onPressed: () async {
                          Provider.of<UpdateProfileViewModel>(context,
                                  listen: false)
                              .isLoading = true;
                          showProgressIndicator(context, viewModel.isLoading,
                              AppStrings.updatingInfoText.getString(context));
                          if (_formKey.currentState!.validate()) {
                            if (_viewModel.nameController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: AppStrings.nameIsEmptyText
                                      .getString(context));
                              context.pop();
                              return;
                            }
                            if (_viewModel.emailController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: AppStrings.emailIsEmptyText
                                      .getString(context));
                              context.pop();
                              return;
                            }
                            if (_viewModel.phoneController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: AppStrings.phoneNumberIsEmptyText
                                      .getString(context));
                              context.pop();
                              return;
                            }
                            if (_viewModel.phoneController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: AppStrings.briefIsEmptyText
                                      .getString(context));
                              context.pop();
                              return;
                            }
                            if (_viewModel.nameController.text ==
                                    supabase.auth.currentUser!
                                        .userMetadata!['full_name'] &&
                                _viewModel.emailController.text ==
                                    supabase.auth.currentUser!
                                        .userMetadata!['email'] &&
                                _viewModel.phoneController.text ==
                                    supabase.auth.currentUser!
                                        .userMetadata!['phone_number'] &&
                                _viewModel.tellUsController.text ==
                                    supabase.auth.currentUser!
                                        .userMetadata!['brief']
                                ) {
                              Fluttertoast.showToast(
                                  msg: AppStrings.noChangesMadeText
                                      .getString(context));
                              context.pop();
                            } else {
                              var result = await _viewModel.updateProfile(
                                  _viewModel.nameController.text,
                                  _viewModel.emailController.text,
                                  _viewModel.phoneController.text,
                                  _viewModel.tellUsController.text,
                                  _viewModel.membershipType!);
                              if (result == 'Success') {
                                if (context.mounted) {
                                  context.pop();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.scale,
                                    dismissOnTouchOutside: false,
                                    dismissOnBackKeyPress: false,
                                    body: TextContainer(
                                      margin: EdgeInsets.only(
                                          top: displayHeight(context) * 0.01,
                                          bottom:
                                              displayHeight(context) * 0.01),
                                      text: AppStrings.updatingInfoSuccessText
                                          .getString(context),
                                      fontSize: 16,
                                      color: ColorManager.fontColor2,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center,
                                    ),
                                    btnOk: ElevatedButton(
                                      onPressed: () {
                                        context.pushReplacement('/homepage');
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorManager.lightGreenColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      displayHeight(context) *
                                                          0.02)))),
                                      child: TextContainer(
                                        text: AppStrings.confirmText
                                            .getString(context),
                                        fontSize: 16,
                                        color: ColorManager.fontColor,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ).show();
                                }
                              } else if (result == 'Upload Failed') {
                                if (context.mounted) {
                                  context.pop();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.scale,
                                    dismissOnTouchOutside: false,
                                    dismissOnBackKeyPress: false,
                                    body: TextContainer(
                                      margin: EdgeInsets.only(
                                          top: displayHeight(context) * 0.01,
                                          bottom:
                                              displayHeight(context) * 0.01),
                                      text: AppStrings.updatingInfoFailedText
                                          .getString(context),
                                      fontSize: 16,
                                      color: ColorManager.fontColor2,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center,
                                    ),
                                    btnOk: ElevatedButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorManager.lightGreenColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      displayHeight(context) *
                                                          0.02)))),
                                      child: TextContainer(
                                        text: AppStrings.confirmText
                                            .getString(context),
                                        fontSize: 16,
                                        color: ColorManager.fontColor,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ).show();
                                }
                              }
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
                          text: AppStrings.saveText.getString(context),
                          color: ColorManager.fontColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
