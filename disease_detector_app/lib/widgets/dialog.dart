import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/widgets/divider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'buttons.dart';
import 'glass.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget(
      {super.key,
      required this.title,
      required this.text,
      required this.child});
  final String title;
  final String text;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: 200.h,
        child: Column(
          children: [
            Glass(
              sigma: 20,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(kDefaultBorderRaduis)),
              child: Container(
                height: 110.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(kDefaultBorderRaduis))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 230.w,
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      text,
                      style: const TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
            Glass(
                sigma: 6,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(kDefaultBorderRaduis)),
                child: Container(
                    height: 50.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.7),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(kDefaultBorderRaduis))),
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
            const DividerWidget(),
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
