import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/themes/color.dart';

class MyButton extends StatelessWidget {
  final String name;
  final bool dark;
  const MyButton({super.key, required this.dark, required this.name});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          // foregroundColor: dark ? ,
          backgroundColor: dark ? AppColor.primary : AppColor.primary),
      child: Text(
        name,
        style: dark
            ? TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.white)
            : TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.white),
      ),
    );
  }
}
