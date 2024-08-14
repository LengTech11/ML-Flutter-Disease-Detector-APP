// import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/config/themes/m3_theme.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
// import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VcDialog extends StatelessWidget {
  const VcDialog({
    super.key,
    required this.headline,
    required this.action,
    required this.description,
  });
  final String headline;
  final List<Widget> action;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return AlertDialog(
      titleTextStyle: TextStyle(
        color: dark
            ? M3Theme.dark().onSurface
            : M3Theme.light().onSurface,
        fontSize: 24.sp,
      ),
      contentTextStyle: TextStyle(
        color: dark
            ? M3Theme.dark().onSurfaceVariant
            : M3Theme.light().onSurfaceVariant,
        fontSize: 16.sp,
      ),
      backgroundColor: dark
          ? M3Theme.dark().surfaceContainerHigh
          : M3Theme.light().surfaceContainerHigh,
      iconColor: dark
          ? M3Theme.dark().secondary
          : M3Theme.light().secondary,
      title: Text(headline),
      content: description != null ? Text(description!) : null,
      actions: action,
    );
  }
}
