import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class LoadingImagePreviewWidget extends StatelessWidget {
  const LoadingImagePreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: kSecondery,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
