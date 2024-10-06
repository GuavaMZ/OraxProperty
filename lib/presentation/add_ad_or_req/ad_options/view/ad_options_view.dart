import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/choose_category/view/choose_category_view.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

class AdOptionsView extends StatefulWidget {
  const AdOptionsView({super.key});

  @override
  State<AdOptionsView> createState() => _AdOptionsViewState();
}

class _AdOptionsViewState extends State<AdOptionsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextContainer(
          text: AppStrings.addANewAdText.getString(context),
          fontSize: 18,
          color: ColorManager.darkGreenColor,
           
          fontWeight: FontWeight.bold,
          margin: EdgeInsets.only(top: displayHeight(context) * 0.035),
        ),
        Container(
          width: displayWidth(context) * 0.85,
          height: displayHeight(context) * 0.09,
          margin: EdgeInsets.only(top: displayHeight(context) * 0.035),
          decoration: ShapeDecoration(
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10)),
                elevation: 0),
            child: Row(
              children: [
                SizedBox(
                  width: displayWidth(context) * 0.038,
                ),
                SvgPicture.asset(
                  ImageAssets.newAdIcon,
                  width: displayWidth(context) * 0.065,
                  color: ColorManager.darkGreenColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextContainer(
                      margin: EdgeInsets.only(
                          left: displayWidth(context) * 0.05,
                          top: displayHeight(context) * 0.027),
                      text: AppStrings.addLicensedAdText.getString(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.darkGreenColor,
                       
                    ),
                    TextContainer(
                      margin: EdgeInsets.only(
                          left: displayWidth(context) * 0.05,
                          top: displayHeight(context) * 0.003),
                      text: AppStrings.addLicensedAdDetailsText
                          .getString(context),
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      color: ColorManager.lightGreyColor,
                       
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          width: displayWidth(context) * 0.85,
          height: displayHeight(context) * 0.09,
          margin: EdgeInsets.only(top: displayHeight(context) * 0.03),
          decoration: ShapeDecoration(
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              context.pop();
              showModalBottomSheet(
                  context: context,
                  builder: ((context) {
                    return SizedBox(
                        height: displayHeight(context) * 0.35,
                        child: const ChooseCategoryView());
                  }),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSize.s30),
                          topRight: Radius.circular(AppSize.s30))),
                  backgroundColor: ColorManager.whiteColor);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10)),
                elevation: 0),
            child: Row(
              children: [
                SizedBox(
                  width: displayWidth(context) * 0.038,
                ),
                SvgPicture.asset(
                  ImageAssets.addListingIcon,
                  width: displayWidth(context) * 0.065,
                  color: ColorManager.darkGreenColor,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  TextContainer(
                    margin: EdgeInsets.only(
                        left: displayWidth(context) * 0.05,
                        top: displayHeight(context) * 0.027),
                    text: AppStrings.addAdWithIssuingLicenseText
                        .getString(context),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.darkGreenColor,
                     
                  ),
                  TextContainer(
                    margin: EdgeInsets.only(
                        left: displayWidth(context) * 0.05,
                        top: displayHeight(context) * 0.003),
                    text: AppStrings.addAdWithIssuingLicenseDetailsText
                        .getString(context),
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    color: ColorManager.lightGreyColor,
                     
                  )
                ])
              ],
            ),
          ),
        ),
        Container(
          width: displayWidth(context) * 0.85,
          height: displayHeight(context) * 0.09,
          margin: EdgeInsets.only(top: displayHeight(context) * 0.03),
          decoration: ShapeDecoration(
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10)),
                elevation: 0),
            child: Row(
              children: [
                SizedBox(
                  width: displayWidth(context) * 0.038,
                ),
                SvgPicture.asset(
                  ImageAssets.addMarketingIcon,
                  width: displayWidth(context) * 0.065,
                  color: ColorManager.darkGreenColor,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  TextContainer(
                    margin: EdgeInsets.only(
                        left: displayWidth(context) * 0.05,
                        top: displayHeight(context) * 0.027),
                    text: AppStrings.addMarketingText.getString(context),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.darkGreenColor,
                     
                  ),
                  TextContainer(
                    margin: EdgeInsets.only(
                        left: displayWidth(context) * 0.05,
                        top: displayHeight(context) * 0.003),
                    text: AppStrings.addMarketingDetailsText.getString(context),
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    color: ColorManager.lightGreyColor,
                     
                  )
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }
}
