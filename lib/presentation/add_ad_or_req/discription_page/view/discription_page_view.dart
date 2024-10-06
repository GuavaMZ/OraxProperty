import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/discription_page/viewmodel/discription_page_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class DiscriptionPageView extends StatefulWidget {
  const DiscriptionPageView({super.key});

  @override
  State<DiscriptionPageView> createState() => _DiscriptionPageViewState();
}

class _DiscriptionPageViewState extends State<DiscriptionPageView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => DiscriptionPageViewModel(),
      child: Scaffold(
        backgroundColor: ColorManager.bgColor,
        resizeToAvoidBottomInset: false,
        body: Consumer<DiscriptionPageViewModel>(
          builder: (BuildContext context, viewModel, Widget? child) =>
              SingleChildScrollView(
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
                        text: AppStrings.discriptionText.getString(context),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                         
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.025,
                ),
                TextContainer(
                  text: AppStrings.typeDescriptionText.getString(context),
                  width: displayWidth(context) * 0.85,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                   
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.022,
                ),
                TextInputField(
                  controller: viewModel.discriptionController,
                  width: displayWidth(context) * 0.9,
                  height: displayHeight(context) * 0.22,
                  focusedBorderRadius: displayHeight(context) * 0.03,
                  errorBorderRadius: displayHeight(context) * 0.03,
                  enabledBorderRadius: displayHeight(context) * 0.03,
                  maxLines: 6,
                  obsecureText: false,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.45,
                ),
                SizedBox(
                  width: displayWidth(context) * 0.45,
                  height: displayHeight(context) * 0.06,
                  child: ElevatedButton(
                      onPressed: () async {
                        viewModel.assignAdValsToConfirmDetailsMap(context);

                        context.push('/add_ad_or_req/choose_location/view');
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
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
