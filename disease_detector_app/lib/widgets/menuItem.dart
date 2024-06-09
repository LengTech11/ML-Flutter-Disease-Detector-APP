import 'package:disease_detector_app/config/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class MenuItem extends StatefulWidget {
  const MenuItem(
      {super.key,
      required this.prefix,
      required this.text,
      required this.dark});

  final IconData prefix;
  final String text;
  final bool dark;
  // final void Function() onpress;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
      color: widget.dark ? AppColor.secondary : AppColor.white,
      child: InkWell(
        child: Container( 
          height: 74.h,
          padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding, horizontal: kDefaultPadding * 0.75),
          child: Row(
            children: [
              Icon(widget.prefix),
              SizedBox(width: 20.w),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              const Spacer(),
              Icon(
                Iconsax.arrow_right_3,
                size: 22.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
