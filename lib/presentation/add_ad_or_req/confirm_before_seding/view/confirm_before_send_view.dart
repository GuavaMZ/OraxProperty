import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/confirm_before_seding/viewmodel/confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class ConfirmBeforeSendView extends StatefulWidget {
  const ConfirmBeforeSendView({super.key});

  @override
  State<ConfirmBeforeSendView> createState() => _ConfirmBeforeSendViewState();
}

class _ConfirmBeforeSendViewState extends State<ConfirmBeforeSendView> {
  @override
  void dispose() {
    ConfirmBeforeSendViewModel.propertyImages.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ConfirmBeforeSendViewModel(),
      child: Scaffold(
        backgroundColor: ColorManager.bgColor,
        resizeToAvoidBottomInset: false,
        body: Column(children: [
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
                  icon: SvgPicture.asset('assets/images/arrow-circle-left.svg'),
                ),
                TextContainer(
                  width: displayWidth(context) * 0.77,
                  text: AppStrings.confirmBeforeSendText.getString(context),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                   
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.03,
          ),
          RoundedContainer(
            height: displayHeight(context) * 0.55,
            width: displayWidth(context) * 0.93,
            radius: displayHeight(context) * 0.02,
            color: ColorManager.whiteColor,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns,
                    crossAxisSpacing: 10, // Spacing between columns
                    mainAxisSpacing: 5, // Spacing between rows
                    mainAxisExtent: displayHeight(context) * 0.075),
                itemCount:
                    ConfirmBeforeSendViewModel.propertyAdDetails.keys.length,
                padding: const EdgeInsets.symmetric(),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        ImageAssets.moreIcon,
                        width: displayWidth(context) * 0.035,
                      ),
                      TextContainer(
                        text:
                            '${ConfirmBeforeSendViewModel.propertyAdDetails.keys.toList()[index].getString(context)}: ${ConfirmBeforeSendViewModel.propertyAdDetails[ConfirmBeforeSendViewModel.propertyAdDetails.keys.toList()[index]]}',
                        width: displayWidth(context) * 0.35,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.fontColor2,
                        align: Alignment.centerLeft,
                        textAlign: TextAlign.left,
                         
                      ),
                    ],
                  );
                }),
          ),
          RoundedContainer(
            height: displayHeight(context) * 0.15,
            width: displayWidth(context) * 0.93,
            radius: displayHeight(context) * 0.02,
            margin: EdgeInsets.only(top: displayHeight(context) * 0.01),
            color: ColorManager.whiteColor,
            child: ListView.builder(
              itemCount: ConfirmBeforeSendViewModel.propertyImages.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              primary: true,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ExtendedImage.file(
                      File(ConfirmBeforeSendViewModel
                          .propertyImages['image$index']!),
                      width: displayWidth(context) * 0.23,
                      height: displayHeight(context) * 0.22,
                      layoutInsets:
                          const EdgeInsets.symmetric(horizontal: AppMargin.m2),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.025,
          ),
          Consumer<ConfirmBeforeSendViewModel>(
            builder: (BuildContext context, viewModel, Widget? child) =>
                SizedBox(
              width: displayWidth(context) * 0.45,
              height: displayHeight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () async {
                    // print(ConfirmBeforeSendViewModel.propertyImages);
                    // return;
                    Provider.of<ConfirmBeforeSendViewModel>(context,
                            listen: false)
                        .isLoading = true;
                    showProgressIndicator(context, viewModel.isLoading,
                        AppStrings.uploadingAdText.getString(context));
                    // Future.delayed(const Duration(milliseconds: 5000));
                    try {
                      var res =
                          await viewModel.indicateCategoryAndPostAd(context);
                      if (res == 'Success') {
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
                                  bottom: displayHeight(context) * 0.01),
                              text: AppStrings.adUploadedSuccessText
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
                                  backgroundColor: ColorManager.lightGreenColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              displayHeight(context) * 0.02)))),
                              child: TextContainer(
                                text: AppStrings.confirmText.getString(context),
                                fontSize: 16,
                                color: ColorManager.fontColor,
                                 
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ).show();
                        }
                      } else if (res == 'Upload Failed') {
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
                                  bottom: displayHeight(context) * 0.01),
                              text: AppStrings.adUploadedSuccessText
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
                                  backgroundColor: ColorManager.lightGreenColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              displayHeight(context) * 0.02)))),
                              child: TextContainer(
                                text: AppStrings.confirmText.getString(context),
                                fontSize: 16,
                                color: ColorManager.fontColor,
                                 
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ).show();
                        }
                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                      context.pop();
                    }
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
          ),
        ]),
      ),
    );
  }
}
