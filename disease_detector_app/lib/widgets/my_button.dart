import 'package:flutter/material.dart';

import '../config/themes/color.dart';

class MyButton extends StatelessWidget {
  final String name;
  final void Function()? onPress;
  const MyButton({
    super.key,
    required this.name,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(backgroundColor: AppColor.primary),
      child: Text(
        name,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
