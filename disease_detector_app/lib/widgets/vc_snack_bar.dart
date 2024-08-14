import 'package:disease_detector_app/config/themes/m3_theme.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class VcSnackBar extends SnackBar {
  VcSnackBar({
    super.key,
    required BuildContext context,
    required String content,
    required void Function() onpressed,
  }) : super(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: HelperFunctions.isDarkMode(context)
              ? M3Theme.dark().inverseSurface
              : M3Theme.light().inverseSurface,
          content: Text(
            content,
            style: TextStyle(
              color: HelperFunctions.isDarkMode(context)
                  ? M3Theme.dark().onInverseSurface
                  : M3Theme.light().onInverseSurface,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          action: SnackBarAction(
            label: 'Close',
            onPressed: onpressed,
            textColor: HelperFunctions.isDarkMode(context)
                ? M3Theme.dark().inversePrimary
                : M3Theme.light().inversePrimary,
          ),
          closeIconColor: HelperFunctions.isDarkMode(context)
              ? M3Theme.dark().onInverseSurface
              : M3Theme.light().onInverseSurface,
          animation: _createSnackBarAnimation(context),
        );

  static Animation<double> _createSnackBarAnimation(BuildContext context) {
    final AnimationController controller = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(milliseconds: 1000),
      vsync: Scaffold.of(context),
    );
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }
}
