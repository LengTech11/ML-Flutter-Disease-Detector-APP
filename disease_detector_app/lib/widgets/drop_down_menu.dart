import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:disease_detector_app/screens/register/register_screen.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:disease_detector_app/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DropDownMenuItem extends StatefulWidget {
  DropDownMenuItem(
      {super.key, required this.controller, required this.selected});
  final TextEditingController controller;
  Object? selected;

  @override
  State<DropDownMenuItem> createState() => _DropDownMenuItemState();
}

class _DropDownMenuItemState extends State<DropDownMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: 6.h),
      child: DropdownMenu<GenderLabel>(
        width: DeviceUtils.getScreenWidth(context) * 0.4,
        controller: widget.controller,
        requestFocusOnTap: false,
        label: const Text('Gender'),
        onSelected: (GenderLabel? gender) {
          setState(() {
            DeviceUtils.hideKeyboard(context);
            widget.selected = gender;
            printMe(widget.selected);
          });
        },
        dropdownMenuEntries:
            GenderLabel.values.map<DropdownMenuEntry<GenderLabel>>(
          (GenderLabel gender) {
            return DropdownMenuEntry<GenderLabel>(
              value: gender,
              label: gender.label,
              style: MenuItemButton.styleFrom(),
            );
          },
        ).toList(),
      ),
    );
  }
}
