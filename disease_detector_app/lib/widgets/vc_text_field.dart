import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:disease_detector_app/config/themes/m3_theme.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VcTextField extends StatelessWidget {
  const VcTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.keyBoardType,
    required this.textInputAction,
    required this.visible,
    this.suffix,
    this.prefixIcon,
  });

  final String hint;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final bool visible;
  final IconButton? suffix;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return TextFormField(
      onTapOutside: (even) {
        FocusScope.of(context).unfocus();
      },
      keyboardType: keyBoardType,
      textInputAction: textInputAction,
      maxLines: 1,
      controller: controller,
      obscureText: visible,
      style: TextStyle(
        letterSpacing: 0.6,
        color: dark ? M3Theme.dark().primary : M3Theme.light().primary,
      ),
      decoration: InputDecoration(
          iconColor: dark
              ? M3Theme.dark().onSurfaceVariant
              : M3Theme.light().onSurfaceVariant,
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
              color: dark ? M3Theme.dark().primary : M3Theme.light().primary,
              width: 2.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(
              color: dark ? M3Theme.dark().error : M3Theme.light().error,
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
          fillColor: dark
              ? M3Theme.dark().surfaceContainerHighest
              : M3Theme.light().surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: dark
                ? M3Theme.dark().onSurfaceVariant
                : M3Theme.light().onSurfaceVariant,
            fontSize: AppSize.md,
            fontWeight: FontWeight.w300,
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please ${hint.toLowerCase()}';
        }
        return null;
      },
      onSaved: (value) {},
    );
  }
}
