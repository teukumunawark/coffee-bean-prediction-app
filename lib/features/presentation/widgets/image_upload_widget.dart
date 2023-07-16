import 'package:flutter/material.dart';

class ImageUploadButton extends StatelessWidget {
  const ImageUploadButton({
    super.key,
    required this.buttonColor,
    required this.borderColor,
    required this.backgroundColor,
    required this.onPressed,
    required this.icon,
    required this.top,
    required this.right,
  });

  final double top;
  final double right;
  final Color buttonColor;
  final Color borderColor;
  final Color backgroundColor;
  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: IconButton.filled(
        padding: const EdgeInsets.all(12),
        color: buttonColor,
        style: IconButton.styleFrom(
          elevation: 15,
          side: BorderSide(
            color: borderColor,
            strokeAlign: BorderSide.strokeAlignCenter,
            width: 2,
          ),
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}
