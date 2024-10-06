// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oraxproperty/app/app.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/fonts_manager.dart';
 
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';

class TextContainer extends StatefulWidget {
  String text;
  double fontSize;
  TextScaler? textScaleFactor;
  double? width;
  double? height;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  AlignmentGeometry? align;
  TextDecoration? decoration;
  TextDirection? textDirection;
  Color? color;
  TextAlign? textAlign = TextAlign.left;
  int? maxLines;
  String? fontFamily;
  FontWeight? fontWeight;
  TextOverflow? overflow;
  Color? decorationColor;
  TextContainer(
      {super.key,
      required this.text,
      required this.fontSize,
      this.textScaleFactor,
      this.color,
      this.width,
      this.height,
      this.margin,
      this.padding,
      this.textAlign,
      this.textDirection,
      this.decoration,
      this.decorationColor,
      this.fontFamily,
      this.fontWeight,
      this.maxLines,
      this.overflow,
      this.align});

  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding,
      alignment: widget.align,
      child: Text(
        widget.text,
        textScaler: widget.textScaleFactor ??
            TextScaler.linear(ScaleSize.textScaleFactor(context)),
        textAlign: widget.textAlign,
        overflow: widget.overflow,
        maxLines: widget.maxLines,
        style: TextStyle(
            color: widget.color,
            fontFamily: widget.fontFamily ??
                (localization.currentLocale!.languageCode == 'en'
                    ? FontConstants.outfitFontFamily
                    : FontConstants.arabicFontFamily),
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight),
      ),
    );
  }
}

class UpperProfilePageContainer extends StatefulWidget {
  UpperProfilePageContainer(
      {super.key, this.imageWidget, this.userFullName, this.userJob});
  Widget? imageWidget;
  String? userFullName;
  String? userJob;
  String? sinceDate;
  String? advertises;
  String? lastSeen;
  @override
  State<UpperProfilePageContainer> createState() =>
      _UpperProfilePageContainerState();
}

class _UpperProfilePageContainerState extends State<UpperProfilePageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context),
      height: displayHeight(context) * 0.35,
      decoration: const ShapeDecoration(
        color: ColorManager.upperProfileContainerColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(80),
            bottomRight: Radius.circular(80),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: displayWidth(context) * 0.24,
            height: displayHeight(context) * 0.115,
            margin: EdgeInsets.only(top: displayHeight(context) * 0.08),
            decoration: const ShapeDecoration(
              color: ColorManager.whiteColor,
              shape: OvalBorder(),
            ),
            child: widget.imageWidget,
          ),
          TextContainer(
            text: '${widget.userFullName}',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            margin: EdgeInsets.only(top: displayHeight(context) * 0.01),
          ),
          TextContainer(
            text: '${widget.userJob}',
            fontSize: 9,
            color: ColorManager.fontColor,
            fontWeight: FontWeight.w600,
            margin: EdgeInsets.only(top: displayHeight(context) * 0.01),
          ),
          SizedBox(
            height: displayHeight(context) * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.date_range_outlined,
                    color: ColorManager.whiteColor,
                  ),
                  TextContainer(
                    text: AppStrings.sinceText.getString(context),
                    width: displayWidth(context) * 0.30,
                    fontSize: 9,
                    fontWeight: FontWeightManager.light,
                    fontFamily: FontConstants.outfitFontFamily,
                    color: ColorManager.fontColor,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.timer_sharp,
                    color: ColorManager.whiteColor,
                  ),
                  TextContainer(
                    text: AppStrings.lastSeenText.getString(context),
                    width: displayWidth(context) * 0.30,
                    fontSize: 9,
                    color: ColorManager.fontColor,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeightManager.light,
                    fontFamily: FontConstants.outfitFontFamily,
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.ads_click,
                    color: ColorManager.whiteColor,
                  ),
                  TextContainer(
                    text: AppStrings.advertisesText.getString(context),
                    width: displayWidth(context) * 0.30,
                    fontSize: 9,
                    color: ColorManager.fontColor,
                    fontWeight: FontWeightManager.light,
                    fontFamily: FontConstants.outfitFontFamily,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UpperProfilePageContainerNew extends StatefulWidget {
  UpperProfilePageContainerNew(
      {super.key, this.imageWidget, this.userFullName, this.userJob});
  Widget? imageWidget;
  String? userFullName;
  String? userJob;
  @override
  State<UpperProfilePageContainerNew> createState() =>
      _UpperProfilePageContainerNewState();
}

class _UpperProfilePageContainerNewState
    extends State<UpperProfilePageContainerNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context) * 0.9,
      height: displayHeight(context) * 0.15,
      margin: EdgeInsets.only(top: displayHeight(context) * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextContainer(
                text: '${widget.userFullName}',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                margin: EdgeInsets.only(
                  top: displayHeight(context) * 0.01,
                ),
              ),
              // TextContainer(
              //   text: '${widget.userJob}',
              //   fontSize: 13,
              //   color: ColorManager.lightGreenColor,
              //   fontWeight: FontWeight.w400,
              //   fontFamily: FontConstants.outfitFontFamily,
              //   margin: EdgeInsets.only(top: displayHeight(context) * 0.005),
              // ),
            ],
          ),
          Container(
            height: 60,
            width: 60,
            decoration: const ShapeDecoration(
                shape: OvalBorder(
                    side: BorderSide(
                        color: ColorManager.lightGreenColor, width: 2)),
                color: ColorManager.whiteColor),
            child: widget.imageWidget,
          )
        ],
      ),
    );
  }
}

