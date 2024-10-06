import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraxproperty/app/app.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/ads_based_categories/viewmodel/ads_based_categories_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AdsBasedCategoryView extends StatefulWidget {
  AdsBasedCategoryView({super.key, this.categoryName});
  String? categoryName;
  @override
  State<AdsBasedCategoryView> createState() => _AdsBasedCategoryViewState();
}

class _AdsBasedCategoryViewState extends State<AdsBasedCategoryView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => AdsBasedCategoryViewModel(),
        child: Scaffold(
          backgroundColor: ColorManager.bgColor,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
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
                        text: AppStrings.advertisesText.getString(context),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Consumer<AdsBasedCategoryViewModel>(
                    builder: (BuildContext context, viewModel, Widget? child) =>
                        FutureBuilder(
                          future: viewModel
                              .indicateCategoryAndGetAds(widget.categoryName!),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                  height: displayHeight(context) * 0.8,
                                  child: LoadingAnimationWidget.twistingDots(
                                      leftDotColor: ColorManager.darkGreenColor,
                                      rightDotColor:
                                          ColorManager.lightGreenColor,
                                      size: displayWidth(context) * 0.15),
                                ),
                              );
                            } else {
                              if (snapshot.data.isEmpty) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(ImageAssets.emptyIcon),
                                    TextContainer(
                                      text: AppStrings.noAdsText
                                          .getString(context),
                                      width: displayWidth(context),
                                      textAlign: TextAlign.center,
                                      align: Alignment.center,
                                      fontSize: 22,
                                      color: ColorManager.fontColor3,
                                      fontWeight: FontWeight.w600,
                                    )
                                  ],
                                );
                              } else {
                                return ListView.builder(
                                  primary: false,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: displayWidth(context) * 0.03,
                                      vertical: displayHeight(context) * 0.02),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return RoundedContainer(
                                      width: displayWidth(context) * 0.85,
                                      // height: displayHeight(context) * 0.15,
                                      radius: displayHeight(context) * 0.03,
                                      margin: EdgeInsets.only(
                                          bottom:
                                              displayHeight(context) * 0.015),
                                      color: ColorManager.whiteColor,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            context.push('/ad_details/view',
                                                extra: snapshot.data[index]);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  ColorManager.whiteColor,
                                              foregroundColor:
                                                  ColorManager.lightGreenColor,
                                              padding: const EdgeInsets.only(
                                                  top: AppPadding.p5,
                                                  bottom: AppPadding.p5,
                                                  left: AppPadding.p5),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          displayHeight(
                                                                  context) *
                                                              0.04))),
                                          child: Row(
                                            children: [
                                              RoundedContainer(
                                                radius: displayHeight(context) *
                                                    0.03,
                                                padding: const EdgeInsets.only(
                                                  right: AppPadding.p2,
                                                ),
                                                child: FutureBuilder(
                                                  future: supabase.storage
                                                      .from('properties_ads')
                                                      .list(
                                                          path:
                                                              '${snapshot.data[index]['bucket_path']}${snapshot.data[index]['ad_id']}'),
                                                  builder: (context,
                                                      AsyncSnapshot snapshott) {
                                                    if (snapshott
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return LoadingAnimationWidget
                                                          .prograssiveDots(
                                                              color: ColorManager
                                                                  .lightGreenColor,
                                                              size: 15);
                                                    } else {
                                                      if (snapshott.data ==
                                                          null) {
                                                        return TextContainer(
                                                          text: AppStrings
                                                              .failedToLoadText
                                                              .getString(
                                                                  context),
                                                          fontSize: 14,
                                                          width: displayWidth(
                                                                  context) *
                                                              0.28,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: ColorManager
                                                              .fontColor3,
                                                          height: displayHeight(
                                                                  context) *
                                                              0.18,
                                                          align:
                                                              Alignment.center,
                                                          textAlign:
                                                              TextAlign.center,
                                                        );
                                                      } else {
                                                        if (snapshott
                                                            .data!.isNotEmpty) {
                                                          return ExtendedImage
                                                              .network(
                                                            supabase.storage
                                                                .from(
                                                                    'properties_ads')
                                                                .getPublicUrl(
                                                                    '${snapshot.data[index]['bucket_path']}${snapshot.data[index]['ad_id']}/${snapshott.data[0].name}'),
                                                            fit: BoxFit.cover,
                                                            width: displayWidth(
                                                                    context) *
                                                                0.28,
                                                            height:
                                                                displayHeight(
                                                                    context)*0.15,
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    displayHeight(
                                                                            context) *
                                                                        0.03),
                                                          );
                                                        } else {
                                                          return TextContainer(
                                                            text: AppStrings
                                                                .noPicsText
                                                                .getString(
                                                                    context),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                FontConstants
                                                                    .arabicFontFamily,
                                                            width: displayWidth(
                                                                    context) *
                                                                0.28,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                165, 134, 134),
                                                            height: displayHeight(
                                                                    context) *
                                                                0.18,
                                                            align: Alignment
                                                                .center,
                                                            textAlign: TextAlign
                                                                .center,
                                                          );
                                                        }
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: displayWidth(context) *
                                                    0.02,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextContainer(
                                                    text: snapshot.data[index]
                                                            ['category_name']
                                                        .toString()
                                                        .getString(context),
                                                    width:
                                                        displayWidth(context) *
                                                            0.47,
                                                    margin: EdgeInsets.only(
                                                        top: displayHeight(
                                                                context) *
                                                            0.005),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorManager
                                                        .adTitleColor,
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 3,
                                                  ),
                                                  TextContainer(
                                                    text: NumberFormat.compact(
                                                            locale: localization
                                                                .currentLocale!
                                                                .languageCode)
                                                        .format(int.parse(
                                                            snapshot.data[index]
                                                                    ['price'] ??
                                                                '0')),
                                                    width:
                                                        displayWidth(context) *
                                                            0.47,
                                                    margin: EdgeInsets.only(
                                                        top: displayHeight(
                                                                context) *
                                                            0.008),
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        ColorManager.fontColor3,
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 1,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        displayHeight(context) *
                                                            0.008,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SvgPicture.asset(
                                                          ImageAssets
                                                              .homeLocationIcon),
                                                      TextContainer(
                                                        text: snapshot
                                                            .data[index][
                                                                'location_address']
                                                            .toString(),
                                                        width: displayWidth(
                                                                context) *
                                                            0.43,
                                                       
                                                       
                                                        margin: EdgeInsets.only(
                                                            left: displayWidth(
                                                                    context) *
                                                                0.01,bottom: displayHeight(context) * 0.01),
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: ColorManager
                                                            .fontColor3,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        maxLines: 3,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      if (snapshot.data[index]
                                                              ['bedrooms'] !=
                                                          null)
                                                        SizedBox(
                                                          width: displayWidth(
                                                                  context) *
                                                              0.13,
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  ImageAssets
                                                                      .roomsIcon),
                                                              TextContainer(
                                                                text: snapshot
                                                                            .data[
                                                                        index][
                                                                    'bedrooms'],
                                                                margin: EdgeInsets.only(
                                                                    left: displayWidth(
                                                                            context) *
                                                                        0.01),
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: ColorManager
                                                                    .fontColor3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                maxLines: 1,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                         if (snapshot.data[
                                                                        index][
                                                                    'bathrooms'] !=
                                                                null)
                                                      SizedBox(
                                                        width: displayWidth(
                                                                context) *
                                                            0.13,
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                ImageAssets
                                                                    .bathIcon),
                                                            TextContainer(
                                                              text: snapshot
                                                                          .data[
                                                                      index]
                                                                  ['bathrooms'],
                                                              margin: EdgeInsets.only(
                                                                  left: displayWidth(
                                                                          context) *
                                                                      0.01),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: ColorManager
                                                                  .fontColor3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              maxLines: 1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: displayWidth(
                                                                context) *
                                                            0.19,
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                ImageAssets
                                                                    .areaIcon),
                                                            TextContainer(
                                                              text:
                                                                  snapshot.data[
                                                                          index]
                                                                      ['area'],
                                                              margin: EdgeInsets.only(
                                                                  left: displayWidth(
                                                                          context) *
                                                                      0.01),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: ColorManager
                                                                  .fontColor3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      if(snapshot.data[index]['street_width'] != null)
                                                      SizedBox(
                                                        width: displayWidth(
                                                                context) *
                                                            0.19,
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                ImageAssets
                                                                    .streetWidthIcon),
                                                            TextContainer(
                                                              text:
                                                                  snapshot.data[
                                                                          index]
                                                                      ['street_width'],
                                                              margin: EdgeInsets.only(
                                                                  left: displayWidth(
                                                                          context) *
                                                                      0.01),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: ColorManager
                                                                  .fontColor3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: SvgPicture.asset(
                                                      ImageAssets.favIcon))
                                            ],
                                          )),
                                    );
                                  },
                                );
                              }
                            }
                          },
                        ))
              ],
            ),
          ),
        ));
  }
}
