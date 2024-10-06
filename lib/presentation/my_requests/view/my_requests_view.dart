import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

class MyRequestsView extends StatefulWidget {
  const MyRequestsView({super.key});

  @override
  State<MyRequestsView> createState() => _MyRequestsViewState();
}

class _MyRequestsViewState extends State<MyRequestsView> {
  @override
  void dispose() {
    ValueHolders.adsOrRequest = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextContainer(
          text: AppStrings.myOrdersText.getString(context),
          fontSize: 18,
          fontWeight: FontWeight.w700,
           
          color: ColorManager.fontColor2,
          textAlign: TextAlign.center,
        ),
        toolbarHeight: displayHeight(context) * 0.09,
        centerTitle: true,
        backgroundColor: ColorManager.bgColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: ColorManager.backButtonColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: displayHeight(context) * 0.15,
            ),
            SvgPicture.asset(
              ImageAssets.noRequestsImage,
              width: displayWidth(context) * 0.33,
              height: displayHeight(context) * 0.33,
            ),
            // SizedBox(
            //   height: displayHeight(context) * 0.055,
            // ),
            TextContainer(
              text: AppStrings.noOrdersYetText.getString(context),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: ColorManager.fontColor2,
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {
                context.push('/add_ad_or_req/property_request_details/view');
              },
              child: TextContainer(
                text: AppStrings.addNewOrderText.getString(context),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                 
                color: ColorManager.lightGreenColor,
                textAlign: TextAlign.center,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
