import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:oraxproperty/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => OnBoardingViewModel(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorManager.bgColor,
        body: Consumer<OnBoardingViewModel>(
          builder: (BuildContext context, viewModel, Widget? child) => Stack(
            children: [
              PageView(
                controller: viewModel.pageController,
                onPageChanged: (index) {
                  setState(() {
                    viewModel.currentIndex = index;
                  });
                },
                children: [
                  onBoadringPage1(viewModel),
                  onBoadringPage2(viewModel),
                  onBoadringPage3(viewModel),
                ],
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: displayHeight(context) * 0.88),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 15,
                        height: 15,
                        margin: EdgeInsets.symmetric(
                            horizontal: displayWidth(context) * 0.025),
                        decoration: BoxDecoration(
                            color: viewModel.currentIndex == index
                                ? ColorManager.darkGreenColor
                                : ColorManager.whiteColor,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: ColorManager.darkGreenColor)),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget onBoadringPage1(viewModel) {
    return Column(
      children: [
        SizedBox(
          height: displayHeight(context) * 0.08,
        ),
        TextContainer(
          width: displayWidth(context) * 0.6,
          margin: EdgeInsets.only(left: displayWidth(context) * 0.3),
          text: AppStrings.onboarding1Text.getString(context),
          fontSize: displayHeight(context) * 0.035,
          color: ColorManager.darkGreenColor,
          fontWeight: FontWeight.w900,
        ),
        SvgPicture.asset(
          ImageAssets.onBoarding1,
          width: displayWidth(context) * 0.7,
          height: displayHeight(context) * 0.45,
        ),
        SizedBox(
          height: displayHeight(context) * 0.08,
        ),
        SizedBox(
            width: displayWidth(context) * 0.55,
            height: displayHeight(context) * 0.06,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.lightGreenColor),
                onPressed: () {
                  if (viewModel.currentIndex < 2) {
                    viewModel.pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease);
                  }
                },
                child: TextContainer(
                  text: AppStrings.nextText.getString(context),
                  fontSize: 18,
                  color: ColorManager.whiteColor,
                  fontWeight: FontWeight.w600,
                )))
      ],
    );
  }

  Widget onBoadringPage2(viewModel) {
    return Column(
      children: [
        SizedBox(
          height: displayHeight(context) * 0.08,
        ),
        SvgPicture.asset(
          ImageAssets.onBoarding2,
          width: displayWidth(context) * 0.8,
          height: displayHeight(context) * 0.5,
        ),
        TextContainer(
          width: displayWidth(context) * 0.8,
          margin: EdgeInsets.only(
              right: displayWidth(context) * 0.1,
              left: displayWidth(context) * 0.1),
          text: AppStrings.onboarding2Text.getString(context),
          fontSize: 30,
          color: ColorManager.darkGreenColor,
          fontWeight: FontWeight.w900,
        ),
        SizedBox(
          height: displayHeight(context) * 0.09,
        ),
        SizedBox(
            width: displayWidth(context) * 0.65,
            height: displayHeight(context) * 0.06,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.lightGreenColor),
                onPressed: () {
                  if (viewModel.currentIndex < 2) {
                    viewModel.pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease);
                  }
                },
                child: TextContainer(
                  text: AppStrings.nextText.getString(context),
                  fontSize: 18,
                  color: ColorManager.whiteColor,
                  fontWeight: FontWeight.w600,
                )))
      ],
    );
  }

  Widget onBoadringPage3(viewModel) {
    return Column(
      children: [
        SizedBox(
          height: displayHeight(context) * 0.08,
        ),
        TextContainer(
          width: displayWidth(context) * 0.6,
          // margin: EdgeInsets.only(
          //     left: displayWidth(context) * 0.3),
          text: AppStrings.onboarding3Text.getString(context),
          fontSize: 30,
          color: ColorManager.darkGreenColor,
          fontWeight: FontWeight.w900,
        ),
        SvgPicture.asset(
          ImageAssets.onBoarding3,
          width: displayWidth(context) * 0.7,
          height: displayHeight(context) * 0.5,
        ),
        SizedBox(
          height: displayHeight(context) * 0.04,
        ),
        SizedBox(
            width: displayWidth(context) * 0.6,
            height: displayHeight(context) * 0.06,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.lightGreenColor,
                    foregroundColor: ColorManager.whiteColor),
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('isFirstTime', false);
                  context.pushReplacement('/login/view');
                },
                child: TextContainer(
                  text: AppStrings.getStartedText.getString(context),
                  fontSize: 18,
                  color: ColorManager.whiteColor,
                  fontWeight: FontWeight.w600,
                )))
      ],
    );
  }
}
