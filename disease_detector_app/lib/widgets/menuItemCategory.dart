import 'package:disease_detector_app/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class MenuItemCategory extends StatefulWidget {
  const MenuItemCategory(
      {super.key,
      required this.prefix,
      required this.text,
      required this.subitems});

  final IconData prefix;
  final String text;
  final List<SubMenuItem> subitems;

  @override
  State<MenuItemCategory> createState() => _MenuItemCategoryState();
}

class _MenuItemCategoryState extends State<MenuItemCategory>
    with TickerProviderStateMixin {
  bool _expanded = true;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 400),
      height: (_expanded ? widget.subitems.length * 76.w : 0) + 74.w,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
        border: Border.all(
          width: 1.1,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3)
        ),
      ),
      child: Stack(children: [
        AnimatedPositioned(
          duration: const Duration(
            milliseconds: 400,
          ),
          top: _expanded ? 74.w : 10.w,
          child: Column(
            children: [...widget.subitems],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
              onTap: () {
                setState(
                  () {
                    _expanded = !_expanded;
                    _expanded
                        ? animationController.forward()
                        : animationController.reverse();
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                  horizontal: kDefaultPadding * 0.75,
                ),
                child: Row(
                  children: [
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.25).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Curves.easeOut,
                        ),
                      ),
                      child: Icon(
                        widget.prefix,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    const Spacer(),
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.5).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Curves.easeOut,
                        ),
                      ),
                      child: Icon(
                        Iconsax.arrow_down_1,
                        size: 22.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class SubMenuItem extends StatelessWidget {
  const SubMenuItem({
    super.key,
    required this.text,
    required this.icon,
    required this.endWidget,
    this.onTap,
  });

  final Widget endWidget;
  final IconData icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76.w,
      width: MediaQuery.of(context).size.width - kDefaultPadding,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
            ),
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 20),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                endWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
