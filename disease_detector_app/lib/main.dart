import 'package:disease_detector_app/api_service/client/dio_http_client.dart';
import 'package:disease_detector_app/l10n/l10n.dart';
import 'package:disease_detector_app/provider/disease_provider.dart';
import 'package:disease_detector_app/provider/document_provider.dart';
import 'package:disease_detector_app/provider/user_profile_provider.dart';
import 'package:disease_detector_app/screens/home/home_screen.dart';
import 'package:disease_detector_app/screens/login/login_screen.dart';
import 'package:disease_detector_app/screens/onboarding/onboarding_view.dart';
import 'package:disease_detector_app/storage/check_first_install.dart';
import 'package:disease_detector_app/storage/token_storage.dart';
import 'package:disease_detector_app/view_model/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/themes/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        // Add more providers as needed
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
  bool? isFirstInstall;
  bool? isLogin;

  Future<void> checkIsLogin() async {
    final token = await TokenStorage.getToken();
    if (token != null || token != '') {
      setState(() {
        isLogin = true;
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }

  Future<void> checkIsFirstInstall() async {
    final getFirstInstall = await CheckFirstInstall.getFirstInstall();
    if (getFirstInstall == false) {
      setState(() {
        isFirstInstall = false;
      });
    } else {
      setState(() {
        isFirstInstall = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsFirstInstall();
    checkIsLogin();
    BaseHttpClient.init();
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
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'VisionCareAI',
                  themeMode: themeProvider.themeMode,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
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
                          ? const LoginScreen()
                          : const HomeScreen(),
                );
              },
            );
          },
        );
      },
    );
  }
}
