import 'dart:async';

import 'package:disease_detector_app/api_service/client/dio_http_client.dart';
import 'package:disease_detector_app/l10n/l10n.dart';
import 'package:disease_detector_app/provider/appointment_provider.dart';
import 'package:disease_detector_app/provider/clinic_provider.dart';
import 'package:disease_detector_app/provider/disease_provider.dart';
import 'package:disease_detector_app/provider/doctor_provider.dart';
import 'package:disease_detector_app/provider/document_provider.dart';
import 'package:disease_detector_app/provider/get_history_provider.dart';
import 'package:disease_detector_app/provider/network_status_provider.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:disease_detector_app/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:disease_detector_app/screens/login/login_screen.dart';
import 'package:disease_detector_app/screens/onboarding/onboarding_view.dart';
import 'package:disease_detector_app/storage/check_first_install.dart';
import 'package:disease_detector_app/storage/token_storage.dart';
import 'package:disease_detector_app/view_model/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:app_ui/app_ui.dart';

import 'config/themes/theme.dart';
import 'firebase_options.dart';
import 'storage/theme_mode_storage.dart';

bool isFirstInstall = true;
ThemeMode thememode = ThemeMode.light;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final getFirstInstall = await CheckFirstInstall.getFirstInstall();
  if (getFirstInstall == false) {
    isFirstInstall = false;
  } else {
    isFirstInstall = true;
  }

  var isDarkModeOn = await ThemeModeStorage.getThemeMode() ?? false;
  if (isDarkModeOn) {
    thememode = ThemeMode.dark;
  } else {
    thememode = ThemeMode.light;
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => DiseaseProvider()),
        ChangeNotifierProvider(create: (_) => DocumentProvider()),
        ChangeNotifierProvider(create: (_) => GetHistoryProvider()),
        ChangeNotifierProvider(create: (_) => NetworkProvider()),
        ChangeNotifierProvider(create: (_) => DoctorProvider()),
        ChangeNotifierProvider(create: (_) => ClinicProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  ThemeProvider themeProvider = ThemeProvider();

  Future<void> checkIsLogin() async {
    final token = await TokenStorage.getToken();
    if (token == null || token == '') {
      setState(() {
        isLogin = false;
      });
    } else {
      setState(() {
        isLogin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (!isFirstInstall) checkIsLogin();
    BaseHttpClient.init();
    NetworkProvider().initConnectivity();
    CheckFirstInstall.setFirstInstall();
  }

  @override
  void dispose() {
    super.dispose();

    NetworkProvider().connectivitySubscription.cancel();
    NetworkProvider().initConnectivity();
    if (!isFirstInstall) checkIsLogin();
    CheckFirstInstall.setFirstInstall();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(430, 932),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return ScreenUtilInit(
              designSize: const Size(430, 932),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return ShadApp.material(
                  debugShowCheckedModeBanner: false,
                  title: 'VisionCareAI',
                  themeMode: themeProvider.themeMode ?? thememode,
                  theme: const AppTheme().theme,
                  darkTheme: const AppDarkTheme().theme,
                  materialThemeBuilder: (context, theme) {
                    return theme.copyWith(
                      appBarTheme: theme.appBarTheme.copyWith(
                        surfaceTintColor: AppColors.transparent,
                      ),
                      textTheme: theme.brightness == Brightness.light
                          ? const AppTheme().textTheme
                          : const AppDarkTheme().textTheme,
                      snackBarTheme: const SnackBarThemeData(
                        behavior: SnackBarBehavior.floating,
                      ),
                      bottomNavigationBarTheme:
                          const BottomNavigationBarThemeData(
                        type: BottomNavigationBarType.fixed,
                      ),
                    );
                  },
                  supportedLocales: L10n.all,
                  locale: Locale(themeProvider.languageCode ?? 'km'),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  home: isFirstInstall == true
                      ? const OnboardingView()
                      : isLogin == true
                          ? const BottomNavigationBarScreen()
                          : const LoginScreen(),
                );
              },
            );
          },
        );
      },
    );
  }
}
