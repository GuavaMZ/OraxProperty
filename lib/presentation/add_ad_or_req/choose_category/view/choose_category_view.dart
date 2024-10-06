import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

class ChooseCategoryView extends StatefulWidget {
  const ChooseCategoryView({super.key});

  @override
  State<ChooseCategoryView> createState() => _ChooseCategoryViewState();
}

class _ChooseCategoryViewState extends State<ChooseCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextContainer(
          text: AppStrings.chooseCategoryText.getString(context),
          fontSize: 18,
          color: ColorManager.darkGreenColor,
           
          fontWeight: FontWeight.bold,
          margin: EdgeInsets.only(top: displayHeight(context) * 0.035),
        ),
        SizedBox(
          height: displayHeight(context) * 0.06,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.whiteColor,
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      shape: const OvalBorder()),
                  child: Container(
                    decoration: const ShapeDecoration(
                      shape: OvalBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: ColorManager.whiteColor,
                      radius: displayWidth(context) * 0.1,
                      child: SvgPicture.asset(
                        ImageAssets.allPropsIcon,
                        color: ColorManager.darkGreenColor,
                        width: displayWidth(context) * 0.075,
                      ),
                    ),
                  ),
                ),
                TextContainer(
                  text: AppStrings.allText.getString(context),
                  margin: const EdgeInsets.only(top: AppMargin.m10),
                  fontSize: 15,
                   
                  color: ColorManager.darkGreenColor,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.whiteColor,
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      shape: const OvalBorder()),
                  child: Container(
                    decoration: const ShapeDecoration(
                      shape: OvalBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: ColorManager.whiteColor,
                      radius: displayWidth(context) * 0.1,
                      child: SvgPicture.asset(
                        ImageAssets.allPropsIcon,
                        color: ColorManager.darkGreenColor,
                        width: displayWidth(context) * 0.075,
                      ),
                    ),
                  ),
                ),
                TextContainer(
                  text: AppStrings.forSaleText.getString(context),
                  margin: const EdgeInsets.only(top: AppMargin.m10),
                  fontSize: 15,
                   
                  color: ColorManager.darkGreenColor,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.whiteColor,
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      shape: const OvalBorder()),
                  child: Container(
                    decoration: const ShapeDecoration(
                      shape: OvalBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: ColorManager.whiteColor,
                      radius: displayWidth(context) * 0.1,
                      child: SvgPicture.asset(
                        ImageAssets.allPropsIcon,
                        color: ColorManager.darkGreenColor,
                        width: displayWidth(context) * 0.075,
                      ),
                    ),
                  ),
                ),
                TextContainer(
                  text: AppStrings.forRentText.getString(context),
                  margin: const EdgeInsets.only(top: AppMargin.m10),
                  fontSize: 15,
                   
                  color: ColorManager.darkGreenColor,
                  fontWeight: FontWeight.bold,
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
