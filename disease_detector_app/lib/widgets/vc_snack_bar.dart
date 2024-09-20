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
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          content: Text(
            content,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          action: SnackBarAction(
            label: 'Close',
            onPressed: onpressed,
            textColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          closeIconColor: Theme.of(context).colorScheme.onInverseSurface,
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
