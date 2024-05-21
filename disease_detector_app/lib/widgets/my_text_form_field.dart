import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/custom_text_theme/custom_text_theme.dart';

class MyTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final bool dark;
  const MyTextFormField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.keyBoardType,
      required this.textInputAction,
      required this.dark});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      padding: EdgeInsets.symmetric(horizontal: AppSize.md),
      margin: EdgeInsets.symmetric(horizontal: AppSize.lg),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      child: TextFormField(
        keyboardType: keyBoardType,
        textInputAction: textInputAction,
        maxLines: 1,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: dark
              ? MyTextTheme.darkTextTheme.labelMedium
              : MyTextTheme.lightTextTheme.labelMedium,
          // fillColor: AppColor.black,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter email';
          }
          return null;
        },
        onSaved: (value) {},
      ),
    );
  }
}
