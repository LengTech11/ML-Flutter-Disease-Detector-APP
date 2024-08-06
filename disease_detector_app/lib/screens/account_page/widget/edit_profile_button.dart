import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:disease_detector_app/screens/account_page/edit_profile_screen.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({
    super.key,
    required this.user,
  });
  final UserProfileProvider user;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: dark ? AppColor.dark : AppColor.light,
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  EditProfileScreen(
                    user: user,
                  ),
                ],
              );
            },
          ),
        );
      },
      icon: const Icon(
        Icons.mode_edit_outline,
        color: AppColor.primary,
      ),
    );
  }
}
