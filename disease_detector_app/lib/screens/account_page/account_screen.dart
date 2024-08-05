import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/config/themes/theme.dart';
import 'package:disease_detector_app/screens/account_page/change_password_screen.dart';
import 'package:disease_detector_app/screens/account_page/widget/logout_button.dart';
import 'package:disease_detector_app/screens/account_page/widget/profile_menu_item.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark ? AppColor.dark : AppColor.light,
      ),
      padding: appPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const profileInfo(),
          SizedBox(height: 16.h),
          profileMenuItems(context),
          SizedBox(
            height: 16.h,
          ),
          const LogoutButton(),
        ],
      ),
    );
  }

  Container profileMenuItems(BuildContext context) {
    Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
          color: Colors.transparent),
      child: Column(
        children: [
          MenuItemCategory(
            subitems: [
              SubMenuItem(
                icon: Iconsax.sun_1,
                text:
                    '${AppLocalizations.of(context)?.light ?? 'Light mode'} / ${AppLocalizations.of(context)?.dark ?? 'Dark mode'}',
                endWidget: ToggleThemeSwitcher(
                  value: HelperFunctions.isDarkMode(context),
                  onChanged: (value) {
                    setState(
                      () {
                        final provider = Provider.of<ThemeProvider>(
                          context,
                          listen: false,
                        );
                        provider.toggleTheme(value);
                      },
                    );
                  },
                ),
              ),
              SubMenuItem(
                onTap: () {
                  switchLanguageDialog();
                },
                icon: Iconsax.language_circle,
                text: AppLocalizations.of(context)?.language ?? 'Language',
                endWidget: Text(
                  AppLocalizations.of(context)?.english_khmer ?? 'English',
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SubMenuItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
                icon: Icons.edit,
                text: AppLocalizations.of(context)?.change_password ??
                    'Change Password',
                endWidget: const SizedBox(),
              ),
            ],
            prefix: Iconsax.setting_2,
            text: AppLocalizations.of(context)?.general_settings ??
                'General Setting',
          ),
        ],
      ),
    );
  }

  switchLanguageDialog() {
    final provider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    final local = Localizations.localeOf(context);

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      insetAnimationDuration: const Duration(microseconds: 50),
      title: Text(
        AppLocalizations.of(context)?.switch_language ?? 'Switch Language',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Column(
        children: [
          CupertinoActionSheetAction(
            onPressed: () {
              provider.setEnglishLanguage();
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)?.switch_to_english ?? 'English',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                local == const Locale('en')
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.green,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              provider.setKhmerLanguage();
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)?.switch_to_khmer ?? 'Khmer',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                local == const Locale('km')
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.green,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent)),
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)?.close ?? 'Close'),
        ),
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
