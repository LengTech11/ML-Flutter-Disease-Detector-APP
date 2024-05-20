import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.icon,
      required this.hint,
      this.label,
      this.inputType = TextInputType.name,
      this.inputAction = TextInputAction.next,
      this.secure = false});

  final IconData icon;
  final String hint;
  final String? label;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool secure;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70.h,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
        ),
        child: TextField(
            decoration: InputDecoration(
                labelText: label, prefixIcon: Icon(icon), hintText: hint),
            obscureText: secure));
  }
}
