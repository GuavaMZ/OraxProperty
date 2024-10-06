import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:oraxproperty/presentation/services_page/viewmodel/services_page_viewmodel.dart';
import 'package:provider/provider.dart';

class ServicesPageView extends StatefulWidget {
  const ServicesPageView({super.key});

  @override
  State<ServicesPageView> createState() => _ServicesPageViewState();
}

class _ServicesPageViewState extends State<ServicesPageView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => ServicePageViewModel(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorManager.bgColor,
          appBar: AppBar(
            title: TextContainer(
              text: AppStrings.servicesText.getString(context),
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              margin: const EdgeInsets.only(top: AppMargin.m10),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: displayHeight(context) * 0.38,
                ),
                TextContainer(
                  fontSize: 24,
                  text: 'سوف يتم اضافة الخدمات العقارية قريباً',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                )
                // GridView(
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       crossAxisSpacing: displayWidth(context) * 0.035),
                //   shrinkWrap: true,
                //   padding: EdgeInsets.symmetric(
                //       horizontal: displayWidth(context) * 0.03),
                //   children: [
                //     RoundedContainer(
                //       radius: displayHeight(context) * 0.02,
                //       child: ElevatedButton(
                //           onPressed: () {},
                //           style: ElevatedButton.styleFrom(
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.all(
                //                       Radius.circular(
                //                           displayHeight(context) * 0.02))),
                //               backgroundColor: ColorManager.whiteColor,
                //               foregroundColor: ColorManager.lightGreenColor,
                //               elevation: 0),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               SvgPicture.asset(
                //                 ImageAssets.compassIcon,
                //                 width: displayWidth(context) * 0.08,
                //               ),
                //               TextContainer(
                //                 text: 'Service 1',
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.bold,
                //                 color: ColorManager.fontColor2,

                //               )
                //             ],
                //           )),
                //     ),
                //     RoundedContainer(
                //       radius: displayHeight(context) * 0.02,
                //       child: ElevatedButton(
                //           onPressed: () {},
                //           style: ElevatedButton.styleFrom(
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.all(
                //                       Radius.circular(
                //                           displayHeight(context) * 0.02))),
                //               backgroundColor: ColorManager.whiteColor,
                //               foregroundColor: ColorManager.lightGreenColor,
                //               elevation: 0),
                //           child: Column()),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ));
  }
}
