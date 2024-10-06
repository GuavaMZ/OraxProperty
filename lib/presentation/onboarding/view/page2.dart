import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';

class OnBoadringPage2 extends StatefulWidget {
  const OnBoadringPage2({super.key});

  @override
  State<OnBoadringPage2> createState() => _OnBoadringPage2State();
}

class _OnBoadringPage2State extends State<OnBoadringPage2> with TickerProviderStateMixin {
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
    return Center(
      child: Column(
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
                text: AppStrings.onboarding2Text.getString(context),
                fontSize: 30,
                color: ColorManager.darkGreenColor,
                fontWeight: FontWeight.w900,
                 
              ),
            ),
          ),
          SvgPicture.asset(
            ImageAssets.onBoarding2,
            width: displayWidth(context) * 0.7,
            height: displayHeight(context) * 0.5,
          ),
        ],
      ),
    );
  }
}