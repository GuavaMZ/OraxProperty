import 'package:flutter/material.dart';
import 'package:oraxproperty/app/app.dart';
import 'package:oraxproperty/app/value_holders.dart';

import 'package:oraxproperty/presentation/homepage/viewmodel/homepage_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:oraxproperty/main.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oraxproperty/presentation/search/view/search_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView>
    with AutomaticKeepAliveClientMixin {
  final HomepageViewModel _viewModel = HomepageViewModel();
  String? selectedFilter;

  final FocusNode _focusNode = FocusNode();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _viewModel.currentAdFuture = _viewModel.getAdsForMap();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
      } else {}
    });
    if (ValueHolders.isGuest == false) {
      Future.wait([_viewModel.getUserRule()]);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomepageViewModel(),
      child: Scaffold(
        backgroundColor: ColorManager.bgColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          // alignment: AlignmentDirectional.center,
          children: [
            GestureDetector(
              onTap: () async {
                // await Provider.of<HomepageViewModel>(context, listen: false)
                //     .hideAdWiget();
                // print('Tappped');
              },
              child: FlutterMap(
                mapController: _viewModel.mapController,
                options: MapOptions(
                    initialCenter: _viewModel.initialCenter,
                    initialZoom: _viewModel.initZoomLevel,
                    maxZoom: _viewModel.maxZoomLevel,
                    keepAlive: true,
                    interactionOptions: const InteractionOptions(
                        rotationWinGestures: MultiFingerGesture.none)),
                children: [
                  TileLayer(
                    urlTemplate: _viewModel.mapStyles[0],
                    errorTileCallback: (tile, error, stackTrace) {},
                    maxZoom: _viewModel.maxZoomLevel,
                  ),
                  FutureBuilder(
                    future: _viewModel.currentAdFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            child: LoadingAnimationWidget.twistingDots(
                                leftDotColor: ColorManager.darkGreenColor,
                                rightDotColor: ColorManager.lightGreenColor,
                                size: displayWidth(context) * 0.15),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return Consumer<HomepageViewModel>(
                          builder: (BuildContext context, viewModell,
                                  Widget? child) =>
                              MarkerLayer(markers: [
                            for (var data in snapshot.data)
                              if (data.isNotEmpty)
                                Marker(
                                    point: LatLng(
                                        double.parse(data['location_latlng']
                                            .toString()
                                            .split(',')
                                            .first),
                                        double.parse(data['location_latlng']
                                            .toString()
                                            .split(',')
                                            .last)),
                                    width: displayWidth(context) * 0.25,
                                    height: 65,
                                    child: IconButton(
                                        onPressed: () {
                                          viewModell.adCategroy =
                                              data['category_name']
                                                  .toString()
                                                  .getString(context);
                                          viewModell.adData = data;
                                          viewModell.showAdWidget(
                                              displayHeight(context) * 0.12);
                                        },
                                        icon: Column(
                                          children: [
                                            Image.asset(
                                              ImageAssets.pinMarkerIcon,
                                              width: 28,
                                              height: 28,
                                              alignment: Alignment.center,
                                            ),
                                            TextContainer(
                                              text: NumberFormat.compact(
                                                      locale: localization
                                                          .currentLocale!
                                                          .languageCode)
                                                  .format(int.parse(
                                                      data['price'] ?? '0')),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.fontColor3,
                                              fontFamily: FontConstants
                                                  .arabicFontFamily,
                                              // overflow: TextOverflow.clip,
                                              maxLines: 1,
                                            ),
                                          ],
                                        )))
                          ]),
                        );
                      } else {
                        return Container(
                            //TODO:Error here
                            );
                      }
                    },
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: displayHeight(context) * 0.05,
                ),
                SizedBox(
                  width: displayWidth(context),
                  height: AppSize.s60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.push('/all_categories/view');
                        },
                        icon: SvgPicture.asset(ImageAssets.categoriesIcon),
                      ),
                      TextContainer(
                        width: displayWidth(context) * 0.68,
                        text: AppStrings.homePageText.getString(context),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      if (ValueHolders.isGuest == false)
                        CircleAvatar(
                            backgroundColor: ColorManager.lightGreenColor,
                            child: supabase.auth.currentUser!
                                        .userMetadata!['profile_photo'] !=
                                    null
                                ? ExtendedImage.network(
                                    supabase.storage
                                        .from('users_profile')
                                        .getPublicUrl(supabase.auth.currentUser!
                                            .userMetadata!['profile_photo']
                                            .toString()
                                            .split('/')
                                            .last),
                                    shape: BoxShape.circle,
                                    compressionRatio: 0.5,
                                  )
                                : TextContainer(
                                    text: supabase.auth.currentUser!
                                        .userMetadata!['full_name'][0],
                                    fontSize: 20)),
                      if (ValueHolders.isGuest == true)
                        const CircleAvatar(
                          backgroundColor: ColorManager.lightGreenColor,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      controller: _viewModel.searchController,
                      onChanged: (query){
                        if (query.isNotEmpty) {
                          context.push('/search/view',extra: query);
                          _viewModel.searchController.clear();
                        }
                      },
                      width: displayWidth(context) * 0.66,
                      height: AppSize.s50,
                      focusedBorderRadius: AppSize.s30,
                      enabledBorderRadius: AppSize.s30,
                      errorBorderRadius: AppSize.s30,
                      obsecureText: false,
                      focusNode: _focusNode,
                      contentPadding:
                          const EdgeInsets.only(left: AppPadding.p16),
                      prefixIcon: SvgPicture.asset(
                        ImageAssets.searchIcon,
                        fit: BoxFit.scaleDown,
                        color: _focusNode.hasFocus
                            ? ColorManager.lightGreenColor
                            : ColorManager.greyColor,
                      ),
                      focusedBorderColor: ColorManager.whiteColor,
                    ),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                    CircleAvatar(
                      backgroundColor: ColorManager.whiteColor,
                      radius: AppSize.s24,
                      child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            ImageAssets.filterIcon,
                            fit: BoxFit.scaleDown,
                            color: ColorManager.lightGreenColor,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: displayHeight(context) * 0.015,
                ),
                SizedBox(
                  height: AppSize.s30,
                  width: displayWidth(context) * 0.95,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: buildadStatusChoices(),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: displayHeight(context) * 0.77, right: AppMargin.m10),
              alignment: Alignment.bottomRight,
              child: Column(children: [
                FloatingActionButton(
                  onPressed: () {},
                  heroTag: 'gpsTag',
                  backgroundColor: ColorManager.whiteColor,
                  child: SvgPicture.asset(
                    ImageAssets.gpsIcon,
                    width: displayWidth(context) * 0.06,
                  ),
                )
              ]),
            ),
            Consumer<HomepageViewModel>(
              builder: (context, homepageViewModel, child) =>
                  AnimatedPositioned(
                      // bottom: displayHeight(context) * 0.12,
                      left: displayWidth(context) * 0.065,
                      bottom: homepageViewModel.adOffsetBottomPosition,
                      duration: const Duration(milliseconds: 300),
                      child: Visibility(
                        visible: homepageViewModel.adContainerIsVisible,
                        child: FutureBuilder(
                            future: homepageViewModel.adData['ad_id'] != null
                                ? homepageViewModel
                                    .indicateCategoryAndGetAdDetails(
                                        homepageViewModel.adData['category_id'],
                                        homepageViewModel.adData['ad_id'])
                                : null,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              } else {
                                return RoundedContainer(
                                  width: displayWidth(context) * 0.9,
                                  // height: displayHeight(context) * 0.18,
                                  constraints: BoxConstraints(
                                      maxHeight: displayHeight(context) * 0.18),
                                  radius: displayHeight(context) * 0.035,
                                  color: ColorManager.whiteColor,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        context.push('/ad_details/view',
                                            extra: snapshot.data[0]);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              ColorManager.whiteColor,
                                          foregroundColor:
                                              ColorManager.lightGreenColor,
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
                                                          0.035))),
                                      child: Row(
                                        children: [
                                          RoundedContainer(
                                            radius:
                                                displayHeight(context) * 0.04,
                                            padding: const EdgeInsets.only(
                                              right: AppPadding.p2,
                                            ),
                                            child: FutureBuilder(
                                                future: supabase.storage
                                                    .from('properties_ads')
                                                    .list(
                                                        path:
                                                            '${snapshot.data[0]['bucket_path']}${snapshot.data[0]['ad_id']}'),
                                                builder: (context,
                                                    AsyncSnapshot<
                                                            List<FileObject>>
                                                        snapshott) {
                                                  if (snapshott
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return SizedBox(
                                                      width: displayWidth(
                                                              context) *
                                                          0.28,
                                                      child: const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    );
                                                  } else {
                                                    if (snapshott.data ==
                                                        null) {
                                                      return TextContainer(
                                                        text: AppStrings
                                                            .failedToLoadText
                                                            .getString(context),
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
                                                            context),
                                                        align: Alignment.center,
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
                                                                  '${snapshot.data[0]['bucket_path']}${snapshot.data[0]['ad_id']}/${snapshott.data?[0].name}'),
                                                          fit: BoxFit.cover,
                                                          width: displayWidth(
                                                                  context) *
                                                              0.28,
                                                          height: displayHeight(
                                                              context),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  displayHeight(
                                                                          context) *
                                                                      0.035),
                                                        );
                                                      } else {
                                                        return TextContainer(
                                                          text: AppStrings
                                                              .noPicsText
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
                                                          color: const Color
                                                              .fromARGB(255,
                                                              165, 134, 134),
                                                          height: displayHeight(
                                                                  context) *
                                                              0.18,
                                                          align:
                                                              Alignment.center,
                                                          textAlign:
                                                              TextAlign.center,
                                                        );
                                                      }
                                                    }
                                                  }
                                                }),
                                          ),
                                          SizedBox(
                                            width: displayWidth(context) * 0.04,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextContainer(
                                                text: snapshot.data[0]
                                                        ['property_categories']
                                                        ['category_name']
                                                    .toString()
                                                    .getString(context),
                                                width: displayWidth(context) *
                                                    0.44,
                                                // margin: EdgeInsets.only(
                                                //     top:
                                                //         displayHeight(context) * 0.005),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    ColorManager.adTitleColor,
                                                fontFamily: FontConstants
                                                    .arabicFontFamily,
                                                overflow: TextOverflow.clip,
                                                maxLines: 2,
                                              ),
                                              TextContainer(
                                                text: NumberFormat.compact(
                                                        locale: localization
                                                            .currentLocale!
                                                            .languageCode)
                                                    .format(int.parse(snapshot
                                                            .data[0]['price'] ??
                                                        '0')),
                                                width: displayWidth(context) *
                                                    0.44,
                                                margin: EdgeInsets.only(
                                                    top:
                                                        displayHeight(context) *
                                                            0.006,
                                                    bottom:
                                                        displayHeight(context) *
                                                            0.006),
                                                fontSize:
                                                    displayHeight(context) *
                                                        0.023,
                                                fontWeight: FontWeight.w700,
                                                color: ColorManager.fontColor3,
                                                fontFamily: FontConstants
                                                    .arabicFontFamily,
                                                overflow: TextOverflow.clip,
                                                maxLines: 1,
                                              ),
                                              // SizedBox(
                                              //   height: displayHeight(context) * 0.01,
                                              // ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(ImageAssets
                                                      .homeLocationIcon),
                                                  TextContainer(
                                                    text:
                                                        '${snapshot.data[0]['location_address']}',
                                                    width:
                                                        displayWidth(context) *
                                                            0.45,
                                                    margin: EdgeInsets.only(
                                                        left: displayWidth(
                                                                context) *
                                                            0.01),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        ColorManager.fontColor3,
                                                    fontFamily: FontConstants
                                                        .arabicFontFamily,
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: displayHeight(context) *
                                                    0.01,
                                              ),
                                              Row(
                                                children: [
                                                  if (snapshot.data[0]
                                                          ['bedrooms'] !=
                                                      null)
                                                    SizedBox(
                                                      // width: displayWidth(context) * 0.12,
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              ImageAssets
                                                                  .roomsIcon),
                                                          TextContainer(
                                                            text:
                                                                '${snapshot.data[0]['bedrooms']}',
                                                            margin: EdgeInsets.only(
                                                                left: displayWidth(
                                                                        context) *
                                                                    0.01,
                                                                right: displayWidth(
                                                                        context) *
                                                                    0.03),
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: ColorManager
                                                                .fontColor3,
                                                            fontFamily:
                                                                FontConstants
                                                                    .arabicFontFamily,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            maxLines: 1,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  if (snapshot.data[0]
                                                          ['bathrooms'] !=
                                                      null)
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
                                                            text:
                                                                '${snapshot.data[0]['bathrooms']}',
                                                            margin: EdgeInsets.only(
                                                                left: displayWidth(
                                                                        context) *
                                                                    0.01),
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: ColorManager
                                                                .fontColor3,
                                                            fontFamily:
                                                                FontConstants
                                                                    .arabicFontFamily,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            maxLines: 1,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  if (snapshot.data[0]
                                                          ['area'] !=
                                                      null)
                                                    SizedBox(
                                                      // width: displayWidth(context) * 0.14,
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              ImageAssets
                                                                  .areaIcon),
                                                          TextContainer(
                                                            text:
                                                                '${snapshot.data[0]['area']}',
                                                            margin: EdgeInsets.only(
                                                                left: displayWidth(
                                                                        context) *
                                                                    0.01,
                                                                right: displayWidth(
                                                                        context) *
                                                                    0.03),
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: ColorManager
                                                                .fontColor3,
                                                            fontFamily:
                                                                FontConstants
                                                                    .arabicFontFamily,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  if (snapshot.data[0]
                                                          ['street_width'] !=
                                                      null)
                                                    SizedBox(
                                                      // width: displayWidth(context) * 0.14,
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            ImageAssets
                                                                .streetWidthIcon,
                                                            width: displayWidth(
                                                                    context) *
                                                                0.04,
                                                          ),
                                                          TextContainer(
                                                            text: snapshot
                                                                .data[0][
                                                                    'street_width']
                                                                .toString()
                                                                .getString(
                                                                    context),
                                                            margin: EdgeInsets.only(
                                                                left: displayWidth(
                                                                        context) *
                                                                    0.01),
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: ColorManager
                                                                .fontColor3,
                                                            fontFamily:
                                                                FontConstants
                                                                    .arabicFontFamily,
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
                                                height: displayHeight(context) *
                                                    0.01,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    ImageAssets.calenderIcon,
                                                    width:
                                                        displayWidth(context) *
                                                            0.038,
                                                  ),
                                                  TextContainer(
                                                    text: snapshot.data[0]
                                                            ['ads_created_at']
                                                        .toString()
                                                        .split('T')
                                                        .first,
                                                    width:
                                                        displayWidth(context) *
                                                            0.4,
                                                    margin: EdgeInsets.only(
                                                        left: displayWidth(
                                                                context) *
                                                            0.01),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        ColorManager.fontColor3,
                                                    fontFamily: FontConstants
                                                        .arabicFontFamily,
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                );
                              }
                            }),
                      )),
            )
          ],
        ),
      ),
    );
  }

  buildadStatusChoices() {
    List<Widget> choices = [];
    List propertyFilters = [
      AppStrings.allText.getString(context),
      AppStrings.villasForSaleText.getString(context),
      AppStrings.villasForRentText.getString(context),
      AppStrings.apartmentForSaleText.getString(context),
      AppStrings.apartmentForRentText.getString(context),
      AppStrings.landForSaleText.getString(context),
      AppStrings.landForRentText.getString(context),
    ];

    List propertyFiltersIcons = [
      ImageAssets.allPropsIcon,
      ImageAssets.villasIcon,
      ImageAssets.villaForRent,
      ImageAssets.apartmentIcon,
      ImageAssets.apartmentForRent,
      ImageAssets.landsIcon,
      ImageAssets.landsIcon,
    ];

    List<Future> adsFutures = [
      _viewModel.getAdsForMap(),
      _viewModel.getVillaForSale(),
      _viewModel.getApartmentsForRent(),
      _viewModel.getApartmentsForSale(),
      _viewModel.getApartmentsForRent(),
    ];

    for (var element in propertyFilters) {
      choices.add(ChoiceChip(
          selected: selectedFilter == element,
          showCheckmark: false,
          elevation: 1,
          onSelected: (selected) {
            setState(() {
              selectedFilter = element;
              _viewModel.currentAdFuture =
                  adsFutures[propertyFilters.indexOf(element)];
            });
          },
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                propertyFiltersIcons[propertyFilters.indexOf(element)],
                fit: BoxFit.contain,
                width: displayWidth(context) * 0.035,
                height: displayHeight(context) * 0.015,
                color: selectedFilter == element
                    ? ColorManager.whiteColor
                    : ColorManager.blackColor,
              ),
              TextContainer(
                text: element,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                margin: const EdgeInsets.only(left: AppMargin.m3,right:AppMargin.m3),
                color: selectedFilter == element
                    ? ColorManager.whiteColor
                    : ColorManager.blackColor,
              ),
            ],
          ),
          side: const BorderSide(width: 0, color: ColorManager.whiteColor),
          selectedColor: ColorManager.lightGreenColor,
          backgroundColor: ColorManager.whiteColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s20)),
          )));
      choices.add(const SizedBox(
        width: AppSize.s3,
      ));
    }
    return choices;
  }
}
