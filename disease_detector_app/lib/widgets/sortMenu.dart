import 'package:disease_detector_app/config/themes/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'buttons.dart';
import 'checkMark.dart';
import 'dropDownBox.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';

class SortMenuBox extends DropDownBox {
  SortMenuBox({
    super.key,
    required this.options,
  }) : super(
            button: IconButtonWidget(
              icon: Iconsax.sort,
              color: AppColor.primary,
            ),
            childWidth: 180.w);
  final List<SortItem> options;
  final double boxWidth = 180.w;

  @override
  SortMenuBoxState createState() => SortMenuBoxState();
}

class SortMenuBoxState extends DropDownBoxState<SortMenuBox> {
  int selectedIndex = 0;
  @override
  Widget buildChildWidget(AnimationController animationController,
      OverlayEntry overlayEntry, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: widget.boxWidth,
          padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 10.r,
                    color: Theme.of(context).scaffoldBackgroundColor)
              ],
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(kDefaultBorderRaduis)),
          child: Column(
              children: widget.options
                  .map((filterItem) => SortItem(
                      text: filterItem.text,
                      active:
                          selectedIndex == widget.options.indexOf(filterItem),
                      onPressed: () async {
                        selectedIndex = widget.options.indexOf(filterItem);
                        debugPrint(selectedIndex.toString());
                        await animationController.reverse();
                        overlayEntry.remove();
                      }))
                  .toList()),
        ),
        // Positioned(
        //     bottom: -18,
        //     child: Container(
        //         padding: EdgeInsets.symmetric(
        //             vertical: kDefaultPadding * 0.3,
        //             horizontal: kDefaultPadding * 0.8),
        //         child: Center(
        //           child: Text(
        //             'Sort by:',
        //             style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 color: Theme.of(context).colorScheme.onPrimary),
        //           ),
        //         ),
        //         decoration: BoxDecoration(
        //             color: Theme.of(context).colorScheme.secondary,
        //             borderRadius: BorderRadius.circular(kDefaultBorderRaduis))))
      ],
    );
  }
}

class SortItem extends StatelessWidget {
  const SortItem(
      {super.key, required this.text, this.onPressed, this.active = false});
  final String text;
  final bool active;
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
                    vertical: kDefaultPadding * 0.75,
                    horizontal: kDefaultPadding * 0.5),
                child: Row(children: [
                  active
                      ? const CheckMark()
                      : SizedBox(
                          width: 20.w,
                        ),
                  SizedBox(width: 10.w),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  const Spacer()
                ]))));
  }
}
