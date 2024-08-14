import 'package:disease_detector_app/config/themes/m3_theme.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class VcFilledButton extends StatelessWidget {
  const VcFilledButton({
    super.key,
    this.onPressed,
    required this.title,
    this.icon,
  });

  final void Function()? onPressed;
  final String title;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          dark
              ? M3Theme.dark().primary
              : M3Theme.light().primary,
        ),
        foregroundColor: WidgetStateProperty.all<Color>(
          dark
              ? M3Theme.dark().onPrimary
              : M3Theme.light().onPrimary,
        ),
        surfaceTintColor: WidgetStateProperty.all<Color>(
          dark
              ? M3Theme.dark().surface
              : M3Theme.light().surface,
        ),
        overlayColor: WidgetStateProperty.all<Color>(
          dark
              ? M3Theme.dark().tertiaryContainer.withOpacity(0.5)
              : M3Theme.light().tertiaryContainer.withOpacity(0.5),
        ),
      ),
      onPressed: onPressed,
      child: icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon!,
                const SizedBox(width: 8),
                Text(title),
              ],
            )
          : Text(title),
    );
  }
}
