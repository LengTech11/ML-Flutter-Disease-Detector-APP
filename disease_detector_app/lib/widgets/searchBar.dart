import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disease_detector_app/config/constants.dart';

class MySearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(kDefaultBorderRaduis * 2),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search", prefixIcon: Icon(Iconsax.search_normal4)),
      ),
    );
  }
}
