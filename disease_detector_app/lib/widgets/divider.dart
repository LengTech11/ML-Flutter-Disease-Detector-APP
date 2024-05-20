import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.w,
      child: Transform.rotate(
        angle: pi / 2,
        child: Divider(
          thickness: 1.h,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
