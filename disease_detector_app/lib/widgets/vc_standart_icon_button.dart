import 'package:disease_detector_app/config/themes/m3_theme.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VcStandartIconButton extends StatelessWidget {
  const VcStandartIconButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final void Function()? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return IconButton(
      iconSize: 24.sp,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(
          dark
              ? M3Theme.dark().onSurfaceVariant
              : M3Theme.light().onSurfaceVariant,
        ),
        surfaceTintColor: WidgetStateProperty.all<Color>(
          dark
              ? M3Theme.dark().surface
              : M3Theme.light().surface,
        ),
        overlayColor: WidgetStateProperty.all<Color>(
          dark
              ? M3Theme.dark().tertiaryContainer.withOpacity(0.25)
              : M3Theme.light().tertiaryContainer.withOpacity(0.25),
        ),
      ),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
