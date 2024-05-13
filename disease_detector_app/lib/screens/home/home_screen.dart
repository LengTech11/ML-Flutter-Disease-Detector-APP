import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/screens/plant/plant_screen.dart';
import 'package:flutter/material.dart';
import 'package:disease_detector_app/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

import '../account_page/account_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  final List pages = [
    Center(child: Text('1')),
    Center(
      child: Text('siofdghfdghsl'),
    ),
    PlantPage(),
    AccountPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: pages[currentPage],
        bottomNavigationBar: BottomNavigator(
            onTabChange: (_currentindex) {
              setState(() {
                currentPage = _currentindex;
              });
            },
            tabs: [
              TabButton(
                color: AppColor.white,
                activeColor: AppColor.light,
                icon: Iconsax.home,
                text: 'Home',
              ),
              TabButton(
                color: AppColor.white,
                activeColor: AppColor.light,
                icon: Iconsax.camera,
                text: 'Camera',
              ),
              TabButton(
                color: AppColor.white,
                activeColor: AppColor.light,
                icon: Iconsax.home,
                text: 'My Plants',
              ),
              TabButton(
                color: AppColor.white,
                activeColor: AppColor.black,
                icon: Iconsax.profile_circle4,
                text: 'Profile',
              )
            ]));
  }
}
