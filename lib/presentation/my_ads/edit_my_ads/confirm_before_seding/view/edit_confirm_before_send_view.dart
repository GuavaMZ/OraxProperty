import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/confirm_before_seding/viewmodel/edit_confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class EditConfirmBeforeSendView extends StatefulWidget {
  const EditConfirmBeforeSendView({super.key});

  @override
  State<EditConfirmBeforeSendView> createState() => _EditConfirmBeforeSendViewState();
}

class _EditConfirmBeforeSendViewState extends State<EditConfirmBeforeSendView> {
  @override
  void dispose() {
    EditConfirmBeforeSendViewModel.propertyImages.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => EditConfirmBeforeSendViewModel(),
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
                    EditConfirmBeforeSendViewModel.propertyAdDetails.keys.length,
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
                            '${EditConfirmBeforeSendViewModel.propertyAdDetails.keys.toList()[index].getString(context)}: ${EditConfirmBeforeSendViewModel.propertyAdDetails[EditConfirmBeforeSendViewModel.propertyAdDetails.keys.toList()[index]]}',
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
              itemCount: EditConfirmBeforeSendViewModel.propertyImages.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              primary: true,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ExtendedImage.file(
                      File(EditConfirmBeforeSendViewModel
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
          Consumer<EditConfirmBeforeSendViewModel>(
            builder: (BuildContext context, viewModel, Widget? child) =>
                SizedBox(
              width: displayWidth(context) * 0.45,
              height: displayHeight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () async {
                    // print(EditConfirmBeforeSendViewModel.propertyImages);
                    // return;
                    Provider.of<EditConfirmBeforeSendViewModel>(context,
                            listen: false)
                        .isLoading = true;
                    showProgressIndicator(context, viewModel.isLoading,
                        AppStrings.uploadingAdText.getString(context));
                    // Future.delayed(const Duration(milliseconds: 5000));
                    try {
                      var res =
                          await viewModel.indicateCategoryAndUpdateAd(context);
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
