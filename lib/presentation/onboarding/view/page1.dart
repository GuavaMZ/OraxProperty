import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oraxproperty/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class OnBoadringPage1 extends StatefulWidget {
  const OnBoadringPage1({super.key});

  @override
  State<OnBoadringPage1> createState() => _onBoadringPage1State();
}

class _onBoadringPage1State extends State<OnBoadringPage1>
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
      child: Center(
        child: Consumer<OnBoardingViewModel>(
          builder: (BuildContext context, viewModel, Widget? child) => Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.08,
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) => Positioned(
                  left: Tween<double>(
                          begin: displayWidth(context) * -1,
                          end: displayWidth(context) * 0.46)
                      .animate(_animationController)
                      .value,
                  child: TextContainer(
                    width: displayWidth(context) * 0.6,
                    // margin: EdgeInsets.only(
                    //     left: displayWidth(context) * 0.3),
                    text: AppStrings.onboarding1Text.getString(context),
                    fontSize: 30,
                    color: ColorManager.darkGreenColor,
                    fontWeight: FontWeight.w900,
                     
                  ),
                ),
              ),
              SvgPicture.asset(
                ImageAssets.onBoarding1,
                width: displayWidth(context) * 0.7,
                height: displayHeight(context) * 0.5,
              ),
              
              SizedBox(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.lightGreenColor),
                      onPressed: () {
                        if(viewModel.currentIndex < 2){
                          viewModel.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                        }
                      },
                      child: TextContainer(
                        text: AppStrings.nextText.getString(context),
                        fontSize: 15,
                        color: ColorManager.whiteColor,
                         
                        fontWeight: FontWeight.w600,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
