import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final double radius;
  final Color? color;
  final Color? textColor;
  final double minWidthSize;
  final double minHeightSize;
  final Function() onPressed;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.radius = 0.0,
    this.color,
    this.textColor = kBackground,
    this.minWidthSize = 0.0,
    this.minHeightSize = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        minimumSize: Size(minWidthSize, minHeightSize),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: kHeading6.copyWith(fontSize: 14, color: textColor),
      ),
    );
  }
}
