import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/widgets/divider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'buttons.dart';
import 'glass.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget(
      {Key? key, required this.title, required this.text, required this.child})
      : super(key: key);
  final String title;
  final String text;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 200.h,
        child: Column(
          children: [
            Glass(
              sigma: 20,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(kDefaultBorderRadius)),
              child: Container(
                height: 110.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(kDefaultBorderRadius))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 230.w,
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AppSize.fontLg,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(fontSize: AppSize.fontXs),
                    )
                  ],
                ),
              ),
            ),
            Glass(
                sigma: 6,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(kDefaultBorderRadius)),
                child: Container(
                    height: 50.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.7),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(kDefaultBorderRadius))),
                    child: child))
          ],
        ),
      ),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.onPressed, required this.title});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
        title: title,
        text: "You can't undo this action",
        child: Row(
          children: [
            Expanded(
                child: SecondaryButton(
                    text: "Cancel", onPressed: () => Navigator.pop(context))),
            DividerWidget(),
            Expanded(
              child: SecondaryButton(
                text: 'Delete',
                color: Theme.of(context).colorScheme.error,
                onPressed: () {
                  onPressed();
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ));
  }
}
