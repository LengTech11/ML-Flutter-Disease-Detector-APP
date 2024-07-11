import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/utils/custom_text_theme/custom_text_theme.dart';
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
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: .4,
            offset: Offset.zero,
          )
        ],
        color: dark ? AppColor.black : AppColor.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: ListTile(
        trailing: trailing,
        leading: leading,
        leadingAndTrailingTextStyle: leadingAndTrailingTextStyle,
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        titleTextStyle: dark
            ? MyTextTheme.darkTextTheme.titleLarge
            : MyTextTheme.lightTextTheme.titleLarge,
        subtitleTextStyle: dark
            ? MyTextTheme.darkTextTheme.bodyMedium
            : MyTextTheme.lightTextTheme.bodyMedium,
      ),
    );
  }
}
