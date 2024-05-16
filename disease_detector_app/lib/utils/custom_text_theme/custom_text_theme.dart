import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:flutter/material.dart';

import '../../config/themes/color.dart';


class MyTextTheme{
  MyTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    /// headline
    headlineLarge: const TextStyle().copyWith(fontSize: AppSize.fontXXl, fontWeight: FontWeight.bold, color: AppColor.dark, letterSpacing: 0.2),
    headlineMedium: const TextStyle().copyWith(fontSize: AppSize.fontXl, fontWeight: FontWeight.w600, color: AppColor.dark, letterSpacing: 0.2),

    /// title
    titleLarge: const TextStyle().copyWith(fontSize: AppSize.fontSm, fontWeight: FontWeight.w600, color: AppColor.dark),
    titleMedium: const TextStyle().copyWith(fontSize: AppSize.fontSm, fontWeight: FontWeight.w500, color: AppColor.dark),
    titleSmall: const TextStyle().copyWith(fontSize: AppSize.fontSm, fontWeight: FontWeight.w400, color: AppColor.dark),

    /// body
    bodyLarge: const TextStyle().copyWith(fontSize: AppSize.fontXs, fontWeight: FontWeight.w500, color: AppColor.dark),
    bodyMedium: const TextStyle().copyWith(fontSize: AppSize.fontXs, fontWeight: FontWeight.normal, color: AppColor.dark),
    bodySmall: const TextStyle().copyWith(fontSize: AppSize.fontXs, fontWeight: FontWeight.w500, color: AppColor.dark),

    /// label
    labelLarge: const TextStyle().copyWith(fontSize: AppSize.fontXs, fontWeight: FontWeight.w600, color: AppColor.black,letterSpacing: 0.2),
    labelMedium: const TextStyle().copyWith(fontSize: AppSize.fontXs, fontWeight: FontWeight.w600, color: AppColor.grey,letterSpacing: 0.2),
  );


  static TextTheme darkTextTheme = TextTheme(
    ///headline
    headlineLarge: const TextStyle().copyWith(fontSize: AppSize.fontXXl, fontWeight: FontWeight.bold, color: AppColor.white, letterSpacing: 0.2),
    headlineMedium: const TextStyle().copyWith(fontSize: AppSize.fontXl, fontWeight: FontWeight.w600, color: AppColor.white, letterSpacing: 0.2),

    /// title
    titleLarge: const TextStyle().copyWith(fontSize: AppSize.fontSm, fontWeight: FontWeight.w600, color: AppColor.white),
    titleMedium: const TextStyle().copyWith(fontSize: AppSize.fontSm, fontWeight: FontWeight.w500, color: AppColor.white),
    titleSmall: const TextStyle().copyWith(fontSize: AppSize.fontSm, fontWeight: FontWeight.w400, color: AppColor.white),

    /// body
    bodyLarge: const TextStyle().copyWith(fontSize: AppSize.fontXs, fontWeight: FontWeight.w500, color: AppColor.white),
    bodyMedium: const TextStyle().copyWith(fontSize: AppSize.fontXs, fontWeight: FontWeight.normal, color: AppColor.white),
    bodySmall: const TextStyle().copyWith(fontSize: AppSize.fontXs, fontWeight: FontWeight.w500, color: AppColor.white),

    /// label
    labelLarge: const TextStyle().copyWith(fontSize: AppSize.fontXs, fontWeight: FontWeight.w600, color: AppColor.white,letterSpacing: 0.2),
    labelMedium: const TextStyle().copyWith(fontSize: AppSize.fontXs, fontWeight: FontWeight.w500, color: AppColor.lightGrey, letterSpacing: 0.2),);
}