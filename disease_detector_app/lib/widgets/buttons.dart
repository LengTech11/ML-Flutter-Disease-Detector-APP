import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key, required this.text, required this.onPressed, this.color});
  final Widget text;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: (color != null)
                ? color
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(kDefaultBorderRaduis)),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
                onTap: () {
                  onPressed();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  child: text,
                ))));
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {super.key, required this.text, required this.onPressed, this.color});
  final String text;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(kDefaultBorderRaduis)),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
                onTap: () {
                  onPressed();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: (color != null)
                            ? color
                            : Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withAlpha(100)),
                  ),
                ))));
  }
}

// ignore: must_be_immutable
class IconButtonWidget extends StatefulWidget {
  IconButtonWidget({
    super.key,
    this.onPressed,
    this.color,
    required this.icon,
  });
  final Color? color;
  final IconData icon;
  final Function? onPressed;
  late Function onTap;
  set setonTap(func) {
    onTap = func;
  }

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.onPressed != null) {
      widget.onTap = widget.onPressed!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color ?? Theme.of(context).colorScheme.secondary),
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                  splashColor: Colors.transparent,
                  customBorder: const CircleBorder(),
                  onTap: () {
                    widget.onTap();
                  },
                  child: Icon(
                    widget.icon,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )))),
    );
  }
}
