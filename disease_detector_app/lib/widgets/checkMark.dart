import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckMark extends StatelessWidget {
  const CheckMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: Container(
        width: 20.w,
        height: 20.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Theme.of(context).colorScheme.secondary),
        child: Transform.rotate(
          angle: -pi / 4,
          child: Icon(
            Icons.check,
            size: 12.sp,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
