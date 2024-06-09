import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:disease_detector_app/widgets/menuItem.dart';
import 'package:flutter/material.dart';

class TileButton extends StatefulWidget {
  const TileButton(
      {super.key,
      required this.onpress,
      required this.prefix,
      // required this.suffix,
      required this.title});

  final void Function() onpress;
  final IconData prefix;
  final String title;

  @override
  State<TileButton> createState() => _TileButtonState();
}

class _TileButtonState extends State<TileButton> {




  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return InkWell(
      onTap:  widget.onpress,
      onDoubleTap: (){
        print("1111111111111111111111111111111111111111");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
          color: Theme.of(context).colorScheme.surface,
        ),  
        child: MenuItem(
          dark: dark,
          prefix: widget.prefix,
          text: "${widget.title}",
        ),
      ),
    );
  }
}
