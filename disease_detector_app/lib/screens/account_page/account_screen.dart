import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/view_model/provider.dart';
import 'package:disease_detector_app/screens/account_page/widget/change_password.dart';
import 'package:disease_detector_app/screens/account_page/widget/logout_button.dart';
import 'package:disease_detector_app/screens/account_page/widget/profile_menu_item.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:disease_detector_app/config/themes/theme.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AppProvider provider = AppProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // final provider = Provider.of<AppProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(color: dark ? AppColor.dark : AppColor.light),
      padding: appPadding,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          const profileInfo(),
          SizedBox(height: 16.h),
          profileMenuItems(context),
          SizedBox(
            height: 16.h,
          ),
          const ChangePasswordButton(),
          SizedBox(height: 16.h),
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
                  text: 'Light Mode / Dark mode',
                  endWidget: ToggleThemeSwitcher(
                      value: HelperFunctions.isDarkMode(context),
                      onChanged: (value) {
                        setState(() {
                          final provider = Provider.of<ThemeProvider>(context,
                              listen: false);
                          provider.toggleTheme(value);
                        });
                      }),
                ),
                SubMenuItem(
                  icon: Iconsax.language_circle,
                  text: 'Languages',
                  endWidget: Text('English',
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 16.sp,
                      )),
                ),
              ],
              prefix: Iconsax.setting_2,
              text: 'General Settings',
            ),
          ],
        ));
  }
}
