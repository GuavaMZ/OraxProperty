import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraxproperty/presentation/all_categories/viewmodel/all_categories_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class AllCategoriesView extends StatefulWidget {
  const AllCategoriesView({super.key});

  @override
  State<AllCategoriesView> createState() => _AllCategoriesViewState();
}

class _AllCategoriesViewState extends State<AllCategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (BuildContext context) => AllCategoriesViewModel(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.05,
              ),
              SizedBox(
                width: displayWidth(context),
                height: AppSize.s60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: SvgPicture.asset(
                          'assets/images/arrow-circle-left.svg'),
                    ),
                    TextContainer(
                      width: displayWidth(context) * 0.68,
                      text: AppStrings.allCategories.getString(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                    const CircleAvatar(
                      backgroundColor: ColorManager.lightGreenColor,
                    ),
                  ],
                ),
              ),
              Consumer<AllCategoriesViewModel>(
                builder: (BuildContext context, viewModel, Widget? child) =>
                    FutureBuilder(
                  future: viewModel.getAdCategories(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.twistingDots(
                            leftDotColor: ColorManager.darkGreenColor,
                            rightDotColor: ColorManager.lightGreenColor,
                            size: displayWidth(context) * 0.15),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                              width: displayWidth(context),
                              height: displayHeight(context) * 0.1,
                              child: ElevatedButton.icon(
                                  onPressed: () {
                                    // if(snapshot.data[index]['category_name'] == 'Lands For Sale' || snapshot.data[index]['category_name'] == 'Lands For Rent'){
                                    //   Fluttertoast.showToast(msg: 'إعلانات الاراضي غير متاحة الان ، سيتم اتاحتها قريبا');
                                    //   return;
                                    // }
                                    context.push('/ads_based_category/view',
                                        extra:
                                            viewModel.categoriesNames[index]);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      alignment: Alignment(
                                          -displayWidth(context) * 0.002, 0),
                                      backgroundColor: const Color(0xffffffff),
                                      elevation: 0),
                                  icon: SvgPicture.asset(
                                    viewModel.categoriesIcons[index],
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    width: displayWidth(context) * 0.075,
                                  ),
                                  label: Row(
                                    children: [
                                      TextContainer(
                                        text: snapshot.data[index]
                                                ['category_name']
                                            .toString()
                                            .getString(context),
                                        fontSize: 18,
                                        color: ColorManager.fontColor3,
                                        fontWeight: FontWeight.w500,
                                        margin: EdgeInsets.only(
                                            left: displayWidth(context) * 0.05),
                                        textAlign: TextAlign.left,
                                        width: displayWidth(context) * 0.5,
                                      ),
                                      SizedBox(
                                        width: displayWidth(context) * 0.2,
                                      ),
                                      SvgPicture.asset(
                                        ImageAssets.arrowRightIcon,
                                        color: ColorManager.blackColor,
                                      )
                                    ],
                                  )));
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