class BottomRoundedContainer extends StatefulWidget {
  BottomRoundedContainer({super.key, this.height, this.color, this.widgets});
  double? height;
  Color? color;
  Widget? widgets;
  @override
  State<BottomRoundedContainer> createState() => _BottomRoundedContainerState();
}

class _BottomRoundedContainerState extends State<BottomRoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: Alignment.bottomCenter,
      decoration: ShapeDecoration(
          color: widget.color ?? Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s50),
              topRight: Radius.circular(AppSize.s50),
            ),
          )),
      child: widget.widgets,
    );
  }
}

class TextInputField extends StatefulWidget {
  TextInputField(
      {super.key,
      this.controller,
      this.focusNode,
      this.width,
      this.height,
      this.focusedBorderRadius,
      this.enabledBorderRadius,
      this.errorBorderRadius,
      this.contentPadding,
      this.validator,
      this.onChanged,
      this.onSubmitted,
      this.obsecureText,
      this.maxLines,
      this.suffixIcon,
      this.suffixIconColor,
      this.prefixIcon,
      this.prefixIconColor,
      this.keyboardType,
      this.enabledBorderColor,
      this.focusedBorderColor,
      this.hintText,
      this.fillColor,this.autofocus});
  double? width;
  double? height;
  double? focusedBorderRadius;
  double? enabledBorderRadius;
  double? errorBorderRadius;
  bool? obsecureText = false;
  int? maxLines = 1;
  TextEditingController? controller;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  void Function(String)? onSubmitted;
  EdgeInsetsGeometry? contentPadding;
  Widget? suffixIcon;
  Color? suffixIconColor;
  Widget? prefixIcon;
  Color? prefixIconColor;
  TextInputType? keyboardType;
  Color? enabledBorderColor;
  Color? focusedBorderColor;
  String? hintText;
  FocusNode? focusNode;
  Color? fillColor;
  bool? autofocus;
  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      // constraints:
      //     BoxConstraints(minHeight: widget.height!, minWidth: widget.width!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.enabledBorderRadius!),
          boxShadow: const [
            // BoxShadow(
            //   color: Color(0x26000000),
            //   blurRadius: 4,
            //   offset: Offset(0, 0),
            //   spreadRadius: 0,
            // )
          ]),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        maxLines: widget.maxLines,
        cursorColor: ColorManager.cursorColor,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        autofocus: widget.autofocus ?? false,
        decoration: InputDecoration(
            contentPadding: widget.contentPadding,
            hintText: widget.hintText,
            constraints: BoxConstraints(
                minWidth: widget.width!,
                maxHeight: widget.height!,
                minHeight: widget.height!,
                maxWidth: widget.width!),
            errorText: null,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.focusedBorderColor ??
                        ColorManager.focusedInputFieldColor,
                    width: AppSize.s1),
                borderRadius:
                    BorderRadius.circular(widget.focusedBorderRadius!)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: ColorManager.errorColor, width: AppSize.s1),
                borderRadius:
                    BorderRadius.circular(widget.focusedBorderRadius!)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        widget.enabledBorderColor ?? ColorManager.whiteColor),
                borderRadius:
                    BorderRadius.circular(widget.enabledBorderRadius!)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: ColorManager.errorColor, width: AppSize.s1),
                borderRadius: BorderRadius.circular(widget.errorBorderRadius!)),
            errorStyle: const TextStyle(fontSize: 0.01),
            filled: true,
            fillColor: widget.fillColor ?? ColorManager.lightGreyColor2,
            suffixIcon: widget.suffixIcon,
            suffixIconColor: widget.suffixIconColor,
            prefixIcon: widget.prefixIcon,
            prefixIconColor: widget.prefixIconColor,
            hintStyle: TextStyle(
                color: ColorManager.transblackColor50,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: FontConstants.outfitFontFamily)),
        // validator: widget.validator,
        obscureText: widget.obsecureText!,
        style: TextStyle(
          fontFamily: FontConstants.outfitFontFamily,
          fontWeight: FontWeightManager.regular,
          fontSize: 14,
        ),
      ),
    );
  }
}

