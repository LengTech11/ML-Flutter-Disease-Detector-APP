import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleThemeSwitcher extends StatefulWidget {
  const ToggleThemeSwitcher(
      {super.key, required this.onChanged, required this.value});
  final Function(bool) onChanged;
  final value;

  @override
  State<ToggleThemeSwitcher> createState() => _ToggleThemeSwitcherState();
}

class _ToggleThemeSwitcherState extends State<ToggleThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35.w,
      child: Transform.scale(
        scale: 0.8,
        child: CupertinoSwitch(
          activeColor: Theme.of(context).colorScheme.primaryContainer,
          value: widget.value,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
