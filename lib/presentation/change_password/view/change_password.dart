import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/presentation/change_password/viewmodel/change_password_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => ChangePasswordViewState();
}

class ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.bgColor,
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (BuildContext context) => ChangePasswordViewModel(),
          child: Consumer<ChangePasswordViewModel>(
            builder: (BuildContext context, viewModel, Widget? child) =>
                SingleChildScrollView(
                    child: Form(
              child: Form(
                key: _formKey,
                child: Column(children: [
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
                          text:
                              AppStrings.changePasswordText.getString(context),
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
                    width: displayWidth(context) * 0.83,
                    text: AppStrings.oldPasswordText.getString(context),
                    fontSize: 16,
                    color: ColorManager.fontColor3,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.left,
                    margin: const EdgeInsets.only(bottom: AppMargin.m10),
                  ),
                  TextInputField(
                    controller: viewModel.oldPasswordController,
                    width: displayWidth(context) * 0.85,
                    height: AppSize.s50,
                    focusedBorderRadius: AppSize.s30,
                    enabledBorderRadius: AppSize.s30,
                    errorBorderRadius: AppSize.s30,
                    obsecureText: false,
                    contentPadding: const EdgeInsets.only(left: AppPadding.p16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        Fluttertoast.showToast(
                            msg: AppStrings.oldPasswordIsEmptyText
                                .getString(context));
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.05,
                  ),
                  TextContainer(
                    width: displayWidth(context) * 0.83,
                    text: AppStrings.newPasswordText.getString(context),
                    fontSize: 16,
                    color: ColorManager.fontColor3,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.left,
                    margin: const EdgeInsets.only(bottom: AppMargin.m10),
                  ),
                  TextInputField(
                    controller: viewModel.newPasswordController,
                    width: displayWidth(context) * 0.85,
                    height: AppSize.s50,
                    focusedBorderRadius: AppSize.s30,
                    enabledBorderRadius: AppSize.s30,
                    errorBorderRadius: AppSize.s30,
                    obsecureText: false,
                    contentPadding: const EdgeInsets.only(left: AppPadding.p16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        Fluttertoast.showToast(
                            msg: AppStrings.newPasswordIsEmptyText
                                .getString(context));
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.05,
                  ),
                  TextContainer(
                    width: displayWidth(context) * 0.83,
                    text: AppStrings.confirmPasswordText.getString(context),
                    fontSize: 16,
                    color: ColorManager.fontColor3,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.left,
                    margin: const EdgeInsets.only(bottom: AppMargin.m10),
                  ),
                  TextInputField(
                    controller: viewModel.confirmNewPasswordController,
                    width: displayWidth(context) * 0.85,
                    height: AppSize.s50,
                    focusedBorderRadius: AppSize.s30,
                    enabledBorderRadius: AppSize.s30,
                    errorBorderRadius: AppSize.s30,
                    obsecureText: false,
                    contentPadding: const EdgeInsets.only(left: AppPadding.p16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        Fluttertoast.showToast(
                            msg: AppStrings.confirmPasswordIsEmptyText
                                .getString(context));
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.25,
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.6,
                    height: AppSize.s50,
                    child: ElevatedButton(
                        onPressed: () async {
                          Provider.of<ChangePasswordViewModel>(context,
                                  listen: false)
                              .isLoading = true;
                          showProgressIndicator(
                              context,
                              viewModel.isLoading,
                              AppStrings.changingYourPasswordNowText
                                  .getString(context));
                          if (_formKey.currentState!.validate()) {
                            if (viewModel.oldPasswordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: AppStrings.oldPasswordIsEmptyText
                                      .getString(context));
                              context.pop();
                              return;
                            }
                            if (viewModel.newPasswordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: AppStrings.newPasswordIsEmptyText
                                      .getString(context));
                              context.pop();
                              return;
                            }
                            if (viewModel
                                .confirmNewPasswordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: AppStrings.confirmPasswordIsEmptyText
                                      .getString(context));
                              context.pop();
                              return;
                            }
                            await viewModel.doChangePassword(
                                viewModel.newPasswordController.text,
                                viewModel.confirmNewPasswordController.text,
                                context);
                          }
                          Provider.of<ChangePasswordViewModel>(context,
                                  listen: false)
                              .isLoading = false;
                          context.pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.buttonsColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s30))),
                        child: TextContainer(
                          fontSize: 20,
                          text: AppStrings.changeText.getString(context),
                          color: ColorManager.fontColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ]),
              ),
            )),
          ),
        ));
  }
}
