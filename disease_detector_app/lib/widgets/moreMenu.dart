import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'dropDownBox.dart';
import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';

class MoreMenuBox extends DropDownBox {
  MoreMenuBox({
    super.key,
    required this.options,
  }) : super(button: MoreButton(), childWidth: 120.w);
  final List<MoreItem> options;
  final double boxWidth = 120.w;

  @override
  MoreMenuBoxState createState() => MoreMenuBoxState();
}

class MoreMenuBoxState extends DropDownBoxState<MoreMenuBox> {
  int selectedIndex = 0;
  @override
  Widget buildChildWidget(AnimationController animationController,
      OverlayEntry overlayEntry, BuildContext context) {
    return Container(
      width: widget.boxWidth,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 10.r,
                color: Theme.of(context).scaffoldBackgroundColor)
          ],
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.options
              .map((filterItem) => MoreItem(
                    text: filterItem.text,
                    onPressed: () {},
                    red: filterItem.red,
                  ))
              .toList()),
    );
  }
}

class MoreItem extends StatelessWidget {
  const MoreItem({
    super.key,
    required this.text,
    this.onPressed,
    this.red = false,
  });
  final String text;
  final bool red;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
            onTap: () {
              onPressed!();
            },
            child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding * 0.6,
                    horizontal: kDefaultPadding * 0.6),
                child: Row(
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: red
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.onBackground,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Spacer()
                  ],
                ))));
  }
}

//ignore: must_be_immutable
class MoreButton extends StatelessWidget {
  late Function onTap;

  MoreButton({super.key});
  set setonTap(func) {
    onTap = func;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30.h,
        width: 30.w,
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(kDefaultBorderRaduis / 2),
                onTap: () {
                  onTap();
                },
                child: Icon(
                  Iconsax.more_24,
                ))));
  }
}
