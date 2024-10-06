// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/domain/model/support_data.dart';
import 'package:oraxproperty/main.dart';
import 'package:oraxproperty/presentation/ad_details/viewmodel/ad_details_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class AdDetailsView extends StatefulWidget {
  AdDetailsView({super.key, this.adDetails});
  // ignore: prefer_typing_uninitialized_variables
  var adDetails;
  @override
  State<AdDetailsView> createState() => _AdDetailsViewState();
}

class _AdDetailsViewState extends State<AdDetailsView> {
  final AdDetailsViewModel _viewModel = AdDetailsViewModel();
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    if (ValueHolders.isGuest == false) {
      Future.wait([
        _viewModel.checkIfFav(
            supabase.auth.currentUser!.id, widget.adDetails['ad_id'])
      ]).then((value) {
        print(value);
        if (value[0][0]['ad_id'] == widget.adDetails['ad_id']) {
          isFav = true;
        }
      });
    }

    // final res = await _viewModel.checkIfFav(
    //     supabase.auth.currentUser!.id, widget.adDetails['ad_id']);
    // if (res[0]['ad_id'] == widget.adDetails['ad_id']) {
    //   isFav = true;

    // }
    // print(res);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AdDetailsViewModel(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorManager.transparent,
        ),
        backgroundColor: ColorManager.bgColor,
        resizeToAvoidBottomInset: false,
        body: Consumer<AdDetailsViewModel>(
            builder: (BuildContext context, viewModel, Widget? child) =>
                SingleChildScrollView(
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Column(
                        children: [
                          FutureBuilder(
                            future: supabase.storage.from('properties_ads').list(
                                path:
                                    '${widget.adDetails['bucket_path']}${widget.adDetails['ad_id']}'),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<FileObject>> snapshot) {
                              return Container(
                                width: displayWidth(context),
                                height: displayHeight(context) * 0.65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(
                                          displayHeight(context) * 0.09),
                                      bottomRight: Radius.circular(
                                          displayHeight(context) * 0.09)),
                                ),
                                child: PageView.builder(
                                  itemCount: snapshot.data?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: LoadingAnimationWidget.flickr(
                                              leftDotColor:
                                                  ColorManager.darkGreenColor,
                                              rightDotColor:
                                                  ColorManager.lightGreenColor,
                                              size: displayWidth(context) *
                                                  0.15));
                                    } else {
                                      if (snapshot.data!.isEmpty) {
                                        return Center(
                                            child: TextContainer(
                                                text: AppStrings.noPicsText
                                                    .getString(context),
                                                fontSize:
                                                    displayHeight(context) *
                                                        0.2,
                                                color:
                                                    ColorManager.fontColor3));
                                      } else {
                                        return GestureDetector(
                                          child: ExtendedImage.network(
                                            supabase.storage
                                                .from('properties_ads')
                                                .getPublicUrl(
                                                    '${widget.adDetails['bucket_path']}${widget.adDetails['ad_id']}/${snapshot.data?[index].name}'),
                                            fit: BoxFit.cover,
                                            width: displayWidth(context),
                                            height:
                                                displayHeight(context) * 0.65,
                                            shape: BoxShape.rectangle,
                                            retries: 5,
                                            compressionRatio: 0.5,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    displayHeight(context) *
                                                        0.09),
                                                bottomRight: Radius.circular(
                                                    displayHeight(context) *
                                                        0.09)),
                                          ),
                                          onTap: () {
                                            showDialog(
                                                barrierColor:
                                                    ColorManager.blackColor,
                                                context: context,
                                                builder: (context) {
                                                  return SizedBox(
                                                    height:
                                                        displayHeight(context),
                                                    width:
                                                        displayWidth(context),
                                                    child: PageView.builder(
                                                      itemCount: snapshot
                                                              .data?.length ??
                                                          0,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int indexx) {
                                                        return Stack(
                                                          children: [
                                                            Center(
                                                              child:
                                                                  ExtendedImage
                                                                      .network(
                                                                supabase.storage
                                                                    .from(
                                                                        'properties_ads')
                                                                    .getPublicUrl(
                                                                        '${widget.adDetails['bucket_path']}${widget.adDetails['ad_id']}/${snapshot.data?[indexx].name}'),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                retries: 5,
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  left:
                                                                      AppMargin
                                                                          .m10,
                                                                  top: AppMargin
                                                                      .m20),
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                        ColorManager
                                                                            .transparent),
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_back,
                                                                  color: ColorManager
                                                                      .whiteColor,
                                                                  size: displayWidth(
                                                                          context) *
                                                                      0.08,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                });
                                          },
                                        );
                                      }
                                    }
                                  },
                                ),
                              );
                            },
                          ),

                          // TextContainer(
                          //   width: displayWidth(context) * 0.88,
                          //   text: 'Listing Agent',
                          //   margin: EdgeInsets.only(
                          //       top: displayHeight(context) * 0.06),
                          //   fontSize: 18,
                          //   fontWeight: FontWeight.w700,
                          // ),
                          SizedBox(
                            height: displayHeight(context) * 0.08,
                          ),
                          FutureBuilder(
                              future: viewModel
                                  .getUserDetails(widget.adDetails['uid']),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                } else {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: displayWidth(context) * 0.05,
                                      ),
                                      CircleAvatar(
                                          radius: displayWidth(context) * 0.065,
                                          child: snapshot.data[0]
                                                      ['profile_photo'] ==
                                                  null
                                              ? TextContainer(
                                                  text: snapshot.data[0]
                                                      ['full_name'][0],
                                                  fontSize: 20)
                                              : ExtendedImage.network(
                                                  supabase.storage
                                                      .from('users_profile')
                                                      .getPublicUrl(snapshot
                                                          .data[0]
                                                              ['profile_photo']
                                                          .toString()
                                                          .split('/')
                                                          .last),
                                                  shape: BoxShape.circle,
                                                  compressionRatio: 0.5,
                                                )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextContainer(
                                            // width: displayWidth(context) *
                                            //     0.35,
                                            text: snapshot.data[0]['full_name'],
                                            margin: EdgeInsets.only(
                                                left: displayWidth(context) *
                                                    0.02),
                                            fontSize: 14,
                                            maxLines: 1,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          // TextContainer(
                                          //   width: displayWidth(context) *
                                          //       0.35,
                                          //   text: snapshot.data[0]
                                          //       ['membership_type'],
                                          //   margin: EdgeInsets.only(
                                          //       left: displayWidth(
                                          //               context) *
                                          //           0.02),
                                          //   fontSize: 14,
                                          //   maxLines: 1,
                                          //   fontWeight: FontWeight.w500,
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: displayWidth(context) * 0.06,
                                      ),
                                      RoundedContainer(
                                        width: displayWidth(context) * 0.11,
                                        height: displayHeight(context) * 0.055,
                                        radius: displayHeight(context) * 0.1,
                                        color: ColorManager.favButtonBackColor,
                                        boxShadow: const BoxShadow(
                                            color: ColorManager
                                                .favButtonBackColor),
                                        child: IconButton(
                                            onPressed: () async {
                                              List<SupportersData> res =
                                                  await viewModel
                                                      .getSupporters();
                                              if (res.isNotEmpty) {
                                                await launchUrl(Uri.parse(
                                                    "tel:${res.first.phone_number}"));
                                              }
                                            },
                                            icon: SvgPicture.asset(
                                              ImageAssets.callIcon,
                                              width:
                                                  displayWidth(context) * 0.09,
                                            )),
                                      ),
                                      // SizedBox(
                                      //   width:
                                      //       displayWidth(context) * 0.04,
                                      // ),
                                      // RoundedContainer(
                                      //   width:
                                      //       displayWidth(context) * 0.11,
                                      //   height: displayHeight(context) *
                                      //       0.055,
                                      //   radius:
                                      //       displayHeight(context) * 0.1,
                                      //   color: ColorManager
                                      //       .favButtonBackColor,
                                      //   boxShadow: const BoxShadow(
                                      //       color: ColorManager
                                      //           .favButtonBackColor),
                                      //   child: IconButton(
                                      //       onPressed: () {
                                      //         context.push(
                                      //             '/chats/conversations/view',
                                      //             extra:
                                      //                 snapshot.data[0]);
                                      //       },
                                      //       icon: SvgPicture.asset(
                                      //         ImageAssets.chatIcon,
                                      //         width:
                                      //             displayWidth(context) *
                                      //                 0.09,
                                      //         color: ColorManager
                                      //             .lightBlueColor,
                                      //       )),
                                      // ),
                                      SizedBox(
                                        width: displayWidth(context) * 0.04,
                                      ),
                                      RoundedContainer(
                                        width: displayWidth(context) * 0.11,
                                        height: displayHeight(context) * 0.055,
                                        radius: displayHeight(context) * 0.1,
                                        color: ColorManager.favButtonBackColor,
                                        boxShadow: const BoxShadow(
                                            color: ColorManager
                                                .favButtonBackColor),
                                        child: IconButton(
                                            onPressed: () async {
                                              String whatsappMsgContent =
                                                  "استفسار بخصوص الإعلان رقم *${widget.adDetails['ad_id'].toString()}* المُعلن بواسطة ${snapshot.data[0]['full_name']}";
                                              List<SupportersData> res =
                                                  await viewModel
                                                      .getSupporters();
                                              if (res.isNotEmpty) {
                                                if (Platform.isAndroid) {
                                                  launchUrl(Uri.parse(
                                                      "whatsapp://send?phone=${res.first.phone_number}&text=$whatsappMsgContent"));
                                                } else {
                                                  launchUrl(Uri.parse(
                                                      "whatsapp://wa.me/${res.first.phone_number}&text=$whatsappMsgContent"));
                                                }
                                              }
                                            },
                                            icon: SvgPicture.asset(
                                              ImageAssets.whatsappIcon,
                                              width:
                                                  displayWidth(context) * 0.09,
                                            )),
                                      ),
                                    ],
                                  );
                                }
                              }),
                          TextContainer(
                            width: displayWidth(context) * 0.88,
                            margin: EdgeInsets.only(
                                top: displayHeight(context) * 0.02),
                            text: widget.adDetails['description'],
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          TextContainer(
                            width: displayWidth(context) * 0.88,
                            text:
                                AppStrings.specificationText.getString(context),
                            margin: EdgeInsets.only(
                                top: displayHeight(context) * 0.025),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          // SizedBox(
                          //   height: displayHeight(context) * 0.01,
                          // ),
                          Consumer<AdDetailsViewModel>(
                            builder: (BuildContext context, viewModel,
                                    Widget? child) =>
                                SizedBox(
                              width: displayWidth(context) * 0.88,
                              child: GridView(
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: EdgeInsets.symmetric(
                                      vertical: displayHeight(context) * 0.01),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisExtent:
                                              displayWidth(context) * 0.23,
                                          mainAxisSpacing:
                                              displayHeight(context) * 0.04,
                                          crossAxisSpacing:
                                              displayWidth(context) * 0.04),
                                  children: [
                                    if (widget.adDetails['bedrooms'] != null)
                                      Column(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0, 1),
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                  shape: BoxShape.circle),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    ColorManager.whiteColor,
                                                minRadius:
                                                    displayWidth(context) *
                                                        0.065,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      ImageAssets.roomsIcon,
                                                      width: displayWidth(
                                                              context) *
                                                          0.05,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          TextContainer(
                                            text: AppStrings.bedroomText
                                                .getString(context),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            width: displayWidth(context) * 0.2,
                                            margin: const EdgeInsets.only(
                                                top: AppMargin.m3),
                                            textAlign: TextAlign.center,
                                          ),
                                          TextContainer(
                                            text: widget.adDetails['bedrooms'],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          )
                                        ],
                                      ),
                                    if (widget.adDetails['livingrooms'] != null)
                                      Column(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0, 1),
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                  shape: BoxShape.circle),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    ColorManager.whiteColor,
                                                minRadius:
                                                    displayWidth(context) *
                                                        0.065,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      ImageAssets.livingIcon,
                                                      width: displayWidth(
                                                              context) *
                                                          0.05,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          TextContainer(
                                            text: AppStrings.livingRoomText
                                                .getString(context),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            width: displayWidth(context) * 0.2,
                                            margin: const EdgeInsets.only(
                                                top: AppMargin.m3),
                                            textAlign: TextAlign.center,
                                          ),
                                          TextContainer(
                                            text:
                                                widget.adDetails['livingrooms'],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          )
                                        ],
                                      ),
                                    if (widget.adDetails['bathrooms'] != null)
                                      Column(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0, 1),
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                  shape: BoxShape.circle),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    ColorManager.whiteColor,
                                                minRadius:
                                                    displayWidth(context) *
                                                        0.065,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      ImageAssets.bathIcon,
                                                      width: displayWidth(
                                                              context) *
                                                          0.05,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          TextContainer(
                                            text: AppStrings.bathRoomText
                                                .getString(context),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            width: displayWidth(context) * 0.2,
                                            margin: const EdgeInsets.only(
                                                top: AppMargin.m3),
                                            textAlign: TextAlign.center,
                                          ),
                                          TextContainer(
                                            text: widget.adDetails['bathrooms'],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          )
                                        ],
                                      ),
                                    if (widget.adDetails['area'] != null)
                                      Column(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0, 1),
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                  shape: BoxShape.circle),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    ColorManager.whiteColor,
                                                minRadius:
                                                    displayWidth(context) *
                                                        0.065,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      ImageAssets.areaIcon,
                                                      width: displayWidth(
                                                              context) *
                                                          0.05,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          TextContainer(
                                            text: AppStrings.areaText
                                                .getString(context),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            width: displayWidth(context) * 0.2,
                                            margin: const EdgeInsets.only(
                                                top: AppMargin.m3),
                                            textAlign: TextAlign.center,
                                          ),
                                          TextContainer(
                                            text: widget.adDetails['area'],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          )
                                        ],
                                      ),
                                    if (widget.adDetails['type'] != null)
                                      Column(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0, 1),
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                  shape: BoxShape.circle),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    ColorManager.whiteColor,
                                                minRadius:
                                                    displayWidth(context) *
                                                        0.065,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      ImageAssets.landTypeIcon,
                                                      width: displayWidth(
                                                              context) *
                                                          0.06,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          TextContainer(
                                            text: AppStrings.landTypeText
                                                .getString(context),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            width: displayWidth(context) * 0.2,
                                            margin: const EdgeInsets.only(
                                                top: AppMargin.m3),
                                            textAlign: TextAlign.center,
                                          ),
                                          TextContainer(
                                            text: widget.adDetails['type']
                                                .toString()
                                                .getString(context),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          )
                                        ],
                                      ),
                                  ]),
                            ),
                          ),
                          // SizedBox(height: displayHeight(context) * 0.03),
                          SizedBox(
                            width: displayWidth(context) * 0.88,
                            child: GridView(
                              padding: EdgeInsets.symmetric(
                                  vertical: displayHeight(context) * 0.03),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent:
                                          displayHeight(context) * 0.14,
                                      mainAxisSpacing:
                                          displayHeight(context) * 0.04,
                                      crossAxisSpacing:
                                          displayWidth(context) * 0.04),
                              primary: false,
                              shrinkWrap: true,
                              children: [
                                if (widget.adDetails['rent_pay_period'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.rentPaymentIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.rentPayPeriodText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                      ),
                                      TextContainer(
                                        text: widget
                                            .adDetails['rent_pay_period']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['street_width'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.streetWidthIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.streetWidthText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['street_width']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['floor_number'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.floorNumberIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.floorText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['floor_number'],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['property_age'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.propertyAgeIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.propertyAgeText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['property_age']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['apartments'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.apartmentsIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.apartmentsText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['apartments']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['is_furnished'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.isFurnishedIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.furnishedText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['is_furnished']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color:
                                            widget.adDetails['is_furnished'] ==
                                                    false
                                                ? ColorManager.errorColor
                                                : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['has_car_entrance'] !=
                                    null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.carEntranceIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.carEntranceText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                      ),
                                      TextContainer(
                                        text: widget
                                            .adDetails['has_car_entrance']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color: widget.adDetails[
                                                    'has_car_entrance'] ==
                                                false
                                            ? ColorManager.errorColor
                                            : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['has_special_roof'] !=
                                    null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.specialRoofIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.specialRoofText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                      ),
                                      TextContainer(
                                        text: widget
                                            .adDetails['has_special_roof']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color: widget.adDetails[
                                                    'has_special_roof'] ==
                                                false
                                            ? ColorManager.errorColor
                                            : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['has_double_entrances'] !=
                                    null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.doubleEntranceIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.doubleEntranceText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget
                                            .adDetails['has_double_entrances']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color: widget.adDetails[
                                                    'has_double_entrances'] ==
                                                false
                                            ? ColorManager.errorColor
                                            : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['has_special_entrance'] !=
                                    null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.specialEntranceIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.speacialEntranceText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget
                                            .adDetails['has_special_entrance']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color: widget.adDetails[
                                                    'has_special_entrance'] ==
                                                false
                                            ? ColorManager.errorColor
                                            : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['has_driver_room'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.driverIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.driverRoomText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget
                                            .adDetails['has_driver_room']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color: widget.adDetails[
                                                    'has_driver_room'] ==
                                                false
                                            ? ColorManager.errorColor
                                            : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['has_kitchen'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.hasKitchenIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.kitchenText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['has_kitchen']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color:
                                            widget.adDetails['has_kitchen'] ==
                                                    false
                                                ? ColorManager.errorColor
                                                : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['has_maid_room'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.maidIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.maidRoomText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['has_maid_room']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color:
                                            widget.adDetails['has_maid_room'] ==
                                                    false
                                                ? ColorManager.errorColor
                                                : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['has_pool'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.hasPoolIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.poolText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['has_pool']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color: widget.adDetails['has_pool'] ==
                                                false
                                            ? ColorManager.errorColor
                                            : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['is_duplex'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.duplexIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.duplexText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['is_duplex']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color: widget.adDetails['is_duplex'] ==
                                                false
                                            ? ColorManager.errorColor
                                            : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['has_basement'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.basementIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.basementText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['has_basement']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color:
                                            widget.adDetails['has_basement'] ==
                                                    false
                                                ? ColorManager.errorColor
                                                : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['with_stairs'] != null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.stairsIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.stairsText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails['with_stairs']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color:
                                            widget.adDetails['with_stairs'] ==
                                                    false
                                                ? ColorManager.errorColor
                                                : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget.adDetails['is_air_conditioned'] !=
                                    null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.airConditionedIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.airConditionedText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget
                                            .adDetails['is_air_conditioned']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color: widget.adDetails[
                                                    'is_air_conditioned'] ==
                                                false
                                            ? ColorManager.errorColor
                                            : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                                if (widget
                                        .adDetails['is_apartment_in_a_villa'] !=
                                    null)
                                  Column(
                                    children: [
                                      CircleWithShadow(
                                        minRadius:
                                            displayWidth(context) * 0.065,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.inAVillaIcon,
                                            width: displayWidth(context) * 0.05,
                                          ),
                                        ],
                                      ),
                                      TextContainer(
                                        text: AppStrings.inAVillaText
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        width: displayWidth(context) * 0.2,
                                        margin: const EdgeInsets.only(
                                            top: AppMargin.m3),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                      TextContainer(
                                        text: widget.adDetails[
                                                'is_apartment_in_a_villa']
                                            .toString()
                                            .getString(context),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        width: displayWidth(context) * 0.2,
                                        textAlign: TextAlign.center,
                                        color: widget.adDetails[
                                                    'is_apartment_in_a_villa'] ==
                                                false
                                            ? ColorManager.errorColor
                                            : ColorManager.lightGreenColor,
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: displayHeight(context) * 0.49),
                        child: Stack(
                          children: [
                            RoundedContainer(
                                width: displayWidth(context) * 0.85,
                                height: displayHeight(context) * 0.22,
                                radius: displayHeight(context) * 0.07,
                                boxShadow: const BoxShadow(
                                    color: ColorManager.grey4TransColor),
                                color: ColorManager.grey4TransColor),
                            RoundedContainer(
                                width: displayWidth(context) * 0.85,
                                height: displayHeight(context) * 0.21,
                                radius: displayHeight(context) * 0.07,
                                boxShadow: const BoxShadow(
                                    color: ColorManager.grey6TransColor),
                                color: ColorManager.grey6TransColor),
                            RoundedContainer(
                              width: displayWidth(context) * 0.85,
                              height: displayHeight(context) * 0.2,
                              radius: displayHeight(context) * 0.07,
                              boxShadow: const BoxShadow(
                                  color: ColorManager.grey4TransColor),
                              color: ColorManager.whiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextContainer(
                                    width: displayWidth(context) * 0.85,
                                    margin: EdgeInsets.only(
                                        left: displayWidth(context) * 0.08,
                                        top: displayHeight(context) * 0.03),
                                    text: widget
                                        .adDetails['property_categories']
                                            ['category_name']
                                        .toString()
                                        .getString(context),
                                    maxLines: 1,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: ColorManager.fontColor3,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: displayWidth(context) * 0.08,
                                      ),
                                      SvgPicture.asset(
                                          ImageAssets.streetAddressIcon),
                                      TextContainer(
                                        width: displayWidth(context) * 0.7,
                                        margin: EdgeInsets.only(
                                          left: displayWidth(context) * 0.01,
                                        ),
                                        text: widget
                                            .adDetails['location_address'],
                                        maxLines: 2,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            FontConstants.arabicFontFamily,
                                        color: ColorManager.fontColor3,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.01,
                                  ),
                                  TextContainer(
                                    width: displayWidth(context) * 0.85,
                                    margin: EdgeInsets.only(
                                      left: displayWidth(context) * 0.08,
                                    ),
                                    text: NumberFormat.compact().format(
                                        int.parse(widget.adDetails['price'])),
                                    maxLines: 1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: ColorManager.lightGreenColor,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.01,
                                  ),
                                  TextContainer(
                                    width: displayWidth(context) * 0.85,
                                    margin: EdgeInsets.only(
                                      left: displayWidth(context) * 0.08,
                                    ),
                                    text: widget.adDetails['ads_created_at']
                                        .toString()
                                        .split('T')
                                        .first,
                                    maxLines: 1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.fontColor3,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            RoundedContainer(
                              width: displayWidth(context) * 0.13,
                              height: displayHeight(context) * 0.065,
                              radius: displayHeight(context) * 0.1,
                              margin: EdgeInsets.only(
                                  top: displayHeight(context) * 0.16,
                                  left: displayWidth(context) * 0.65),
                              color: ColorManager.favButtonBackColor,
                              boxShadow: const BoxShadow(
                                  color: ColorManager.favButtonBackColor),
                              child: IconButton(
                                  onPressed: () async {
                                    if (ValueHolders.isGuest == false) {
                                      if (isFav == false) {
                                        try {
                                          final res = await viewModel.addToFav(
                                              supabase.auth.currentUser!.id,
                                              widget.adDetails['ad_id']);
                                          if (res == 'Success') {
                                            Fluttertoast.showToast(
                                                msg: AppStrings.addedToFavText
                                                    .getString(context));
                                            isFav = true;
                                            viewModel.toggleNotifyListener();
                                          }
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                              msg: e.toString());
                                        }
                                      } else if (isFav == true) {
                                        try {
                                          final res =
                                              await viewModel.removeFromFav(
                                                  supabase.auth.currentUser!.id,
                                                  widget.adDetails['ad_id']);
                                          if (res == 'Success') {
                                            Fluttertoast.showToast(
                                                msg: AppStrings
                                                    .removedFromFavText
                                                    .getString(context));
                                            isFav = false;
                                            viewModel.toggleNotifyListener();
                                          }
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                              msg: e.toString());
                                        }
                                      }
                                    }
                                  },
                                  icon: isFav == true
                                      ? SvgPicture.asset(
                                          ImageAssets.favFilledIcon,
                                          width: displayWidth(context) * 0.09,
                                          color: ColorManager.favColor,
                                        )
                                      : SvgPicture.asset(
                                          ImageAssets.favIcon,
                                          width: displayWidth(context) * 0.09,
                                        )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
