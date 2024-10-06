import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oraxproperty/app/app.dart';

class FontConstants {
  // static String outfitFontFamily =
  // localization.currentLocale!.languageCode == 'en'
  //     ? "Poppins"
  //     : "LamaSans";
  static String outfitFontFamily = "Poppins";
  static String arabicFontFamily = "LamaSans";
}

class FontWeightManager {
  static const FontWeight extraLight = FontWeight.w100;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
