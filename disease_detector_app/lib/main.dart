import 'package:disease_detector_app/screens/home/home_screen.dart';
import 'package:disease_detector_app/screens/register/register_screen.dart';
import 'package:disease_detector_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/themes/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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
                    return MaterialPageRoute(builder: (_) => (HomeScreen()));
                  //     case AccountPage.route:
                  //       return MaterialPageRoute(builder: (_) => AccountPage());
                  //     // default:
                  //     //   return MaterialPageRoute(builder: (_) => LoginScreen());
                }
                return null;
              });
        });
  }
}
