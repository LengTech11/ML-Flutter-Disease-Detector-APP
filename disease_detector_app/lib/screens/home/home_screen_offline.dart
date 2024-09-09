import 'package:flutter/material.dart';

class HomeScreenOffline extends StatefulWidget {
  const HomeScreenOffline({super.key});

  @override
  State<HomeScreenOffline> createState() => _HomeScreenOfflineState();
}

class _HomeScreenOfflineState extends State<HomeScreenOffline> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
        'No Internet Connection',
      ),
    );
  }
}
