import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.prefix, required this.text});

  final IconData prefix;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
        onTap: () {},
        child: Container(
          height: 74.h,
          padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding, horizontal: kDefaultPadding * 0.75),
          child: Row(
            children: [
              Icon(prefix),
              SizedBox(width: 20.w),
              Text(
                text,
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
