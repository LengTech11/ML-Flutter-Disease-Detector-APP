import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:disease_detector_app/screens/diseases/disease_screen.dart';
import 'package:disease_detector_app/screens/home/image_upload_screen.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../account_page/account_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  final List pages = [
    const ImageUploadScreen(),
    const DiseaseScreen(),
    const AccountScreen()
  ];

  UserProfileProvider provider = UserProfileProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<UserProfileProvider>(context, listen: false);
    provider.checkIsGuest();
  }

  @override
  void dispose() {
    provider.checkIsGuest();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: dark ? AppColor.dark : AppColor.light,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context)?.app_name ?? 'VisionCare AI',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: dark ? AppColor.white : AppColor.black,
                  letterSpacing: 0.8),
            ),
            backgroundColor: dark ? AppColor.dark : AppColor.light,
          ),
          backgroundColor: dark ? AppColor.dark : AppColor.light,
          body: pages[currentPage],
          bottomNavigationBar: BottomNavigator(
            onTabChange: (currentIndex) {
              setState(
                () {
                  currentPage = currentIndex;
                },
              );
            },
            tabs: [
              TabButton(
                color: AppColor.white,
                activeColor: AppColor.light,
                icon: Iconsax.camera,
                text: AppLocalizations.of(context)?.camera ?? 'Camera',
              ),
              TabButton(
                color: AppColor.white,
                activeColor: AppColor.light,
                icon: Iconsax.save_add,
                text: AppLocalizations.of(context)?.my_eye ?? 'My Eye',
              ),
              TabButton(
                color: AppColor.white,
                activeColor: AppColor.black,
                icon: Iconsax.profile_circle4,
                text: AppLocalizations.of(context)?.profile ?? 'Profile',
              )
            ],
          ),
        );
      },
    );
  }
}
