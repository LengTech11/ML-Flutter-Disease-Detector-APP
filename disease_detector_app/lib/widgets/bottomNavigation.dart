import 'dart:math' show pow;
import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/config/themes/theme.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator(
      {super.key,
      this.selectedIndex = 0,
      this.onTabChange,
      required this.tabs});

  final int selectedIndex;
  final ValueChanged<int>? onTabChange;
  final List<TabButton> tabs;

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  late int selectedIndex;
  bool clickable = true;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(BottomNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            // height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(140.r)),
              color: Theme.of(context).colorScheme.primary,
            ),
            margin: EdgeInsets.symmetric(
                horizontal: AppSize.md, vertical: AppSize.sm),
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.sm, vertical: AppSize.sm),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: widget.tabs
                    .map((tab) => TabButton(
                          activeColor: Theme.of(context).colorScheme.primary,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.10),
                          active: selectedIndex == widget.tabs.indexOf(tab),
                          text: tab.text,
                          icon: tab.icon,
                          onPressed: () {
                            if (!clickable) return;
                            setState(() {
                              selectedIndex = widget.tabs.indexOf(tab);
                              clickable = false;
                            });

                            tab.onPressed?.call();
                            widget.onTabChange?.call(selectedIndex);

                            Future.delayed(Duration(milliseconds: 400), () {
                              setState(() {
                                clickable = true;
                              });
                            });
                          },
                        ))
                    .toList())));
  }
}

class TabButton extends StatefulWidget {
  const TabButton(
      {super.key,
      this.color,
      required this.icon,
      required this.text,
      this.activeColor,
      this.onPressed,
      this.active});

  final IconData icon;
  final String text;
  final Color? color;
  final Color? activeColor;
  final bool? active;
  final VoidCallback? onPressed;

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> with TickerProviderStateMixin {
  late bool _expanded;
  late final AnimationController expandController;

  @override
  void initState() {
    super.initState();
    _expanded = widget.active!;

    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400))
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    var curveValue = expandController
        .drive(CurveTween(
            curve: _expanded ? Curves.easeInCubic : Curves.easeInCubic.flipped))
        .value;
    var colorTween = ColorTween(
        begin: dark
            ? AppTheme.darkTheme.iconTheme.color
            : AppTheme.darkTheme.iconTheme.color,
        end: widget.activeColor);
    var colorTweenAnimation = colorTween.animate(CurvedAnimation(
        parent: expandController,
        curve: _expanded ? Curves.easeInExpo : Curves.easeOutCirc));

    _expanded = !widget.active!;
    if (_expanded)
      expandController.reverse();
    else
      expandController.forward();

    Widget icon = Icon(widget.icon, color: colorTweenAnimation.value);

    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(100.r)),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2, vertical: kDefaultPadding * 0.5),
        duration: Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: _expanded ? AppColor.light.withOpacity(0) : AppColor.light,
          borderRadius: BorderRadius.all(Radius.circular(100.r)),
        ),
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Builder(builder: (_) {
            return Stack(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Opacity(
                    opacity: 0,
                    child: icon,
                  ),
                  Container(
                    child: Align(
                        alignment: Alignment.centerRight,
                        widthFactor: curveValue,
                        child: Container(
                          child: Opacity(
                              opacity: _expanded
                                  ? pow(expandController.value, 13) as double
                                  : expandController
                                      .drive(CurveTween(curve: Curves.easeIn))
                                      .value,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16 -
                                        (8 *
                                            expandController
                                                .drive(CurveTween(
                                                    curve: Curves.easeOutSine))
                                                .value).w,
                                    right: 8 *
                                        expandController
                                            .drive(CurveTween(
                                                curve: Curves.easeOutSine))
                                            .value).w,
                                child: Text(
                                  widget.text,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: widget.activeColor,
                                  ),
                                ),
                              )),
                        )),
                  ),
                ]),
                Align(alignment: Alignment.centerLeft, child: icon),
              ],
            );
          }),
        ),
      ),
    );
  }
}
