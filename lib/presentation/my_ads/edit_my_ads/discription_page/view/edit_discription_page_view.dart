import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/discription_page/viewmodel/edit_discription_page_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class EditDiscriptionPageView extends StatefulWidget {
  const EditDiscriptionPageView({super.key,this.data});
  final List? data;
  @override
  State<EditDiscriptionPageView> createState() => _EditDiscriptionPageViewState();
}

class _EditDiscriptionPageViewState extends State<EditDiscriptionPageView> {
  final EditDiscriptionPageViewModel  _viewModel = EditDiscriptionPageViewModel();
  @override
  void initState() {
    _viewModel.discriptionController.text = widget.data![0]['description'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _viewModel,
      child: Scaffold(
        backgroundColor: ColorManager.bgColor,
        resizeToAvoidBottomInset: false,
        body: Consumer<EditDiscriptionPageViewModel>(
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

                        context.push('/edit_my_ads/choose_location/view',extra: widget.data);
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
