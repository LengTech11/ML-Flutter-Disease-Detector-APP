import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/widgets/tile_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChangePasswordButton extends StatefulWidget {
  const ChangePasswordButton({super.key});

  @override
  State<ChangePasswordButton> createState() => _ChangePasswordButtonState();
}

class _ChangePasswordButtonState extends State<ChangePasswordButton> {
  @override
  Widget build(BuildContext context) {
    return TileButton(
      onpress: () {
        setState(() {
          HelperFunctions.debug("Change Password");
        });
      },
      prefix: Iconsax.password_check,
      title: 'Change Password',
    );
  }
}
