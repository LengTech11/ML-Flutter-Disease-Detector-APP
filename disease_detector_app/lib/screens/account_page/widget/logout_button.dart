import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:disease_detector_app/screens/login/login_screen.dart';
import 'package:disease_detector_app/storage/token_storage.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        return value.isGuest
            ? VcOutlinedButton(
                title: AppLocalizations.of(context)?.login ?? 'Login',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
              )
            : VcOutlinedButton(
                title: AppLocalizations.of(context)?.logout ?? 'Logout',
                onPressed: () {
                  showLoaderDialog(context);
                  value.clearUser();

                  AppConstant.userToken = '';

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
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => VcDialog(
                        description: 'Something when wrong!',
                        headline: 'Logout Failed',
                        action: [
                          VcTextButton(
                            title: 'Close',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  side: WidgetStateProperty.all<BorderSide>(
                    const BorderSide(
                      color: AppColor.error,
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.surface,
                  ),
                  foregroundColor: WidgetStateProperty.all<Color>(
                    AppColor.error,
                  ),
                  overlayColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.error,
                  ),
                ),
              );
      },
    );
  }
}
