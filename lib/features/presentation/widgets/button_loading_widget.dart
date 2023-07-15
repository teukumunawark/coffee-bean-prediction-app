import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: kPrimary,
        padding: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {},
      child: const Center(
        child: CircularProgressIndicator(
          color: kBackground,
        ),
      ),
    );
  }
}
