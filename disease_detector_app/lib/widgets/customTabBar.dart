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
        borderRadius: BorderRadius.circular(kDefaultBorderRaduis * 2),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis * 2),
          color: Theme.of(context).colorScheme.secondary,
        ),
        labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
        tabs: [
          ...tabTexts.map((text) => Tab(
                text: text,
              ))
        ],
      ),
    );
  }
}