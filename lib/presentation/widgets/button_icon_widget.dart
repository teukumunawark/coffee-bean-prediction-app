import 'package:flutter/material.dart';
import 'package:predict_coffee/utils/constants.dart';

class ButtonIconComponet extends StatelessWidget {
  const ButtonIconComponet({
    required this.onPressed,
    this.child = const SizedBox(),
    this.buttonColor = kPrimary,
    this.buttonRadius = 50,
    this.height = 48,
    super.key,
  });

  final Function() onPressed;
  final Widget child;
  final Color buttonColor;
  final double buttonRadius;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
        child: child,
      ),
    );
  }
}
