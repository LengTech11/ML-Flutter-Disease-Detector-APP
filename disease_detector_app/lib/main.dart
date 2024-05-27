import 'package:disease_detector_app/screens/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'config/themes/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  // await binding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return ScreenUtilInit(
            designSize: const Size(430, 932),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'PlantAi',
                themeMode: themeProvider.themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                home: const LoginScreen(),
              );
              // onGenerateRoute: (settings) {
              //   switch (settings.name) {
              //     case HomeScreen.route:
              //       return MaterialPageRoute(
              //           builder: (_) => (const HomeScreen()));
              //   }
              //   return null;
              // });
            },
            // child: ,
          );
        });
  }
}