class RoundedContainer extends StatefulWidget {
  RoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.color,
    this.child,
    this.padding,
    this.margin,
    this.border,
    this.boxShadow,
    this.constraints,
  });
  double? width;
  double? height;
  double? radius;
  Color? color;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  BoxBorder? border;
  BoxShadow? boxShadow;
  BoxConstraints? constraints;
  Widget? child;
  @override
  State<RoundedContainer> createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      margin: widget.margin,
      constraints: widget.constraints,
      decoration: BoxDecoration(
          border: widget.border,
          boxShadow: [
            widget.boxShadow ??
                const BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
          ],
          borderRadius: BorderRadius.circular(widget.radius!),
          color: widget.color),
      child: widget.child,
    );
  }
}

class AdBox extends StatefulWidget {
  AdBox({super.key});
  double? width;
  double? height;
  double? radius;

  @override
  State<AdBox> createState() => _AdBoxState();
}

class _AdBoxState extends State<AdBox> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: widget.width,
      height: widget.height,
      radius: widget.radius,
      color: ColorManager.whiteColor,
      child: ElevatedButton(onPressed: () {}, child: Container()),
    );
  }
}

class CustomProgressIndicator extends StatefulWidget {
  CustomProgressIndicator({super.key, this.isLoading});
  bool? isLoading;
  @override
  State<CustomProgressIndicator> createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading!) {
      return AlertDialog(
        content: SizedBox(
          child: LoadingAnimationWidget.twistingDots(
              leftDotColor: ColorManager.whiteColor,
              rightDotColor: ColorManager.lightGreenColor,
              size: displayWidth(context) * 0.15),
        ),
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: ColorManager.transblackColor,
      );
    } else {
      return const SizedBox();
    }
  }
}

showProgressIndicator(BuildContext context, bool isLoading, String? text) {
  if (isLoading) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: displayHeight(context) * 0.17,
                  width: displayWidth(context) * 0.15,
                  child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: ColorManager.whiteColor,
                      rightDotColor: ColorManager.lightGreenColor,
                      size: displayWidth(context) * 0.15),
                ),
                TextContainer(
                  text: text!,
                  fontSize: 20,
                  color: ColorManager.fontColor,
                  
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            contentPadding: const EdgeInsets.all(8),
            backgroundColor: ColorManager.transparent,
            shadowColor: ColorManager.transparent,
          );
        });
  } else {
    return const SizedBox();
  }
}

class CircleWithShadow extends StatelessWidget {
  CircleWithShadow({super.key, required this.children, this.minRadius});
  List<Widget> children;
  double? minRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: Color(0x3F000000),
            blurRadius: 4,
          ),
        ], shape: BoxShape.circle),
        child: CircleAvatar(
          backgroundColor: ColorManager.whiteColor,
          minRadius: minRadius,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ));
  }
}

class SentMessageBubbleChat extends StatefulWidget {
  SentMessageBubbleChat({super.key, this.message, this.time});
  String? message;
  String? time;
  @override
  State<SentMessageBubbleChat> createState() => _SentMessageTemplateState();
}

