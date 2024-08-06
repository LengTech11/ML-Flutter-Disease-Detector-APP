import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/screens/account_page/edit_profile_screen.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: dark ? AppColor.dark : AppColor.light,
          showDragHandle: true,
          useSafeArea: true,
          context: context,
          isScrollControlled: true,
          clipBehavior: Clip.none,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return const EditProfileScreen();
            },
          ),
        );
      },
      icon: const Icon(Icons.edit),
    );
  }
}
