// import 'package:disease_detector_app/screens/home_screen/home_screen.dart';
// import 'package:disease_detector_app/screens/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'config/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
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
                  home: RegisterScreen(),
                  onGenerateRoute: (settings) {
                    switch (settings.name) {
                      case HomeScreen.route:
                        return MaterialPageRoute(
                            builder: (_) => (HomeScreen()));
                      //     case AccountPage.route:
                      //       return MaterialPageRoute(builder: (_) => AccountPage());
                      //     // default:
                      //     //   return MaterialPageRoute(builder: (_) => LoginScreen());
                    }
                    return null;
                  });
            },
          );
        });
  }
}
