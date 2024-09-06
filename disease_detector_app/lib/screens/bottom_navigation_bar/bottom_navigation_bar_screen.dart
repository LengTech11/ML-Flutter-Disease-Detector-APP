import 'package:disease_detector_app/config/app_constants/app_constants.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/provider/network_status_provider.dart';
import 'package:disease_detector_app/screens/account_page/account_screen_offline.dart';
import 'package:disease_detector_app/screens/disease_detection/disease_detect_screen.dart';
import 'package:disease_detector_app/screens/disease_detection/disease_detect_screen_offline.dart';
import 'package:disease_detector_app/screens/history/history_screen.dart';
import 'package:disease_detector_app/screens/history/history_screen_offline.dart';
import 'package:disease_detector_app/screens/home/home_screen.dart';
import 'package:disease_detector_app/screens/home/home_screen_offline.dart';
import 'package:disease_detector_app/storage/token_storage.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../account_page/account_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  static const String route = '/';
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  NetworkProvider networkProvider = NetworkProvider();

  int currentPage = 0;

  final List pages = [
    const HomeScreen(),
    const DiseaseDetectScreen(),
    const HistoryScreen(),
    const AccountScreen()
  ];

  final List offlinePages = [
    const HomeScreenOffline(),
    const DiseaseDetectScreenOffline(),
    const HistoryScreenOffline(),
    const AccountScreenOffline()
  ];

  Future<void> checkIsLogin() async {
    final token = await TokenStorage.getToken();
    if (token == null || token == '') {
      AppConstant.userToken = '';
    } else {
      AppConstant.userToken = token;
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsLogin();

    networkProvider = Provider.of<NetworkProvider>(context, listen: false);

    networkProvider.updateStatus();
  }

  @override
  void dispose() {
    super.dispose();
    networkProvider.initConnectivity();
    networkProvider.updateStatus();
    networkProvider.connectivitySubscription;
    checkIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Consumer<NetworkProvider>(
          builder: (context, value, child) {
            return Scaffold(
              appBar: AppBar(
                surfaceTintColor: Theme.of(context).colorScheme.surface,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Text(
                  AppLocalizations.of(context)?.app_name ?? 'VisionCare AI',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onSurface,
                      letterSpacing: 0.8),
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
              body: value.isOnline
                  ? pages[currentPage]
                  : offlinePages[currentPage],
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
                    icon: Iconsax.home,
                    text: AppLocalizations.of(context)?.home ?? 'Home',
                  ),
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
      },
    );
  }
}
