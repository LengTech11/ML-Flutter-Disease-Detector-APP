import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';
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
  bool _expanded = false;
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
      height: (_expanded ? widget.subitems.length * 74.w : 0) + 74.w,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis)),
      child: Stack(children: [
        AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            top: _expanded ? 74.w : 10.w,
            child: Column(
              children: [...widget.subitems],
            )),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                  _expanded
                      ? animationController.forward()
                      : animationController.reverse();
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                    horizontal: kDefaultPadding * 0.75),
                child: Row(
                  children: [
                    RotationTransition(
                        turns: Tween(begin: 0.0, end: 0.25)
                            .animate(CurvedAnimation(
                          parent: animationController,
                          curve: Curves.easeOut,
                        )),
                        child: Icon(widget.prefix)),
                    SizedBox(width: 20.w),
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    const Spacer(),
                    RotationTransition(
                        turns:
                            Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
                          parent: animationController,
                          curve: Curves.easeOut,
                        )),
                        child: Icon(
                          Iconsax.arrow_down_1,
                          size: 22.sp,
                        ))
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
  });

  final Widget endWidget;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74.h,
      width: MediaQuery.of(context).size.width - kDefaultPadding,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
          onTap: () {},
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultBorderRaduis)),
              padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                  horizontal: kDefaultPadding * 0.75),
              child: Row(
                children: [
                  Icon(
                    this.icon,
                  ),
                  SizedBox(width: 20),
                  Text(
                    this.text,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  this.endWidget,
                ],
              )),
        ),
      ),
    );
  }
}
