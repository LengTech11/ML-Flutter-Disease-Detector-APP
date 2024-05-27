import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/themes/color.dart';
import '../utils/custom_text_theme/custom_text_theme.dart';

class MyTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final bool dark;
  final bool visible;
  final IconButton? suffix;
  final Icon? prefixIcon;
  const MyTextFormField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.keyBoardType,
      required this.textInputAction,
      required this.dark,
      required this.visible,
      this.suffix,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.xs),
      child: TextFormField(
        keyboardType: keyBoardType,
        textInputAction: textInputAction,
        maxLines: 1,
        controller: controller,
        obscureText: visible,
        style: dark
            ? MyTextTheme.darkTextTheme.labelLarge
            : MyTextTheme.lightTextTheme.labelLarge,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          alignLabelWithHint: true,
          suffixIcon: suffix,
          suffixIconConstraints: BoxConstraints(
            minWidth: 0.0,
            maxWidth: 58.w,
            minHeight: 0.0,
            maxHeight: 44.h,
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: AppSize.lg, vertical: AppSize.sm),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(
              color: AppColor.primary,
              width: 2.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(
              color: AppColor.primary,
              width: 2.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: dark
              ? MyTextTheme.darkTextTheme.labelMedium
              : MyTextTheme.lightTextTheme.labelMedium,
          // fillColor: AppColor.black,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please ${hint.toLowerCase()}';
          }
          return null;
        },
        onSaved: (value) {},
      ),
    );
  }
}
