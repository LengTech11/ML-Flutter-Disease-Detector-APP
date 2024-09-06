import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/config/themes/theme.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
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
  UserProfileProvider userProfileProvider = UserProfileProvider();

  @override
  void initState() {
    super.initState();
    userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: appPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileInfo(
                  userProvider: value,
                ),
                SizedBox(height: 16.h),
                SizedBox(height: 16.h),
                profileMenuItems(context),
                SizedBox(
                  height: 16.h,
                ),
                const LogoutButton(),
              ],
            ),
          ),
        );
      },
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
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SubMenuItem(
                onTap: () {
                  if (AppConstant.userToken == null ||
                      AppConstant.userToken == '') {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)
                                  ?.login_to_change_password ??
                              'Please login to change password',
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen(),
                      ),
                    );
                  }
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
            overlayColor: WidgetStateProperty.all(
              Colors.transparent,
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context)?.close ?? 'Close',
            style: const TextStyle(
              color: AppColor.error,
              fontSize: 17,
            ),
          ),
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
