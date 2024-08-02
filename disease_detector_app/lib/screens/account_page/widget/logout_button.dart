import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:disease_detector_app/screens/login/login_screen.dart';
import 'package:disease_detector_app/storage/token_storage.dart';
import 'package:disease_detector_app/widgets/tile_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        return TileButton(
          onpress: () {
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
          prefix: Iconsax.logout4,
          title: value.isGuest
              ? AppLocalizations.of(context)?.login ?? 'Login'
              : AppLocalizations.of(context)?.logout ?? 'Logout',
        );
      },
    );
  }
}
