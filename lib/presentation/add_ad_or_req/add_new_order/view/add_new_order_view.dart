import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/add_new_order/viewmodel/add_new_order_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class AddNewOrderView extends StatefulWidget {
  const AddNewOrderView({super.key});

  @override
  State<AddNewOrderView> createState() => _AddNewOrderViewState();
}

class _AddNewOrderViewState extends State<AddNewOrderView> {
  List<String> categoriesList = [
    AppStrings.apartmentForSaleText,
    AppStrings.apartmentForRentText,
    AppStrings.villasForSaleText,
    AppStrings.villasForRentText,
    AppStrings.landForSaleText,
  ];
  // final AddNewOrderViewModel _viewModel = AddNewOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddNewOrderViewModel(),
      child: Scaffold(
        backgroundColor: ColorManager.bgColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextContainer(
            text: AppStrings.newOrderText.getString(context),
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
        body: Center(
          child: Consumer<AddNewOrderViewModel>(
            builder: (BuildContext context, viewModel, Widget? child) => Column(
              children: [
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                TextContainer(
                  text: AppStrings.categoryText.getString(context),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.fontColor2,
                   
                  textAlign: TextAlign.left,
                  width: displayWidth(context) * 0.87,
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                DropdownButtonFormField(
                  elevation: 1,
                  alignment: AlignmentDirectional.bottomCenter,
                  borderRadius: BorderRadius.all(
                      Radius.circular(displayHeight(context) * 0.04)),
                  value: viewModel.propertyCategory,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: displayWidth(context) * 0.04),
                    constraints: BoxConstraints(
                        maxWidth: displayWidth(context) * 0.9,
                        maxHeight: displayHeight(context) * 0.063),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0),
                      borderRadius:
                          BorderRadius.circular(displayHeight(context) * 0.02),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0),
                      borderRadius:
                          BorderRadius.circular(displayHeight(context) * 0.02),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0),
                      borderRadius:
                          BorderRadius.circular(displayHeight(context) * 0.02),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0),
                      borderRadius:
                          BorderRadius.circular(displayHeight(context) * 0.02),
                    ),
                    filled: true,
                    fillColor: ColorManager.whiteColor,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: ColorManager.lightGreenColor,
                  ),
                  items:
                      categoriesList.map<DropdownMenuItem<String>>((String e) {
                    return DropdownMenuItem(
                      value: e.getString(context),
                      onTap: () {
                        viewModel.requestPagesController
                            .jumpToPage(categoriesList.indexOf(e));
                      },
                      child: TextContainer(
                        text: e.getString(context),
                        fontSize: 16,
                         
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.lightGreenColor,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    Provider.of<AddNewOrderViewModel>(context, listen: false)
                        .changePropertyCategoryAndPage(newValue!);
                  },
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: viewModel.requestPagesController,
                    onPageChanged: (index) {},
                    children: viewModel.requestCategoriesPages,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
