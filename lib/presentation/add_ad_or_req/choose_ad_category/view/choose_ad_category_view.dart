import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/choose_ad_category/viewmodel/choose_ad_category_viewmodel.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/confirm_before_seding/viewmodel/confirm_before_send_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';

import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class ChooseAdCategoryView extends StatefulWidget {
  const ChooseAdCategoryView({super.key});

  @override
  State<ChooseAdCategoryView> createState() => _ChooseAdCategoryViewState();
}

class _ChooseAdCategoryViewState extends State<ChooseAdCategoryView> {
  @override
  void dispose() {
    ValueHolders.categoryAdsType = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => ChooseAdCategoryViewModel(),
        child: Scaffold(
          backgroundColor: ColorManager.bgColor,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: displayHeight(context) * 0.06,
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
                        text: AppStrings.chooseCategoryText.getString(context),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Consumer<ChooseAdCategoryViewModel>(
                  builder: (BuildContext context, viewModel, Widget? child) =>
                      FutureBuilder(
                          future: viewModel.getAdCategories(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                padding: EdgeInsets.symmetric(
                                    vertical: displayHeight(context) * 0.01,
                                    horizontal: displayWidth(context) * 0.03),
                                itemBuilder: (BuildContext context, int index) {
                                  return RoundedContainer(
                                      width: displayWidth(context) * 0.98,
                                      height: displayHeight(context) * 0.1,
                                      radius: displayHeight(context) * 0.015,
                                      margin: EdgeInsets.only(
                                          bottom:
                                              displayHeight(context) * 0.015),
                                      child: ElevatedButton.icon(
                                          onPressed: () {
                                            // if (snapshot.data[index]
                                            //             ['category_name'] ==
                                            //         'Lands For Sale' ||
                                            //     snapshot.data[index]
                                            //             ['category_name'] ==
                                            //         'Lands For Rent') {
                                            //   Fluttertoast.showToast(
                                            //       msg:
                                            //           'إعلانات الاراضي غير متاحة الان ، سيتم اتاحتها قريبا');
                                            //   return;
                                            // }
                                            ValueHolders.categoryAdsType =
                                                viewModel.adCategories[index];
                                            ConfirmBeforeSendViewModel
                                                        .propertyAdDetails[
                                                    'category_id'] =
                                                snapshot.data[index]
                                                    ['category_id'];
                                            context.push(viewModel
                                                .categoriesPages[index]);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          displayHeight(
                                                                  context) *
                                                              0.015)),
                                              alignment: Alignment(
                                                  -displayWidth(context) *
                                                      0.002,
                                                  0),
                                              backgroundColor:
                                                  ColorManager.whiteColor,
                                              foregroundColor:
                                                  ColorManager.lightGreenColor,
                                              // side: const BorderSide(
                                              //     color: ColorManager
                                              //         .lightGreenColor,
                                              //     width: 0.5),
                                              elevation: 0.5),
                                          icon: SvgPicture.asset(
                                            viewModel.adCategoriesIcons[index],
                                            color: ColorManager.blackColor,
                                            width: displayWidth(context) * 0.09,
                                          ),
                                          label: TextContainer(
                                            text: snapshot.data[index]
                                                    ['category_name']
                                                .toString()
                                                .getString(context),
                                            fontSize: 18,
                                            color: ColorManager.fontColor3,
                                            fontWeight: FontWeight.w500,
                                            margin: EdgeInsets.only(
                                                left: displayWidth(context) *
                                                    0.05),
                                            textAlign: TextAlign.left,
                                            width: displayWidth(context) * 0.5,
                                          )));
                                },
                              );
                            }
                          }),
                )
              ],
            ),
          ),
        ));
  }
}
