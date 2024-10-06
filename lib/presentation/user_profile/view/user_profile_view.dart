import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/app/app.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';

import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:oraxproperty/presentation/user_profile/viewmodel/user_profile_viewmodel.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final UserProfileViewModel _viewModel = UserProfileViewModel();
  @override
  void initState() {
    // final usrRule = _viewModel.getUserDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Scaffold(
        backgroundColor: ColorManager.bgColor,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Consumer<UserProfileViewModel>(
          builder: (BuildContext context, viewModel, Widget? child) =>
              SingleChildScrollView(
            child: Column(
              children: [
                UpperProfilePageContainerNew(
                    userFullName:
                        supabase.auth.currentUser!.userMetadata!['full_name'],
                    userJob: supabase
                        .auth.currentUser!.userMetadata!['membership_type'],
                    imageWidget: ExtendedImage.network(
                      supabase.storage.from('users_profile').getPublicUrl(
                          supabase
                              .auth.currentUser!.userMetadata!['profile_photo']
                              .toString()
                              .split('/')
                              .last),
                      shape: BoxShape.circle,
                      compressionRatio: 0.5,
                    )),
                if(ValueHolders.userRule == 1)
                SizedBox(
                  height: displayHeight(context) * 0.08,
                  child: ElevatedButton(
                      onPressed: () {
                        context.push('/update_profile/view');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.whiteColor,
                          elevation: 0,
                          surfaceTintColor: ColorManager.whiteColor,
                          foregroundColor: ColorManager.whiteColor),
                      child: Row(
                        children: [
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          SvgPicture.asset(
                            ImageAssets.userIcon,
                            color: ColorManager.userProfileIconsColor,
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.05,
                          ),
                          TextContainer(
                            text:
                                AppStrings.updateProfileText.getString(context),
                            fontSize: 17,
                            width: displayWidth(context) * 0.68,
                            color: ColorManager.userProfileFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SvgPicture.asset(ImageAssets.arrowRightIcon)
                        ],
                      )),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                 SizedBox(
                  height: displayHeight(context) * 0.08,
                  child: ElevatedButton(
                      onPressed: () {
                        context.push('/my_ads/view');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.whiteColor,
                          elevation: 0,
                          surfaceTintColor: ColorManager.whiteColor,
                          foregroundColor: ColorManager.whiteColor),
                      child: Row(
                        children: [
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          SvgPicture.asset(
                            ImageAssets.myadsIcon,
                            width: displayWidth(context) * 0.055,
                            color: ColorManager.userProfileIconsColor,
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.05,
                          ),
                          TextContainer(
                            text:
                                AppStrings.myadsText.getString(context),
                            fontSize: 17,
                            width: displayWidth(context) * 0.68,
                            color: ColorManager.userProfileFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SvgPicture.asset(ImageAssets.arrowRightIcon)
                        ],
                      )),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.08,
                  child: ElevatedButton(
                      onPressed: () {
                        context.push('/verify_account/view');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.whiteColor,
                          elevation: 0,
                          surfaceTintColor: ColorManager.whiteColor,
                          foregroundColor: ColorManager.whiteColor),
                      child: Row(
                        children: [
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          SvgPicture.asset(
                            ImageAssets.verifyIcon,
                            color: ColorManager.userProfileIconsColor,
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.05,
                          ),
                          TextContainer(
                            text:
                                AppStrings.verifyAccountText.getString(context),
                            fontSize: 17,
                            width: displayWidth(context) * 0.68,
                            color: ColorManager.userProfileFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SvgPicture.asset(ImageAssets.arrowRightIcon)
                        ],
                      )),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.08,
                  child: ElevatedButton(
                      onPressed: () {
                        context.push('/change_password/view');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.whiteColor,
                          elevation: 0,
                          surfaceTintColor: ColorManager.whiteColor,
                          foregroundColor: ColorManager.whiteColor),
                      child: Row(
                        children: [
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          SvgPicture.asset(
                            ImageAssets.changePassword,
                            color: ColorManager.userProfileIconsColor,
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.05,
                          ),
                          TextContainer(
                            text: AppStrings.changePasswordText
                                .getString(context),
                            fontSize: 17,
                            width: displayWidth(context) * 0.68,
                            color: ColorManager.userProfileFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SvgPicture.asset(ImageAssets.arrowRightIcon)
                        ],
                      )),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.08,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.whiteColor,
                          elevation: 0,
                          surfaceTintColor: ColorManager.whiteColor,
                          foregroundColor: ColorManager.whiteColor),
                      child: Row(
                        children: [
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          SvgPicture.asset(
                            ImageAssets.callSupportIcon,
                            color: ColorManager.userProfileIconsColor,
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.05,
                          ),
                          TextContainer(
                            text: AppStrings.supportText.getString(context),
                            fontSize: 17,
                            width: displayWidth(context) * 0.68,
                            color: ColorManager.userProfileFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SvgPicture.asset(ImageAssets.arrowRightIcon)
                        ],
                      )),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.08,
                  child: ElevatedButton(
                      onPressed: () {
                        if (localization.getLanguageName() == 'English') {
                          localization.translate('ar');
                        } else {
                          localization.translate('en');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.whiteColor,
                          elevation: 0,
                          surfaceTintColor: ColorManager.whiteColor,
                          foregroundColor: ColorManager.whiteColor),
                      child: Row(
                        children: [
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          SvgPicture.asset(
                            ImageAssets.languageIcon,
                            color: ColorManager.userProfileIconsColor,
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.05,
                          ),
                          TextContainer(
                            text: AppStrings.languageText.getString(context),
                            fontSize: 17,
                            width: displayWidth(context) * 0.68,
                            color: ColorManager.userProfileFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SvgPicture.asset(ImageAssets.arrowRightIcon)
                        ],
                      )),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.08,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.whiteColor,
                          elevation: 0,
                          surfaceTintColor: ColorManager.whiteColor,
                          foregroundColor: ColorManager.whiteColor),
                      child: Row(
                        children: [
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          SvgPicture.asset(
                            ImageAssets.blogIcon,
                            color: ColorManager.userProfileIconsColor,
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.05,
                          ),
                          TextContainer(
                            text: AppStrings.blogText.getString(context),
                            fontSize: 17,
                            width: displayWidth(context) * 0.68,
                            color: ColorManager.userProfileFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SvgPicture.asset(ImageAssets.arrowRightIcon)
                        ],
                      )),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.08,
                  child: ElevatedButton(
                      onPressed: () async {
                        Provider.of<UserProfileViewModel>(context,
                                listen: false)
                            .isLoading = true;
                        showProgressIndicator(context, viewModel.isLoading,
                            AppStrings.loggingOutText.getString(context));
                        viewModel.signUserOut(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.whiteColor,
                        elevation: 0,
                        surfaceTintColor: ColorManager.whiteColor,
                        foregroundColor: ColorManager.whiteColor,
                        shadowColor: ColorManager.whiteColor,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          SvgPicture.asset(
                            ImageAssets.logoutIcon,
                            color: ColorManager.userProfileIconsColor,
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.05,
                          ),
                          TextContainer(
                            text: AppStrings.logoutText.getString(context),
                            fontSize: 17,
                            width: displayWidth(context) * 0.68,
                            color: ColorManager.userProfileFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SvgPicture.asset(ImageAssets.arrowRightIcon)
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