class _SentMessageTemplateState extends State<SentMessageBubbleChat> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
            // fit: FlexFit.tight,
            child: Container(
          margin: const EdgeInsets.only(top: AppMargin.m5),
          // height: 50,
          decoration: BoxDecoration(
              color: ColorManager.sentBubbleChatColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(displayHeight(context) * 0.03),
                topLeft: Radius.circular(displayHeight(context) * 0.03),
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: ColorManager.transblackColor25,
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextContainer(
                text: '${widget.message}',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorManager.fontColor,
                fontFamily: FontConstants.arabicFontFamily,
                padding: EdgeInsets.only(
                    left: displayWidth(context) * 0.03,
                    right: displayWidth(context) * 0.03,
                    top: displayHeight(context) * 0.02),
              ),
              TextContainer(
                text: '${widget.time}',
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: ColorManager.fontColor,
                fontFamily: FontConstants.outfitFontFamily,
                padding: EdgeInsets.only(
                    right: displayWidth(context) * 0.04,
                    left: displayWidth(context) * 0.04,
                    bottom: displayHeight(context) * 0.01),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

class ReceivedMessageBubbleChat extends StatefulWidget {
  ReceivedMessageBubbleChat({super.key, this.message, this.time});
  String? message;
  String? time;
  @override
  State<ReceivedMessageBubbleChat> createState() =>
      _ReceivedMessageTemplateState();
}

class _ReceivedMessageTemplateState extends State<ReceivedMessageBubbleChat> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Container(
          margin: const EdgeInsets.only(top: AppMargin.m5, right: AppMargin.m5),
          decoration: BoxDecoration(
              color: ColorManager.receivedBubbleChatColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(displayHeight(context) * 0.03),
                bottomRight: Radius.circular(displayHeight(context) * 0.03),
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: ColorManager.transblackColor25,
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextContainer(
                text: '${widget.message}',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorManager.fontColor3,
                fontFamily: FontConstants.arabicFontFamily,
                
                padding: EdgeInsets.only(
                    left: displayWidth(context) * 0.03,
                    right: displayWidth(context) * 0.03,
                    top: displayHeight(context) * 0.02),
              ),
              TextContainer(
                text: '${widget.time}',
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: ColorManager.fontColor3,
                fontFamily: FontConstants.outfitFontFamily,
                padding: EdgeInsets.only(
                    right: displayWidth(context) * 0.04,
                    left: displayWidth(context) * 0.04,
                    bottom: displayHeight(context) * 0.01),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

class ModalBottomSheetButton extends StatefulWidget {
  ModalBottomSheetButton(
      {super.key,
      this.buttonName,
      this.buttonDescription,
      this.buttonIcon,
      this.onPressed});
  String? buttonName;
  String? buttonDescription;
  String? buttonIcon;
  void Function()? onPressed;
  @override
  State<ModalBottomSheetButton> createState() => _ModalBottomSheetButtonState();
}

class _ModalBottomSheetButtonState extends State<ModalBottomSheetButton> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: displayWidth(context) * 0.88,
      height: displayHeight(context) * 0.09,
      margin: EdgeInsets.only(top: displayHeight(context) * 0.035),
      radius: AppSize.s10,
      boxShadow: const BoxShadow(
        color: Color(0x3F000000),
        blurRadius: 4,
        offset: Offset(0, 0),
        spreadRadius: 0,
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.whiteColor,
            foregroundColor: ColorManager.lightGreenColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s10)),
            elevation: 0),
        child: Row(
          children: [
            SizedBox(
              width: displayWidth(context) * 0.038,
            ),
            SvgPicture.asset(
              widget.buttonIcon ?? '',
              width: displayWidth(context) * 0.065,
              color: ColorManager.darkGreenColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextContainer(
                  margin: EdgeInsets.only(
                      left: displayWidth(context) * 0.05,
                      top: displayHeight(context) * 0.027),
                  text: widget.buttonName ?? '',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.darkGreenColor,
                ),
                TextContainer(
                  margin: EdgeInsets.only(
                      left: displayWidth(context) * 0.05,
                      top: displayHeight(context) * 0.003),
                  text: widget.buttonDescription ?? '',
                  fontSize: 9,
                  fontWeight: FontWeight.w300,
                  color: ColorManager.lightGreyColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
