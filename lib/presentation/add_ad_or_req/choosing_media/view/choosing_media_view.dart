import 'dart:io';
import 'package:flutter/material.dart';

import 'package:oraxproperty/presentation/add_ad_or_req/choosing_media/viewmodel/choosing_media_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:extended_image/extended_image.dart';

class ChoosingMediaView extends StatefulWidget {
  const ChoosingMediaView({super.key});

  @override
  State<ChoosingMediaView> createState() => _ChoosingMediaViewState();
}

class _ChoosingMediaViewState extends State<ChoosingMediaView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ChoosingMediaViewModel(),
      child: ChangeNotifierProvider(
        create: (BuildContext context) => ChoosingMediaViewModel(),
        child: Scaffold(
          backgroundColor: ColorManager.bgColor,
          resizeToAvoidBottomInset: false,
          body: Column(
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
                      text: AppStrings.selectingPhotosText.getString(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.05,
              ),
              Consumer<ChoosingMediaViewModel>(
                builder: (BuildContext context, viewModel, Widget? child) =>
                    RoundedContainer(
                  height: displayHeight(context) * 0.25,
                  width: displayWidth(context) * 0.9,
                  radius: displayHeight(context) * 0.02,
                  color: ColorManager.whiteColor,
                  border: Border.all(
                      color: ColorManager.lightGreenColor, width: AppSize.s1_5),
                  boxShadow: const BoxShadow(),
                  child: viewModel.imageFileList!.isNotEmpty
                      ? ListView.builder(
                          itemCount: viewModel.imageFileList!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          primary: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                ExtendedImage.file(
                                  File(viewModel.imageFileList![index].path),
                                  width: displayWidth(context) * 0.23,
                                  height: displayHeight(context) * 0.22,
                                  layoutInsets: const EdgeInsets.symmetric(
                                      horizontal: AppMargin.m2),
                                ),
                                RoundedContainer(
                                  color: ColorManager.whiteTransColor,
                                  radius: displayHeight(context) * 0.1,
                                  child: IconButton(
                                      onPressed: () {
                                        viewModel.deletePhoto(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever_rounded,
                                        color: ColorManager.errorColor,
                                      )),
                                )
                              ],
                            );
                          },
                        )
                      : Center(
                          child: IconButton(
                            onPressed: () async {
                              await viewModel.adsImagesPicker();
                            },
                            splashColor: ColorManager.lightGreenColor,
                            icon: SvgPicture.asset(
                              ImageAssets.addIcon,
                              color: ColorManager.lightGreenColor,
                              width: displayWidth(context) * 0.2,
                            ),
                          ),
                        ),
                ),
              ),
              TextContainer(
                width: displayWidth(context) * 0.77,
                text: AppStrings.pleaseSelectPhotosText.getString(context),
                margin: EdgeInsets.only(top: displayHeight(context) * 0.025),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: ColorManager.errorColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: displayHeight(context) * 0.3,
              ),
              Consumer<ChoosingMediaViewModel>(
                builder: (BuildContext context, viewModel, Widget? child) =>
                    SizedBox(
                  width: displayWidth(context) * 0.45,
                  height: displayHeight(context) * 0.06,
                  child: ElevatedButton(
                      onPressed: () async {
                        viewModel.assignImagesToAdetailsMap(context);
                        context
                            .push('/add_ad_or_req/confirm_before_sending/view');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.buttonsColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  displayHeight(context) * 0.03))),
                      child: TextContainer(
                        fontSize: 20,
                        text: AppStrings.nextText.getString(context),
                        color: ColorManager.fontColor,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
