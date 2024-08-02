import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.icon,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
  });

  final void Function() onPressed;
  final String title;
  final Widget? icon;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return ElevatedButton(
      clipBehavior: Clip.hardEdge,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: backgroundColor ?? AppColor.splashColor,
        overlayColor: borderColor ?? AppColor.primary.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(29.r),
          side: BorderSide(
            color: borderColor ?? AppColor.primary,
            width: 1.8.w,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: icon),
          SizedBox(
            width: 8.w,
          ),
          Text(
            title,
            style: dark
                ? TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor ?? AppColor.primary)
                : TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.primary,
                  ),
          ),
        ],
      ),
    );
  }
}
