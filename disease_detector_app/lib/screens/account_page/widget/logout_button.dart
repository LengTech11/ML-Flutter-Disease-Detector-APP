import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:disease_detector_app/screens/login/login_screen.dart';
import 'package:disease_detector_app/storage/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, value, child) {
        return TextButton(
          style: TextButton.styleFrom(
            alignment: Alignment.centerLeft,
            minimumSize: Size(1.sw, 0),
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            overlayColor: value.isGuest
                ? AppColor.primary
                : AppColor.error.withOpacity(0.1),
          ),
          onPressed: () {
            showLoaderDialog(context);
            value.clearUser();

            AppConstant.USER_TOKEN = '';

            TokenStorage.removeToken();

            if (value.userProfileModel?.data == null) {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            }
          },
          child: value.isGuest
              ? Text(
                  AppLocalizations.of(context)?.login ?? 'Login',
                  style: const TextStyle(
                    color: AppColor.primary,
                    fontSize: 18,
                  ),
                )
              : Text(
                  AppLocalizations.of(context)?.logout ?? 'Logout',
                  style: const TextStyle(
                    color: AppColor.error,
                    fontSize: 18,
                  ),
                ),
        );
      },
    );
  }
}
