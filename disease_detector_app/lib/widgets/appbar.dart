import 'dart:ui';

import 'package:flutter/material.dart';

class VcAppbar extends StatelessWidget implements PreferredSizeWidget {
  const VcAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              color: Colors.white.withOpacity(0.1), // Adjusted opacity
            ),
          ),
        ),
        AppBar(
          centerTitle: true,
          title: const Text(
            'VisionCare AI',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor:
              Theme.of(context).colorScheme.surface, // Adjusted opacity
          elevation: 0,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
