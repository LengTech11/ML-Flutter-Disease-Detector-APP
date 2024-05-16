import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key, required TabController tabController, required this.tabTexts})
      : _tabController = tabController;

  final TabController _tabController;
  final List<String> tabTexts;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius * 2),
        color: Theme.of(context).colorScheme.background,
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius * 2),
          color: Theme.of(context).colorScheme.background,
        ),
        labelStyle: TextStyle(fontSize: AppSize.fontSm, fontWeight: FontWeight.bold),
        unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
        tabs: [
          ...tabTexts.map((text) => Tab(
                text: text,
              ))
        ],
      ),
    );
  }
}
