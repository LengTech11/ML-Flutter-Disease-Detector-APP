import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class EcaListtile extends ListTile {
  const EcaListtile(
      {super.key,
      required super.title,
      super.subtitle,
      super.leading,
      super.trailing,
      super.onTap});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: dark ? const Color(0x8BFFFFFF) : const Color(0x8B000000),
        ),
        color: dark ? Colors.black : Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: ListTile(
        trailing: trailing,
        leading: leading,
        leadingAndTrailingTextStyle: leadingAndTrailingTextStyle,
        title: title,
        subtitle: subtitle,
        onTap: onTap,
      ),
    );
  }
}
