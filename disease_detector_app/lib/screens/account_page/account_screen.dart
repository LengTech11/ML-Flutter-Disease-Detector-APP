import 'package:disease_detector_app/firebase_helpers/firebase_auth/firebase_auth_helpers.dart';
import 'package:disease_detector_app/screens/login/login_screen.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: kDefaultPadding / 2,
          top: kDefaultPadding,
          left: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2),
      child: Column(
        children: [
          profileInfo(context),
          SizedBox(height: 30.h),
          profileMenuItems(context),
        ],
      ),
    );
  }

  Container profileInfo(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80.h, //140
            width: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 5.w,
                color: Colors.transparent,
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/me.jpg'),
              ),
            ),
          ),
          SizedBox(
            width: kDefaultPadding * 0.75,
          ),
          Expanded(
            child: SizedBox(
              height: 80.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                  Text('Leng Tech',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
              onTap: () async {
                try {
                  showLoaderDialog(context);
                  await FirebaseAuthHelper.instance.handleSignOut();
                  FirebaseAuthHelper.instance.signOut();
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                } catch (e) {
                  if (e is PlatformException) {
                    // Handle the PlatformException
                    print('Failed to disconnect: ${e.message}');
                  } else {
                    // Re-throw any other exceptions
                    rethrow;
                  }
                }
              },
              child: Container(
                  padding: EdgeInsets.all(kDefaultPadding * 0.5),
                  child: const Icon(Icons.logout)),
            ),
          )
        ],
      ),
    );
  }

  Container profileMenuItems(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Column(
          children: [
            MenuItem(
              prefix: Iconsax.profile_circle4,
              text: 'Profile',
            ),
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
            )
          ],
        ));
  }
}
