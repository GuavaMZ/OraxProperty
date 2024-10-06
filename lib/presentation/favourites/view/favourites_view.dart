import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraxproperty/app/app.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/favourites/viewmodel/favourites_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FavouritesViewModel(),
      child: Scaffold(
        backgroundColor: ColorManager.bgColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextContainer(
            text: AppStrings.favsText.getString(context),
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 25,
            fontWeight: FontWeight.bold,
            margin: const EdgeInsets.only(top: AppMargin.m10),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Consumer<FavouritesViewModel>(
          builder: (BuildContext context, viewModel, Widget? child) =>
              SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: viewModel
                              .getFavouriteAds(supabase.auth.currentUser!.id),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                  height: displayHeight(context) * 0.75,
                                  child: LoadingAnimationWidget.prograssiveDots(
                                      color: ColorManager.lightGreenColor, size: displayWidth(context) * 0.15),
                                ),
                              );
                            } else {
                              if (snapshot.data.isEmpty) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(ImageAssets.emptyIcon),
                                    TextContainer(
                                      text: AppStrings.noAdsText.getString(context),
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
                                    // controller: _viewModel.scrollController,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: displayWidth(context) * 0.03,
                                        vertical: displayHeight(context) * 0.02),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return RoundedContainer(
                                        width: displayWidth(context) * 0.85,
                                        height: displayHeight(context) * 0.18,
                                        radius: displayHeight(context) * 0.04,
                                        margin: EdgeInsets.only(
                                            bottom: displayHeight(context) * 0.015),
                                        color: ColorManager.whiteColor,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              print(snapshot.data[index]);
                                              context.push('/ad_details/view',
                                                  extra: snapshot.data[index]);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: ColorManager
                                                    .whiteColor,
                                                foregroundColor: ColorManager
                                                    .lightGreenColor,
                                                padding: EdgeInsets.only(
                                                    top: displayHeight(context) *
                                                        0.005,
                                                    bottom: displayHeight(context) *
                                                        0.005,
                                                    left: AppPadding.p5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            displayHeight(context) *
                                                                0.04))),
                                            child: Row(
                                              children: [
                                                RoundedContainer(
                                                  radius:
                                                      displayHeight(context) * 0.04,
                                                  padding: const EdgeInsets.only(
                                                      right: AppPadding.p2,
                                                      bottom: AppPadding.p2),
                                                  child: FutureBuilder(
                                                      future: supabase.storage
                                                          .from('properties_ads')
                                                          .list(
                                                              path:
                                                                  '${snapshot.data[index]['bucket_path']}${snapshot.data[index]['ad_id']}'),
                                                      builder:
                                                          (context, snapshott) {
                                                        if (snapshott
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return SizedBox(
                                                            width: displayWidth(
                                                                    context) *
                                                                0.28,
                                                            child: const Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                          );
                                                        } else {
                                                          if (snapshot.data ==
                                                              null) {
                                                            return TextContainer(
                                                              text: AppStrings
                                                                  .failedToLoadText
                                                                  .getString(
                                                                      context),
                                                              fontSize: 14,
                                                              fontFamily: FontConstants
                                                                  .arabicFontFamily,
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
                                                                        '${snapshot.data[index]['bucket_path']}${snapshot.data[index]['ad_id']}/${snapshott.data?[0].name}'),
                                                                fit: BoxFit.cover,
                                                                width: displayWidth(
                                                                        context) *
                                                                    0.28,
                                                                height:
                                                                    displayHeight(
                                                                        context),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        displayHeight(
                                                                                context) *
                                                                            0.04),
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
                                                      }),
                                                ),
                                                SizedBox(
                                                  width:
                                                      displayWidth(context) * 0.04,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextContainer(
                                                      text: snapshot.data[index]
                                                          ['category_name'].toString().getString(context),
                                                      width: displayWidth(context) *
                                                          0.44,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color:
                                                          ColorManager.adTitleColor,
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
                                                      width: displayWidth(context) *
                                                          0.44,
                                                      margin: EdgeInsets.only(
                                                          top: displayHeight(
                                                                  context) *
                                                              0.006,
                                                          bottom: displayHeight(
                                                                  context) *
                                                              0.006),
                                                      fontSize:
                                                          displayHeight(context) *
                                                              0.023,
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                          ColorManager.fontColor3,
                                                      overflow: TextOverflow.clip,
                                                      maxLines: 1,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(ImageAssets
                                                            .homeLocationIcon),
                                                        TextContainer(
                                                          text:
                                                              '${snapshot.data[index]['location_address']}',
                                                          width: displayWidth(
                                                                  context) *
                                                              0.4,
                                                          margin: EdgeInsets.only(
                                                              left: displayWidth(
                                                                      context) *
                                                                  0.01),
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorManager
                                                              .fontColor3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          maxLines: 2,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          displayHeight(context) *
                                                              0.01,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: displayWidth(
                                                                  context) *
                                                              0.12,
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  ImageAssets
                                                                      .roomsIcon),
                                                              TextContainer(
                                                                text: snapshot
                                                                        .data[index]
                                                                    ['bedrooms'],
                                                                margin: EdgeInsets.only(
                                                                    left: displayWidth(
                                                                            context) *
                                                                        0.01),
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight.w500,
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
                                                              0.12,
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  ImageAssets
                                                                      .bathIcon),
                                                              TextContainer(
                                                                text: snapshot
                                                                        .data[index]
                                                                    ['bathrooms'],
                                                                margin: EdgeInsets.only(
                                                                    left: displayWidth(
                                                                            context) *
                                                                        0.01),
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight.w500,
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
                                                              0.14,
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  ImageAssets
                                                                      .areaIcon),
                                                              TextContainer(
                                                                text: snapshot
                                                                        .data[index]
                                                                    ['area'],
                                                                margin: EdgeInsets.only(
                                                                    left: displayWidth(
                                                                            context) *
                                                                        0.01),
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight.w500,
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
                                                    SizedBox(
                                                      height:
                                                          displayHeight(context) *
                                                              0.01,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(ImageAssets
                                                            .calenderIcon,width: displayWidth(context) *0.038,),
                                                        TextContainer(
                                                          text: snapshot.data[index]
                                                                  ['ads_created_at']
                                                              .toString()
                                                              .split('T')
                                                              .first,
                                                          width: displayWidth(
                                                                  context) *
                                                              0.4,
                                                          margin: EdgeInsets.only(
                                                              left: displayWidth(
                                                                      context) *
                                                                  0.01),
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorManager
                                                              .fontColor3,
                                                          fontFamily: FontConstants
                                                              .outfitFontFamily,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          maxLines: 2,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      try {
                                                        final res =
                                                            await viewModel
                                                                .removeFromFav(
                                                                    supabase
                                                                        .auth
                                                                        .currentUser!
                                                                        .id,
                                                                    snapshot.data[
                                                                            index]
                                                                        ['ad_id']);
                                                        if (res == 'Success') {
                                                          Fluttertoast.showToast(
                                                              msg: AppStrings
                                                                  .removedFromFavText
                                                                  .getString(
                                                                      context));
                      
                                                          viewModel
                                                              .toggleNotifyListener();
                                                        }
                                                      } catch (e) {
                                                        Fluttertoast.showToast(
                                                            msg: e.toString());
                                                      }
                                                    },
                                                    icon: SvgPicture.asset(
                                                      ImageAssets.favFilledIcon,
                                                      color: ColorManager.favColor,
                                                    ))
                                              ],
                                            )),
                                      );
                                    });
                              }
                            }
                          }),
                          SizedBox(height: displayHeight(context) * 0.12,)
                    ],
                  )),
        ),
      ),
    );
  }
}
