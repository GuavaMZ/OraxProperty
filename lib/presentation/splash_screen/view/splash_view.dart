import 'package:flutter/material.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:oraxproperty/presentation/splash_screen/viewmodel/splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  final SplashViewModel _viewModel = SplashViewModel();

  late AnimationController _animationController;
  late AnimationController _animationController2;
  late AnimationController _animationController3;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();

    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    Future.delayed(const Duration(milliseconds: 2000), () {
      _animationController2.forward();
    });

    _animationController3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Animation<double> rotationAnimation= Tween(begin: 0.0,end: 360.0).animate(_animationController3);

    _animationController.addStatusListener((status) {
      if (_animationController.isCompleted) {
        Future.delayed(const Duration(milliseconds: 500));
        _animationController3.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: _viewModel.splashDuration)),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _viewModel.pushToOnBoarding(context);
        }
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: displayWidth(context),
                height: displayHeight(context),
                color: ColorManager.bgColor2,
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  return AnimatedPositioned(
                      // left: displayWidth(context) * 0.5,
                      top: Tween<double>(
                              begin: -100, end: displayHeight(context) * 0.45)
                          .animate(_animationController)
                          .value,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.bounceOut,
                      child: TextContainer(
                        text: 'Orax Property',
                        width: displayWidth(context),
                        fontSize: 32,
                        color: ColorManager.fontColor,
                         
                        fontWeight: FontWeight.w900,
                        textAlign: TextAlign.center,
                        align: Alignment.center,
                      ));
                },
              ),
              AnimatedBuilder(
                animation: _animationController2,
                builder: (BuildContext context, Widget? child) {
                  return AnimatedPositioned(
                      // left: displayWidth(context) * 0.5,
                      right: Tween<double>(
                              begin: -displayWidth(context),
                              end: displayWidth(context) * 0.001)
                          .animate(_animationController)
                          .value,
                      top: displayHeight(context) * 0.5,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: TextContainer(
                        text: 'أسهل مما تتخيل',
                        width: displayWidth(context),
                        fontSize: 22,
                        color: ColorManager.fontColor,
                        fontFamily: FontConstants.arabicFontFamily,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                        align: Alignment.center,
                      ));
                },
              )
            ],
          ),
        );
      },
    );
  }
}
