import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/themes/color.dart';

class MyElevatedBtnTheme {
  MyElevatedBtnTheme._();

  static final lightElevatedBtnTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: AppColor.white,
    backgroundColor: AppColor.primary,
    disabledForegroundColor: AppColor.grey,
    disabledBackgroundColor: AppColor.grey,
    side: const BorderSide(color: AppColor.primary),
    padding: EdgeInsets.symmetric(vertical: 8.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.r)),
  ));

  static final darkElevatedBtnTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: AppColor.white,
    backgroundColor: AppColor.primary,
    disabledForegroundColor: AppColor.grey,
    disabledBackgroundColor: AppColor.grey,
    side: const BorderSide(color: AppColor.primary),
    padding: EdgeInsets.symmetric(vertical: 8.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.r)),
  ));
}
