import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/app/app.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/choosing_ad_or_eq/view/choosing_ad_or_req.dart';
import 'package:oraxproperty/presentation/chat/view/chat_view.dart';
import 'package:oraxproperty/presentation/favourites/view/favourites_view.dart';
import 'package:oraxproperty/presentation/homepage/view/homepage_view.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/services_page/view/services_page_view.dart';
import 'package:oraxproperty/presentation/user_profile/view/user_profile_view.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  var navbarIcons = [
    ImageAssets.moreIcon,
    ImageAssets.chatIcon,
    ImageAssets.favIcon,
    ImageAssets.userIcon,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this, initialIndex: 4);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(AppPadding.p5),
        decoration: const ShapeDecoration(
            color: Color(0xFF3AC387),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
            shape: OvalBorder()),
        child: FloatingActionButton(
          onPressed: () {
            if (tabController.index == 4) {
             
                showModalBottomSheet(
                    context: context,
                    builder: ((context) {
                      return SizedBox(
                          height: displayHeight(context) * 0.35,
                          width: displayWidth(context),
                          child: const ChoosingAdOrReqView());
                    }),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSize.s30),
                            topRight: Radius.circular(AppSize.s30))),
                    backgroundColor: ColorManager.whiteColor);
              
            } else {
              setState(() {
                tabController.index = 4;
              });
            }
          },
          backgroundColor: Color(0xFF3AC387),
          elevation: 0,
          child: tabController.index != 4
              ? SvgPicture.asset(ImageAssets.homeIcon)
              : SvgPicture.asset(
                  ImageAssets.addIcon,
                  color: ColorManager.whiteColor,
                  width: displayWidth(context) * 0.09,
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        activeIndex: tabController.index,
        onTap: (index) {
          if (ValueHolders.isGuest == true) {
            if (index == 1 || index == 2 || index == 3) {
              Fluttertoast.showToast(
                  msg: AppStrings.notAvailableForGuestsText.getString(context));
            }
          } else {
            setState(() {
              tabController.index = index;
            });
          }
        },
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        height: displayHeight(context) * 0.073,
        shadow: const BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 4,
          offset: Offset(0, 0),
          spreadRadius: 0,
        ),
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          return SvgPicture.asset(
            navbarIcons[index],
            width: displayWidth(context) * 0.01,
            height: displayHeight(context) * 0.01,
            fit: BoxFit.scaleDown,
            color: isActive
                ? ColorManager.activeNavigationBarColor
                : ColorManager.notActiveNavigationBarColor,
          );
        },
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ServicesPageView(),
          ChatView(),
          FavouritesView(),
          UserProfileView(),
          HomepageView(),
        ],
      ),
    );
  }
}
